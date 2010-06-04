From: olof@lixom.net (Olof Johansson)
Date: Fri,  4 Jun 2010 02:10:36 -0500
Subject: [PATCH 04/10] [ARM] tegra: SMP support
In-Reply-To: <1275635441-17378-4-git-send-email-olof@lixom.net>
References: <3478yvr76gerav> <1275635441-17378-1-git-send-email-olof@lixom.net>
	<1275635441-17378-2-git-send-email-olof@lixom.net>
	<1275635441-17378-3-git-send-email-olof@lixom.net>
	<1275635441-17378-4-git-send-email-olof@lixom.net>
Message-ID: <1275635441-17378-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Erik Gilling <konkers@android.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/Kconfig                       |   12 ++-
 arch/arm/mach-tegra/Makefile           |    2 +
 arch/arm/mach-tegra/headsmp.S          |   61 +++++++++++++
 arch/arm/mach-tegra/hotplug.c          |  140 ++++++++++++++++++++++++++++
 arch/arm/mach-tegra/include/mach/smp.h |   30 ++++++
 arch/arm/mach-tegra/localtimer.c       |   25 +++++
 arch/arm/mach-tegra/platsmp.c          |  156 ++++++++++++++++++++++++++++++++
 7 files changed, 422 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-tegra/headsmp.S
 create mode 100644 arch/arm/mach-tegra/hotplug.c
 create mode 100644 arch/arm/mach-tegra/include/mach/smp.h
 create mode 100644 arch/arm/mach-tegra/localtimer.c
 create mode 100644 arch/arm/mach-tegra/platsmp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92b9572..14453b2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1107,10 +1107,12 @@ source "kernel/time/Kconfig"
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
-		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
+		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
+		 ARCH_U8500 || ARCH_TEGRA)
 	depends on GENERIC_CLOCKEVENTS
 	select USE_GENERIC_SMP_HELPERS
-	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
+	select HAVE_ARM_SCU if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500 || \
+		 ARCH_TEGRA)
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -1179,9 +1181,11 @@ config HOTPLUG_CPU
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
-		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)
+		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
+		ARCH_U8500 || ARCH_TEGRA)
 	default y
-	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500)
+	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4 || ARCH_U8500 || \
+		ARCH_TEGRA)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index e20546a..f339559 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -3,3 +3,5 @@ obj-y                                   += io.o
 obj-y                                   += irq.o
 obj-y                                   += clock.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
+obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
new file mode 100644
index 0000000..b5349b2
--- /dev/null
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -0,0 +1,61 @@
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+        .section ".text.head", "ax"
+	__CPUINIT
+
+/*
+ * Tegra specific entry point for secondary CPUs.
+ *   The secondary kernel init calls v7_flush_dcache_all before it enables
+ *   the L1; however, the L1 comes out of reset in an undefined state, so
+ *   the clean + invalidate performed by v7_flush_dcache_all causes a bunch
+ *   of cache lines with uninitialized data and uninitialized tags to get
+ *   written out to memory, which does really unpleasant things to the main
+ *   processor.  We fix this by performing an invalidate, rather than a
+ *   clean + invalidate, before jumping into the kernel.
+ */
+ENTRY(v7_invalidate_l1)
+        mov     r0, #0
+        mcr     p15, 2, r0, c0, c0, 0
+        mrc     p15, 1, r0, c0, c0, 0
+
+        ldr     r1, =0x7fff
+        and     r2, r1, r0, lsr #13
+
+        ldr     r1, =0x3ff
+
+        and     r3, r1, r0, lsr #3  @ NumWays - 1
+        add     r2, r2, #1          @ NumSets
+
+        and     r0, r0, #0x7
+        add     r0, r0, #4          @ SetShift
+
+        clz     r1, r3              @ WayShift
+        add     r4, r3, #1          @ NumWays
+1:      sub     r2, r2, #1          @ NumSets--
+        mov     r3, r4              @ Temp = NumWays
+2:      subs    r3, r3, #1          @ Temp--
+        mov     r5, r3, lsl r1
+        mov     r6, r2, lsl r0
+        orr     r5, r5, r6          @ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
+        mcr     p15, 0, r5, c7, c6, 2
+        bgt     2b
+        cmp     r2, #0
+        bgt     1b
+        dsb
+        isb
+        mov     pc, lr
+ENDPROC(v7_invalidate_l1)
+
+ENTRY(tegra_secondary_startup)
+	msr	cpsr_fsxc, #0xd3
+        bl      v7_invalidate_l1
+	mrc	p15, 0, r0, c0, c0, 5
+        and	r0, r0, #15
+        ldr     r1, =0x6000f100
+        str     r0, [r1]
+1:      ldr     r2, [r1]
+        cmp     r0, r2
+        beq     1b
+        b       secondary_startup
+ENDPROC(tegra_secondary_startup)
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
new file mode 100644
index 0000000..464316c
--- /dev/null
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -0,0 +1,140 @@
+/*
+ *  linux/arch/arm/mach-realview/hotplug.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/completion.h>
+
+#include <asm/cacheflush.h>
+
+static DECLARE_COMPLETION(cpu_killed);
+
+static inline void cpu_enter_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_all();
+	asm volatile(
+	"	mcr	p15, 0, %1, c7, c5, 0\n"
+	"	mcr	p15, 0, %1, c7, c10, 4\n"
+	/*
+	 * Turn off coherency
+	 */
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, #0x20\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, #0x04\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "r" (0)
+	  : "cc");
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, #0x04\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, #0x20\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  :
+	  : "cc");
+}
+
+static inline void platform_do_lowpower(unsigned int cpu)
+{
+	/*
+	 * there is no power-control hardware on this platform, so all
+	 * we can do is put the core into WFI; this is safe as the calling
+	 * code will have already disabled interrupts
+	 */
+	for (;;) {
+		/*
+		 * here's the WFI
+		 */
+		asm(".word	0xe320f003\n"
+		    :
+		    :
+		    : "memory", "cc");
+
+		/*if (pen_release == cpu) {*/
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		/*}*/
+
+		/*
+		 * getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * The trouble is, letting people know about this is not really
+		 * possible, since we are currently running incoherently, and
+		 * therefore cannot safely call printk() or anything else
+		 */
+#ifdef DEBUG
+		printk(KERN_WARN "CPU%u: spurious wakeup call\n", cpu);
+#endif
+	}
+}
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return wait_for_completion_timeout(&cpu_killed, 5000);
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+#ifdef DEBUG
+	unsigned int this_cpu = hard_smp_processor_id();
+
+	if (cpu != this_cpu) {
+		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
+			   this_cpu, cpu);
+		BUG();
+	}
+#endif
+
+	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
+	complete(&cpu_killed);
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+	platform_do_lowpower(cpu);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	cpu_leave_lowpower();
+}
+
+int mach_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
diff --git a/arch/arm/mach-tegra/include/mach/smp.h b/arch/arm/mach-tegra/include/mach/smp.h
new file mode 100644
index 0000000..8b42dab
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/smp.h
@@ -0,0 +1,30 @@
+#ifndef ASMARM_ARCH_SMP_H
+#define ASMARM_ARCH_SMP_H
+
+
+#include <asm/hardware/gic.h>
+
+#define hard_smp_processor_id()			\
+	({						\
+		unsigned int cpunum;			\
+		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
+			: "=r" (cpunum));		\
+		cpunum &= 0x0F;				\
+	})
+
+/*
+ * We use IRQ1 as the IPI
+ */
+static inline void smp_cross_call(const struct cpumask *mask)
+{
+	gic_raise_softirq(mask, 1);
+}
+
+/*
+ * Do nothing on MPcore.
+ */
+static inline void smp_cross_call_done(cpumask_t callmap)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/localtimer.c b/arch/arm/mach-tegra/localtimer.c
new file mode 100644
index 0000000..f81ca7c
--- /dev/null
+++ b/arch/arm/mach-tegra/localtimer.c
@@ -0,0 +1,25 @@
+/*
+ *  arch/arm/mach-tegra/localtimer.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clockchips.h>
+#include <asm/irq.h>
+#include <asm/smp_twd.h>
+#include <asm/localtimer.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+void __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+	twd_timer_setup(evt);
+}
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
new file mode 100644
index 0000000..1c0fd92
--- /dev/null
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -0,0 +1,156 @@
+/*
+ *  linux/arch/arm/mach-tegra/platsmp.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ *  Copyright (C) 2009 Palm
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/cacheflush.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/localtimer.h>
+#include <asm/smp_scu.h>
+
+#include <mach/iomap.h>
+
+extern void tegra_secondary_startup(void);
+
+static DEFINE_SPINLOCK(boot_lock);
+static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
+
+#define EVP_CPU_RESET_VECTOR \
+	(IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
+#define CLK_RST_CONTROLLER_CLK_CPU_CMPLX \
+	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x4c)
+#define CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR \
+	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x344)
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	trace_hardirqs_off();
+
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_cpu_init(0, IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x100);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long old_boot_vector;
+	unsigned long boot_vector;
+	unsigned long timeout;
+	u32 reg;
+
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+
+	/* set the reset vector to point to the secondary_startup routine */
+
+	boot_vector = virt_to_phys(tegra_secondary_startup);
+	old_boot_vector = readl(EVP_CPU_RESET_VECTOR);
+	writel(boot_vector, EVP_CPU_RESET_VECTOR);
+
+	/* enable cpu clock on cpu1 */
+	reg = readl(CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+	writel(reg & ~(1<<9), CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+
+	reg = (1<<13) | (1<<9) | (1<<5) | (1<<1);
+	writel(reg, CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR);
+
+	smp_wmb();
+	flush_cache_all();
+
+	/* unhalt the cpu */
+	writel(0, IO_ADDRESS(TEGRA_FLOW_CTRL_BASE) + 0x14);
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		if (readl(EVP_CPU_RESET_VECTOR) != boot_vector)
+			break;
+		udelay(10);
+	}
+
+	/* put the old boot vector back */
+	writel(old_boot_vector, EVP_CPU_RESET_VECTOR);
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return 0;
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	unsigned int i, ncores = scu_get_core_count(scu_base);
+
+	for (i = 0; i < ncores; i++)
+		cpu_set(i, cpu_possible_map);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = scu_get_core_count(scu_base);
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
+	 * them know where to start. Note that, on modern versions of
+	 * MILO, the "poke" doesn't actually do anything until each
+	 * individual core is sent a soft interrupt to get it out of
+	 * WFI
+	 */
+	if (max_cpus > 1) {
+		percpu_timer_setup();
+		scu_enable(scu_base);
+	}
+}
-- 
1.5.6.5
