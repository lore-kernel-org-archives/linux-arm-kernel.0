From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 10 Jul 2014 10:04:00 +0800
Subject: [PATCH v10 01/11] irq: gic: support hip04 gic
In-Reply-To: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1404957850-13340-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a little difference between ARM GIC and HiP04 GIC.

* HiP04 GIC could support 16 cores at most, and ARM GIC could support
8 cores at most. So the difination on GIC_DIST_TARGET registers are
different since CPU interfaces are increased from 8-bit to 16-bit.

* HiP04 GIC could support 510 interrupts at most, and ARM GIC could
support 1020 interrupts at most.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 Documentation/devicetree/bindings/arm/gic.txt |   1 +
 drivers/irqchip/irq-gic.c                     | 141 +++++++++++++++++++-------
 2 files changed, 108 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 5573c08..150f7d6 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -16,6 +16,7 @@ Main node required properties:
 	"arm,cortex-a9-gic"
 	"arm,cortex-a7-gic"
 	"arm,arm11mp-gic"
+	"hisilicon,hip04-gic"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source.  The type shall be a <u32> and the value shall be 3.
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 508b815..55c34fb 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -69,6 +69,9 @@ struct gic_chip_data {
 #ifdef CONFIG_GIC_NON_BANKED
 	void __iomem *(*get_base)(union gic_base *);
 #endif
+	u32 nr_cpu_if;
+	u32 nr_cpu_if_mask;
+	u32 cpu_target_shift;
 };
 
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
@@ -77,9 +80,11 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
  * The GIC mapping of CPU interfaces does not necessarily match
  * the logical CPU numbering.  Let's use a mapping as returned
  * by the GIC itself.
+ *
+ * Hisilicon HiP04 extends the number of CPU interface from 8 to 16.
  */
-#define NR_GIC_CPU_IF 8
-static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
+#define NR_GIC_CPU_IF	16
+static u16 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
 
 /*
  * Supported arch specific GIC irq extension.
@@ -218,12 +223,41 @@ static int gic_retrigger(struct irq_data *d)
 	return 0;
 }
 
+static bool gic_is_standard(struct gic_chip_data *gic_data)
+{
+	return (gic_data->nr_cpu_if == 8);
+}
+
+static u32 irqs_per_target_reg(struct gic_chip_data *gic_data)
+{
+	return (32 / gic_data->nr_cpu_if);
+}
+
+static u32 irq_to_target_reg(struct gic_chip_data *gic_data, u32 irq)
+{
+	if (!gic_is_standard(gic_data))
+		irq *= 2;
+	irq &= ~3U;
+	return (irq + GIC_DIST_TARGET);
+}
+
 #ifdef CONFIG_SMP
+static u32 irq_to_core_shift(struct irq_data *d)
+{
+	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
+	unsigned int i = gic_irq(d);
+
+	if (gic_is_standard(gic_data))
+		return ((i % 4) << 3);
+	return ((i % 2) << 4);
+}
+
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
-	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
+	void __iomem *reg;
+	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
+	unsigned int cpu, shift = irq_to_core_shift(d);
 	u32 val, mask, bit;
 
 	if (!force)
@@ -231,11 +265,13 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	else
 		cpu = cpumask_first(mask_val);
 
-	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
+	if (cpu >= gic_data->nr_cpu_if || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
+	reg = gic_dist_base(d) + irq_to_target_reg(gic_data, gic_irq(d));
+
 	raw_spin_lock(&irq_controller_lock);
-	mask = 0xff << shift;
+	mask = gic_data->nr_cpu_if_mask << irq_to_core_shift(d);
 	bit = gic_cpu_map[cpu] << shift;
 	val = readl_relaxed(reg) & ~mask;
 	writel_relaxed(val | bit, reg);
@@ -335,15 +371,20 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 	irq_set_chained_handler(irq, gic_handle_cascade_irq);
 }
 
-static u8 gic_get_cpumask(struct gic_chip_data *gic)
+static u16 gic_get_cpumask(struct gic_chip_data *gic)
 {
 	void __iomem *base = gic_data_dist_base(gic);
 	u32 mask, i;
 
-	for (i = mask = 0; i < 32; i += 4) {
-		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
+	/*
+	 * ARM GIC uses 8 registers for interrupt 0-31,
+	 * HiP04 GIC uses 16 registers for interrupt 0-31.
+	 */
+	for (i = mask = 0; i < 32; i++) {
+		mask = readl_relaxed(base + irq_to_target_reg(gic, i));
 		mask |= mask >> 16;
-		mask |= mask >> 8;
+		if (gic_is_standard(gic))
+			mask |= mask >> 8;
 		if (mask)
 			break;
 	}
@@ -351,6 +392,10 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 	if (!mask)
 		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
 
+	/* ARM GIC needs 8-bit cpu mask, HiP04 GIC needs 16-bit cpu mask. */
+	if (gic_is_standard(gic))
+		mask &= 0xff;
+
 	return mask;
 }
 
@@ -367,10 +412,11 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	 * Set all global interrupts to this CPU only.
 	 */
 	cpumask = gic_get_cpumask(gic);
-	cpumask |= cpumask << 8;
+	if (gic_is_standard(gic))
+		cpumask |= cpumask << 8;
 	cpumask |= cpumask << 16;
-	for (i = 32; i < gic_irqs; i += 4)
-		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
+	for (i = 32; i < gic_irqs; i++)
+		writel_relaxed(cpumask, base + irq_to_target_reg(gic, i));
 
 	gic_dist_config(base, gic_irqs, NULL);
 
@@ -387,7 +433,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 	/*
 	 * Get what the GIC says our CPU mask is.
 	 */
-	BUG_ON(cpu >= NR_GIC_CPU_IF);
+	BUG_ON(cpu >= gic->nr_cpu_if);
 	cpu_mask = gic_get_cpumask(gic);
 	gic_cpu_map[cpu] = cpu_mask;
 
@@ -395,7 +441,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 	 * Clear our mask from the other map entries in case they're
 	 * still undefined.
 	 */
-	for (i = 0; i < NR_GIC_CPU_IF; i++)
+	for (i = 0; i < gic->nr_cpu_if; i++)
 		if (i != cpu)
 			gic_cpu_map[i] &= ~cpu_mask;
 
@@ -437,9 +483,10 @@ static void gic_dist_save(unsigned int gic_nr)
 		gic_data[gic_nr].saved_spi_conf[i] =
 			readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
 
-	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
+	for (i = 0; i < gic_irqs; i += irqs_per_target_reg(&gic_data[gic_nr]))
 		gic_data[gic_nr].saved_spi_target[i] =
-			readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
+			readl_relaxed(dist_base +
+				      irq_to_target_reg(&gic_data[gic_nr], i));
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
 		gic_data[gic_nr].saved_spi_enable[i] =
@@ -478,9 +525,9 @@ static void gic_dist_restore(unsigned int gic_nr)
 		writel_relaxed(0xa0a0a0a0,
 			dist_base + GIC_DIST_PRI + i * 4);
 
-	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
+	for (i = 0; i < gic_irqs; i += irqs_per_target_reg(&gic_data[gic_nr]))
 		writel_relaxed(gic_data[gic_nr].saved_spi_target[i],
-			dist_base + GIC_DIST_TARGET + i * 4);
+			dist_base + irq_to_target_reg(&gic_data[gic_nr], i));
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
 		writel_relaxed(gic_data[gic_nr].saved_spi_enable[i],
@@ -618,9 +665,16 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	 */
 	dmb(ishst);
 
-	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
-
+	/*
+	 * CPUTargetList -- bit[23:16] in GIC_DIST_SOFTINT in ARM GIC.
+	 *                  bit[23:8] in GIC_DIST_SOFTINT in HiP04 GIC.
+	 * NSATT -- bit[15] in GIC_DIST_SOFTINT in ARM GIC.
+	 *          bit[7] in GIC_DIST_SOFTINT in HiP04 GIC.
+	 * this always happens on GIC0
+	 */
+	map = map << gic_data[0].cpu_target_shift;
+	writel_relaxed(map | irq,
+		       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
 #endif
@@ -634,10 +688,12 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
  */
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
 {
-	BUG_ON(cpu_id >= NR_GIC_CPU_IF);
+	BUG_ON(cpu_id >= gic_data[0].nr_cpu_if);
 	cpu_id = 1 << cpu_id;
 	/* this always happens on GIC0 */
-	writel_relaxed((cpu_id << 16) | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	cpuid = cpuid << gic_data[0].cpu_target_shift;
+	writel_relaxed(cpu_id | irq,
+		       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 }
 
 /*
@@ -653,7 +709,7 @@ int gic_get_cpu_id(unsigned int cpu)
 {
 	unsigned int cpu_bit;
 
-	if (cpu >= NR_GIC_CPU_IF)
+	if (cpu >= gic_data[0].nr_cpu_if)
 		return -1;
 	cpu_bit = gic_cpu_map[cpu];
 	if (cpu_bit & (cpu_bit - 1))
@@ -700,13 +756,15 @@ void gic_migrate_target(unsigned int new_cpu_id)
 	 * CPU interface and migrate them to the new CPU interface.
 	 * We skip DIST_TARGET 0 to 7 as they are read-only.
 	 */
-	for (i = 8; i < DIV_ROUND_UP(gic_irqs, 4); i++) {
-		val = readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
+	for (i = 8; i < gic_irqs; i += irqs_per_target_reg(&gic_data[gic_nr])) {
+		val = readl_relaxed(dist_base +
+				    irq_to_target_reg(&gic_data[gic_nr], i));
 		active_mask = val & cur_target_mask;
 		if (active_mask) {
 			val &= ~active_mask;
 			val |= ror32(active_mask, ror_val);
-			writel_relaxed(val, dist_base + GIC_DIST_TARGET + i*4);
+			writel_relaxed(val, dist_base +
+				       irq_to_target_reg(&gic_data[gic_nr], i));
 		}
 	}
 
@@ -884,7 +942,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
 	int gic_irqs, irq_base, i;
-	int nr_routable_irqs;
+	int nr_routable_irqs, max_nr_irq;
 
 	BUG_ON(gic_nr >= MAX_GIC_NR);
 
@@ -920,12 +978,25 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_set_base_accessor(gic, gic_get_common_base);
 	}
 
+	if (of_device_is_compatible(node, "hisilicon,hip04-gic")) {
+		/* HiP04 GIC supports 16 CPUs at most */
+		gic->nr_cpu_if = 16;
+		gic->cpu_target_shift = 8;
+		max_nr_irq = 510;
+	} else {
+		/* ARM/Qualcomm GIC supports 8 CPUs at most */
+		gic->nr_cpu_if = 8;
+		gic->cpu_target_shift = 16;
+		max_nr_irq = 1020;
+	}
+	gic->nr_cpu_if_mask = (1 << gic->nr_cpu_if) - 1;
+
 	/*
 	 * Initialize the CPU interface map to all CPUs.
 	 * It will be refined as each CPU probes its ID.
 	 */
-	for (i = 0; i < NR_GIC_CPU_IF; i++)
-		gic_cpu_map[i] = 0xff;
+	for (i = 0; i < gic->nr_cpu_if; i++)
+		gic_cpu_map[i] = (1 << gic->nr_cpu_if) - 1;
 
 	/*
 	 * For primary GICs, skip over SGIs.
@@ -941,12 +1012,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 
 	/*
 	 * Find out how many interrupts are supported.
-	 * The GIC only supports up to 1020 interrupt sources.
+	 * The ARM/Qualcomm GIC only supports up to 1020 interrupt sources.
+	 * The HiP04 GIC only supports up to 510 interrupt sources.
 	 */
 	gic_irqs = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_CTR) & 0x1f;
 	gic_irqs = (gic_irqs + 1) * 32;
-	if (gic_irqs > 1020)
-		gic_irqs = 1020;
+	if (gic_irqs > max_nr_irq)
+		gic_irqs = max_nr_irq;
 	gic->gic_irqs = gic_irqs;
 
 	gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
@@ -1022,6 +1094,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 }
 IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
+IRQCHIP_DECLARE(hip04_gic, "hisilicon,hip04-gic", gic_of_init);
 IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
 IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 
-- 
1.9.1
