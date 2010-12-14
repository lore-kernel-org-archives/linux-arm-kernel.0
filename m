From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 14 Dec 2010 16:56:55 +0900
Subject: [PATCH 01/03] ARM: mach-shmobile: SMP base support
In-Reply-To: <20101214075647.11275.25933.sendpatchset@t400s>
References: <20101214075647.11275.25933.sendpatchset@t400s>
Message-ID: <20101214075655.11275.95963.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SMP base support for R-Mobile / SH-Mobile processors.

This patch contains all base code to support CONFIG_SMP
regardless of ARCH_SHMOBILE processor type. Both local timer
and CPU hotplug are supported, but no processor specific
code is included.

At this point only the default behavior is in place, so
a single core will always be used even though CONFIG_SMP
is enabled on multicore systems.

The SMP Kconfig entry for arch/arm/Kconfig is excluded from
this patch to simplify merging.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Future patches may be required to sync up the framework
 bits with current/upcoming changes in RMKs git repository.

 arch/arm/mach-shmobile/Makefile                        |    6 +
 arch/arm/mach-shmobile/headsmp.S                       |   26 +++++
 arch/arm/mach-shmobile/hotplug.c                       |   41 ++++++++
 arch/arm/mach-shmobile/include/mach/common.h           |    1 
 arch/arm/mach-shmobile/include/mach/entry-macro-intc.S |    6 +
 arch/arm/mach-shmobile/include/mach/smp.h              |   16 +++
 arch/arm/mach-shmobile/localtimer.c                    |   25 +++++
 arch/arm/mach-shmobile/platsmp.c                       |   73 ++++++++++++++++
 8 files changed, 194 insertions(+)

--- 0006/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-12-14 13:50:20.000000000 +0900
@@ -11,6 +11,11 @@ obj-$(CONFIG_ARCH_SH7377)	+= setup-sh737
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o
 
+# SMP objects
+smp-y				:= platsmp.o headsmp.o
+smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
+
 # Pinmux setup
 pfc-y				:=
 pfc-$(CONFIG_ARCH_SH7367)	+= pfc-sh7367.o
@@ -26,4 +31,5 @@ obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5ev
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 
 # Framework support
+obj-$(CONFIG_SMP)		+= $(smp-y)
 obj-$(CONFIG_GENERIC_GPIO)	+= $(pfc-y)
--- /dev/null
+++ work/arch/arm/mach-shmobile/headsmp.S	2010-12-14 13:50:21.000000000 +0900
@@ -0,0 +1,26 @@
+/*
+ * SMP support for R-Mobile / SH-Mobile
+ *
+ * Copyright (C) 2010  Magnus Damm
+ * Copyright (C) 2010  Takashi Yoshii
+ *
+ * Based on vexpress, Copyright (c) 2003 ARM Limited, All Rights Reserved
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
+ * Reset vector for secondary CPUs.
+ * This will be mapped at address 0 by SBAR register.
+ * We need _long_ jump to the physical address.
+ */
+	.align  12
+ENTRY(shmobile_secondary_vector)
+	ldr     pc, 1f
+1:	.long   secondary_startup - CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START
--- /dev/null
+++ work/arch/arm/mach-shmobile/hotplug.c	2010-12-14 13:50:21.000000000 +0900
@@ -0,0 +1,41 @@
+/*
+ * SMP support for R-Mobile / SH-Mobile
+ *
+ * Copyright (C) 2010  Magnus Damm
+ *
+ * Based on realview, Copyright (C) 2002 ARM Ltd, All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
+
+void platform_cpu_die(unsigned int cpu)
+{
+	while (1) {
+		/*
+		 * here's the WFI
+		 */
+		asm(".word	0xe320f003\n"
+		    :
+		    :
+		    : "memory", "cc");
+	}
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-12-14 13:50:20.000000000 +0900
@@ -3,6 +3,7 @@
 
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
+extern void shmobile_secondary_vector(void);
 struct clk;
 extern int clk_init(void);
 
--- 0001/arch/arm/mach-shmobile/include/mach/entry-macro-intc.S
+++ work/arch/arm/mach-shmobile/include/mach/entry-macro-intc.S	2010-12-14 13:50:20.000000000 +0900
@@ -17,6 +17,12 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
+	.macro	test_for_ipi, irqnr, irqstat, base, tmp
+	.endm
+
+	.macro	test_for_ltirq, irqnr, irqstat, base, tmp
+	.endm
+
 	.macro  disable_fiq
 	.endm
 
--- /dev/null
+++ work/arch/arm/mach-shmobile/include/mach/smp.h	2010-12-14 13:50:21.000000000 +0900
@@ -0,0 +1,16 @@
+#ifndef __MACH_SMP_H
+#define __MACH_SMP_H
+
+#include <asm/hardware/gic.h>
+#include <asm/smp_mpidr.h>
+
+/*
+ * We use IRQ1 as the IPI
+ */
+static inline void smp_cross_call(const struct cpumask *mask)
+{
+#if defined(CONFIG_ARM_GIC)
+	gic_raise_softirq(mask, 1);
+#endif
+}
+#endif
--- /dev/null
+++ work/arch/arm/mach-shmobile/localtimer.c	2010-12-14 14:31:51.000000000 +0900
@@ -0,0 +1,25 @@
+/*
+ * SMP support for R-Mobile / SH-Mobile - local timer portion
+ *
+ * Copyright (C) 2010  Magnus Damm
+ *
+ * Based on vexpress, Copyright (C) 2002 ARM Ltd, All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clockchips.h>
+#include <asm/smp_twd.h>
+#include <asm/localtimer.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+void __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = 29;
+	twd_timer_setup(evt);
+}
--- /dev/null
+++ work/arch/arm/mach-shmobile/platsmp.c	2010-12-14 14:32:27.000000000 +0900
@@ -0,0 +1,73 @@
+/*
+ * SMP support for R-Mobile / SH-Mobile
+ *
+ * Copyright (C) 2010  Magnus Damm
+ *
+ * Based on vexpress, Copyright (C) 2002 ARM Ltd, All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <asm/localtimer.h>
+
+static unsigned int __init shmobile_smp_get_core_count(void)
+{
+	return 1;
+}
+
+static void __init shmobile_smp_prepare_cpus(void)
+{
+	/* do nothing for now */
+}
+
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	trace_hardirqs_off();
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	return -ENOSYS;
+}
+
+void __init smp_init_cpus(void)
+{
+	unsigned int ncores = shmobile_smp_get_core_count();
+	unsigned int i;
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = shmobile_smp_get_core_count();
+	unsigned int cpu = smp_processor_id();
+	int i;
+
+	smp_store_cpu_info(cpu);
+
+	if (max_cpus > ncores)
+		max_cpus = ncores;
+
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	if (max_cpus > 1) {
+		shmobile_smp_prepare_cpus();
+
+		/*
+		 * Enable the local timer or broadcast device for the
+		 * boot CPU, but only if we have more than one CPU.
+		 */
+		percpu_timer_setup();
+	}
+}
