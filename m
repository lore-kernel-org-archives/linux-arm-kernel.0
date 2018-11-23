From: tiny.windzz@gmail.com (Yangtao Li)
Date: Fri, 23 Nov 2018 11:54:18 -0500
Subject: [PATCH] irqchhip: Convert to using %pOFn instead of device_node.name
Message-ID: <20181123165418.27745-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/irqchip/irq-mscc-ocelot.c |  6 +++---
 drivers/irqchip/irq-stm32-exti.c  |  6 +++---
 drivers/irqchip/irq-tango.c       | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index b63e40c00a02..88143c0b700c 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -72,7 +72,7 @@ static int __init ocelot_irq_init(struct device_node *node,
 	domain = irq_domain_add_linear(node, OCELOT_NR_IRQ,
 				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
-		pr_err("%s: unable to add irq domain\n", node->name);
+		pr_err("%pOFn: unable to add irq domain\n", node);
 		return -ENOMEM;
 	}
 
@@ -80,14 +80,14 @@ static int __init ocelot_irq_init(struct device_node *node,
 					     "icpu", handle_level_irq,
 					     0, 0, 0);
 	if (ret) {
-		pr_err("%s: unable to alloc irq domain gc\n", node->name);
+		pr_err("%pOFn: unable to alloc irq domain gc\n", node);
 		goto err_domain_remove;
 	}
 
 	gc = irq_get_domain_generic_chip(domain, 0);
 	gc->reg_base = of_iomap(node, 0);
 	if (!gc->reg_base) {
-		pr_err("%s: unable to map resource\n", node->name);
+		pr_err("%pOFn: unable to map resource\n", node);
 		ret = -ENOMEM;
 		goto err_gc_free;
 	}
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 0a2088e12d96..363385750fa7 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -678,8 +678,8 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
 				       &irq_exti_domain_ops, NULL);
 	if (!domain) {
-		pr_err("%s: Could not register interrupt domain.\n",
-		       node->name);
+		pr_err("%pOFn: Could not register interrupt domain.\n",
+		       node);
 		ret = -ENOMEM;
 		goto out_unmap;
 	}
@@ -768,7 +768,7 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 					  host_data);
 
 	if (!domain) {
-		pr_err("%s: Could not register exti domain.\n", node->name);
+		pr_err("%pOFn: Could not register exti domain.\n", node);
 		ret = -ENOMEM;
 		goto out_unmap;
 	}
diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
index 580e2d72b9ba..ae28d8648679 100644
--- a/drivers/irqchip/irq-tango.c
+++ b/drivers/irqchip/irq-tango.c
@@ -184,11 +184,11 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq)
-		panic("%s: failed to get IRQ", node->name);
+		panic("%pOFn: failed to get IRQ", node);
 
 	err = of_address_to_resource(node, 0, &res);
 	if (err)
-		panic("%s: failed to get address", node->name);
+		panic("%pOFn: failed to get address", node);
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	chip->ctl = res.start - baseres->start;
@@ -196,12 +196,12 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
 
 	dom = irq_domain_add_linear(node, 64, &irq_generic_chip_ops, chip);
 	if (!dom)
-		panic("%s: failed to create irqdomain", node->name);
+		panic("%pOFn: failed to create irqdomain", node);
 
 	err = irq_alloc_domain_generic_chips(dom, 32, 2, node->name,
 					     handle_level_irq, 0, 0, 0);
 	if (err)
-		panic("%s: failed to allocate irqchip", node->name);
+		panic("%pOFn: failed to allocate irqchip", node);
 
 	tangox_irq_domain_init(dom);
 
@@ -219,7 +219,7 @@ static int __init tangox_of_irq_init(struct device_node *node,
 
 	base = of_iomap(node, 0);
 	if (!base)
-		panic("%s: of_iomap failed", node->name);
+		panic("%pOFn: of_iomap failed", node);
 
 	of_address_to_resource(node, 0, &res);
 
-- 
2.17.0
