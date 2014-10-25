From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 25 Oct 2014 11:14:56 +0100
Subject: [PATCH 2/3] irqchip: GIC: Add support for irq_{get, set}_irqchip_state
In-Reply-To: <1414232097-4328-1-git-send-email-marc.zyngier@arm.com>
References: <1414232097-4328-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1414232097-4328-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the required hooks for the internal state of an interrupt
to be exposed to other subsystems.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 70 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 38493ff..d78169e 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -151,12 +151,22 @@ static inline unsigned int gic_irq(struct irq_data *d)
 /*
  * Routines to acknowledge, disable and enable interrupts
  */
-static void gic_mask_irq(struct irq_data *d)
+static void gic_poke_irq(struct irq_data *d, u32 offset)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
+	writel_relaxed(mask, gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4);
+}
 
+static int gic_peek_irq(struct irq_data *d, u32 offset)
+{
+	u32 mask = 1 << (gic_irq(d) % 32);
+	return !!(readl_relaxed(gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4) & mask);
+}
+
+static void gic_mask_irq(struct irq_data *d)
+{
 	raw_spin_lock(&irq_controller_lock);
-	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
+	gic_poke_irq(d, GIC_DIST_ENABLE_CLEAR);
 	if (gic_arch_extn.irq_mask)
 		gic_arch_extn.irq_mask(d);
 	raw_spin_unlock(&irq_controller_lock);
@@ -164,12 +174,10 @@ static void gic_mask_irq(struct irq_data *d)
 
 static void gic_unmask_irq(struct irq_data *d)
 {
-	u32 mask = 1 << (gic_irq(d) % 32);
-
 	raw_spin_lock(&irq_controller_lock);
 	if (gic_arch_extn.irq_unmask)
 		gic_arch_extn.irq_unmask(d);
-	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
+	gic_poke_irq(d, GIC_DIST_ENABLE_SET);
 	raw_spin_unlock(&irq_controller_lock);
 }
 
@@ -184,6 +192,56 @@ static void gic_eoi_irq(struct irq_data *d)
 	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
+static void gic_irq_set_irqchip_state(struct irq_data *d, int state, int val)
+{
+	u32 reg;
+
+	switch (state) {
+	case IRQCHIP_STATE_PENDING:
+		reg = val ? GIC_DIST_PENDING_SET : GIC_DIST_PENDING_CLEAR;
+		break;
+
+	case IRQCHIP_STATE_ACTIVE:
+		reg = val ? GIC_DIST_ACTIVE_SET : GIC_DIST_ACTIVE_CLEAR;
+		break;
+
+	case IRQCHIP_STATE_MASKED:
+		reg = val ? GIC_DIST_ENABLE_CLEAR : GIC_DIST_ENABLE_SET;
+		break;
+
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	gic_poke_irq(d, reg);
+}
+
+static int gic_irq_get_irqchip_state(struct irq_data *d, int state)
+{
+	int val;
+
+	switch (state) {
+	case IRQCHIP_STATE_PENDING:
+		val = gic_peek_irq(d, GIC_DIST_PENDING_SET);
+		break;
+
+	case IRQCHIP_STATE_ACTIVE:
+		val = gic_peek_irq(d, GIC_DIST_ACTIVE_SET);
+		break;
+
+	case IRQCHIP_STATE_MASKED:
+		val = !gic_peek_irq(d, GIC_DIST_ENABLE_SET);
+		break;
+
+	default:
+		WARN_ON(1);
+		val = 0;
+	}
+
+	return val;
+}
+
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	void __iomem *base = gic_dist_base(d);
@@ -322,6 +380,8 @@ static struct irq_chip gic_chip = {
 	.irq_set_affinity	= gic_set_affinity,
 #endif
 	.irq_set_wake		= gic_set_wake,
+	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 };
 
 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
-- 
2.1.0
