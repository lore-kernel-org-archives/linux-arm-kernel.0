From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:19:36 +0000
Subject: [PATCH 02/22] ARM: SMP: pass an ipi number to smp_cross_call()
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POc6S-0007r7-60@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to use smp_cross_call() to trigger a number of different
software generated interrupts, rather than combining them all on one
SGI.  Recover the SGI number via do_IPI.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/smp.h                |    4 ++--
 arch/arm/kernel/entry-armv.S              |    2 +-
 arch/arm/kernel/smp.c                     |   10 ++--------
 arch/arm/mach-msm/include/mach/smp.h      |    4 ++--
 arch/arm/mach-omap2/omap-smp.c            |    2 +-
 arch/arm/mach-realview/include/mach/smp.h |    4 ++--
 arch/arm/mach-realview/platsmp.c          |    2 +-
 arch/arm/mach-s5pv310/include/mach/smp.h  |    4 ++--
 arch/arm/mach-s5pv310/platsmp.c           |    2 +-
 arch/arm/mach-tegra/include/mach/smp.h    |    4 ++--
 arch/arm/mach-ux500/include/mach/smp.h    |    4 ++--
 arch/arm/mach-ux500/platsmp.c             |    2 +-
 arch/arm/mach-vexpress/include/mach/smp.h |    4 ++--
 arch/arm/mach-vexpress/platsmp.c          |    2 +-
 arch/arm/plat-omap/include/plat/smp.h     |    4 ++--
 15 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 3d05190..da7e7ca 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -38,7 +38,7 @@ extern void show_ipi_list(struct seq_file *p);
 /*
  * Called from assembly code, this handles an IPI.
  */
-asmlinkage void do_IPI(struct pt_regs *regs);
+asmlinkage void do_IPI(int ipinr, struct pt_regs *regs);
 
 /*
  * Setup the set of possible CPUs (via set_cpu_possible)
@@ -53,7 +53,7 @@ extern void smp_store_cpu_info(unsigned int cpuid);
 /*
  * Raise an IPI cross call on CPUs in callmap.
  */
-extern void smp_cross_call(const struct cpumask *mask);
+extern void smp_cross_call(const struct cpumask *mask, int ipi);
 
 /*
  * Boot a secondary CPU, and assign it the specified idle task.
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c09e357..955cf5f 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -48,7 +48,7 @@
 	 */
 	ALT_SMP(test_for_ipi r0, r6, r5, lr)
 	ALT_UP_B(9997f)
-	movne	r0, sp
+	movne	r1, sp
 	adrne	lr, BSYM(1b)
 	bne	do_IPI
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8c19595..7a236db 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -404,7 +404,7 @@ static void send_ipi_message(const struct cpumask *mask, enum ipi_msg_type msg)
 	/*
 	 * Call the platform specific cross-CPU call function.
 	 */
-	smp_cross_call(mask);
+	smp_cross_call(mask, 1);
 
 	local_irq_restore(flags);
 }
@@ -537,14 +537,8 @@ static void ipi_cpu_stop(unsigned int cpu)
 
 /*
  * Main handler for inter-processor interrupts
- *
- * For ARM, the ipimask now only identifies a single
- * category of IPI (Bit 1 IPIs have been replaced by a
- * different mechanism):
- *
- *  Bit 0 - Inter-processor function call
  */
-asmlinkage void __exception do_IPI(struct pt_regs *regs)
+asmlinkage void __exception do_IPI(int ipinr, struct pt_regs *regs)
 {
 	unsigned int cpu = smp_processor_id();
 	struct ipi_data *ipi = &per_cpu(ipi_data, cpu);
diff --git a/arch/arm/mach-msm/include/mach/smp.h b/arch/arm/mach-msm/include/mach/smp.h
index 3ff7bf5..a95f7b9 100644
--- a/arch/arm/mach-msm/include/mach/smp.h
+++ b/arch/arm/mach-msm/include/mach/smp.h
@@ -31,9 +31,9 @@
 
 #include <asm/hardware/gic.h>
 
-static inline void smp_cross_call(const struct cpumask *mask)
+static inline void smp_cross_call(const struct cpumask *mask, int ipi)
 {
-	gic_raise_softirq(mask, 1);
+	gic_raise_softirq(mask, ipi);
 }
 
 #endif
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 9e9f70e..56a8bce 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -76,7 +76,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	omap_modify_auxcoreboot0(0x200, 0xfffffdff);
 	flush_cache_all();
 	smp_wmb();
-	smp_cross_call(cpumask_of(cpu));
+	smp_cross_call(cpumask_of(cpu), 1);
 
 	/*
 	 * Now the secondary core is starting up let it run its
diff --git a/arch/arm/mach-realview/include/mach/smp.h b/arch/arm/mach-realview/include/mach/smp.h
index d3cd265..d1aa704 100644
--- a/arch/arm/mach-realview/include/mach/smp.h
+++ b/arch/arm/mach-realview/include/mach/smp.h
@@ -7,9 +7,9 @@
 /*
  * We use IRQ1 as the IPI
  */
-static inline void smp_cross_call(const struct cpumask *mask)
+static inline void smp_cross_call(const struct cpumask *mask, int ipi)
 {
-	gic_raise_softirq(mask, 1);
+	gic_raise_softirq(mask, ipi);
 }
 
 #endif
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 0092658..af3d909 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -116,7 +116,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Use smp_cross_call() for this, since there's little
 	 * point duplicating the code here
 	 */
-	smp_cross_call(cpumask_of(cpu));
+	smp_cross_call(cpumask_of(cpu), 1);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
diff --git a/arch/arm/mach-s5pv310/include/mach/smp.h b/arch/arm/mach-s5pv310/include/mach/smp.h
index b7ec252..2897747 100644
--- a/arch/arm/mach-s5pv310/include/mach/smp.h
+++ b/arch/arm/mach-s5pv310/include/mach/smp.h
@@ -14,9 +14,9 @@ extern void __iomem *gic_cpu_base_addr;
 /*
  * We use IRQ1 as the IPI
  */
-static inline void smp_cross_call(const struct cpumask *mask)
+static inline void smp_cross_call(const struct cpumask *mask, int ipi)
 {
-	gic_raise_softirq(mask, 1);
+	gic_raise_softirq(mask, ipi);
 }
 
 #endif
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-s5pv310/platsmp.c
index d357c19..d474426 100644
--- a/arch/arm/mach-s5pv310/platsmp.c
+++ b/arch/arm/mach-s5pv310/platsmp.c
@@ -97,7 +97,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	smp_cross_call(cpumask_of(cpu));
+	smp_cross_call(cpumask_of(cpu), 1);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
diff --git a/arch/arm/mach-tegra/include/mach/smp.h b/arch/arm/mach-tegra/include/mach/smp.h
index d3cd265..d1aa704 100644
--- a/arch/arm/mach-tegra/include/mach/smp.h
+++ b/arch/arm/mach-tegra/include/mach/smp.h
@@ -7,9 +7,9 @@
 /*
  * We use IRQ1 as the IPI
  */
-static inline void smp_cross_call(const struct cpumask *mask)
+static inline void smp_cross_call(const struct cpumask *mask, int ipi)
 {
-	gic_raise_softirq(mask, 1);
+	gic_raise_softirq(mask, ipi);
 }
 
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/smp.h b/arch/arm/mach-ux500/include/mach/smp.h
index 197e841..bd57c50 100644
--- a/arch/arm/mach-ux500/include/mach/smp.h
+++ b/arch/arm/mach-ux500/include/mach/smp.h
@@ -18,8 +18,8 @@ extern void u8500_secondary_startup(void);
 /*
  * We use IRQ1 as the IPI
  */
-static inline void smp_cross_call(const struct cpumask *mask)
+static inline void smp_cross_call(const struct cpumask *mask, int ipi)
 {
-	gic_raise_softirq(mask, 1);
+	gic_raise_softirq(mask, ipi);
 }
 #endif
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 9e4c678..b8987bd 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -78,7 +78,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
 	outer_clean_range(__pa(&pen_release), __pa(&pen_release) + 1);
 
-	smp_cross_call(cpumask_of(cpu));
+	smp_cross_call(cpumask_of(cpu), 1);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
diff --git a/arch/arm/mach-vexpress/include/mach/smp.h b/arch/arm/mach-vexpress/include/mach/smp.h
index 5a6da4f..721be0f 100644
--- a/arch/arm/mach-vexpress/include/mach/smp.h
+++ b/arch/arm/mach-vexpress/include/mach/smp.h
@@ -7,8 +7,8 @@
 /*
  * We use IRQ1 as the IPI
  */
-static inline void smp_cross_call(const struct cpumask *mask)
+static inline void smp_cross_call(const struct cpumask *mask, int ipi)
 {
-	gic_raise_softirq(mask, 1);
+	gic_raise_softirq(mask, ipi);
 }
 #endif
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 6709706..276f916 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -92,7 +92,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	smp_cross_call(cpumask_of(cpu));
+	smp_cross_call(cpumask_of(cpu), 1);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
diff --git a/arch/arm/plat-omap/include/plat/smp.h b/arch/arm/plat-omap/include/plat/smp.h
index ecd6a48..e5541e5 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -29,9 +29,9 @@ extern u32 omap_read_auxcoreboot0(void);
 /*
  * We use Soft IRQ1 as the IPI
  */
-static inline void smp_cross_call(const struct cpumask *mask)
+static inline void smp_cross_call(const struct cpumask *mask, int ipi)
 {
-	gic_raise_softirq(mask, 1);
+	gic_raise_softirq(mask, ipi);
 }
 
 #endif
-- 
1.6.2.5
