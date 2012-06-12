From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jun 2012 13:30:50 +0100
Subject: [PATCH v8 07/13] ARM: convert ux500 to smp_ops
In-Reply-To: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
References: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339504256-11266-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert ux500 platforms to use the smp_ops to provide
their SMP and CPU hotplug operations.

Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/board-mop500.c       |    4 ++++
 arch/arm/mach-ux500/hotplug.c            |    8 +++++---
 arch/arm/mach-ux500/include/mach/setup.h |    7 +++++++
 arch/arm/mach-ux500/platsmp.c            |   14 ++++++++++----
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 9c74ac5..86258fa 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -788,6 +788,7 @@ static void __init hrefv60_init_machine(void)
 
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
+	smp_ops(ux500_smp_ops)
 	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
@@ -799,6 +800,7 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 MACHINE_END
 
 MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
+	smp_ops(ux500_smp_ops)
 	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
@@ -809,6 +811,7 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 MACHINE_END
 
 MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
+	smp_ops(ux500_smp_ops)
 	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
@@ -939,6 +942,7 @@ static const char * u8500_dt_board_compat[] = {
 
 
 DT_MACHINE_START(U8500_DT, "ST-Ericsson U8500 platform (Device Tree Support)")
+	smp_ops(ux500_smp_ops)
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
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
index 8b7ed82..3fcd58b 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -11,6 +11,7 @@
 #ifndef __ASM_ARCH_SETUP_H
 #define __ASM_ARCH_SETUP_H
 
+#include <asm/smp_ops.h>
 #include <asm/mach/time.h>
 #include <linux/init.h>
 
@@ -44,4 +45,10 @@ extern struct sys_timer ux500_timer;
 	.type		= MT_MEMORY,		\
 }
 
+extern struct smp_ops ux500_smp_ops;
+
+extern int  ux500_cpu_kill(unsigned int cpu);
+extern void ux500_cpu_die(unsigned int cpu);
+extern int  ux500_cpu_disable(unsigned int cpu);
+
 #endif /*  __ASM_ARCH_SETUP_H */
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index da1d5ad..9afd9d7 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -58,7 +58,7 @@ static void __iomem *scu_base_addr(void)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit ux500_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -80,7 +80,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit ux500_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
@@ -145,7 +145,7 @@ static void __init wakeup_secondary(void)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+static void __init ux500_smp_init_cpus(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
@@ -165,9 +165,15 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init ux500_smp_prepare_cpus(unsigned int max_cpus)
 {
 
 	scu_enable(scu_base_addr());
 	wakeup_secondary();
 }
+
+struct smp_ops ux500_smp_ops __initdata = {
+	smp_init_ops(ux500)
+	smp_secondary_ops(ux500)
+	smp_hotplug_ops(ux500)
+};
-- 
1.7.10.3
