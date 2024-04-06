-- SELECT company_id, name as company_name
-- FROM company_dim
-- WHERE company_id IN(
--     SELECT company_id
--     FROM job_postings_fact
--     WHERE job_no_degree_mention = TRUE
-- )

-- WITH company_job_count AS (
--     SELECT 
--         company_id, 
--         COUNT(*) AS total_jobs
--     FROM 
--         job_postings_fact
--     GROUP BY 
--         company_id
-- )

-- SELECT 
--     name,
--     total_jobs 
-- FROM
--     company_dim
-- LEFT JOIN 
--     company_job_count
-- ON company_dim.company_id = company_job_count.company_id
-- ORDER BY total_jobs DESC


WITH top_job AS (
    SELECT
        skill_id, COUNT(*) as skill_count
    FROM 
        skills_job_dim
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_postings_fact.job_work_from_home = TRUE AND
        job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    top_job.skill_id, skills, skill_count
FROM
    top_job
JOIN skills_dim
ON top_job.skill_id = skills_dim.skill_id
ORDER BY skill_count DESC
LIMIT 5
