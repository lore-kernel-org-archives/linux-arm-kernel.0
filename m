From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Feb 2012 00:30:53 +0000
Subject: [PATCH v6 09/15] ARM: SoC: convert shmobile SMP to SoC descriptor
In-Reply-To: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328661059-24584-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert shmobile SMP platforms to use the SoC descriptor to provide
their SMP and CPU hotplug operations.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Makefile               |    2 +-
 arch/arm/mach-shmobile/board-ag5evm.c         |    1 +
 arch/arm/mach-shmobile/board-kota2.c          |    1 +
 arch/arm/mach-shmobile/board-marzen.c         |    1 +
 arch/arm/mach-shmobile/hotplug.c              |   13 +++-
 arch/arm/mach-shmobile/include/mach/common.h  |   14 +---
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    6 ++
 arch/arm/mach-shmobile/include/mach/sh73a0.h  |    6 ++
 arch/arm/mach-shmobile/platsmp.c              |   97 -------------------------
 arch/arm/mach-shmobile/setup-r8a7779.c        |    6 ++
 arch/arm/mach-shmobile/setup-sh73a0.c         |    6 ++
 arch/arm/mach-shmobile/smp-r8a7779.c          |   40 +++++++++-
 arch/arm/mach-shmobile/smp-sh73a0.c           |   41 ++++++++++-
 13 files changed, 114 insertions(+), 120 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/platsmp.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 7ad6954..b6dbffa 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o clock-r8a7740.o intc-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o clock-r8a7779.o intc-r8a7779.o
 
 # SMP objects
-smp-y				:= platsmp.o headsmp.o
+smp-y				:= headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index eff8a96..55c8e03 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -633,6 +633,7 @@ struct sys_timer ag5evm_timer = {
 };
 
 MACHINE_START(AG5EVM, "ag5evm")
+	.soc		= &sh73a0_soc_desc,
 	.map_io		= ag5evm_map_io,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 857ceee..200aaef 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -548,6 +548,7 @@ struct sys_timer kota2_timer = {
 };
 
 MACHINE_START(KOTA2, "kota2")
+	.soc		= &sh73a0_soc_desc,
 	.map_io		= kota2_map_io,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq,
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index f0e02c0..a244d32 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -147,6 +147,7 @@ struct sys_timer marzen_timer = {
 };
 
 MACHINE_START(MARZEN, "marzen")
+	.soc		= &r8a7779_soc_desc,
 	.map_io		= marzen_map_io,
 	.init_early	= marzen_init_early,
 	.nr_irqs	= NR_IRQS_LEGACY,
diff --git a/arch/arm/mach-shmobile/hotplug.c b/arch/arm/mach-shmobile/hotplug.c
index 828d22f..d191582 100644
--- a/arch/arm/mach-shmobile/hotplug.c
+++ b/arch/arm/mach-shmobile/hotplug.c
@@ -16,10 +16,15 @@
 #include <linux/delay.h>
 #include <mach/common.h>
 #include <asm/cacheflush.h>
+#include <asm/mach-types.h>
 
 static cpumask_t dead_cpus;
 
-int platform_cpu_kill(unsigned int cpu)
+#include <mach/common.h>
+
+#define is_r8a7779() machine_is_marzen()
+
+int shmobile_cpu_kill(unsigned int cpu)
 {
 	int k;
 
@@ -29,7 +34,7 @@ int platform_cpu_kill(unsigned int cpu)
 	 */
 	for (k = 0; k < 1000; k++) {
 		if (cpumask_test_cpu(cpu, &dead_cpus))
-			return shmobile_platform_cpu_kill(cpu);
+			return is_r8a7779() ? r8a7779_platform_cpu_kill(cpu) : 1;
 
 		mdelay(1);
 	}
@@ -37,7 +42,7 @@ int platform_cpu_kill(unsigned int cpu)
 	return 0;
 }
 
-void platform_cpu_die(unsigned int cpu)
+void shmobile_cpu_die(unsigned int cpu)
 {
 	/* hardware shutdown code running on the CPU that is being offlined */
 	flush_cache_all();
@@ -60,7 +65,7 @@ void platform_cpu_die(unsigned int cpu)
 	}
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int shmobile_cpu_disable(unsigned int cpu)
 {
 	cpumask_clear_cpu(cpu, &dead_cpus);
 	/*
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index e4b945e..a152503 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -4,7 +4,6 @@
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
-extern int shmobile_platform_cpu_kill(unsigned int cpu);
 struct clk;
 extern int clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
@@ -50,11 +49,6 @@ extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
 extern struct clk sh73a0_extalr_clk;
 
-extern unsigned int sh73a0_get_core_count(void);
-extern void sh73a0_secondary_init(unsigned int cpu);
-extern int sh73a0_boot_secondary(unsigned int cpu);
-extern void sh73a0_smp_prepare_cpus(void);
-
 extern void r8a7740_init_irq(void);
 extern void r8a7740_add_early_devices(void);
 extern void r8a7740_add_standard_devices(void);
@@ -68,10 +62,10 @@ extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
 
-extern unsigned int r8a7779_get_core_count(void);
 extern int r8a7779_platform_cpu_kill(unsigned int cpu);
-extern void r8a7779_secondary_init(unsigned int cpu);
-extern int r8a7779_boot_secondary(unsigned int cpu);
-extern void r8a7779_smp_prepare_cpus(void);
+
+extern int shmobile_cpu_kill(unsigned int cpu);
+extern void shmobile_cpu_die(unsigned int cpu);
+extern int shmobile_cpu_disable(unsigned int cpu);
 
 #endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index b07ad31..0f67b4f 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -360,4 +360,10 @@ extern void r8a7779_add_device_to_domain(struct r8a7779_pm_domain *r8a7779_pd,
 #define r8a7779_add_device_to_domain(pd, pdev) do { } while (0)
 #endif /* CONFIG_PM */
 
+#include <asm/soc.h>
+
+extern struct arm_soc_smp_init_ops r8a7779_soc_smp_init_ops;
+extern struct arm_soc_smp_ops r8a7779_soc_smp_ops;
+extern struct arm_soc_desc r8a7779_soc_desc;
+
 #endif /* __ASM_R8A7779_H__ */
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 881d515..4aeb692 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -519,4 +519,10 @@ enum {
 #define SH73A0_PINT0_IRQ(irq) ((irq) + 768)
 #define SH73A0_PINT1_IRQ(irq) ((irq) + 800)
 
+#include <asm/soc.h>
+
+extern struct arm_soc_smp_init_ops sh73a0_soc_smp_init_ops;
+extern struct arm_soc_smp_ops sh73a0_soc_smp_ops;
+extern struct arm_soc_desc sh73a0_soc_desc;
+
 #endif /* __ASM_SH73A0_H__ */
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
deleted file mode 100644
index 9933812..0000000
--- a/arch/arm/mach-shmobile/platsmp.c
+++ /dev/null
@@ -1,97 +0,0 @@
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
-#define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2())
-#define is_r8a7779() machine_is_marzen()
-
-static unsigned int __init shmobile_smp_get_core_count(void)
-{
-	if (is_sh73a0())
-		return sh73a0_get_core_count();
-
-	if (is_r8a7779())
-		return r8a7779_get_core_count();
-
-	return 1;
-}
-
-static void __init shmobile_smp_prepare_cpus(void)
-{
-	if (is_sh73a0())
-		sh73a0_smp_prepare_cpus();
-
-	if (is_r8a7779())
-		r8a7779_smp_prepare_cpus();
-}
-
-int shmobile_platform_cpu_kill(unsigned int cpu)
-{
-	if (is_r8a7779())
-		return r8a7779_platform_cpu_kill(cpu);
-
-	return 1;
-}
-
-void __cpuinit platform_secondary_init(unsigned int cpu)
-{
-	trace_hardirqs_off();
-
-	if (is_sh73a0())
-		sh73a0_secondary_init(cpu);
-
-	if (is_r8a7779())
-		r8a7779_secondary_init(cpu);
-}
-
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
-{
-	if (is_sh73a0())
-		return sh73a0_boot_secondary(cpu);
-
-	if (is_r8a7779())
-		return r8a7779_boot_secondary(cpu);
-
-	return -ENOSYS;
-}
-
-void __init smp_init_cpus(void)
-{
-	unsigned int ncores = shmobile_smp_get_core_count();
-	unsigned int i;
-
-	if (ncores > nr_cpu_ids) {
-		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
-			ncores, nr_cpu_ids);
-		ncores = nr_cpu_ids;
-	}
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
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 4725663..7f8b9e3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -237,3 +237,9 @@ void __init r8a7779_add_early_devices(void)
 	early_platform_add_devices(r8a7779_early_devices,
 				   ARRAY_SIZE(r8a7779_early_devices));
 }
+
+struct arm_soc_desc r8a7779_soc_desc __initdata = {
+	.name		= "Renesas r8a7779",
+	soc_smp_init_ops(r8a7779_soc_smp_init_ops)
+	soc_smp_ops(r8a7779_soc_smp_ops)
+};
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 20e71e5..3bb9bdd 100644
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
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 4fe2e9e..49610ba 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -78,7 +78,7 @@ static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 	__raw_writel(tmp, scu_base + 8);
 }
 
-unsigned int __init r8a7779_get_core_count(void)
+static unsigned int __init r8a7779_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
@@ -109,12 +109,12 @@ int r8a7779_platform_cpu_kill(unsigned int cpu)
 	return ret ? ret : 1;
 }
 
-void __cpuinit r8a7779_secondary_init(unsigned int cpu)
+static void __cpuinit r8a7779_secondary_init(unsigned int cpu)
 {
 	gic_secondary_init(0);
 }
 
-int __cpuinit r8a7779_boot_secondary(unsigned int cpu)
+static int __cpuinit r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	struct r8a7779_pm_ch *ch = NULL;
 	int ret = -EIO;
@@ -133,7 +133,7 @@ int __cpuinit r8a7779_boot_secondary(unsigned int cpu)
 	return ret;
 }
 
-void __init r8a7779_smp_prepare_cpus(void)
+static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpu = cpu_logical_map(0);
 
@@ -152,3 +152,35 @@ void __init r8a7779_smp_prepare_cpus(void)
 	r8a7779_platform_cpu_kill(2);
 	r8a7779_platform_cpu_kill(3);
 }
+
+static void __init r8a7779_smp_init_cpus(void)
+{
+	unsigned int ncores = r8a7779_get_core_count();
+	unsigned int i;
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+struct arm_soc_smp_init_ops r8a7779_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= r8a7779_smp_init_cpus,
+	.smp_prepare_cpus	= r8a7779_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops r8a7779_soc_smp_ops __initdata = {
+	.smp_secondary_init	= r8a7779_secondary_init,
+	.smp_boot_secondary	= r8a7779_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= shmobile_cpu_kill,
+	.cpu_die		= shmobile_cpu_die,
+	.cpu_disable		= shmobile_cpu_disable,
+#endif
+};
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 0d159d6..8b16e25 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <mach/common.h>
+#include <mach/sh73a0.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
@@ -56,7 +57,7 @@ static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 	__raw_writel(tmp, scu_base + 8);
 }
 
-unsigned int __init sh73a0_get_core_count(void)
+static unsigned int __init sh73a0_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
@@ -68,12 +69,12 @@ unsigned int __init sh73a0_get_core_count(void)
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
 
@@ -88,7 +89,7 @@ int __cpuinit sh73a0_boot_secondary(unsigned int cpu)
 	return 0;
 }
 
-void __init sh73a0_smp_prepare_cpus(void)
+static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpu = cpu_logical_map(0);
 
@@ -101,3 +102,35 @@ void __init sh73a0_smp_prepare_cpus(void)
 	/* enable cache coherency on CPU0 */
 	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 }
+
+static void __init sh73a0_smp_init_cpus(void)
+{
+	unsigned int ncores = sh73a0_get_core_count();
+	unsigned int i;
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
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
1.7.3.4
