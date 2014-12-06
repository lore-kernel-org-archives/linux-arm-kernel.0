From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  6 Dec 2014 13:46:15 +0000
Subject: [PATCH 4/5] irqchip: GIC: get rid of routable domain
In-Reply-To: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417873576-10463-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only user of the so called "routable domain" functionnality
now being fixed, let's clean up the GIC.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c       | 59 ++++-------------------------------------
 include/linux/irqchip/arm-gic.h |  6 -----
 2 files changed, 5 insertions(+), 60 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 540f23c..ad2ca50 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -742,15 +742,12 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-
-		gic_routable_irq_domain_ops->map(d, irq, hw);
 	}
 	return 0;
 }
 
 static void gic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
 {
-	gic_routable_irq_domain_ops->unmap(d, irq);
 }
 
 static int gic_irq_domain_xlate(struct irq_domain *d,
@@ -769,16 +766,8 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 	*out_hwirq = intspec[1] + 16;
 
 	/* For SPIs, we need to add 16 more to get the GIC irq ID number */
-	if (!intspec[0]) {
-		ret = gic_routable_irq_domain_ops->xlate(d, controller,
-							 intspec,
-							 intsize,
-							 out_hwirq,
-							 out_type);
-
-		if (IS_ERR_VALUE(ret))
-			return ret;
-	}
+	if (!intspec[0])
+		*out_hwirq += 16;
 
 	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
 
@@ -835,37 +824,6 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
 };
 
-/* Default functions for routable irq domain */
-static int gic_routable_irq_domain_map(struct irq_domain *d, unsigned int irq,
-			      irq_hw_number_t hw)
-{
-	return 0;
-}
-
-static void gic_routable_irq_domain_unmap(struct irq_domain *d,
-					  unsigned int irq)
-{
-}
-
-static int gic_routable_irq_domain_xlate(struct irq_domain *d,
-				struct device_node *controller,
-				const u32 *intspec, unsigned int intsize,
-				unsigned long *out_hwirq,
-				unsigned int *out_type)
-{
-	*out_hwirq += 16;
-	return 0;
-}
-
-static const struct irq_domain_ops gic_default_routable_irq_domain_ops = {
-	.map = gic_routable_irq_domain_map,
-	.unmap = gic_routable_irq_domain_unmap,
-	.xlate = gic_routable_irq_domain_xlate,
-};
-
-const struct irq_domain_ops *gic_routable_irq_domain_ops =
-					&gic_default_routable_irq_domain_ops;
-
 void gic_set_irqchip_flags(unsigned long flags)
 {
 	gic_chip.flags |= flags;
@@ -878,7 +836,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
 	int gic_irqs, irq_base, i;
-	int nr_routable_irqs;
 
 	BUG_ON(gic_nr >= MAX_GIC_NR);
 
@@ -934,15 +891,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	gic->gic_irqs = gic_irqs;
 
 	if (node) {		/* DT case */
-		const struct irq_domain_ops *ops = &gic_irq_domain_hierarchy_ops;
-
-		if (!of_property_read_u32(node, "arm,routable-irqs",
-					  &nr_routable_irqs)) {
-			ops = &gic_irq_domain_ops;
-			gic_irqs = nr_routable_irqs;
-		}
-
-		gic->domain = irq_domain_add_linear(node, gic_irqs, ops, gic);
+		gic->domain = irq_domain_add_linear(node, gic_irqs,
+						    &gic_irq_domain_hierarchy_ops,
+						    gic);
 	} else {		/* Non-DT case */
 		/*
 		 * For primary GICs, skip over SGIs.
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 4637213..9de976b 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -114,11 +114,5 @@ int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
 unsigned long gic_get_sgir_physaddr(void);
 
-extern const struct irq_domain_ops *gic_routable_irq_domain_ops;
-static inline void __init register_routable_domain_ops
-					(const struct irq_domain_ops *ops)
-{
-	gic_routable_irq_domain_ops = ops;
-}
 #endif /* __ASSEMBLY */
 #endif
-- 
2.1.3
