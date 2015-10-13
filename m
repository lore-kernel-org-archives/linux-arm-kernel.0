From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Oct 2015 12:51:41 +0100
Subject: [PATCH v2 13/17] irqchip/gic: Kill the xlate method
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444737105-31573-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are now left with only two use models for the GIC driver:
- Via a firmware interface, which mandates a hierarchical domain,
  and the use of the 'translate' method
- The legacy platforms, which assume irq==hwirq, hence not using
  the 'xlate' method.

The logical conclusion is that we can now nuke the 'xlate' method
altogether.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 491eacb..1d0e768 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -916,30 +916,6 @@ static void gic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
 {
 }
 
-static int gic_irq_domain_xlate(struct irq_domain *d,
-				struct device_node *controller,
-				const u32 *intspec, unsigned int intsize,
-				unsigned long *out_hwirq, unsigned int *out_type)
-{
-	unsigned long ret = 0;
-
-	if (irq_domain_get_of_node(d) != controller)
-		return -EINVAL;
-	if (intsize < 3)
-		return -EINVAL;
-
-	/* Get the interrupt number and add 16 to skip over SGIs */
-	*out_hwirq = intspec[1] + 16;
-
-	/* For SPIs, we need to add 16 more to get the GIC irq ID number */
-	if (!intspec[0])
-		*out_hwirq += 16;
-
-	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
-
-	return ret;
-}
-
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -1021,7 +997,6 @@ static const struct irq_domain_ops gic_irq_domain_hierarchy_ops = {
 static const struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
 	.unmap = gic_irq_domain_unmap,
-	.xlate = gic_irq_domain_xlate,
 };
 
 static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
-- 
2.1.4
