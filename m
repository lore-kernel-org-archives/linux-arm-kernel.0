From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 12 Nov 2011 16:09:49 +0000
Subject: [PATCH v2] ARM: gic: allow GIC to support non-banked setups
Message-ID: <1321114189-8583-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC support code is heavily using the fact that hardware
implementations are exposing banked registers. Unfortunately, it
looks like at least one GIC implementation (EXYNOS) offers both
the distributor and the CPU interfaces at different addresses,
depending on the CPU.

This problem is solved by allowing the distributor and CPU interface
addresses to be per-cpu variables for the platforms that require it.
The EXYNOS code is updated not to mess with the GIC internals while
handling interrupts, and struct gic_chip_data is back to being private.
The DT binding for the gic is updated to allow an optional "cpu-offset"
value, which is used to compute the various base addresses.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Rob Herring <robherring2@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
This version tries to address Rob's comments about DT, and reserve
the use of per-cpu variables to the odd platforms that require the
feature.

As previously, I willing to receive any comment that would help
cleaning this corner of our codebase.

 Documentation/devicetree/bindings/arm/gic.txt |    4 +
 arch/arm/common/gic.c                         |  112 ++++++++++++++++++++----
 arch/arm/include/asm/hardware/gic.h           |   24 ++----
 arch/arm/mach-exynos/cpu.c                    |   20 +----
 arch/arm/mach-exynos/platsmp.c                |   28 +------
 5 files changed, 108 insertions(+), 80 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 52916b4..9b4b82a 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -42,6 +42,10 @@ Optional
 - interrupts	: Interrupt source of the parent interrupt controller. Only
   present on secondary GICs.
 
+- cpu-offset	: per-cpu offset within the distributor and cpu interface
+  regions, used when the GIC doesn't have banked registers. The offset is
+  cpu-offset * cpu-nr.
+
 Example:
 
 	intc: interrupt-controller at fff11000 {
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 0e6ae47..463ed62 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -43,6 +43,29 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
 
+union gic_base {
+	void __iomem *common_base;
+	void __percpu __iomem **percpu_base;
+};
+
+struct gic_chip_data {
+	unsigned int irq_offset;
+	union gic_base dist_base;
+	union gic_base cpu_base;
+#ifdef CONFIG_CPU_PM
+	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
+	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
+	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
+	u32 __percpu *saved_ppi_enable;
+	u32 __percpu *saved_ppi_conf;
+#endif
+#ifdef CONFIG_IRQ_DOMAIN
+	struct irq_domain domain;
+#endif
+	unsigned int gic_irqs;
+	void __iomem *(*get_base)(union gic_base *);
+};
+
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 /* Address of GIC 0 CPU interface */
@@ -67,16 +90,36 @@ struct irq_chip gic_arch_extn = {
 
 static struct gic_chip_data gic_data[MAX_GIC_NR] __read_mostly;
 
+static void __iomem *gic_get_percpu_base(union gic_base *base)
+{
+	return *__this_cpu_ptr(base->percpu_base);
+}
+
+static void __iomem *gic_get_common_base(union gic_base *base)
+{
+	return base->common_base;
+}
+
+static inline void __iomem *gic_data_dist_base(struct gic_chip_data *data)
+{
+	return data->get_base(&data->dist_base);
+}
+
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
-	return gic_data->dist_base;
+	return gic_data_dist_base(gic_data);
+}
+
+static inline void __iomem *gic_data_cpu_base(struct gic_chip_data *data)
+{
+	return data->get_base(&data->cpu_base);
 }
 
 static inline void __iomem *gic_cpu_base(struct irq_data *d)
 {
 	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
-	return gic_data->cpu_base;
+	return gic_data_cpu_base(gic_data);
 }
 
 static inline unsigned int gic_irq(struct irq_data *d)
@@ -225,7 +268,7 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	raw_spin_lock(&irq_controller_lock);
-	status = readl_relaxed(chip_data->cpu_base + GIC_CPU_INTACK);
+	status = readl_relaxed(gic_data_cpu_base(chip_data) + GIC_CPU_INTACK);
 	raw_spin_unlock(&irq_controller_lock);
 
 	gic_irq = (status & 0x3ff);
@@ -270,7 +313,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	u32 cpumask;
 	unsigned int gic_irqs = gic->gic_irqs;
 	struct irq_domain *domain = &gic->domain;
-	void __iomem *base = gic->dist_base;
+	void __iomem *base = gic_data_dist_base(gic);
 	u32 cpu = 0;
 
 #ifdef CONFIG_SMP
@@ -330,8 +373,8 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 
 static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
 {
-	void __iomem *dist_base = gic->dist_base;
-	void __iomem *base = gic->cpu_base;
+	void __iomem *dist_base = gic_data_dist_base(gic);
+	void __iomem *base = gic_data_cpu_base(gic);
 	int i;
 
 	/*
@@ -368,7 +411,7 @@ static void gic_dist_save(unsigned int gic_nr)
 		BUG();
 
 	gic_irqs = gic_data[gic_nr].gic_irqs;
-	dist_base = gic_data[gic_nr].dist_base;
+	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
 
 	if (!dist_base)
 		return;
@@ -403,7 +446,7 @@ static void gic_dist_restore(unsigned int gic_nr)
 		BUG();
 
 	gic_irqs = gic_data[gic_nr].gic_irqs;
-	dist_base = gic_data[gic_nr].dist_base;
+	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
 
 	if (!dist_base)
 		return;
@@ -439,8 +482,8 @@ static void gic_cpu_save(unsigned int gic_nr)
 	if (gic_nr >= MAX_GIC_NR)
 		BUG();
 
-	dist_base = gic_data[gic_nr].dist_base;
-	cpu_base = gic_data[gic_nr].cpu_base;
+	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
+	cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
 
 	if (!dist_base || !cpu_base)
 		return;
@@ -465,8 +508,8 @@ static void gic_cpu_restore(unsigned int gic_nr)
 	if (gic_nr >= MAX_GIC_NR)
 		BUG();
 
-	dist_base = gic_data[gic_nr].dist_base;
-	cpu_base = gic_data[gic_nr].cpu_base;
+	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
+	cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
 
 	if (!dist_base || !cpu_base)
 		return;
@@ -491,6 +534,10 @@ static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 	int i;
 
 	for (i = 0; i < MAX_GIC_NR; i++) {
+		/* Skip over unused GICs */
+		if (!gic_data[i].get_base)
+			continue;
+
 		switch (cmd) {
 		case CPU_PM_ENTER:
 			gic_cpu_save(i);
@@ -563,8 +610,9 @@ const struct irq_domain_ops gic_irq_domain_ops = {
 #endif
 };
 
-void __init gic_init(unsigned int gic_nr, int irq_start,
-	void __iomem *dist_base, void __iomem *cpu_base)
+void __init gic_init_bases(unsigned int gic_nr, int irq_start,
+			   void __iomem *dist_base, void __iomem *cpu_base,
+			   u32 percpu_offset)
 {
 	struct gic_chip_data *gic;
 	struct irq_domain *domain;
@@ -574,8 +622,30 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
 
 	gic = &gic_data[gic_nr];
 	domain = &gic->domain;
-	gic->dist_base = dist_base;
-	gic->cpu_base = cpu_base;
+	if (percpu_offset) { /* Frankein-GIC without banked registers... */
+		unsigned int cpu;
+
+		gic->dist_base.percpu_base = alloc_percpu(void __iomem *);
+		gic->cpu_base.percpu_base = alloc_percpu(void __iomem *);
+		if (WARN_ON(!gic->dist_base.percpu_base ||
+			    !gic->cpu_base.percpu_base)) {
+			free_percpu(gic->dist_base.percpu_base);
+			free_percpu(gic->cpu_base.percpu_base);
+			return;
+		}
+
+		for_each_possible_cpu(cpu) {
+			unsigned long offset = percpu_offset * cpu_logical_map(cpu);
+			*per_cpu_ptr(gic->dist_base.percpu_base, cpu) = dist_base + offset;
+			*per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = cpu_base + offset;
+		}
+
+		gic->get_base = gic_get_percpu_base;
+	} else { /* Normal, sane GIC... */
+		gic->dist_base.common_base = dist_base;
+		gic->cpu_base.common_base = cpu_base;
+		gic->get_base = gic_get_common_base;
+	}
 
 	/*
 	 * For primary GICs, skip over SGIs.
@@ -593,7 +663,7 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
 	 * Find out how many interrupts are supported.
 	 * The GIC only supports up to 1020 interrupt sources.
 	 */
-	gic_irqs = readl_relaxed(dist_base + GIC_DIST_CTR) & 0x1f;
+	gic_irqs = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_CTR) & 0x1f;
 	gic_irqs = (gic_irqs + 1) * 32;
 	if (gic_irqs > 1020)
 		gic_irqs = 1020;
@@ -641,7 +711,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	dsb();
 
 	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
+	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 }
 #endif
 
@@ -652,6 +722,7 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *cpu_base;
 	void __iomem *dist_base;
+	u32 percpu_offset;
 	int irq;
 	struct irq_domain *domain = &gic_data[gic_cnt].domain;
 
@@ -664,9 +735,12 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 	cpu_base = of_iomap(node, 1);
 	WARN(!cpu_base, "unable to map gic cpu registers\n");
 
+	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
+		percpu_offset = 0;
+
 	domain->of_node = of_node_get(node);
 
-	gic_init(gic_cnt, -1, dist_base, cpu_base);
+	gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset);
 
 	if (parent) {
 		irq = irq_of_parse_and_map(node, 0);
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 3e91f22..2721d90 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -39,27 +39,19 @@ struct device_node;
 extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
-void gic_init(unsigned int, int, void __iomem *, void __iomem *);
+void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
+		    u32 offset);
 int gic_of_init(struct device_node *node, struct device_node *parent);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 
-struct gic_chip_data {
-	void __iomem *dist_base;
-	void __iomem *cpu_base;
-#ifdef CONFIG_CPU_PM
-	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
-	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
-	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
-	u32 __percpu *saved_ppi_enable;
-	u32 __percpu *saved_ppi_conf;
-#endif
-#ifdef CONFIG_IRQ_DOMAIN
-	struct irq_domain domain;
-#endif
-	unsigned int gic_irqs;
-};
+static inline void gic_init(unsigned int nr, int start,
+			    void __iomem *dist , void __iomem *cpu)
+{
+	gic_init_bases(nr, start, dist, cpu, 0);
+}
+
 #endif
 
 #endif
diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
index 90ec247..92cfcf4 100644
--- a/arch/arm/mach-exynos/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@ -33,8 +33,6 @@
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
 
-unsigned int gic_bank_offset __read_mostly;
-
 extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
 			 unsigned int irq_start);
 extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq);
@@ -207,27 +205,13 @@ void __init exynos4_init_clocks(int xtal)
 	exynos4_setup_clocks();
 }
 
-static void exynos4_gic_irq_fix_base(struct irq_data *d)
-{
-	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
-
-	gic_data->cpu_base = S5P_VA_GIC_CPU +
-			    (gic_bank_offset * smp_processor_id());
-
-	gic_data->dist_base = S5P_VA_GIC_DIST +
-			    (gic_bank_offset * smp_processor_id());
-}
-
 void __init exynos4_init_irq(void)
 {
 	int irq;
 
-	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
+	unsigned int gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
 
-	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
-	gic_arch_extn.irq_eoi = exynos4_gic_irq_fix_base;
-	gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
-	gic_arch_extn.irq_mask = exynos4_gic_irq_fix_base;
+	gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset);
 
 	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
 
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 69ffb2f..60bc45e 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -32,7 +32,6 @@
 
 #include <plat/cpu.h>
 
-extern unsigned int gic_bank_offset;
 extern void exynos4_secondary_startup(void);
 
 #define CPU1_BOOT_REG		(samsung_rev() == EXYNOS4210_REV_1_1 ? \
@@ -65,31 +64,6 @@ static void __iomem *scu_base_addr(void)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-static void __cpuinit exynos4_gic_secondary_init(void)
-{
-	void __iomem *dist_base = S5P_VA_GIC_DIST +
-				(gic_bank_offset * smp_processor_id());
-	void __iomem *cpu_base = S5P_VA_GIC_CPU +
-				(gic_bank_offset * smp_processor_id());
-	int i;
-
-	/*
-	 * Deal with the banked PPI and SGI interrupts - disable all
-	 * PPI interrupts, ensure all SGI interrupts are enabled.
-	 */
-	__raw_writel(0xffff0000, dist_base + GIC_DIST_ENABLE_CLEAR);
-	__raw_writel(0x0000ffff, dist_base + GIC_DIST_ENABLE_SET);
-
-	/*
-	 * Set priority on PPI and SGI interrupts
-	 */
-	for (i = 0; i < 32; i += 4)
-		__raw_writel(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
-
-	__raw_writel(0xf0, cpu_base + GIC_CPU_PRIMASK);
-	__raw_writel(1, cpu_base + GIC_CPU_CTRL);
-}
-
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	/*
@@ -97,7 +71,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-	exynos4_gic_secondary_init();
+	gic_secondary_init(0);
 
 	/*
 	 * let the primary processor know we're out of the
-- 
1.7.7.2
