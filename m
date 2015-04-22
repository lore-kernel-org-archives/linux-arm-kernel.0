From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Apr 2015 18:20:04 +0100
Subject: [PATCH] irqchip: gic: Drop support for gic_arch_extn
Message-ID: <1429723204-25868-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the users of gic_arch_extn have been fixed, drop the
"feature" for good. This leads to the removal of some now useless
locking.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
This is the final blow for this ill fated son of a hack.
The last user (iMX6) has been merged via arm-soc, and I don't
want to leave that thing hanging around for too long!

 drivers/irqchip/irq-gic.c       | 71 +----------------------------------------
 include/linux/irqchip/arm-gic.h |  2 --
 2 files changed, 1 insertion(+), 72 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a6ce347..dd98914 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -80,19 +80,6 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 #define NR_GIC_CPU_IF 8
 static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
 
-/*
- * Supported arch specific GIC irq extension.
- * Default make them NULL.
- */
-struct irq_chip gic_arch_extn = {
-	.irq_eoi	= NULL,
-	.irq_mask	= NULL,
-	.irq_unmask	= NULL,
-	.irq_retrigger	= NULL,
-	.irq_set_type	= NULL,
-	.irq_set_wake	= NULL,
-};
-
 #ifndef MAX_GIC_NR
 #define MAX_GIC_NR	1
 #endif
@@ -165,34 +152,16 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
 
 static void gic_mask_irq(struct irq_data *d)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 	gic_poke_irq(d, GIC_DIST_ENABLE_CLEAR);
-	if (gic_arch_extn.irq_mask)
-		gic_arch_extn.irq_mask(d);
-	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
 
 static void gic_unmask_irq(struct irq_data *d)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&irq_controller_lock, flags);
-	if (gic_arch_extn.irq_unmask)
-		gic_arch_extn.irq_unmask(d);
 	gic_poke_irq(d, GIC_DIST_ENABLE_SET);
-	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	if (gic_arch_extn.irq_eoi) {
-		raw_spin_lock(&irq_controller_lock);
-		gic_arch_extn.irq_eoi(d);
-		raw_spin_unlock(&irq_controller_lock);
-	}
-
 	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
@@ -249,8 +218,6 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	void __iomem *base = gic_dist_base(d);
 	unsigned int gicirq = gic_irq(d);
-	unsigned long flags;
-	int ret;
 
 	/* Interrupt configuration for SGIs can't be changed */
 	if (gicirq < 16)
@@ -261,25 +228,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 			    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&irq_controller_lock, flags);
-
-	if (gic_arch_extn.irq_set_type)
-		gic_arch_extn.irq_set_type(d, type);
-
-	ret = gic_configure_irq(gicirq, type, base, NULL);
-
-	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
-
-	return ret;
-}
-
-static int gic_retrigger(struct irq_data *d)
-{
-	if (gic_arch_extn.irq_retrigger)
-		return gic_arch_extn.irq_retrigger(d);
-
-	/* the genirq layer expects 0 if we can't retrigger in hardware */
-	return 0;
+	return gic_configure_irq(gicirq, type, base, NULL);
 }
 
 #ifdef CONFIG_SMP
@@ -310,21 +259,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #endif
 
-#ifdef CONFIG_PM
-static int gic_set_wake(struct irq_data *d, unsigned int on)
-{
-	int ret = -ENXIO;
-
-	if (gic_arch_extn.irq_set_wake)
-		ret = gic_arch_extn.irq_set_wake(d, on);
-
-	return ret;
-}
-
-#else
-#define gic_set_wake	NULL
-#endif
-
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
@@ -383,11 +317,9 @@ static struct irq_chip gic_chip = {
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
-	.irq_retrigger		= gic_retrigger,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= gic_set_affinity,
 #endif
-	.irq_set_wake		= gic_set_wake,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 };
@@ -1053,7 +985,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		set_handle_irq(gic_handle_irq);
 	}
 
-	gic_chip.flags |= gic_arch_extn.flags;
 	gic_dist_init(gic);
 	gic_cpu_init(gic);
 	gic_pm_init(gic);
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 36ec4ae..9de976b 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -95,8 +95,6 @@
 
 struct device_node;
 
-extern struct irq_chip gic_arch_extn;
-
 void gic_set_irqchip_flags(unsigned long flags);
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
-- 
2.1.4
