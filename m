From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Wed, 26 Aug 2015 14:35:55 -0500
Subject: [PATCH v2 1/1] irqchip: imx-gpcv2:  Simplify the implementation
Message-ID: <1440617755-2942-1-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Sudeep Holla's review comments, the implementation can
be simplified by using the two flags: IRQCHIP_SKIP_SET_WAKE and
IRQCHIP_MASK_ON_SUSPEND. This patch enables the flags in the
struct irq_chip and removes the unnecessory syscore_ops callbacks.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
Change log:
	v2 - Fixed the typo in the subject.

 drivers/irqchip/irq-imx-gpcv2.c | 83 +++++++----------------------------------
 1 file changed, 13 insertions(+), 70 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 4a97afa..e25df78 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -22,7 +22,6 @@ struct gpcv2_irqchip_data {
 	struct raw_spinlock    rlock;
 	void __iomem       *gpc_base;
 	u32 wakeup_sources[IMR_NUM];
-	u32 saved_irq_mask[IMR_NUM];
 	u32 cpu2wakeup;
 };

@@ -30,79 +29,25 @@ static struct gpcv2_irqchip_data *imx_gpcv2_instance;

 u32 imx_gpcv2_get_wakeup_source(u32 **sources)
 {
-	if (!imx_gpcv2_instance)
+	struct gpcv2_irqchip_data *cd;
+	void __iomem *reg;
+	int i;
+
+	cd = imx_gpcv2_instance;
+	if (!cd)
 		return 0;

+	for (i = 0; i < IMR_NUM; i++) {
+		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
+		cd->wakeup_sources[i] = readl_relaxed(reg);
+	}
+
 	if (sources)
-		*sources = imx_gpcv2_instance->wakeup_sources;
+		*sources = cd->wakeup_sources;

 	return IMR_NUM;
 }

-static int gpcv2_wakeup_source_save(void)
-{
-	struct gpcv2_irqchip_data *cd;
-	void __iomem *reg;
-	int i;
-
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return 0;
-
-	for (i = 0; i < IMR_NUM; i++) {
-		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
-		cd->saved_irq_mask[i] = readl_relaxed(reg);
-		writel_relaxed(cd->wakeup_sources[i], reg);
-	}
-
-	return 0;
-}
-
-static void gpcv2_wakeup_source_restore(void)
-{
-	struct gpcv2_irqchip_data *cd;
-	void __iomem *reg;
-	int i;
-
-	cd = imx_gpcv2_instance;
-	if (!cd)
-		return;
-
-	for (i = 0; i < IMR_NUM; i++) {
-		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
-		writel_relaxed(cd->saved_irq_mask[i], reg);
-	}
-}
-
-static struct syscore_ops imx_gpcv2_syscore_ops = {
-	.suspend	= gpcv2_wakeup_source_save,
-	.resume		= gpcv2_wakeup_source_restore,
-};
-
-static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
-{
-	struct gpcv2_irqchip_data *cd = d->chip_data;
-	unsigned int idx = d->hwirq / 32;
-	unsigned long flags;
-	void __iomem *reg;
-	u32 mask, val;
-
-	raw_spin_lock_irqsave(&cd->rlock, flags);
-	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
-	mask = 1 << d->hwirq % 32;
-	val = cd->wakeup_sources[idx];
-
-	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
-	raw_spin_unlock_irqrestore(&cd->rlock, flags);
-
-	/*
-	 * Do *not* call into the parent, as the GIC doesn't have any
-	 * wake-up facility...
-	 */
-
-	return 0;
-}
-
 static void imx_gpcv2_irq_unmask(struct irq_data *d)
 {
 	struct gpcv2_irqchip_data *cd = d->chip_data;
@@ -140,11 +85,11 @@ static struct irq_chip gpcv2_irqchip_data_chip = {
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_mask		= imx_gpcv2_irq_mask,
 	.irq_unmask		= imx_gpcv2_irq_unmask,
-	.irq_set_wake		= imx_gpcv2_irq_set_wake,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 };

 static int imx_gpcv2_domain_xlate(struct irq_domain *domain,
@@ -253,7 +198,6 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	for (i = 0; i < IMR_NUM; i++) {
 		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
 		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
-		cd->wakeup_sources[i] = ~0;
 	}

 	/* Let CORE0 as the default CPU to wake up by GPC */
@@ -267,7 +211,6 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);

 	imx_gpcv2_instance = cd;
-	register_syscore_ops(&imx_gpcv2_syscore_ops);

 	return 0;
 }
--
2.5.0.rc2
