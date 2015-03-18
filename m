From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Mar 2015 11:01:24 +0000
Subject: [PATCH v4 3/3] irqchip: GICv3: Add support for irq_{get,
 set}_irqchip_state
In-Reply-To: <1426676484-21812-1-git-send-email-marc.zyngier@arm.com>
References: <1426676484-21812-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426676484-21812-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the required hooks for the internal state of an interrupt
to be exposed to other subsystems.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 83 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd8850d..4f2fb62 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -195,6 +195,19 @@ static void gic_enable_redist(bool enable)
 /*
  * Routines to disable, enable, EOI and route interrupts
  */
+static int gic_peek_irq(struct irq_data *d, u32 offset)
+{
+	u32 mask = 1 << (gic_irq(d) % 32);
+	void __iomem *base;
+
+	if (gic_irq_in_rdist(d))
+		base = gic_data_rdist_sgi_base();
+	else
+		base = gic_data.dist_base;
+
+	return !!(readl_relaxed(base + offset + (gic_irq(d) / 32) * 4) & mask);
+}
+
 static void gic_poke_irq(struct irq_data *d, u32 offset)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
@@ -223,6 +236,61 @@ static void gic_unmask_irq(struct irq_data *d)
 	gic_poke_irq(d, GICD_ISENABLER);
 }
 
+static int gic_irq_set_irqchip_state(struct irq_data *d,
+				     enum irqchip_irq_state which, bool val)
+{
+	u32 reg;
+
+	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
+		return -EINVAL;
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		reg = val ? GICD_ISPENDR : GICD_ICPENDR;
+		break;
+
+	case IRQCHIP_STATE_ACTIVE:
+		reg = val ? GICD_ISACTIVER : GICD_ICACTIVER;
+		break;
+
+	case IRQCHIP_STATE_MASKED:
+		reg = val ? GICD_ICENABLER : GICD_ISENABLER;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	gic_poke_irq(d, reg);
+	return 0;
+}
+
+static int gic_irq_get_irqchip_state(struct irq_data *d,
+				     enum irqchip_irq_state which, bool *val)
+{
+	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
+		return -EINVAL;
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		*val = gic_peek_irq(d, GICD_ISPENDR);
+		break;
+
+	case IRQCHIP_STATE_ACTIVE:
+		*val = gic_peek_irq(d, GICD_ISACTIVER);
+		break;
+
+	case IRQCHIP_STATE_MASKED:
+		*val = !gic_peek_irq(d, GICD_ISENABLER);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void gic_eoi_irq(struct irq_data *d)
 {
 	gic_write_eoir(gic_irq(d));
@@ -418,19 +486,6 @@ static void gic_cpu_init(void)
 }
 
 #ifdef CONFIG_SMP
-static int gic_peek_irq(struct irq_data *d, u32 offset)
-{
-	u32 mask = 1 << (gic_irq(d) % 32);
-	void __iomem *base;
-
-	if (gic_irq_in_rdist(d))
-		base = gic_data_rdist_sgi_base();
-	else
-		base = gic_data.dist_base;
-
-	return !!(readl_relaxed(base + offset + (gic_irq(d) / 32) * 4) & mask);
-}
-
 static int gic_secondary_init(struct notifier_block *nfb,
 			      unsigned long action, void *hcpu)
 {
@@ -601,6 +656,8 @@ static struct irq_chip gic_chip = {
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 };
 
 #define GIC_ID_NR		(1U << gic_data.rdists.id_bits)
-- 
2.1.4
