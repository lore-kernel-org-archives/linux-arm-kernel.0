From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:18 -0400
Subject: [PATCH 02/13] ARM: gic: add CPU migration support
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required by the big.LITTLE switcher code.

The gic_migrate_target() changes the CPU interface mapping for the
current CPU to redirect SGIs to the specified interface, and it also
updates the target CPU for each interrupts to that CPU interface
if they were targeting the current interface.  Finally, pending
SGIs for the current CPU are forwarded to the new interface.

Because Linux does not use it, the SGI source information for the
forwarded SGIs is not preserved.  Neither is the source information
for the SGIs sent by the current CPU to other CPUs adjusted to match
the new CPU interface mapping.  The required registers are banked so
only the target CPU could do it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/irqchip/irq-gic.c       | 81 +++++++++++++++++++++++++++++++++++++++--
 include/linux/irqchip/arm-gic.h |  4 ++
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ee7c503120..6bd5a8c1aa 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -253,10 +253,9 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
+	raw_spin_lock(&irq_controller_lock);
 	mask = 0xff << shift;
 	bit = gic_cpu_map[cpu] << shift;
-
-	raw_spin_lock(&irq_controller_lock);
 	val = readl_relaxed(reg) & ~mask;
 	writel_relaxed(val | bit, reg);
 	raw_spin_unlock(&irq_controller_lock);
@@ -646,7 +645,9 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
 	int cpu;
-	unsigned long map = 0;
+	unsigned long flags, map = 0;
+
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
@@ -660,6 +661,80 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 	/* this always happens on GIC0 */
 	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
+}
+#endif
+
+#ifdef CONFIG_BL_SWITCHER
+/*
+ * gic_migrate_target - migrate IRQs to another PU interface
+ *
+ * @new_cpu_id: the CPU target ID to migrate IRQs to
+ *
+ * Migrate all peripheral interrupts with a target matching the current CPU
+ * to the interface corresponding to @new_cpu_id.  The CPU interface mapping
+ * is also updated.  Targets to other CPU interfaces are unchanged.
+ * This must be called with IRQs locally disabled.
+ */
+void gic_migrate_target(unsigned int new_cpu_id)
+{
+	unsigned int old_cpu_id, gic_irqs, gic_nr = 0;
+	void __iomem *dist_base;
+	int i, ror_val, cpu = smp_processor_id();
+	u32 val, old_mask, active_mask;
+
+	if (gic_nr >= MAX_GIC_NR)
+		BUG();
+
+	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
+	if (!dist_base)
+		return;
+	gic_irqs = gic_data[gic_nr].gic_irqs;
+
+	old_cpu_id = __ffs(gic_cpu_map[cpu]);
+	old_mask = 0x01010101 << old_cpu_id;
+	ror_val = (old_cpu_id - new_cpu_id) & 31;
+
+	raw_spin_lock(&irq_controller_lock);
+
+	gic_cpu_map[cpu] = 1 << new_cpu_id;
+
+	for (i = 8; i < DIV_ROUND_UP(gic_irqs, 4); i++) {
+		val = readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
+		active_mask = val & old_mask;
+		if (active_mask) {
+			val &= ~active_mask;
+			val |= ror32(active_mask, ror_val);
+			writel_relaxed(val, dist_base + GIC_DIST_TARGET + i*4);
+		}
+	}
+
+	raw_spin_unlock(&irq_controller_lock);
+
+	/*
+	 * Now let's migrate and clear any potential SGIs that might be
+	 * pending for us (old_cpu_id).  Since GIC_DIST_SGI_PENDING_SET
+	 * is a banked register, we can only forward the SGI using
+	 * GIC_DIST_SOFTINT.  The original SGI source is lost but Linux
+	 * doesn't use that information anyway.
+	 *
+	 * For the same reason we do not adjust SGI source information
+	 * for previously sent SGIs by us to other CPUs either.
+	 */
+	for (i = 0; i < 16; i += 4) {
+		int j;
+		val = readl_relaxed(dist_base + GIC_DIST_SGI_PENDING_SET + i);
+		if (!val)
+			continue;
+		writel_relaxed(val, dist_base + GIC_DIST_SGI_PENDING_CLEAR + i);
+		for (j = i; j < i + 4; j++) {
+			if (val & 0xff)
+				writel_relaxed((1 << (new_cpu_id + 16)) | j,
+						dist_base + GIC_DIST_SOFTINT);
+			val >>= 8;
+		}
+	}
 }
 #endif
 
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 3e203eb23c..40bfcac959 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -31,6 +31,8 @@
 #define GIC_DIST_TARGET			0x800
 #define GIC_DIST_CONFIG			0xc00
 #define GIC_DIST_SOFTINT		0xf00
+#define GIC_DIST_SGI_PENDING_CLEAR	0xf10
+#define GIC_DIST_SGI_PENDING_SET	0xf20
 
 #define GICH_HCR			0x0
 #define GICH_VTR			0x4
@@ -73,6 +75,8 @@ static inline void gic_init(unsigned int nr, int start,
 	gic_init_bases(nr, start, dist, cpu, 0, NULL);
 }
 
+void gic_migrate_target(unsigned int new_cpu_id);
+
 #endif /* __ASSEMBLY */
 
 #endif
-- 
1.8.1.2
