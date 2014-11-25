From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 25 Nov 2014 16:04:19 +0800
Subject: [PATCH v8 1/4] irqchip: gic: Support hierarchy irq domain.
In-Reply-To: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1416902662-19281-2-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to use gic as a parent for stacked irq domain.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/irqchip/Kconfig   |  1 +
 drivers/irqchip/irq-gic.c | 77 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b21f12f..7f34138 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -5,6 +5,7 @@ config IRQCHIP
 config ARM_GIC
 	bool
 	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
 	select MULTI_IRQ_HANDLER
 
 config GIC_NON_BANKED
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 38493ff..ab6069b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -788,17 +788,16 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 {
 	if (hw < 32) {
 		irq_set_percpu_devid(irq);
-		irq_set_chip_and_handler(irq, &gic_chip,
-					 handle_percpu_devid_irq);
+		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
+				    handle_percpu_devid_irq, NULL, NULL);
 		set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
 	} else {
-		irq_set_chip_and_handler(irq, &gic_chip,
-					 handle_fasteoi_irq);
+		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
+				    handle_fasteoi_irq, NULL, NULL);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 
 		gic_routable_irq_domain_ops->map(d, irq, hw);
 	}
-	irq_set_chip_data(irq, d->host_data);
 	return 0;
 }
 
@@ -858,6 +857,31 @@ static struct notifier_block gic_cpu_notifier = {
 };
 #endif
 
+static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct of_phandle_args *irq_data = arg;
+
+	ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
+				   irq_data->args_count, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		gic_irq_domain_map(domain, virq + i, hwirq + i);
+
+	return 0;
+}
+
+static const struct irq_domain_ops gic_irq_domain_hierarchy_ops = {
+	.xlate = gic_irq_domain_xlate,
+	.alloc = gic_irq_domain_alloc,
+	.free = irq_domain_free_irqs_top,
+};
+
 static const struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
 	.unmap = gic_irq_domain_unmap,
@@ -948,18 +972,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_cpu_map[i] = 0xff;
 
 	/*
-	 * For primary GICs, skip over SGIs.
-	 * For secondary GICs, skip over PPIs, too.
-	 */
-	if (gic_nr == 0 && (irq_start & 31) > 0) {
-		hwirq_base = 16;
-		if (irq_start != -1)
-			irq_start = (irq_start & ~31) + 16;
-	} else {
-		hwirq_base = 32;
-	}
-
-	/*
 	 * Find out how many interrupts are supported.
 	 * The GIC only supports up to 1020 interrupt sources.
 	 */
@@ -969,10 +981,31 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_irqs = 1020;
 	gic->gic_irqs = gic_irqs;
 
-	gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
+	if (node) {		/* DT case */
+		const struct irq_domain_ops *ops = &gic_irq_domain_hierarchy_ops;
+
+		if (!of_property_read_u32(node, "arm,routable-irqs",
+					  &nr_routable_irqs)) {
+			ops = &gic_irq_domain_ops;
+			gic_irqs = nr_routable_irqs;
+		}
+
+		gic->domain = irq_domain_add_linear(node, gic_irqs, ops, gic);
+	} else {		/* Non-DT case */
+		/*
+		 * For primary GICs, skip over SGIs.
+		 * For secondary GICs, skip over PPIs, too.
+		 */
+		if (gic_nr == 0 && (irq_start & 31) > 0) {
+			hwirq_base = 16;
+			if (irq_start != -1)
+				irq_start = (irq_start & ~31) + 16;
+		} else {
+			hwirq_base = 32;
+		}
+
+		gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
 
-	if (of_property_read_u32(node, "arm,routable-irqs",
-				 &nr_routable_irqs)) {
 		irq_base = irq_alloc_descs(irq_start, 16, gic_irqs,
 					   numa_node_id());
 		if (IS_ERR_VALUE(irq_base)) {
@@ -983,10 +1016,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 
 		gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
 					hwirq_base, &gic_irq_domain_ops, gic);
-	} else {
-		gic->domain = irq_domain_add_linear(node, nr_routable_irqs,
-						    &gic_irq_domain_ops,
-						    gic);
 	}
 
 	if (WARN_ON(!gic->domain))
-- 
1.8.1.1.dirty
