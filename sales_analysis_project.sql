CREATE DATABASE sales_analysis
USE sales_analysis

CREATE TABLE `Sales_Dataset` (
	order_id VARCHAR(15) NOT NULL, 
	order_date DATE NOT NULL, 
	ship_date DATE NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 5) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	year DECIMAL(38, 0) NOT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Sales_Dataset.csv'
INTO TABLE Sales_Dataset
FIELDS TERMINATED BY  ','
ENCLOSED BY  '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_Dataset
WHERE ship_date = '2011-05-01'

SELECT * FROM Sales_Dataset
WHERE ship_date > '2011-05-01'

-- AVERAGE SALES EACH YEAR
SELECT year, AVG(sales) as average_sales FROM Sales_Dataset
GROUP BY year

-- TOTAL SALES EVERY YEAR
SELECT year, SUM(sales) as Total_sales FROM Sales_Dataset
GROUP BY year

-- MINIMUM SALES EVERY YEAR
SELECT year, MIN(sales) as Min_sales FROM Sales_Dataset
GROUP BY year

-- CALCULATING TOTAL COST TO COMPANY (CTC)
SELECT SUM((sales*discount) + shipping_cost) as cost_to_company FROM Sales_Dataset 

-- NUMBER OF ORDERS PLACED BETWEEN 2011-02-01 AND 2011-03-01

SELECT  COUNT(*) as Total_orders_between_Dates FROM Sales_Dataset
WHERE order_date BETWEEN '2011-02-01' AND '2011-03-01'

-- PRINT YES IF THERE IS A DISCOUNT ELSE NO

SELECT order_id,  discount ,
CASE Discount
	WHEN discount > 0.000 THEN "DISCOUNT AVAILABLE"
    ELSE "NO DISCOUNT"
END AS Discounted_Flag
FROM Sales_Dataset

-- HOW MANY PRODUCTS HAVE DISCOUNT AND HOW MANY DON'T 
SELECT Discounted_Flag, count(Discounted_Flag) FROM 
(SELECT order_id,  discount ,
CASE Discount
	WHEN discount > 0.000 THEN "DISCOUNT AVAILABLE"
    ELSE "NO DISCOUNT"
END AS Discounted_Flag
FROM Sales_Dataset) as TEMPTABLE
GROUP BY Discounted_Flag