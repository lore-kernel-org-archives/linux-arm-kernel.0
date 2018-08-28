From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Aug 2018 20:52:25 -0500
Subject: [PATCH] irqchip: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Message-ID: <20180828015252.28511-24-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c      |  4 ++--
 drivers/irqchip/irq-mscc-ocelot.c |  6 +++---
 drivers/irqchip/irq-orion.c       | 22 +++++++++++-----------
 drivers/irqchip/irq-stm32-exti.c  |  6 +++---
 drivers/irqchip/irq-tango.c       | 10 +++++-----
 drivers/irqchip/irq-tb10x.c       | 18 +++++++++---------
 6 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d5912f1ec884..fcb6227ff5ac 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1183,8 +1183,8 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 
 		part->partition_id = of_node_to_fwnode(child_part);
 
-		pr_info("GIC: PPI partition %s[%d] { ",
-			child_part->name, part_idx);
+		pr_info("GIC: PPI partition %pOFn[%d] { ",
+			child_part, part_idx);
 
 		n = of_property_count_elems_of_size(child_part, "affinity",
 						    sizeof(u32));
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
diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index be4c5a8c9659..c4b5ffb61954 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -64,14 +64,14 @@ static int __init orion_irq_init(struct device_node *np,
 				num_chips * ORION_IRQS_PER_CHIP,
 				&irq_generic_chip_ops, NULL);
 	if (!orion_irq_domain)
-		panic("%s: unable to add irq domain\n", np->name);
+		panic("%pOFn: unable to add irq domain\n", np);
 
 	ret = irq_alloc_domain_generic_chips(orion_irq_domain,
-				ORION_IRQS_PER_CHIP, 1, np->name,
+				ORION_IRQS_PER_CHIP, 1, np->full_name,
 				handle_level_irq, clr, 0,
 				IRQ_GC_INIT_MASK_CACHE);
 	if (ret)
-		panic("%s: unable to alloc irq domain gc\n", np->name);
+		panic("%pOFn: unable to alloc irq domain gc\n", np);
 
 	for (n = 0, base = 0; n < num_chips; n++, base += ORION_IRQS_PER_CHIP) {
 		struct irq_chip_generic *gc =
@@ -80,12 +80,12 @@ static int __init orion_irq_init(struct device_node *np,
 		of_address_to_resource(np, n, &r);
 
 		if (!request_mem_region(r.start, resource_size(&r), np->name))
-			panic("%s: unable to request mem region %d",
-			      np->name, n);
+			panic("%pOFn: unable to request mem region %d",
+			      np, n);
 
 		gc->reg_base = ioremap(r.start, resource_size(&r));
 		if (!gc->reg_base)
-			panic("%s: unable to map resource %d", np->name, n);
+			panic("%pOFn: unable to map resource %d", np, n);
 
 		gc->chip_types[0].regs.mask = ORION_IRQ_MASK;
 		gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
@@ -150,20 +150,20 @@ static int __init orion_bridge_irq_init(struct device_node *np,
 	domain = irq_domain_add_linear(np, nrirqs,
 				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
-		pr_err("%s: unable to add irq domain\n", np->name);
+		pr_err("%pOFn: unable to add irq domain\n", np);
 		return -ENOMEM;
 	}
 
 	ret = irq_alloc_domain_generic_chips(domain, nrirqs, 1, np->name,
 			     handle_edge_irq, clr, 0, IRQ_GC_INIT_MASK_CACHE);
 	if (ret) {
-		pr_err("%s: unable to alloc irq domain gc\n", np->name);
+		pr_err("%pOFn: unable to alloc irq domain gc\n", np);
 		return ret;
 	}
 
 	ret = of_address_to_resource(np, 0, &r);
 	if (ret) {
-		pr_err("%s: unable to get resource\n", np->name);
+		pr_err("%pOFn: unable to get resource\n", np);
 		return ret;
 	}
 
@@ -175,14 +175,14 @@ static int __init orion_bridge_irq_init(struct device_node *np,
 	/* Map the parent interrupt for the chained handler */
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0) {
-		pr_err("%s: unable to parse irq\n", np->name);
+		pr_err("%pOFn: unable to parse irq\n", np);
 		return -EINVAL;
 	}
 
 	gc = irq_get_domain_generic_chip(domain, 0);
 	gc->reg_base = ioremap(r.start, resource_size(&r));
 	if (!gc->reg_base) {
-		pr_err("%s: unable to map resource\n", np->name);
+		pr_err("%pOFn: unable to map resource\n", np);
 		return -ENOMEM;
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
 
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 848d782a2a3b..7e6708099a7b 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -115,21 +115,21 @@ static int __init of_tb10x_init_irq(struct device_node *ictl,
 	void __iomem *reg_base;
 
 	if (of_address_to_resource(ictl, 0, &mem)) {
-		pr_err("%s: No registers declared in DeviceTree.\n",
-			ictl->name);
+		pr_err("%pOFn: No registers declared in DeviceTree.\n",
+			ictl);
 		return -EINVAL;
 	}
 
 	if (!request_mem_region(mem.start, resource_size(&mem),
-		ictl->name)) {
-		pr_err("%s: Request mem region failed.\n", ictl->name);
+		ictl->full_name)) {
+		pr_err("%pOFn: Request mem region failed.\n", ictl);
 		return -EBUSY;
 	}
 
 	reg_base = ioremap(mem.start, resource_size(&mem));
 	if (!reg_base) {
 		ret = -EBUSY;
-		pr_err("%s: ioremap failed.\n", ictl->name);
+		pr_err("%pOFn: ioremap failed.\n", ictl);
 		goto ioremap_fail;
 	}
 
@@ -137,8 +137,8 @@ static int __init of_tb10x_init_irq(struct device_node *ictl,
 					&irq_generic_chip_ops, NULL);
 	if (!domain) {
 		ret = -ENOMEM;
-		pr_err("%s: Could not register interrupt domain.\n",
-			ictl->name);
+		pr_err("%pOFn: Could not register interrupt domain.\n",
+			ictl);
 		goto irq_domain_add_fail;
 	}
 
@@ -147,8 +147,8 @@ static int __init of_tb10x_init_irq(struct device_node *ictl,
 				IRQ_NOREQUEST, IRQ_NOPROBE,
 				IRQ_GC_INIT_MASK_CACHE);
 	if (ret) {
-		pr_err("%s: Could not allocate generic interrupt chip.\n",
-			ictl->name);
+		pr_err("%pOFn: Could not allocate generic interrupt chip.\n",
+			ictl);
 		goto gc_alloc_fail;
 	}
 
-- 
2.17.1
