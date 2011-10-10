From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 10 Oct 2011 15:02:21 +0100
Subject: [PATCH v5 09/10] ARM: SoC: convert shmobile sh73a0 to SoC descriptor
In-Reply-To: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
References: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1318255342-17451-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert shmobile SMP platform to use the SoC descriptor to provide
its SMP and CPU hotplug operations.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Makefile              |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c        |    1 +
 arch/arm/mach-shmobile/hotplug.c             |    8 ++-
 arch/arm/mach-shmobile/include/mach/common.h |    7 +--
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    6 ++
 arch/arm/mach-shmobile/platsmp.c             |   68 --------------------------
 arch/arm/mach-shmobile/setup-sh73a0.c        |    6 ++
 arch/arm/mach-shmobile/smp-sh73a0.c          |   35 ++++++++++++--
 8 files changed, 53 insertions(+), 80 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/platsmp.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 612b270..43754f3 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
 
 # SMP objects
-smp-y				:= platsmp.o headsmp.o
+smp-y				:= headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 475342b..448f51a 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -601,6 +601,7 @@ struct sys_timer ag5evm_timer = {
 
 MACHINE_START(AG5EVM, "ag5evm")
 	.map_io		= ag5evm_map_io,
+	.soc		= &sh73a0_soc_desc,
 	.init_irq	= ag5evm_init_irq,
 	.handle_irq	= shmobile_handle_irq_gic,
 	.init_machine	= ag5evm_init,
diff --git a/arch/arm/mach-shmobile/hotplug.c b/arch/arm/mach-shmobile/hotplug.c
index 238a0d9..687c8c2 100644
--- a/arch/arm/mach-shmobile/hotplug.c
+++ b/arch/arm/mach-shmobile/hotplug.c
@@ -13,12 +13,14 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
-int platform_cpu_kill(unsigned int cpu)
+#include <mach/common.h>
+
+int shmobile_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
 
-void platform_cpu_die(unsigned int cpu)
+void shmobile_cpu_die(unsigned int cpu)
 {
 	while (1) {
 		/*
@@ -31,7 +33,7 @@ void platform_cpu_die(unsigned int cpu)
 	}
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int shmobile_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index c0cdbf9..2283521 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -48,9 +48,8 @@ extern void sh73a0_pinmux_init(void);
 extern struct clk sh73a0_extal1_clk;
 extern struct clk sh73a0_extal2_clk;
 
-extern unsigned int sh73a0_get_core_count(void);
-extern void sh73a0_secondary_init(unsigned int cpu);
-extern int sh73a0_boot_secondary(unsigned int cpu);
-extern void sh73a0_smp_prepare_cpus(void);
+extern int shmobile_cpu_kill(unsigned int cpu);
+extern void shmobile_cpu_die(unsigned int cpu);
+extern int shmobile_cpu_disable(unsigned int cpu);
 
 #endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index b385e97..d22a1a5 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -507,4 +507,10 @@ enum {
 	SHDMA_SLAVE_MMCIF_RX,
 };
 
+#include <asm/soc.h>
+
+extern struct arm_soc_smp_init_ops sh73a0_soc_smp_init_ops;
+extern struct arm_soc_smp_ops sh73a0_soc_smp_ops;
+extern struct arm_soc_desc sh73a0_soc_desc;
+
 #endif /* __ASM_SH73A0_H__ */
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
deleted file mode 100644
index 66f9806..0000000
--- a/arch/arm/mach-shmobile/platsmp.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * SMP support for R-Mobile / SH-Mobile
- *
- * Copyright (C) 2010  Magnus Damm
- * Copyright (C) 2011  Paul Mundt
- *
- * Based on vexpress, Copyright (C) 2002 ARM Ltd, All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/smp.h>
-#include <linux/io.h>
-#include <asm/hardware/gic.h>
-#include <asm/localtimer.h>
-#include <asm/mach-types.h>
-#include <mach/common.h>
-
-static unsigned int __init shmobile_smp_get_core_count(void)
-{
-	if (machine_is_ag5evm())
-		return sh73a0_get_core_count();
-
-	return 1;
-}
-
-static void __init shmobile_smp_prepare_cpus(void)
-{
-	if (machine_is_ag5evm())
-		sh73a0_smp_prepare_cpus();
-}
-
-void __cpuinit platform_secondary_init(unsigned int cpu)
-{
-	trace_hardirqs_off();
-
-	if (machine_is_ag5evm())
-		sh73a0_secondary_init(cpu);
-}
-
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
-{
-	if (machine_is_ag5evm())
-		return sh73a0_boot_secondary(cpu);
-
-	return -ENOSYS;
-}
-
-void __init smp_init_cpus(void)
-{
-	unsigned int ncores = shmobile_smp_get_core_count();
-	unsigned int i;
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
-}
-
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
-{
-	shmobile_smp_prepare_cpus();
-}
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index e46821c..85ab3e1 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -672,3 +672,9 @@ void __init sh73a0_add_early_devices(void)
 	early_platform_add_devices(sh73a0_early_devices,
 				   ARRAY_SIZE(sh73a0_early_devices));
 }
+
+struct arm_soc_desc sh73a0_soc_desc __initdata = {
+	.name		= "Renesas sh73a0",
+	soc_smp_init_ops(sh73a0_soc_smp_init_ops)
+	soc_smp_ops(sh73a0_soc_smp_ops)
+};
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index be1ade7..274b9c5 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <mach/common.h>
+#include <mach/sh73a0.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/gic.h>
@@ -55,7 +56,7 @@ static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 	__raw_writel(tmp, scu_base + 8);
 }
 
-unsigned int __init sh73a0_get_core_count(void)
+static unsigned int __init sh73a0_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
@@ -67,12 +68,12 @@ unsigned int __init sh73a0_get_core_count(void)
 	return scu_get_core_count(scu_base);
 }
 
-void __cpuinit sh73a0_secondary_init(unsigned int cpu)
+static void __cpuinit sh73a0_secondary_init(unsigned int cpu)
 {
 	gic_secondary_init(0);
 }
 
-int __cpuinit sh73a0_boot_secondary(unsigned int cpu)
+static int __cpuinit sh73a0_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	cpu = cpu_logical_map(cpu);
 
@@ -87,7 +88,7 @@ int __cpuinit sh73a0_boot_secondary(unsigned int cpu)
 	return 0;
 }
 
-void __init sh73a0_smp_prepare_cpus(void)
+static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpu = cpu_logical_map(0);
 
@@ -100,3 +101,29 @@ void __init sh73a0_smp_prepare_cpus(void)
 	/* enable cache coherency on CPU0 */
 	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 }
+
+static void __init sh73a0_smp_init_cpus(void)
+{
+	unsigned int ncores = sh73a0_get_core_count();
+	unsigned int i;
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+struct arm_soc_smp_init_ops sh73a0_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= sh73a0_smp_init_cpus,
+	.smp_prepare_cpus	= sh73a0_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops sh73a0_soc_smp_ops __initdata = {
+	.smp_secondary_init	= sh73a0_secondary_init,
+	.smp_boot_secondary	= sh73a0_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= shmobile_cpu_kill,
+	.cpu_die		= shmobile_cpu_die,
+	.cpu_disable		= shmobile_cpu_disable,
+#endif
+};
-- 
1.7.0.4
