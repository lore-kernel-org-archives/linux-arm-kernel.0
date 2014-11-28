From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 28 Nov 2014 17:26:53 +0000
Subject: [PATCH 9/9] irqchip: gic: Drop support for gic_arch_extn
In-Reply-To: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
References: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417195613-8447-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the only user of gic_arch_extn has been fixed, drop the
"feature" for good. This leads to the removal of some now useless
locking.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c       | 46 +----------------------------------------
 include/linux/irqchip/arm-gic.h |  2 --
 2 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 5a71be7..663dca9 100644
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
@@ -155,32 +142,18 @@ static void gic_mask_irq(struct irq_data *d)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
 
-	raw_spin_lock(&irq_controller_lock);
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
-	if (gic_arch_extn.irq_mask)
-		gic_arch_extn.irq_mask(d);
-	raw_spin_unlock(&irq_controller_lock);
 }
 
 static void gic_unmask_irq(struct irq_data *d)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
 
-	raw_spin_lock(&irq_controller_lock);
-	if (gic_arch_extn.irq_unmask)
-		gic_arch_extn.irq_unmask(d);
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
-	raw_spin_unlock(&irq_controller_lock);
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
 
@@ -196,23 +169,13 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	raw_spin_lock(&irq_controller_lock);
-
-	if (gic_arch_extn.irq_set_type)
-		gic_arch_extn.irq_set_type(d, type);
-
 	gic_configure_irq(gicirq, type, base, NULL);
 
-	raw_spin_unlock(&irq_controller_lock);
-
 	return 0;
 }
 
 static int gic_retrigger(struct irq_data *d)
 {
-	if (gic_arch_extn.irq_retrigger)
-		return gic_arch_extn.irq_retrigger(d);
-
 	/* the genirq layer expects 0 if we can't retrigger in hardware */
 	return 0;
 }
@@ -247,14 +210,8 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #ifdef CONFIG_PM
 static int gic_set_wake(struct irq_data *d, unsigned int on)
 {
-	int ret = -ENXIO;
-
-	if (gic_arch_extn.irq_set_wake)
-		ret = gic_arch_extn.irq_set_wake(d, on);
-
-	return ret;
+	return -ENXIO;
 }
-
 #else
 #define gic_set_wake	NULL
 #endif
@@ -1029,7 +986,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		set_handle_irq(gic_handle_irq);
 	}
 
-	gic_chip.flags |= gic_arch_extn.flags;
 	gic_dist_init(gic);
 	gic_cpu_init(gic);
 	gic_pm_init(gic);
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 60b09ed..1911f06 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -93,8 +93,6 @@
 
 struct device_node;
 
-extern struct irq_chip gic_arch_extn;
-
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
-- 
2.1.3
