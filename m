From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jun 2012 13:30:45 +0100
Subject: [PATCH v8 02/13] ARM: convert VExpress/RealView to smp_ops
In-Reply-To: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
References: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339504256-11266-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert both Realview and VExpress to use the smp_ops to
provide their SMP and CPU hotplug operation.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@fluxnic.net>
Acked-by: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/core.c                  |    1 +
 arch/arm/mach-realview/core.h                  |    7 +++++++
 arch/arm/mach-realview/hotplug.c               |    6 +++---
 arch/arm/mach-realview/platsmp.c               |   15 +++++++++++----
 arch/arm/mach-realview/realview_eb.c           |    1 +
 arch/arm/mach-realview/realview_pb11mp.c       |    1 +
 arch/arm/mach-realview/realview_pbx.c          |    1 +
 arch/arm/mach-vexpress/core.h                  |    8 ++++++++
 arch/arm/mach-vexpress/hotplug.c               |    6 +++---
 arch/arm/mach-vexpress/platsmp.c               |   16 ++++++++++++----
 arch/arm/mach-vexpress/v2m.c                   |    4 ++++
 arch/arm/plat-versatile/include/plat/platsmp.h |   14 ++++++++++++++
 arch/arm/plat-versatile/platsmp.c              |    4 ++--
 13 files changed, 68 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 45868bb..1fec1a0 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -37,6 +37,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
+#include <asm/smp_ops.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index f8f2c0a..b2da98f 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -27,6 +27,7 @@
 
 #include <asm/setup.h>
 #include <asm/leds.h>
+#include <asm/smp_ops.h>
 
 #define APB_DEVICE(name, busid, base, plat)			\
 static AMBA_APB_DEVICE(name, busid, 0, REALVIEW_##base##_BASE, base##_IRQ, plat)
@@ -56,4 +57,10 @@ extern void realview_init_early(void);
 extern void realview_fixup(struct tag *tags, char **from,
 			   struct meminfo *meminfo);
 
+extern struct smp_ops		realview_smp_ops;
+
+extern int  realview_cpu_kill(unsigned int cpu);
+extern void realview_cpu_die(unsigned int cpu);
+extern int  realview_cpu_disable(unsigned int cpu);
+
 #endif
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index 57d9efb..95e6723 100644
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
+void __cpuinit realview_cpu_die(unsigned int cpu)
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
index 17c878d..eb2cd2f 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -17,14 +17,15 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
+#include <asm/smp_ops.h>
 
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
@@ -77,3 +78,9 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	__raw_writel(virt_to_phys(versatile_secondary_startup),
 		     __io_address(REALVIEW_SYS_FLAGSSET));
 }
+
+struct smp_ops realview_smp_ops __initdata = {
+	smp_init_ops(realview)
+	smp_secondary_ops(versatile)
+	smp_hotplug_ops(realview)
+};
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index baf382c..31ca8dc 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -470,6 +470,7 @@ static void __init realview_eb_init(void)
 
 MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
+	smp_ops(realview_smp_ops)
 	.atag_offset	= 0x100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_eb_map_io,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index a98c536..0c3e717 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -365,6 +365,7 @@ static void __init realview_pb11mp_init(void)
 
 MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
+	smp_ops(realview_smp_ops)
 	.atag_offset	= 0x100,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pb11mp_map_io,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 3f2f605..4c0da44 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -402,6 +402,7 @@ static void __init realview_pbx_init(void)
 
 MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
+	smp_ops(realview_smp_ops)
 	.atag_offset	= 0x100,
 	.fixup		= realview_pbx_fixup,
 	.map_io		= realview_pbx_map_io,
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index a3a4980..785737e 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -5,3 +5,11 @@
 #define V2T_PERIPH 0xf8200000
 
 void vexpress_dt_smp_map_io(void);
+
+struct smp_ops;
+
+extern struct smp_ops		vexpress_smp_ops;
+
+extern int  vexpress_cpu_kill(unsigned int cpu);
+extern void vexpress_cpu_die(unsigned int cpu);
+extern int  vexpress_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index c504a72..c280125 100644
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
+void __cpuinit vexpress_cpu_die(unsigned int cpu)
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
index 14ba112..681ac7d 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -18,11 +18,13 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 
+#include <asm/smp_ops.h>
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
@@ -195,3 +197,9 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 */
 	v2m_flags_set(virt_to_phys(versatile_secondary_startup));
 }
+
+struct smp_ops vexpress_smp_ops __initdata = {
+	smp_init_ops(vexpress)
+	smp_secondary_ops(versatile)
+	smp_hotplug_ops(vexpress)
+};
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index fde26ad..4697785 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -20,6 +20,7 @@
 
 #include <asm/arch_timer.h>
 #include <asm/mach-types.h>
+#include <asm/smp_ops.h>
 #include <asm/sizes.h>
 #include <asm/smp_twd.h>
 #include <asm/mach/arch.h>
@@ -35,6 +36,7 @@
 #include <mach/motherboard.h>
 
 #include <plat/sched_clock.h>
+#include <plat/platsmp.h>
 
 #include "core.h"
 
@@ -474,6 +476,7 @@ static void __init v2m_init(void)
 }
 
 MACHINE_START(VEXPRESS, "ARM-Versatile Express")
+	smp_ops(vexpress_smp_ops)
 	.atag_offset	= 0x100,
 	.map_io		= v2m_map_io,
 	.init_early	= v2m_init_early,
@@ -678,6 +681,7 @@ const static char *v2m_dt_match[] __initconst = {
 };
 
 DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
+	smp_ops(vexpress_smp_ops)
 	.dt_compat	= v2m_dt_match,
 	.map_io		= v2m_dt_map_io,
 	.init_early	= v2m_dt_init_early,
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
1.7.10.3
