From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 18 Jun 2010 22:14:51 +0400
Subject: [PATCH 1/2] ARM: Factor out secondary CPU bootup code from
	RealView platforms
Message-ID: <20100618181451.GA17455@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For CNS3xxx we want to reuse the original ARM approach of booting
secondary CPUs. This patch turns RealView's code into "SCU library",
so that now platform code can call the generic routines.

Note that there are also mach-{omap2,ux500,vexpress} that might
benefit from this change.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/include/asm/smp_scu.h   |    8 ++
 arch/arm/kernel/Makefile         |    2 +-
 arch/arm/kernel/smp_scu.c        |  164 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/smp_scu_head.S   |   37 +++++++++
 arch/arm/mach-realview/Makefile  |    2 +-
 arch/arm/mach-realview/headsmp.S |   39 ---------
 arch/arm/mach-realview/platsmp.c |  165 ++------------------------------------
 7 files changed, 217 insertions(+), 200 deletions(-)
 create mode 100644 arch/arm/kernel/smp_scu_head.S
 delete mode 100644 arch/arm/mach-realview/headsmp.S

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 2376835..45a281a 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -4,4 +4,12 @@
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
 
+extern volatile int __cpuinitdata scu_pen_release;
+void scu_secondary_startup(void);
+void __cpuinit scu_secondary_init(unsigned int cpu);
+int __cpuinit scu_boot_secondary(unsigned int cpu, struct task_struct *idle);
+void __init scu_init_cpus(void __iomem *scu_base);
+void __init scu_prepare_cpus(void __iomem *scu_base, void __iomem *maddr,
+			     unsigned int max_cpus);
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
index 9ab4149..810d91c 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -8,10 +8,16 @@
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
+#include <asm/unified.h>
+#include <asm/localtimer.h>
 #include <asm/cacheflush.h>
 
 #define SCU_CTRL		0x00
@@ -50,3 +56,161 @@ void __init scu_enable(void __iomem *scu_base)
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
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting scu_pen_release.
+	 *
+	 * Note that "scu_pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	scu_pen_release = cpu;
+	flush_cache_all();
+
+	/*
+	 * XXX
+	 *
+	 * This is a later addition to the booting protocol: the
+	 * bootMonitor now puts secondary cores into WFI, so
+	 * poke_milo() no longer gets the cores moving; we need
+	 * to send a soft interrupt to wake the secondary core.
+	 * Use smp_cross_call() for this, since there's little
+	 * point duplicating the code here
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
+	unsigned int ncores = scu_get_core_count(scu_base);
+	unsigned int i;
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+static void __init poke_milo(void __iomem *maddr)
+{
+	/* nobody is to be released from the pen yet */
+	scu_pen_release = -1;
+
+	/*
+	 * Write the address of secondary startup into the system-wide flags
+	 * register. The BootMonitor waits for this register to become
+	 * non-zero.
+	 */
+	__raw_writel(BSYM(virt_to_phys(scu_secondary_startup)), maddr);
+
+	mb();
+}
+
+void __init scu_prepare_cpus(void __iomem *scu_base, void __iomem *maddr,
+			     unsigned int max_cpus)
+{
+	unsigned int ncores = scu_get_core_count(scu_base);
+	unsigned int cpu = smp_processor_id();
+	int i;
+
+	/* sanity check */
+	if (ncores == 0) {
+		pr_err("%s: strange CM count of 0? Default to 1\n", __func__);
+
+		ncores = 1;
+	}
+
+	if (ncores > NR_CPUS) {
+		pr_warn("%s: no. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n", __func__,
+		       ncores, NR_CPUS);
+		ncores = NR_CPUS;
+	}
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
+	 * them know where to start. Note that, on modern versions of
+	 * MILO, the "poke" doesn't actually do anything until each
+	 * individual core is sent a soft interrupt to get it out of
+	 * WFI
+	 */
+	if (max_cpus > 1) {
+		/*
+		 * Enable the local timer or broadcast device for the
+		 * boot CPU, but only if we have more than one CPU.
+		 */
+		percpu_timer_setup();
+
+		scu_enable(scu_base);
+		poke_milo(maddr);
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
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index a01b76b..d456163 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -8,6 +8,6 @@ obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
 obj-$(CONFIG_MACH_REALVIEW_PBA8)	+= realview_pba8.o
 obj-$(CONFIG_MACH_REALVIEW_PBX)		+= realview_pbx.o
-obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
diff --git a/arch/arm/mach-realview/headsmp.S b/arch/arm/mach-realview/headsmp.S
deleted file mode 100644
index 4075473..0000000
--- a/arch/arm/mach-realview/headsmp.S
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *  linux/arch/arm/mach-realview/headsmp.S
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
- * Realview specific entry point for secondary CPUs.  This provides
- * a "holding pen" into which all secondary cores are held until we're
- * ready for them to initialise.
- */
-ENTRY(realview_secondary_startup)
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
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 0092658..a41e169 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -9,18 +9,11 @@
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
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/localtimer.h>
-#include <asm/unified.h>
 
 #include <mach/board-eb.h>
 #include <mach/board-pb11mp.h>
@@ -29,14 +22,6 @@
 
 #include "core.h"
 
-extern void realview_secondary_startup(void);
-
-/*
- * control for which core is the next to come out of the secondary
- * boot "holding pen"
- */
-volatile int __cpuinitdata pen_release = -1;
-
 static void __iomem *scu_base_addr(void)
 {
 	if (machine_is_realview_eb_mp())
@@ -50,16 +35,6 @@ static void __iomem *scu_base_addr(void)
 		return (void __iomem *)0;
 }
 
-static inline unsigned int get_core_count(void)
-{
-	void __iomem *scu_base = scu_base_addr();
-	if (scu_base)
-		return scu_get_core_count(scu_base);
-	return 1;
-}
-
-static DEFINE_SPINLOCK(boot_lock);
-
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	trace_hardirqs_off();
@@ -71,151 +46,23 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
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
-	 * set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
-	 * The secondary processor is waiting to be released from
-	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
-	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
-	 * "cpu" is Linux's internal ID.
-	 */
-	pen_release = cpu;
-	flush_cache_all();
-
-	/*
-	 * XXX
-	 *
-	 * This is a later addition to the booting protocol: the
-	 * bootMonitor now puts secondary cores into WFI, so
-	 * poke_milo() no longer gets the cores moving; we need
-	 * to send a soft interrupt to wake the secondary core.
-	 * Use smp_cross_call() for this, since there's little
-	 * point duplicating the code here
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
 
-static void __init poke_milo(void)
-{
-	/* nobody is to be released from the pen yet */
-	pen_release = -1;
-
-	/*
-	 * Write the address of secondary startup into the system-wide flags
-	 * register. The BootMonitor waits for this register to become
-	 * non-zero.
-	 */
-	__raw_writel(BSYM(virt_to_phys(realview_secondary_startup)),
-		     __io_address(REALVIEW_SYS_FLAGSSET));
-
-	mb();
-}
-
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
 void __init smp_init_cpus(void)
 {
-	unsigned int i, ncores = get_core_count();
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	scu_init_cpus(scu_base_addr());
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned int ncores = get_core_count();
-	unsigned int cpu = smp_processor_id();
-	int i;
-
-	/* sanity check */
-	if (ncores == 0) {
-		printk(KERN_ERR
-		       "Realview: strange CM count of 0? Default to 1\n");
-
-		ncores = 1;
-	}
-
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "Realview: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
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
-	 * them know where to start. Note that, on modern versions of
-	 * MILO, the "poke" doesn't actually do anything until each
-	 * individual core is sent a soft interrupt to get it out of
-	 * WFI
-	 */
-	if (max_cpus > 1) {
-		/*
-		 * Enable the local timer or broadcast device for the
-		 * boot CPU, but only if we have more than one CPU.
-		 */
-		percpu_timer_setup();
+	void __iomem *scu_base = scu_base_addr();
+	void __iomem *maddr = __io_address(REALVIEW_SYS_FLAGSSET);
 
-		scu_enable(scu_base_addr());
-		poke_milo();
-	}
+	scu_prepare_cpus(scu_base, maddr, max_cpus);
 }
-- 
1.7.0.5
