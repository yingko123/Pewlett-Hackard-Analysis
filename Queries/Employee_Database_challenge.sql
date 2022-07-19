-- 1. The Number of Retiring Employees by Title 
-- 1a. Set up retirement_titles table with employees with retirement birthday
DROP TABLE retirement_titles

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
	JOIN titles as ti
		ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01'AND'1955-12-31')
ORDER BY e.emp_no

SELECT * FROM retirement_titles

-- 1b. set up 'unique_title' table with current employee's most recent title
DROP TABLE unique_titles

SELECT DISTINCT ON (emp_no)
	emp_no, 
	first_name, 
	last_name, 
	title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC

SELECT * FROM unique_titles

-- 1c. show # of retirement qualified by titles
SELECT count(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC

SELECT * FROM retiring_titles

-- 2. The Employees Eligible for the Mentorship Program (count=1549)
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
	INNER JOIN dept_employees as de
		ON(e.emp_no = de.emp_no)
	INNER JOIN titles as ti
		ON (de.emp_no = ti.emp_no)
WHERE de.to_date = ('9999-01-01') 
AND(e.birth_date BETWEEN '1965-01-01'AND '1965-12-31')

SELECT * FROM mentorship_eligibility

SELECT COUNT(emp_no) FROM mentorship_eligibility

-- 3a. Expanding mentorship program (count=56,859)
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO expand_mentorship
FROM employees as e
	INNER JOIN dept_employees as de
		ON(e.emp_no = de.emp_no)
	INNER JOIN titles as ti
		ON (de.emp_no = ti.emp_no)
WHERE de.to_date = ('9999-01-01') 
AND(e.birth_date BETWEEN '1962-01-01'AND '1967-12-31')

SELECT * FROM expand_mentorship

SELECT COUNT(emp_no) FROM expand_mentorship
-- 3b. Expanded mentorship program by title cound
SELECT count(title), title
FROM expand_mentorship
GROUP BY title
ORDER BY COUNT(title) DESC

