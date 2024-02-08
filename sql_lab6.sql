use sakila;

-- 1

CREATE VIEW part_1 AS
select 
cust.customer_id,
concat(first_name, ' ', last_name) as name,
email,
count(rental_id) as number_of_rentals
from sakila.customer as cust
left join sakila.rental as rent
on cust.customer_id = rent.customer_id
group by customer_id;

-- 2


CREATE TEMPORARY TABLE temporary_table_3 AS
select 
part_1.customer_id,
name,
sum(amount) as total
from
part_1
left join sakila.payment as pay
on part_1.customer_id = pay.customer_id
group by customer_id;

-- 3


with cte as( 
SELECT 
part.name,
email,
number_of_rentals,
total, 
number_of_rentals/total
from 
part_1 as part
left join temporary_table_3 as temp
on part.customer_id = temp.customer_id)

select *
from
cte;






