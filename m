From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  8 Sep 2011 18:00:12 +0100
Subject: [RFC PATCH 3/3] ARM: SoC: convert VExpress/RealView to SoC descriptor
In-Reply-To: <1315501212-1820-1-git-send-email-marc.zyngier@arm.com>
References: <1315501212-1820-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1315501212-1820-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert both Realview and VExpress to use the SoC descriptor to
provide their SMP and CPU hotplug operation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/core.c                  |   19 +++++++++++++++++++
 arch/arm/mach-realview/core.h                  |    9 +++++++++
 arch/arm/mach-realview/hotplug.c               |    6 +++---
 arch/arm/mach-realview/platsmp.c               |    4 ++--
 arch/arm/mach-realview/realview_eb.c           |    1 +
 arch/arm/mach-realview/realview_pb1176.c       |    1 +
 arch/arm/mach-realview/realview_pb11mp.c       |    1 +
 arch/arm/mach-realview/realview_pba8.c         |    1 +
 arch/arm/mach-realview/realview_pbx.c          |    1 +
 arch/arm/mach-vexpress/core.h                  |    6 ++++++
 arch/arm/mach-vexpress/hotplug.c               |    6 +++---
 arch/arm/mach-vexpress/platsmp.c               |    4 ++--
 arch/arm/mach-vexpress/v2m.c                   |   20 ++++++++++++++++++++
 arch/arm/plat-versatile/include/plat/platsmp.h |   13 +++++++++++++
 arch/arm/plat-versatile/platsmp.c              |    4 ++--
 15 files changed, 84 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/plat-versatile/include/plat/platsmp.h

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 5c23450..60893c6 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -33,6 +33,7 @@
 #include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
 
+#include <asm/soc.h>
 #include <asm/system.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -51,6 +52,7 @@
 #include <mach/irqs.h>
 #include <asm/hardware/timer-sp.h>
 
+#include <plat/platsmp.h>
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
 
@@ -534,3 +536,20 @@ void realview_fixup(struct machine_desc *mdesc, struct tag *tags, char **from,
 	meminfo->nr_banks = 1;
 #endif
 }
+
+struct arm_soc_desc realview_soc_desc __refdata = {
+	.name		= "ARM RealView Platform",
+#ifdef CONFIG_SMP
+	.smp_ops	= {
+		.smp_init_cpus		= realview_smp_init_cpus,
+		.smp_prepare_cpus	= realview_smp_prepare_cpus,
+		.smp_secondary_init	= versatile_secondary_init,
+		.smp_boot_secondary	= versatile_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+		.cpu_kill		= realview_cpu_kill,
+		.cpu_die		= realview_cpu_die,
+		.cpu_disable		= realview_cpu_disable,
+#endif
+	},
+#endif
+};
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 5c83d1e..93b23f1 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -45,6 +45,7 @@ static struct amba_device name##_device = {			\
 }
 
 struct machine_desc;
+struct arm_soc_desc;
 
 extern struct platform_device realview_flash_device;
 extern struct platform_device realview_cf_device;
@@ -67,4 +68,12 @@ extern void realview_fixup(struct machine_desc *mdesc, struct tag *tags,
 			   char **from, struct meminfo *meminfo);
 extern void (*realview_reset)(char);
 
+extern struct arm_soc_desc realview_soc_desc;
+
+extern void realview_smp_init_cpus(void);
+extern void realview_smp_prepare_cpus(unsigned int max_cpus);
+extern int  realview_cpu_kill(unsigned int cpu);
+extern void realview_cpu_die(unsigned int cpu);
+extern int  realview_cpu_disable(unsigned int cpu);
+
 #endif
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index a87523d..ce28104 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -87,7 +87,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int realview_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -97,7 +97,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void realview_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
@@ -117,7 +117,7 @@ void platform_cpu_die(unsigned int cpu)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int realview_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 4ae943b..da6acae 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -44,7 +44,7 @@ static void __iomem *scu_base_addr(void)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+void __init realview_smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
@@ -66,7 +66,7 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 {
 
 	scu_enable(scu_base_addr());
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 2e16bc4..bb45143 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -489,6 +489,7 @@ static void __init realview_eb_init(void)
 MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_fixup,
 	.map_io		= realview_eb_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index c47e599..539cde3 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -359,6 +359,7 @@ static void __init realview_pb1176_init(void)
 MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_pb1176_fixup,
 	.map_io		= realview_pb1176_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 5dd8f00..95bdf42 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -384,6 +384,7 @@ static void __init realview_pb11mp_init(void)
 MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pb11mp_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 6e5f2b9..0896cc4 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -311,6 +311,7 @@ static void __init realview_pba8_init(void)
 MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pba8_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index be2d7de..80ce353 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -418,6 +418,7 @@ static void __init realview_pbx_init(void)
 MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
+	.soc		= &realview_soc_desc,
 	.fixup		= realview_pbx_fixup,
 	.map_io		= realview_pbx_map_io,
 	.init_early	= realview_init_early,
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index e325f50..7f1e7d8 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -24,3 +24,9 @@ struct amba_device name##_device = {		\
 	.irq		= IRQ_##base,		\
 	/* .dma		= DMA_##base,*/		\
 }
+
+extern void v2m_smp_init_cpus(void);
+extern void v2m_smp_prepare_cpus(unsigned int max_cpus);
+extern int  v2m_cpu_kill(unsigned int cpu);
+extern void v2m_cpu_die(unsigned int cpu);
+extern int  v2m_cpu_disable(unsigned int cpu);
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index ea4cbfb..1d57864 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -88,7 +88,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int v2m_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -98,7 +98,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void v2m_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
@@ -118,7 +118,7 @@ void platform_cpu_die(unsigned int cpu)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int v2m_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index ae31cc2..5f2f5e0 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -26,13 +26,13 @@ extern void versatile_secondary_startup(void);
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+void __init v2m_smp_init_cpus(void)
 {
 	set_smp_cross_call(gic_raise_softirq);
 	ct_desc->init_cpu_map();
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+void __init v2m_smp_prepare_cpus(unsigned int max_cpus)
 {
 	/*
 	 * Initialise the present map, which describes the set of CPUs
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index ed02f27..8981d4a 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -18,6 +18,7 @@
 #include <linux/mtd/physmap.h>
 
 #include <asm/mach-types.h>
+#include <asm/soc.h>
 #include <asm/sizes.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -33,6 +34,7 @@
 #include <mach/motherboard.h>
 
 #include <plat/sched_clock.h>
+#include <plat/platsmp.h>
 #include <plat/clcd.h>
 
 #include "core.h"
@@ -563,8 +565,26 @@ static void __init v2m_init(void)
 	amba_device_register(&clcd_device, &iomem_resource);
 }
 
+static struct arm_soc_desc v2m_soc_desc __refdata = {
+	.name		= "ARM VE Platform",
+#ifdef CONFIG_SMP
+	.smp_ops	= {
+		.smp_init_cpus		= v2m_smp_init_cpus,
+		.smp_prepare_cpus	= v2m_smp_prepare_cpus,
+		.smp_secondary_init	= versatile_secondary_init,
+		.smp_boot_secondary	= versatile_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+		.cpu_kill		= v2m_cpu_kill,
+		.cpu_die		= v2m_cpu_die,
+		.cpu_disable		= v2m_cpu_disable,
+#endif
+	},
+#endif
+};
+
 MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.atag_offset	= 0x100,
+	.soc		= &v2m_soc_desc,
 	.map_io		= v2m_map_io,
 	.init_early	= v2m_init_early,
 	.init_irq	= v2m_init_irq,
diff --git a/arch/arm/plat-versatile/include/plat/platsmp.h b/arch/arm/plat-versatile/include/plat/platsmp.h
new file mode 100644
index 0000000..cb893c2
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/platsmp.h
@@ -0,0 +1,13 @@
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
+extern void versatile_secondary_init(unsigned int cpu);
+extern int  versatile_boot_secondary(unsigned int cpu, struct task_struct *idle);
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 51ecfea..ec6a80b 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -39,7 +39,7 @@ static void __cpuinit write_pen_release(int val)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+void __cpuinit versatile_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -61,7 +61,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+int __cpuinit versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
-- 
1.7.0.4
