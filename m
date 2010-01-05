From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 5 Jan 2010 09:56:34 +0530
Subject: [PATCH] gic: implement set_type
Message-ID: <mailman.449.1274073676.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement set_type() to allow configuration of the trigger type.

Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/common/gic.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 337741f..7dfa9a8 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -108,6 +108,51 @@ static void gic_unmask_irq(unsigned int irq)
 	spin_unlock(&irq_controller_lock);
 }
 
+static int gic_set_type(unsigned int irq, unsigned int type)
+{
+	void __iomem *base = gic_dist_base(irq);
+	unsigned int gicirq = gic_irq(irq);
+	u32 enablemask = 1 << (gicirq % 32);
+	u32 enableoff = (gicirq / 32) * 4;
+	u32 confmask = 0x2 << ((gicirq % 16) * 2);
+	u32 confoff = (gicirq / 16) * 4;
+	bool enabled = false;
+	u32 val;
+
+	/* Interrupt configuration for SGIs can't be changed */
+	if (gicirq < 16)
+		return -EINVAL;
+
+	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
+
+	spin_lock(&irq_controller_lock);
+
+	val = readl(base + GIC_DIST_CONFIG + confoff);
+	if (type == IRQ_TYPE_LEVEL_HIGH)
+		val &= ~confmask;
+	else if (type == IRQ_TYPE_EDGE_RISING)
+		val |= confmask;
+
+	/*
+	 * As recommended by the spec, disable the interrupt before changing
+	 * the configuration
+	 */
+	if (readl(base + GIC_DIST_ENABLE_SET + enableoff) & enablemask) {
+		writel(enablemask, base + GIC_DIST_ENABLE_CLEAR + enableoff);
+		enabled = true;
+	}
+
+	writel(val, base + GIC_DIST_CONFIG + confoff);
+
+	if (enabled)
+		writel(enablemask, base + GIC_DIST_ENABLE_SET + enableoff);
+
+	spin_unlock(&irq_controller_lock);
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 static int gic_set_cpu(unsigned int irq, const struct cpumask *mask_val)
 {
@@ -161,6 +206,7 @@ static struct irq_chip gic_chip = {
 	.ack		= gic_ack_irq,
 	.mask		= gic_mask_irq,
 	.unmask		= gic_unmask_irq,
+	.set_type	= gic_set_type,
 #ifdef CONFIG_SMP
 	.set_affinity	= gic_set_cpu,
 #endif
-- 
1.7.0
