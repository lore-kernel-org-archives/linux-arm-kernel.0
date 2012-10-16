From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 16 Oct 2012 14:21:48 +0100
Subject: [RFC PATCH 4/4] ARM: gic: use a private mapping for CPU target
 interfaces
In-Reply-To: <1350393709-23546-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1350393709-23546-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1350393709-23546-5-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

The GIC interface numbering does not necessarily follow the logical
CPU numbering, especially for complex topologies such as multi-cluster
systems.

Fortunately we can easily probe the GIC to create a mapping as the
Interrupt Processor Targets Registers for the first 32 interrupts are
read-only, and each field returns a value that always corresponds to
the processor reading the register.

Initially all mappings target all CPUs in case an IPI is required to
boot secondary CPUs.  It is refined as those CPUs discover what their
actual mapping is.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/gic.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index aa52699..1338a55 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -70,6 +70,13 @@ struct gic_chip_data {
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 /*
+ * The GIC mapping of CPU interfaces does not necessarily match
+ * the logical CPU numbering.  Let's use a mapping as returned
+ * by the GIC itself.
+ */
+static u8 gic_cpu_map[8] __read_mostly;
+
+/*
  * Supported arch specific GIC irq extension.
  * Default make them NULL.
  */
@@ -242,7 +249,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 		return -EINVAL;
 
 	mask = 0xff << shift;
-	bit = 1 << (cpu_logical_map(cpu) + shift);
+	bit = gic_cpu_map[cpu] << shift;
 
 	raw_spin_lock(&irq_controller_lock);
 	val = readl_relaxed(reg) & ~mask;
@@ -349,11 +356,6 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	u32 cpumask;
 	unsigned int gic_irqs = gic->gic_irqs;
 	void __iomem *base = gic_data_dist_base(gic);
-	u32 cpu = cpu_logical_map(smp_processor_id());
-
-	cpumask = 1 << cpu;
-	cpumask |= cpumask << 8;
-	cpumask |= cpumask << 16;
 
 	writel_relaxed(0, base + GIC_DIST_CTRL);
 
@@ -366,6 +368,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	/*
 	 * Set all global interrupts to this CPU only.
 	 */
+	cpumask = readl_relaxed(base + GIC_DIST_TARGET + 0);
 	for (i = 32; i < gic_irqs; i += 4)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
 
@@ -389,9 +392,25 @@ static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
 {
 	void __iomem *dist_base = gic_data_dist_base(gic);
 	void __iomem *base = gic_data_cpu_base(gic);
+	unsigned int cpu_mask, cpu = smp_processor_id();
 	int i;
 
 	/*
+	 * Get what the GIC says our CPU mask is.
+	 */
+	BUG_ON(cpu >= 8);
+	cpu_mask = readl_relaxed(dist_base + GIC_DIST_TARGET + 0);
+	gic_cpu_map[cpu] = cpu_mask;
+
+	/*
+	 * Clear our mask from the other map entries in case they're
+	 * still undefined.
+	 */
+	for (i = 0; i < 8; i++)
+		if (i != cpu)
+			gic_cpu_map[i] &= ~cpu_mask;
+
+	/*
 	 * Deal with the banked PPI and SGI interrupts - disable all
 	 * PPI interrupts, ensure all SGI interrupts are enabled.
 	 */
@@ -646,7 +665,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 {
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
-	int gic_irqs, irq_base;
+	int gic_irqs, irq_base, i;
 
 	BUG_ON(gic_nr >= MAX_GIC_NR);
 
@@ -683,6 +702,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	}
 
 	/*
+	 * Initialize the CPU interface map to all CPUs.
+	 * It will be refined as each CPU probes its ID.
+	 */
+	for (i = 0; i < 8; i++)
+		gic_cpu_map[i] = 0xff;
+
+	/*
 	 * For primary GICs, skip over SGIs.
 	 * For secondary GICs, skip over PPIs, too.
 	 */
@@ -737,7 +763,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
-		map |= 1 << cpu_logical_map(cpu);
+		map |= gic_cpu_map[cpu];
 
 	/*
 	 * Ensure that stores to Normal memory are visible to the
-- 
1.7.12
