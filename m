From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Sat, 19 Jun 2010 00:36:30 +0400
Subject: [PATCH v2 1/3] ARM: Factor out secondary CPU bootup code from
	VExpress platforms
In-Reply-To: <20100618181707.GA21578@n2100.arm.linux.org.uk>
References: <20100618181707.GA21578@n2100.arm.linux.org.uk>
Message-ID: <20100618203630.GA9155@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For CNS3xxx we want to reuse the original ARM approach of booting
secondary CPUs. This patch turns VExpress' code into "SCU library",
so that now platform code can call the generic routines.

Note that there are also mach-{omap2,ux500,realview} that might
benefit from this change.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/include/asm/smp_scu.h   |    7 ++
 arch/arm/kernel/Makefile         |    2 +-
 arch/arm/kernel/smp_scu.c        |  136 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/smp_scu_head.S   |   37 +++++++++
 arch/arm/mach-vexpress/Makefile  |    2 +-
 arch/arm/mach-vexpress/headsmp.S |   39 ----------
 arch/arm/mach-vexpress/platsmp.c |  150 ++++----------------------------------
 7 files changed, 196 insertions(+), 177 deletions(-)
 create mode 100644 arch/arm/kernel/smp_scu_head.S
 delete mode 100644 arch/arm/mach-vexpress/headsmp.S

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 2376835..2474590 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -4,4 +4,11 @@
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
 
+extern volatile int __cpuinitdata scu_pen_release;
+void scu_secondary_startup(void);
+void __cpuinit scu_secondary_init(unsigned int cpu);
+int __cpuinit scu_boot_secondary(unsigned int cpu, struct task_struct *idle);
+void __init scu_init_cpus(void __iomem *scu_base);
+void __init scu_prepare_cpus(void __iomem *scu_base, unsigned int max_cpus);
+
 #endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 26d302c..2fc7cb1 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
 obj-$(CONFIG_SMP)		+= smp.o
-obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
+obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o smp_scu_head.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 9ab4149..b18414c 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -8,10 +8,15 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/compiler.h>
+#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/delay.h>
 
 #include <asm/smp_scu.h>
+#include <asm/localtimer.h>
 #include <asm/cacheflush.h>
 
 #define SCU_CTRL		0x00
@@ -50,3 +55,134 @@ void __init scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
+
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+volatile int __cpuinitdata scu_pen_release = -1;
+
+static DEFINE_SPINLOCK(boot_lock);
+
+void __cpuinit scu_secondary_init(unsigned int cpu)
+{
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	scu_pen_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit scu_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * Set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * This is really belt and braces; we hold unintended secondary
+	 * CPUs in the holding pen until we're ready for them.  However,
+	 * since we haven't sent them a soft interrupt, they shouldn't
+	 * be there.
+	 */
+	scu_pen_release = cpu;
+	__cpuc_flush_dcache_area((void *)&scu_pen_release,
+				 sizeof(scu_pen_release));
+	outer_clean_range(__pa(&scu_pen_release), __pa(&scu_pen_release + 1));
+
+	/*
+	 * Send the secondary CPU a soft interrupt, thereby causing
+	 * the boot monitor to read the system wide flags register,
+	 * and branch to the address found there.
+	 */
+	smp_cross_call(cpumask_of(cpu));
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (scu_pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return scu_pen_release != -1 ? -ENOSYS : 0;
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init scu_init_cpus(void __iomem *scu_base)
+{
+	unsigned int ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+	unsigned int i;
+
+	/* sanity check */
+	if (ncores == 0) {
+		pr_err("%s: strange CM count of 0? Default to 1\n", __func__);
+		ncores = 1;
+	}
+
+	if (ncores > NR_CPUS) {
+		pr_warn("%s: no. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n", __func__, ncores, NR_CPUS);
+		ncores = NR_CPUS;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init scu_prepare_cpus(void __iomem *scu_base, unsigned int max_cpus)
+{
+	unsigned int ncores = num_possible_cpus();
+	unsigned int cpu = smp_processor_id();
+	int i;
+
+	smp_store_cpu_info(cpu);
+
+	/*
+	 * are we trying to boot more cores than exist?
+	 */
+	if (max_cpus > ncores)
+		max_cpus = ncores;
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated at the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	/*
+	 * Initialise the SCU if there are more than one CPU and let
+	 * them know where to start.
+	 */
+	if (max_cpus > 1) {
+		/*
+		 * Enable the local timer or broadcast device for the
+		 * boot CPU, but only if we have more than one CPU.
+		 */
+		percpu_timer_setup();
+
+		scu_enable(scu_base);
+	}
+}
diff --git a/arch/arm/kernel/smp_scu_head.S b/arch/arm/kernel/smp_scu_head.S
new file mode 100644
index 0000000..200010b
--- /dev/null
+++ b/arch/arm/kernel/smp_scu_head.S
@@ -0,0 +1,37 @@
+/*
+ *  Copyright (c) 2003 ARM Limited
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+
+/*
+ * SCU specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(scu_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
+1:	.long	.
+	.long	scu_pen_release
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 1b71b77..6533d11 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -4,5 +4,5 @@
 
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
-obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
diff --git a/arch/arm/mach-vexpress/headsmp.S b/arch/arm/mach-vexpress/headsmp.S
deleted file mode 100644
index 8a78ff6..0000000
--- a/arch/arm/mach-vexpress/headsmp.S
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *  linux/arch/arm/mach-vexpress/headsmp.S
- *
- *  Copyright (c) 2003 ARM Limited
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-	__INIT
-
-/*
- * Versatile Express specific entry point for secondary CPUs.  This
- * provides a "holding pen" into which all secondary cores are held
- * until we're ready for them to initialise.
- */
-ENTRY(vexpress_secondary_startup)
-	mrc	p15, 0, r0, c0, c0, 5
-	and	r0, r0, #15
-	adr	r4, 1f
-	ldmia	r4, {r5, r6}
-	sub	r4, r4, r5
-	add	r6, r6, r4
-pen:	ldr	r7, [r6]
-	cmp	r7, r0
-	bne	pen
-
-	/*
-	 * we've been released from the holding pen: secondary_stack
-	 * should now contain the SVC stack for this core
-	 */
-	b	secondary_startup
-
-1:	.long	.
-	.long	pen_release
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 6709706..2d4146f 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -9,15 +9,9 @@
  * published by the Free Software Foundation.
  */
 #include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <asm/cacheflush.h>
-#include <asm/localtimer.h>
 #include <asm/smp_scu.h>
 #include <asm/unified.h>
 
@@ -27,21 +21,11 @@
 
 #include "core.h"
 
-extern void vexpress_secondary_startup(void);
-
-/*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-volatile int __cpuinitdata pen_release = -1;
-
 static void __iomem *scu_base_addr(void)
 {
 	return MMIO_P2V(A9_MPCORE_SCU);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
-
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	trace_hardirqs_off();
@@ -53,138 +37,32 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 */
 	gic_cpu_init(0, gic_cpu_base_addr);
 
-	/*
-	 * let the primary processor know we're out of the
-	 * pen, then head off into the C entry point
-	 */
-	pen_release = -1;
-	smp_wmb();
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	scu_secondary_init(cpu);
 }
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
-
-	/*
-	 * Set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
-	 * This is really belt and braces; we hold unintended secondary
-	 * CPUs in the holding pen until we're ready for them.  However,
-	 * since we haven't sent them a soft interrupt, they shouldn't
-	 * be there.
-	 */
-	pen_release = cpu;
-	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
-	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
-
-	/*
-	 * Send the secondary CPU a soft interrupt, thereby causing
-	 * the boot monitor to read the system wide flags register,
-	 * and branch to the address found there.
-	 */
-	smp_cross_call(cpumask_of(cpu));
-
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		smp_rmb();
-		if (pen_release == -1)
-			break;
-
-		udelay(10);
-	}
-
-	/*
-	 * now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-
-	return pen_release != -1 ? -ENOSYS : 0;
+	return scu_boot_secondary(cpu, idle);
 }
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
 void __init smp_init_cpus(void)
 {
-	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
-
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-
-	/* sanity check */
-	if (ncores == 0) {
-		printk(KERN_ERR
-		       "vexpress: strange CM count of 0? Default to 1\n");
-
-		ncores = 1;
-	}
+	scu_init_cpus(scu_base_addr());
+}
 
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "vexpress: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
+/* If there are more than one CPU let them know where to start. */
+static void __init smp_point_cpus(void)
+{
+	if (num_present_cpus() <= 1)
+		return;
 
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
+	writel(BSYM(virt_to_phys(scu_secondary_startup)),
+	       MMIO_P2V(V2M_SYS_FLAGSSET));
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int ncores = num_possible_cpus();
-	unsigned int cpu = smp_processor_id();
-	int i;
-
-	smp_store_cpu_info(cpu);
-
-	/*
-	 * are we trying to boot more cores than exist?
-	 */
-	if (max_cpus > ncores)
-		max_cpus = ncores;
-
-	/*
-	 * Initialise the present map, which describes the set of CPUs
-	 * actually populated at the present time.
-	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
-	/*
-	 * Initialise the SCU if there are more than one CPU and let
-	 * them know where to start.
-	 */
-	if (max_cpus > 1) {
-		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
-		 */
-		percpu_timer_setup();
-
-		scu_enable(scu_base_addr());
-
-		/*
-		 * Write the address of secondary startup into the
-		 * system-wide flags register. The boot monitor waits
-		 * until it receives a soft interrupt, and then the
-		 * secondary CPU branches to this address.
-		 */
-		writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
-		writel(BSYM(virt_to_phys(vexpress_secondary_startup)),
-			MMIO_P2V(V2M_SYS_FLAGSSET));
-	}
+	scu_prepare_cpus(scu_base_addr(), max_cpus);
+	smp_point_cpus();
 }
-- 
1.7.0.5
