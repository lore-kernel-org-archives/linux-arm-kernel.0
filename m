From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Apr 2011 11:37:30 +0100
Subject: RFC, GIC based smp_cross_call cleanup suggestion
In-Reply-To: <BANLkTimjyBzh3Kc+1njcBBYCouKdSWhgng@mail.gmail.com>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
	<20110402085133.GE8482@n2100.arm.linux.org.uk>
	<BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
	<BANLkTimjyBzh3Kc+1njcBBYCouKdSWhgng@mail.gmail.com>
Message-ID: <20110403103730.GB4213@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2011 at 10:47:57PM -0600, Grant Likely wrote:
> On Sat, Apr 2, 2011 at 3:10 AM, Colin Cross <ccross@google.com> wrote:
> > On Sat, Apr 2, 2011 at 1:51 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Fri, Apr 01, 2011 at 04:55:02PM -0600, Grant Likely wrote:
> >>> On Fri, Apr 1, 2011 at 4:26 PM, John Linn <John.Linn@xilinx.com> wrote:
> >>> > I?m getting ready to submit a patch to add SMP to Xilinx code. I notice that
> >>> > smp_cross_call for all GIC based platforms is duplicated across each
> >>> > platform in smp.h.
> >>> >
> >>> >
> >>> >
> >>> > I thought I?d try to jump in to help with some cleanup, although I realize
> >>> > it?s minimal, I have to start somewhere.
> >>> >
> >>> >
> >>> >
> >>> > What about moving the smp_cross_call for GIC based designs into gic.h?
> >>>
> >>> Go for it. ?It's an obvious cleanup.
> >>
> >> That assumes that all SMP implementations will always have a GIC. ?It
> >> looks to me like this is conditional on shmobile, and so I don't think
> >> its that trivial - maybe Paul or Magnus can first indicate why this is.
> >
> > OMAP4 may also require a custom smp_cross_call implementation if CPU
> > idle is going to be supported in SMP - in CPU off idle modes, a GIC
> > SGI will not wake the CPU, and a write directly to the CPU's power
> > management controller or an external interrupt source would be
> > required.
> 
> What John proposes appears to be a pretty sane default though.  It
> would make sense to move it to common code, and require explicit
> action on the part of the subarch to compile it out for a different
> behaviour.  Requiring each subarch to define it explicitly doesn't
> seem optimal.

Bear in mind that the GIC doesn't do any PM support, so the hardware
folk are inventing their own IRQ controller to sit along side the GIC
to provide that missing functionality.  What I expect will happen is
that the GIC will be obsoleted and replaced by something integrating
PM support.

So we could end up in the situation where we need both GIC and something
else in the kernel at the same time - especially if we persue the single
kernel image thing.  Moving smp_cross_call() into gic.h would add an
additional bar to that happening.

A better solution may be to make smp_cross_call() be a function pointer
which must be initialized as part of the platforms SMP initialization.
That'd get rid of mach/smp.h entirely.

Oh, and while looking at that, guess what annoyingly stands in the way
of eliminating mach/smp.h ?  Yes, it's OMAP, because they've bunged some
function prototypes into plat/smp.h.  (I've not cared about that in the
patch below; I've deleted the entire thing, so it probably breaks OMAP.)

 arch/arm/include/asm/smp.h                |    6 +----
 arch/arm/kernel/smp.c                     |    7 +++++
 arch/arm/mach-exynos4/include/mach/smp.h  |   19 ---------------
 arch/arm/mach-exynos4/platsmp.c           |    5 +++-
 arch/arm/mach-msm/include/mach/smp.h      |   23 -------------------
 arch/arm/mach-msm/platsmp.c               |    4 ++-
 arch/arm/mach-omap2/omap-smp.c            |    5 +++-
 arch/arm/mach-realview/include/mach/smp.h |   14 -----------
 arch/arm/mach-realview/platsmp.c          |    3 ++
 arch/arm/mach-shmobile/include/mach/smp.h |   16 -------------
 arch/arm/mach-shmobile/platsmp.c          |    3 ++
 arch/arm/mach-tegra/include/mach/smp.h    |   14 -----------
 arch/arm/mach-tegra/platsmp.c             |    3 ++
 arch/arm/mach-ux500/include/mach/smp.h    |   24 --------------------
 arch/arm/mach-ux500/platsmp.c             |    5 +++-
 arch/arm/mach-vexpress/ct-ca9x4.c         |    2 +
 arch/arm/mach-vexpress/include/mach/smp.h |   13 ----------
 arch/arm/plat-omap/include/plat/smp.h     |   36 ------------------------------
 arch/arm/plat-versatile/platsmp.c         |    3 +-
 19 files changed, 37 insertions(+), 168 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 96ed521..27d1c95 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -14,8 +14,6 @@
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
 
-#include <mach/smp.h>
-
 #ifndef CONFIG_SMP
 # error "<asm/smp.h> included in non-SMP build"
 #endif
@@ -47,9 +45,9 @@ extern void smp_init_cpus(void);
 
 
 /*
- * Raise an IPI cross call on CPUs in callmap.
+ * Provide a function to raise an IPI cross call on CPUs in callmap.
  */
-extern void smp_cross_call(const struct cpumask *mask, int ipi);
+extern void smp_set_cross_call(void (*fn)(const struct cpumask *, int));
 
 /*
  * Boot a secondary CPU, and assign it the specified idle task.
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8fe05ad..c58bae9 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -376,6 +376,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
+static void (*smp_cross_call)(const struct cpumask *, int);
+
+void __init smp_set_cross_call(void (*fn)(const struct cpumask *, int))
+{
+	smp_cross_call = fn;
+}
+
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_CALL_FUNC);
diff --git a/arch/arm/mach-exynos4/include/mach/smp.h b/arch/arm/mach-exynos4/include/mach/smp.h
deleted file mode 100644
index a463dce..0000000
--- a/arch/arm/mach-exynos4/include/mach/smp.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/smp.h
- *
- * Cloned from arch/arm/mach-realview/include/mach/smp.h
-*/
-
-#ifndef ASM_ARCH_SMP_H
-#define ASM_ARCH_SMP_H __FILE__
-
-#include <asm/hardware/gic.h>
-
-/*
- * We use IRQ1 as the IPI
- */
-static inline void smp_cross_call(const struct cpumask *mask, int ipi)
-{
-	gic_raise_softirq(mask, ipi);
-}
-
-#endif
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index 6d35878..8403dd2 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
+#include <asm/hardare/gic.h>
 #include <asm/smp_scu.h>
 #include <asm/unified.h>
 
@@ -104,7 +105,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	smp_cross_call(cpumask_of(cpu), 1);
+	gic_raise_softirq(cpumask_of(cpu), 1);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
@@ -147,6 +148,8 @@ void __init smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-msm/include/mach/smp.h b/arch/arm/mach-msm/include/mach/smp.h
deleted file mode 100644
index 3c01000..0000000
--- a/arch/arm/mach-msm/include/mach/smp.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __ASM_ARCH_MSM_SMP_H
-#define __ASM_ARCH_MSM_SMP_H
-
-#include <asm/hardware/gic.h>
-
-static inline void smp_cross_call(const struct cpumask *mask, int ipi)
-{
-	gic_raise_softirq(mask, ipi);
-}
-
-#endif
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 0f427bc..2034098 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -119,7 +119,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	smp_cross_call(cpumask_of(cpu), 1);
+	gic_raise_softirq(cpumask_of(cpu), 1);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
@@ -151,6 +151,8 @@ void __init smp_init_cpus(void)
 
 	for (i = 0; i < NR_CPUS; i++)
 		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index b66cfe8..ecfe93c 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
+#include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -63,7 +64,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	omap_modify_auxcoreboot0(0x200, 0xfffffdff);
 	flush_cache_all();
 	smp_wmb();
-	smp_cross_call(cpumask_of(cpu), 1);
+	gic_raise_softirq(cpumask_of(cpu), 1);
 
 	/*
 	 * Now the secondary core is starting up let it run its
@@ -118,6 +119,8 @@ void __init smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-realview/include/mach/smp.h b/arch/arm/mach-realview/include/mach/smp.h
deleted file mode 100644
index c8221b3..0000000
--- a/arch/arm/mach-realview/include/mach/smp.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef ASMARM_ARCH_SMP_H
-#define ASMARM_ARCH_SMP_H
-
-#include <asm/hardware/gic.h>
-
-/*
- * We use IRQ1 as the IPI
- */
-static inline void smp_cross_call(const struct cpumask *mask, int ipi)
-{
-	gic_raise_softirq(mask, ipi);
-}
-
-#endif
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 2391922..963bf0d 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
 #include <asm/unified.h>
@@ -61,6 +62,8 @@ void __init smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-shmobile/include/mach/smp.h b/arch/arm/mach-shmobile/include/mach/smp.h
deleted file mode 100644
index 50db94e..0000000
--- a/arch/arm/mach-shmobile/include/mach/smp.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef __MACH_SMP_H
-#define __MACH_SMP_H
-
-#include <asm/hardware/gic.h>
-
-/*
- * We use IRQ1 as the IPI
- */
-static inline void smp_cross_call(const struct cpumask *mask, int ipi)
-{
-#if defined(CONFIG_ARM_GIC)
-	gic_raise_softirq(mask, ipi);
-#endif
-}
-
-#endif
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 65e879b..f3888fe 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <asm/hardware/gic.h>
 #include <asm/localtimer.h>
 #include <asm/mach-types.h>
 #include <mach/common.h>
@@ -57,6 +58,8 @@ void __init smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-tegra/include/mach/smp.h b/arch/arm/mach-tegra/include/mach/smp.h
deleted file mode 100644
index c8221b3..0000000
--- a/arch/arm/mach-tegra/include/mach/smp.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef ASMARM_ARCH_SMP_H
-#define ASMARM_ARCH_SMP_H
-
-#include <asm/hardware/gic.h>
-
-/*
- * We use IRQ1 as the IPI
- */
-static inline void smp_cross_call(const struct cpumask *mask, int ipi)
-{
-	gic_raise_softirq(mask, ipi);
-}
-
-#endif
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index ec1f689..b8ae3c9 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
+#include <asm/hardware/gic.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
@@ -122,6 +123,8 @@ void __init smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		cpu_set(i, cpu_possible_map);
+
+	set_smp_cross_call(gic_raise_softirq);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-ux500/include/mach/smp.h b/arch/arm/mach-ux500/include/mach/smp.h
deleted file mode 100644
index ca2b15b..0000000
--- a/arch/arm/mach-ux500/include/mach/smp.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * This file is based ARM realview platform.
- * Copyright (C) ARM Limited.
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#ifndef ASMARM_ARCH_SMP_H
-#define ASMARM_ARCH_SMP_H
-
-#include <asm/hardware/gic.h>
-
-/* This is required to wakeup the secondary core */
-extern void u8500_secondary_startup(void);
-
-/*
- * We use IRQ1 as the IPI
- */
-static inline void smp_cross_call(const struct cpumask *mask, int ipi)
-{
-	gic_raise_softirq(mask, ipi);
-}
-#endif
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 4fff4d4..4e33846 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
+#include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
@@ -94,7 +95,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(cpu);
 
-	smp_cross_call(cpumask_of(cpu), 1);
+	gic_raise_softirq(cpumask_of(cpu), 1);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
@@ -162,6 +163,8 @@ void __init smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index ebc22e7..9dc1c69 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -210,6 +210,8 @@ static void ct_ca9x4_init_cpu_map(void)
 
 	for (i = 0; i < ncores; ++i)
 		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void ct_ca9x4_smp_enable(unsigned int max_cpus)
diff --git a/arch/arm/mach-vexpress/include/mach/smp.h b/arch/arm/mach-vexpress/include/mach/smp.h
deleted file mode 100644
index 4c05e4a..0000000
--- a/arch/arm/mach-vexpress/include/mach/smp.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __MACH_SMP_H
-#define __MACH_SMP_H
-
-#include <asm/hardware/gic.h>
-
-/*
- * We use IRQ1 as the IPI
- */
-static inline void smp_cross_call(const struct cpumask *mask, int ipi)
-{
-	gic_raise_softirq(mask, ipi);
-}
-#endif
diff --git a/arch/arm/plat-omap/include/plat/smp.h b/arch/arm/plat-omap/include/plat/smp.h
deleted file mode 100644
index 7a10257..0000000
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * OMAP4 machine specific smp.h
- *
- * Copyright (C) 2009 Texas Instruments, Inc.
- *
- * Author:
- *	Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * Interface functions needed for the SMP. This file is based on arm
- * realview smp platform.
- * Copyright (c) 2003 ARM Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef OMAP_ARCH_SMP_H
-#define OMAP_ARCH_SMP_H
-
-#include <asm/hardware/gic.h>
-
-/* Needed for secondary core boot */
-extern void omap_secondary_startup(void);
-extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
-extern void omap_auxcoreboot_addr(u32 cpu_addr);
-extern u32 omap_read_auxcoreboot0(void);
-
-/*
- * We use Soft IRQ1 as the IPI
- */
-static inline void smp_cross_call(const struct cpumask *mask, int ipi)
-{
-	gic_raise_softirq(mask, ipi);
-}
-
-#endif
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index ba3d471..51ecfea 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/hardware/gic.h>
 
 /*
  * control for which core is the next to come out of the secondary
@@ -83,7 +84,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	smp_cross_call(cpumask_of(cpu), 1);
+	gic_raise_softirq(cpumask_of(cpu), 1);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
