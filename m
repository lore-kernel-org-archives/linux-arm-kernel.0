From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 00:04:38 +0000
Subject: Versatile Express randomly fails to boot
In-Reply-To: <20150315213330.GB8656@n2100.arm.linux.org.uk>
References: <20150315213330.GB8656@n2100.arm.linux.org.uk>
Message-ID: <20150316000438.GD8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 15, 2015 at 09:33:30PM +0000, Russell King - ARM Linux wrote:
> I'm going to try a few other kernels to try and track down what's going
> on - whether something from arm-soc or my tree is responsible for this
> really weird behaviour.

Okay, this is weird - it seems that it's caused by the FIQ oops
dumping code/FIQ changes which I've carried for many months
unchanged in my tree.

I haven't yet been able to prove which bit of those changes is
responsible yet - with a build time of about 5 minutes, and a test
time (due to the number of iterations required to prove it) around
10 minutes, it takes a while to narrow stuff down - it's taken all
evening to work out which branch is responsible, I'm just narrowing
it down to the commit, which looks like it's a result of something
in the change below.

This is pretty close to Daniel's patches, and we know that the GIC
on Versatile Express has problems with this stuff - I wonder if this
means we can't even probe the GIC to find out whether it's capable of
FIQ delivery via testing whether GICD_ENABLE_GRP1 can be set.

That said, and as I said above, this exact patch has been in my kernel,
and has been built and tested over many months, so I find it hard to
believe that this really _is_ responsible.

For tonights build, I'm going to drop the FIQ stuff from my devel tree,
which means it'll be gone from the build tree until we can, again,
figure out what the heck's going on here.

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 17e54f1df258..e0ba62117c5a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -543,7 +543,7 @@ static void ipi_cpu_stop(unsigned int cpu)
 		cpu_relax();
 }
 
-static void ipi_cpu_backtrace(struct pt_regs *regs)
+void ipi_cpu_backtrace(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 439138d3437e..f88af68f9345 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -60,6 +60,7 @@ static int __init user_debug_setup(char *str)
 __setup("user_debug=", user_debug_setup);
 #endif
 
+extern void ipi_cpu_backtrace(struct pt_regs *regs);
 static void dump_mem(const char *, const char *, unsigned long, unsigned long);
 
 void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame)
@@ -480,6 +481,9 @@ asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
 	nmi_enter();
 
 	/* nop. FIQ handlers for special arch/arm features can be added here. */
+#ifdef CONFIG_SMP
+	ipi_cpu_backtrace(regs);
+#endif
 
 	nmi_exit();
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index dda6dbc23565..786a662f9842 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -48,6 +48,8 @@
 #include "irq-gic-common.h"
 #include "irqchip.h"
 
+#define GICD_ENABLE_GRP1               0x2
+
 union gic_base {
 	void __iomem *common_base;
 	void __percpu * __iomem *percpu_base;
@@ -102,7 +104,7 @@ static struct gic_chip_data gic_data[MAX_GIC_NR] __read_mostly;
 #ifdef CONFIG_GIC_NON_BANKED
 static void __iomem *gic_get_percpu_base(union gic_base *base)
 {
-	return *__this_cpu_ptr(base->percpu_base);
+	return raw_cpu_read(*base->percpu_base);
 }
 
 static void __iomem *gic_get_common_base(union gic_base *base)
@@ -270,8 +272,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
 		if (likely(irqnr > 15 && irqnr < 1021)) {
-			irqnr = irq_find_mapping(gic->domain, irqnr);
-			handle_IRQ(irqnr, regs);
+			handle_domain_irq(gic->domain, irqnr, regs);
 			continue;
 		}
 		if (irqnr < 16) {
@@ -298,8 +299,8 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	status = readl_relaxed(gic_data_cpu_base(chip_data) + GIC_CPU_INTACK);
 	raw_spin_unlock(&irq_controller_lock);
 
-	gic_irq = (status & 0x3ff);
-	if (gic_irq == 1023)
+	gic_irq = (status & GICC_IAR_INT_ID_MASK);
+	if (gic_irq == GICC_INT_SPURIOUS)
 		goto out;
 
 	cascade_irq = irq_find_mapping(chip_data->domain, gic_irq);
@@ -353,6 +354,25 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 	return mask;
 }
 
+static void gic_cpu_if_up(void)
+{
+	void __iomem *cpu_base = gic_data_cpu_base(&gic_data[0]);
+	void __iomem *dist_base = gic_data_dist_base(&gic_data[0]);
+	u32 bypass = 0;
+
+	/*
+	* Preserve bypass disable bits to be written back later
+	*/
+	bypass = readl(cpu_base + GIC_CPU_CTRL);
+	bypass &= GICC_DIS_BYPASS_MASK;
+
+	if (readl_relaxed(dist_base + GIC_DIST_CTRL) & GICD_ENABLE_GRP1)
+		bypass |= 0x1e;
+
+	writel_relaxed(bypass | GICC_ENABLE, cpu_base + GIC_CPU_CTRL);
+}
+
+
 static void __init gic_dist_init(struct gic_chip_data *gic)
 {
 	unsigned int i;
@@ -360,7 +380,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	unsigned int gic_irqs = gic->gic_irqs;
 	void __iomem *base = gic_data_dist_base(gic);
 
-	writel_relaxed(0, base + GIC_DIST_CTRL);
+	writel_relaxed(GICD_DISABLE, base + GIC_DIST_CTRL);
 
 	/*
 	 * Set all global interrupts to this CPU only.
@@ -371,9 +391,19 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 	for (i = 32; i < gic_irqs; i += 4)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
 
+	writel_relaxed(GICD_ENABLE_GRP1, base + GIC_DIST_CTRL);
+
+	/*
+	 * Optionally set all global interrupts to be group 1.
+	 */
+	if (readl_relaxed(base + GIC_DIST_CTRL) & GICD_ENABLE_GRP1) {
+		for (i = 32; i < gic_irqs; i += 32)
+			writel_relaxed(0xffffffff, base + GIC_DIST_IGROUP + i * 4 / 32);
+	}
+
 	gic_dist_config(base, gic_irqs, NULL);
 
-	writel_relaxed(1, base + GIC_DIST_CTRL);
+	writel_relaxed(GICD_ENABLE | GICD_ENABLE_GRP1, base + GIC_DIST_CTRL);
 }
 
 static void gic_cpu_init(struct gic_chip_data *gic)
@@ -400,14 +430,29 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 
 	gic_cpu_config(dist_base, NULL);
 
-	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, base + GIC_CPU_CTRL);
+	/*
+	 * Set all PPI and SGI interrupts to be group 1.
+	 *
+	 * If grouping is not available (not implemented or prohibited by
+	 * security mode) these registers are read-as-zero/write-ignored.
+	 */
+	if (readl_relaxed(dist_base + GIC_DIST_CTRL) & GICD_ENABLE_GRP1) {
+		writel_relaxed(0xfffffeff, dist_base + GIC_DIST_IGROUP + 0);
+		writel_relaxed(0xa0a0a000, dist_base + GIC_DIST_PRI + 8);
+	}
+
+	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
+	gic_cpu_if_up();
 }
 
 void gic_cpu_if_down(void)
 {
 	void __iomem *cpu_base = gic_data_cpu_base(&gic_data[0]);
-	writel_relaxed(0, cpu_base + GIC_CPU_CTRL);
+	u32 val = 0;
+
+	val = readl(cpu_base + GIC_CPU_CTRL);
+	val &= ~GICC_ENABLE;
+	writel_relaxed(val, cpu_base + GIC_CPU_CTRL);
 }
 
 #ifdef CONFIG_CPU_PM
@@ -467,14 +512,14 @@ static void gic_dist_restore(unsigned int gic_nr)
 	if (!dist_base)
 		return;
 
-	writel_relaxed(0, dist_base + GIC_DIST_CTRL);
+	writel_relaxed(GICD_DISABLE, dist_base + GIC_DIST_CTRL);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 16); i++)
 		writel_relaxed(gic_data[gic_nr].saved_spi_conf[i],
 			dist_base + GIC_DIST_CONFIG + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
-		writel_relaxed(0xa0a0a0a0,
+		writel_relaxed(GICD_INT_DEF_PRI_X4,
 			dist_base + GIC_DIST_PRI + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
@@ -485,7 +530,7 @@ static void gic_dist_restore(unsigned int gic_nr)
 		writel_relaxed(gic_data[gic_nr].saved_spi_enable[i],
 			dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
-	writel_relaxed(1, dist_base + GIC_DIST_CTRL);
+	writel_relaxed(GICD_ENABLE | 2, dist_base + GIC_DIST_CTRL);
 }
 
 static void gic_cpu_save(unsigned int gic_nr)
@@ -504,11 +549,11 @@ static void gic_cpu_save(unsigned int gic_nr)
 	if (!dist_base || !cpu_base)
 		return;
 
-	ptr = __this_cpu_ptr(gic_data[gic_nr].saved_ppi_enable);
+	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_enable);
 	for (i = 0; i < DIV_ROUND_UP(32, 32); i++)
 		ptr[i] = readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
-	ptr = __this_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
+	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
 	for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
 		ptr[i] = readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
 
@@ -530,19 +575,31 @@ static void gic_cpu_restore(unsigned int gic_nr)
 	if (!dist_base || !cpu_base)
 		return;
 
-	ptr = __this_cpu_ptr(gic_data[gic_nr].saved_ppi_enable);
+	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_enable);
 	for (i = 0; i < DIV_ROUND_UP(32, 32); i++)
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
-	ptr = __this_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
+	ptr = raw_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
 	for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_CONFIG + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(32, 4); i++)
-		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4);
+		writel_relaxed(GICD_INT_DEF_PRI_X4,
+					dist_base + GIC_DIST_PRI + i * 4);
 
-	writel_relaxed(0xf0, cpu_base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, cpu_base + GIC_CPU_CTRL);
+	/*
+	 * Set all PPI and SGI interrupts to be group 1.
+	 *
+	 * If grouping is not available (not implemented or prohibited by
+	 * security mode) these registers are read-as-zero/write-ignored.
+	 */
+	if (readl_relaxed(dist_base + GIC_DIST_CTRL) & GICD_ENABLE_GRP1) {
+		writel_relaxed(0xfffffeff, dist_base + GIC_DIST_IGROUP + 0);
+		writel_relaxed(0xa0a0a000, dist_base + GIC_DIST_PRI + 8);
+	}
+
+	writel_relaxed(GICC_INT_PRI_THRESHOLD, cpu_base + GIC_CPU_PRIMASK);
+	gic_cpu_if_up();
 }
 
 static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
@@ -600,10 +657,19 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 #endif
 
 #ifdef CONFIG_SMP
+static bool sgi_is_nonsecure(int irq, struct gic_chip_data *gic)
+{
+	void __iomem *dist_base = gic_data_dist_base(gic);
+	/* FIXME: this should be done in a more generic way */
+	return irq != 8 && readl_relaxed(dist_base + GIC_DIST_CTRL) & GICD_ENABLE_GRP1;
+}
+
 static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
-	int cpu;
+	struct gic_chip_data *gic = &gic_data[0];
 	unsigned long flags, map = 0;
+	unsigned int softirq;
+	int cpu;
 
 	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 
@@ -617,8 +683,14 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	 */
 	dmb(ishst);
 
+	softirq = map << 16 | irq;
+
+	/* SATT only has effect if we are running in the secure world */
+	if (sgi_is_nonsecure(irq, gic))
+		softirq |= 0x8000;
+
 	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	writel_relaxed(softirq, gic_data_dist_base(gic) + GIC_DIST_SOFTINT);
 
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 }


-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
