From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  7 Jun 2012 17:09:20 +0100
Subject: [PATCH v7 03/12] ARM: SoC: convert VExpress/RealView to SoC descriptor
In-Reply-To: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339085369-26073-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert both Realview and VExpress to use the SoC descriptor to
provide their SMP and CPU hotplug operation.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/core.c                  |    7 +++++++
 arch/arm/mach-realview/core.h                  |    9 +++++++++
 arch/arm/mach-realview/hotplug.c               |    6 +++---
 arch/arm/mach-realview/platsmp.c               |   20 ++++++++++++++++----
 arch/arm/mach-realview/realview_eb.c           |    1 +
 arch/arm/mach-realview/realview_pb1176.c       |    1 +
 arch/arm/mach-realview/realview_pb11mp.c       |    1 +
 arch/arm/mach-realview/realview_pba8.c         |    1 +
 arch/arm/mach-realview/realview_pbx.c          |    1 +
 arch/arm/mach-vexpress/core.h                  |   10 ++++++++++
 arch/arm/mach-vexpress/hotplug.c               |    6 +++---
 arch/arm/mach-vexpress/platsmp.c               |   21 +++++++++++++++++----
 arch/arm/mach-vexpress/v2m.c                   |   10 ++++++++++
 arch/arm/plat-versatile/include/plat/platsmp.h |   14 ++++++++++++++
 arch/arm/plat-versatile/platsmp.c              |    4 ++--
 15 files changed, 96 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 45868bb..b31e070 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -37,6 +37,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
+#include <asm/soc.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
@@ -532,3 +533,9 @@ void realview_fixup(struct tag *tags, char **from, struct meminfo *meminfo)
 	meminfo->nr_banks = 1;
 #endif
 }
+
+struct arm_soc_desc realview_soc_desc __initdata = {
+	.name		= "ARM RealView Platform",
+	soc_smp_init_ops(realview_soc_smp_init_ops)
+	soc_smp_ops(realview_soc_smp_ops)
+};
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index f8f2c0a..2a7097f 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -27,6 +27,7 @@
 
 #include <asm/setup.h>
 #include <asm/leds.h>
+#include <asm/soc.h>
 
 #define APB_DEVICE(name, busid, base, plat)			\
 static AMBA_APB_DEVICE(name, busid, 0, REALVIEW_##base##_BASE, base##_IRQ, plat)
@@ -56,4 +57,12 @@ extern void realview_init_early(void);
 extern void realview_fixup(struct tag *tags, char **from,
 			   struct meminfo *meminfo);
 
+extern struct arm_soc_desc		realview_soc_desc;
+extern struct arm_soc_smp_init_ops	realview_soc_smp_init_ops;
+extern struct arm_soc_smp_ops		realview_soc_smp_ops;
+
+extern int  realview_cpu_kill(unsigned int cpu);
+extern void realview_cpu_die(unsigned int cpu);
+extern int  realview_cpu_disable(unsigned int cpu);
+
 #endif
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index 57d9efb..c308b85 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -89,7 +89,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int realview_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -99,7 +99,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void realview_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
@@ -119,7 +119,7 @@ void platform_cpu_die(unsigned int cpu)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int realview_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 17c878d..68872b6 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -17,14 +17,15 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
+#include <asm/soc.h>
 
 #include <mach/board-eb.h>
 #include <mach/board-pb11mp.h>
 #include <mach/board-pbx.h>
 
-#include "core.h"
+#include <plat/platsmp.h>
 
-extern void versatile_secondary_startup(void);
+#include "core.h"
 
 static void __iomem *scu_base_addr(void)
 {
@@ -43,7 +44,7 @@ static void __iomem *scu_base_addr(void)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+static void __init realview_smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
@@ -63,7 +64,7 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 {
 
 	scu_enable(scu_base_addr());
@@ -77,3 +78,14 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	__raw_writel(virt_to_phys(versatile_secondary_startup),
 		     __io_address(REALVIEW_SYS_FLAGSSET));
 }
+
+struct arm_soc_smp_init_ops realview_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= realview_smp_init_cpus,
+	.smp_prepare_cpus	= realview_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops realview_soc_smp_ops __initdata = {
+	.smp_secondary_init	= versatile_secondary_init,
+	.smp_boot_secondary	= versatile_boot_secondary,
+	soc_hotplug_ops(realview)
+};
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index baf382c..6289506 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -471,6 +471,7 @@ static void __init realview_eb_init(void)
 MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_fixup,
 	.map_io		= realview_eb_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index b1d7caf..b751f69 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -384,6 +384,7 @@ static void __init realview_pb1176_init(void)
 MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_pb1176_fixup,
 	.map_io		= realview_pb1176_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index a98c536..e527460 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -366,6 +366,7 @@ static void __init realview_pb11mp_init(void)
 MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pb11mp_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 5965017..519bab2 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -308,6 +308,7 @@ static void __init realview_pba8_init(void)
 MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pba8_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 3f2f605..13c886f 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -403,6 +403,7 @@ static void __init realview_pbx_init(void)
 MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_pbx_fixup,
 	.map_io		= realview_pbx_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index a3a4980..4e46d69 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -5,3 +5,13 @@
 #define V2T_PERIPH 0xf8200000
 
 void vexpress_dt_smp_map_io(void);
+
+struct arm_soc_smp_init_ops;
+struct arm_soc_smp_ops;
+
+extern struct arm_soc_smp_init_ops	vexpress_soc_smp_init_ops;
+extern struct arm_soc_smp_ops		vexpress_soc_smp_ops;
+
+extern int  vexpress_cpu_kill(unsigned int cpu);
+extern void vexpress_cpu_die(unsigned int cpu);
+extern int  vexpress_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index c504a72..89281e3 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -84,7 +84,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int vexpress_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -94,7 +94,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void vexpress_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
@@ -114,7 +114,7 @@ void platform_cpu_die(unsigned int cpu)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int vexpress_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 14ba112..7da255b 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -18,11 +18,13 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 
+#include <asm/soc.h>
+
 #include <mach/motherboard.h>
 
-#include "core.h"
+#include <plat/platsmp.h>
 
-extern void versatile_secondary_startup(void);
+#include "core.h"
 
 #if defined(CONFIG_OF)
 
@@ -167,7 +169,7 @@ void __init vexpress_dt_smp_prepare_cpus(unsigned int max_cpus)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+static void __init vexpress_smp_init_cpus(void)
 {
 	if (ct_desc)
 		ct_desc->init_cpu_map();
@@ -176,7 +178,7 @@ void __init smp_init_cpus(void)
 
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init vexpress_smp_prepare_cpus(unsigned int max_cpus)
 {
 	/*
 	 * Initialise the present map, which describes the set of CPUs
@@ -195,3 +197,14 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 */
 	v2m_flags_set(virt_to_phys(versatile_secondary_startup));
 }
+
+struct arm_soc_smp_init_ops vexpress_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= vexpress_smp_init_cpus,
+	.smp_prepare_cpus	= vexpress_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops vexpress_soc_smp_ops __initdata = {
+	.smp_secondary_init	= versatile_secondary_init,
+	.smp_boot_secondary	= versatile_boot_secondary,
+	soc_hotplug_ops(vexpress)
+};
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index fde26ad..102cbb8 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -20,6 +20,7 @@
 
 #include <asm/arch_timer.h>
 #include <asm/mach-types.h>
+#include <asm/soc.h>
 #include <asm/sizes.h>
 #include <asm/smp_twd.h>
 #include <asm/mach/arch.h>
@@ -35,6 +36,7 @@
 #include <mach/motherboard.h>
 
 #include <plat/sched_clock.h>
+#include <plat/platsmp.h>
 
 #include "core.h"
 
@@ -473,8 +475,15 @@ static void __init v2m_init(void)
 	ct_desc->init_tile();
 }
 
+static struct arm_soc_desc vexpress_soc_desc __initdata = {
+	.name		= "ARM VE Platform",
+	soc_smp_init_ops(vexpress_soc_smp_init_ops)
+	soc_smp_ops(vexpress_soc_smp_ops)
+};
+
 MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.atag_offset	= 0x100,
+	.soc		= &vexpress_soc_desc,
 	.map_io		= v2m_map_io,
 	.init_early	= v2m_init_early,
 	.init_irq	= v2m_init_irq,
@@ -679,6 +688,7 @@ const static char *v2m_dt_match[] __initconst = {
 
 DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.dt_compat	= v2m_dt_match,
+	.soc		= &vexpress_soc_desc,
 	.map_io		= v2m_dt_map_io,
 	.init_early	= v2m_dt_init_early,
 	.init_irq	= v2m_dt_init_irq,
diff --git a/arch/arm/plat-versatile/include/plat/platsmp.h b/arch/arm/plat-versatile/include/plat/platsmp.h
new file mode 100644
index 0000000..50fb830
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/platsmp.h
@@ -0,0 +1,14 @@
+/*
+ *  linux/arch/arm/plat-versatile/include/plat/platsmp.h
+ *
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+extern void versatile_secondary_startup(void);
+extern void versatile_secondary_init(unsigned int cpu);
+extern int  versatile_boot_secondary(unsigned int cpu, struct task_struct *idle);
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 49c7db4..41b4706 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -40,7 +40,7 @@ static void __cpuinit write_pen_release(int val)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+void __cpuinit versatile_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -62,7 +62,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+int __cpuinit versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
-- 
1.7.10.1
