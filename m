From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Feb 2012 00:30:52 +0000
Subject: [PATCH v6 08/15] ARM: SoC: convert ux500 to SoC descriptor
In-Reply-To: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328661059-24584-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert ux500 platforms to use the SoC descriptor to provide
their SMP and CPU hotplug operations.

Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/board-mop500.c       |    3 +++
 arch/arm/mach-ux500/board-u5500.c        |    1 +
 arch/arm/mach-ux500/cpu.c                |    7 ++++++-
 arch/arm/mach-ux500/hotplug.c            |    8 +++++---
 arch/arm/mach-ux500/include/mach/setup.h |    9 +++++++++
 arch/arm/mach-ux500/platsmp.c            |   23 +++++++++++++++++++----
 6 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 5c00712..8780c79 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -692,6 +692,7 @@ static void __init hrefv60_init_machine(void)
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
 	.atag_offset	= 0x100,
+	.soc		= &ux500_soc_desc,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
@@ -702,6 +703,7 @@ MACHINE_END
 
 MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.atag_offset	= 0x100,
+	.soc		= &ux500_soc_desc,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
@@ -711,6 +713,7 @@ MACHINE_END
 
 MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 	.atag_offset	= 0x100,
+	.soc		= &ux500_soc_desc,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index 9de9e9c..47e0c6b 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -147,6 +147,7 @@ static void __init u5500_init_machine(void)
 
 MACHINE_START(U5500, "ST-Ericsson U5500 Platform")
 	.atag_offset	= 0x100,
+	.soc		= &ux500_soc_desc,
 	.map_io		= u5500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index f418574..4fb3cea 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -14,7 +14,6 @@
 
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
-#include <asm/localtimer.h>
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
@@ -50,3 +49,9 @@ void __init ux500_init_irq(void)
 		db8500_prcmu_early_init();
 	clk_init();
 }
+
+struct arm_soc_desc ux500_soc_desc __initdata = {
+	.name		= "STE Ux500",
+	soc_smp_init_ops(ux500_soc_smp_init_ops)
+	soc_smp_ops(ux500_soc_smp_ops)
+};
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index c76f0f4..ae1a8eb 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -15,6 +15,8 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
+#include <mach/setup.h>
+
 extern volatile int pen_release;
 
 static inline void platform_do_lowpower(unsigned int cpu)
@@ -34,7 +36,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int ux500_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -44,13 +46,13 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void ux500_cpu_die(unsigned int cpu)
 {
 	/* directly enter low power state, skipping secure registers */
 	platform_do_lowpower(cpu);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int ux500_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index a7d363f..e764530 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -11,6 +11,7 @@
 #ifndef __ASM_ARCH_SETUP_H
 #define __ASM_ARCH_SETUP_H
 
+#include <asm/soc.h>
 #include <asm/mach/time.h>
 #include <linux/init.h>
 
@@ -50,4 +51,12 @@ extern struct sys_timer ux500_timer;
 	.type		= MT_MEMORY,		\
 }
 
+extern struct arm_soc_smp_init_ops ux500_soc_smp_init_ops;
+extern struct arm_soc_smp_ops ux500_soc_smp_ops;
+extern struct arm_soc_desc ux500_soc_desc;
+
+extern int  ux500_cpu_kill(unsigned int cpu);
+extern void ux500_cpu_die(unsigned int cpu);
+extern int  ux500_cpu_disable(unsigned int cpu);
+
 #endif /*  __ASM_ARCH_SETUP_H */
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index d2058ef..fc72ce1 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -60,7 +60,7 @@ static void __iomem *scu_base_addr(void)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit ux500_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -82,7 +82,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit ux500_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
@@ -149,7 +149,7 @@ static void __init wakeup_secondary(void)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+static void __init ux500_smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
@@ -169,9 +169,24 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init ux500_smp_prepare_cpus(unsigned int max_cpus)
 {
 
 	scu_enable(scu_base_addr());
 	wakeup_secondary();
 }
+
+struct arm_soc_smp_init_ops ux500_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= ux500_smp_init_cpus,
+	.smp_prepare_cpus	= ux500_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops ux500_soc_smp_ops __initdata = {
+	.smp_secondary_init	= ux500_secondary_init,
+	.smp_boot_secondary	= ux500_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= ux500_cpu_kill,
+	.cpu_die		= ux500_cpu_die,
+	.cpu_disable		= ux500_cpu_disable,
+#endif
+};
-- 
1.7.3.4
