From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 8 Aug 2018 15:03:19 +0300
Subject: [PATCH] irqchip/stm32: fix init error handling
Message-ID: <20180808120319.akmstg3ads325xcy@kili.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there are any errors in stm32_exti_host_init() then it leads to a
NULL dereference in the callers.  The function should clean up after
itself.

Fixes: f9fc1745501e ("irqchip/stm32: Add host and driver data structures")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 3df527fcf4e1..0a2088e12d96 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -603,17 +603,24 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 					sizeof(struct stm32_exti_chip_data),
 					GFP_KERNEL);
 	if (!host_data->chips_data)
-		return NULL;
+		goto free_host_data;
 
 	host_data->base = of_iomap(node, 0);
 	if (!host_data->base) {
 		pr_err("%pOF: Unable to map registers\n", node);
-		return NULL;
+		goto free_chips_data;
 	}
 
 	stm32_host_data = host_data;
 
 	return host_data;
+
+free_chips_data:
+	kfree(host_data->chips_data);
+free_host_data:
+	kfree(host_data);
+
+	return NULL;
 }
 
 static struct
@@ -665,10 +672,8 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	struct irq_domain *domain;
 
 	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data) {
-		ret = -ENOMEM;
-		goto out_free_mem;
-	}
+	if (!host_data)
+		return -ENOMEM;
 
 	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
 				       &irq_exti_domain_ops, NULL);
@@ -725,7 +730,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	irq_domain_remove(domain);
 out_unmap:
 	iounmap(host_data->base);
-out_free_mem:
 	kfree(host_data->chips_data);
 	kfree(host_data);
 	return ret;
@@ -752,10 +756,8 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 	}
 
 	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data) {
-		ret = -ENOMEM;
-		goto out_free_mem;
-	}
+	if (!host_data)
+		return -ENOMEM;
 
 	for (i = 0; i < drv_data->bank_nr; i++)
 		stm32_exti_chip_init(host_data, i, node);
@@ -777,7 +779,6 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 
 out_unmap:
 	iounmap(host_data->base);
-out_free_mem:
 	kfree(host_data->chips_data);
 	kfree(host_data);
 	return ret;
