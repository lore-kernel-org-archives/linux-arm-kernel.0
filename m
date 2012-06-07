From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  7 Jun 2012 17:09:26 +0100
Subject: [PATCH v7 09/12] ARM: SoC: convert shmobile SMP to SoC descriptor
In-Reply-To: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339085369-26073-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert shmobile SMP platforms to use the SoC descriptor to provide
their SMP and CPU hotplug operations.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c         |    1 +
 arch/arm/mach-shmobile/board-kota2.c          |    1 +
 arch/arm/mach-shmobile/board-kzm9d.c          |    1 +
 arch/arm/mach-shmobile/board-kzm9g.c          |    1 +
 arch/arm/mach-shmobile/board-marzen.c         |    1 +
 arch/arm/mach-shmobile/hotplug.c              |   26 ++++++--
 arch/arm/mach-shmobile/include/mach/common.h  |   19 ++----
 arch/arm/mach-shmobile/include/mach/emev2.h   |   10 +--
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    8 +++
 arch/arm/mach-shmobile/include/mach/sh73a0.h  |    6 ++
 arch/arm/mach-shmobile/platsmp.c              |   86 +------------------------
 arch/arm/mach-shmobile/setup-emev2.c          |    7 ++
 arch/arm/mach-shmobile/setup-r8a7779.c        |    6 ++
 arch/arm/mach-shmobile/setup-sh73a0.c         |    6 ++
 arch/arm/mach-shmobile/smp-emev2.c            |   26 ++++++--
 arch/arm/mach-shmobile/smp-r8a7779.c          |   26 ++++++--
 arch/arm/mach-shmobile/smp-sh73a0.c           |   27 ++++++--
 17 files changed, 140 insertions(+), 118 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 5a6f22f..55dab6d 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -574,6 +574,7 @@ static void __init ag5evm_init(void)
 }
 
 MACHINE_START(AG5EVM, "ag5evm")
+	.soc		= &sh73a0_soc_desc,
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index f60f1b2..dc76bf5 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -515,6 +515,7 @@ static void __init kota2_init(void)
 }
 
 MACHINE_START(KOTA2, "kota2")
+	.soc		= &sh73a0_soc_desc,
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
diff --git a/arch/arm/mach-shmobile/board-kzm9d.c b/arch/arm/mach-shmobile/board-kzm9d.c
index 7bc5e7d..bef8c75 100644
--- a/arch/arm/mach-shmobile/board-kzm9d.c
+++ b/arch/arm/mach-shmobile/board-kzm9d.c
@@ -74,6 +74,7 @@ static const char *kzm9d_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(KZM9D_DT, "kzm9d")
+	.soc		= &emev2_soc_desc,
 	.map_io		= emev2_map_io,
 	.init_early	= emev2_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index d8e33b6..19a0c11 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -449,6 +449,7 @@ static const char *kzm9g_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(KZM9G_DT, "kzm9g")
+	.soc		= &sh73a0_soc_desc,
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 14de378..25c2ae2 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -92,6 +92,7 @@ static void __init marzen_init(void)
 }
 
 MACHINE_START(MARZEN, "marzen")
+	.soc		= &r8a7779_soc_desc,
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
diff --git a/arch/arm/mach-shmobile/hotplug.c b/arch/arm/mach-shmobile/hotplug.c
index 828d22f..dd854fb 100644
--- a/arch/arm/mach-shmobile/hotplug.c
+++ b/arch/arm/mach-shmobile/hotplug.c
@@ -14,12 +14,21 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 #include <mach/common.h>
+#include <mach/r8a7779.h>
+#include <mach/emev2.h>
 #include <asm/cacheflush.h>
+#include <asm/mach-types.h>
 
 static cpumask_t dead_cpus;
 
-int platform_cpu_kill(unsigned int cpu)
+#include <mach/common.h>
+
+#define is_r8a7779() machine_is_marzen()
+#define is_emev2() of_machine_is_compatible("renesas,emev2")
+
+int shmobile_cpu_kill(unsigned int cpu)
 {
 	int k;
 
@@ -28,8 +37,15 @@ int platform_cpu_kill(unsigned int cpu)
 	 * finish before asking SoC-specific code to power off the CPU core.
 	 */
 	for (k = 0; k < 1000; k++) {
-		if (cpumask_test_cpu(cpu, &dead_cpus))
-			return shmobile_platform_cpu_kill(cpu);
+		if (cpumask_test_cpu(cpu, &dead_cpus)) {
+			if (is_r8a7779())
+				return r8a7779_platform_cpu_kill(cpu);
+
+			if (is_emev2())
+				return emev2_platform_cpu_kill(cpu);
+
+			return 1;
+		}
 
 		mdelay(1);
 	}
@@ -37,7 +53,7 @@ int platform_cpu_kill(unsigned int cpu)
 	return 0;
 }
 
-void platform_cpu_die(unsigned int cpu)
+void shmobile_cpu_die(unsigned int cpu)
 {
 	/* hardware shutdown code running on the CPU that is being offlined */
 	flush_cache_all();
@@ -60,7 +76,7 @@ void platform_cpu_die(unsigned int cpu)
 	}
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int shmobile_cpu_disable(unsigned int cpu)
 {
 	cpumask_clear_cpu(cpu, &dead_cpus);
 	/*
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 01e2bc0..cdc4b86 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -4,11 +4,10 @@
 extern void shmobile_earlytimer_init(void);
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
-				 unsigned int mult, unsigned int div);
+			 unsigned int mult, unsigned int div);
 struct twd_local_timer;
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
-extern int shmobile_platform_cpu_kill(unsigned int cpu);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
@@ -58,11 +57,6 @@ extern struct clk sh73a0_extal2_clk;
 extern struct clk sh73a0_extcki_clk;
 extern struct clk sh73a0_extalr_clk;
 
-extern unsigned int sh73a0_get_core_count(void);
-extern void sh73a0_secondary_init(unsigned int cpu);
-extern int sh73a0_boot_secondary(unsigned int cpu);
-extern void sh73a0_smp_prepare_cpus(void);
-
 extern void r8a7740_init_irq(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
@@ -78,11 +72,6 @@ extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
 
-extern unsigned int r8a7779_get_core_count(void);
-extern int r8a7779_platform_cpu_kill(unsigned int cpu);
-extern void r8a7779_secondary_init(unsigned int cpu);
-extern int r8a7779_boot_secondary(unsigned int cpu);
-extern void r8a7779_smp_prepare_cpus(void);
 extern void r8a7779_register_twd(void);
 
 extern void shmobile_init_late(void);
@@ -99,4 +88,10 @@ int shmobile_cpuidle_init(void);
 static inline int shmobile_cpuidle_init(void) { return 0; }
 #endif
 
+extern int shmobile_cpu_kill(unsigned int cpu);
+extern void shmobile_cpu_die(unsigned int cpu);
+extern int shmobile_cpu_disable(unsigned int cpu);
+
+extern void shmobile_smp_init_cpus(unsigned int ncores);
+
 #endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/include/mach/emev2.h b/arch/arm/mach-shmobile/include/mach/emev2.h
index e6b0c1b..1bd0f68 100644
--- a/arch/arm/mach-shmobile/include/mach/emev2.h
+++ b/arch/arm/mach-shmobile/include/mach/emev2.h
@@ -7,13 +7,15 @@ extern void emev2_add_early_devices(void);
 extern void emev2_add_standard_devices(void);
 extern void emev2_clock_init(void);
 extern void emev2_set_boot_vector(unsigned long value);
-extern unsigned int emev2_get_core_count(void);
 extern int emev2_platform_cpu_kill(unsigned int cpu);
-extern void emev2_secondary_init(unsigned int cpu);
-extern int emev2_boot_secondary(unsigned int cpu);
-extern void emev2_smp_prepare_cpus(void);
 
 #define EMEV2_GPIO_BASE 200
 #define EMEV2_GPIO_IRQ(n) (EMEV2_GPIO_BASE + (n))
 
+#include <asm/soc.h>
+
+extern struct arm_soc_smp_init_ops emev2_soc_smp_init_ops;
+extern struct arm_soc_smp_ops emev2_soc_smp_ops;
+extern struct arm_soc_desc emev2_soc_desc;
+
 #endif /* __ASM_EMEV2_H__ */
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index b07ad31..3ab5155 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -360,4 +360,12 @@ extern void r8a7779_add_device_to_domain(struct r8a7779_pm_domain *r8a7779_pd,
 #define r8a7779_add_device_to_domain(pd, pdev) do { } while (0)
 #endif /* CONFIG_PM */
 
+extern int r8a7779_platform_cpu_kill(unsigned int cpu);
+
+#include <asm/soc.h>
+
+extern struct arm_soc_smp_init_ops r8a7779_soc_smp_init_ops;
+extern struct arm_soc_smp_ops r8a7779_soc_smp_ops;
+extern struct arm_soc_desc r8a7779_soc_desc;
+
 #endif /* __ASM_R8A7779_H__ */
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 398e2c1..c6e5e3b 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -550,4 +550,10 @@ enum {
 #define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
 #define SH73A0_PINT1_IRQ(irq) ((irq) + 732)
 
+#include <asm/soc.h>
+
+extern struct arm_soc_smp_init_ops sh73a0_soc_smp_init_ops;
+extern struct arm_soc_smp_ops sh73a0_soc_smp_ops;
+extern struct arm_soc_desc sh73a0_soc_desc;
+
 #endif /* __ASM_SH73A0_H__ */
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index bacdd66..ed8d235 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -11,90 +11,11 @@
  * published by the Free Software Foundation.
  */
 #include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/smp.h>
-#include <linux/io.h>
-#include <linux/of.h>
 #include <asm/hardware/gic.h>
-#include <asm/mach-types.h>
-#include <mach/common.h>
-#include <mach/emev2.h>
 
-#define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2() || \
-			of_machine_is_compatible("renesas,sh73a0"))
-#define is_r8a7779() machine_is_marzen()
-#define is_emev2() of_machine_is_compatible("renesas,emev2")
-
-static unsigned int __init shmobile_smp_get_core_count(void)
-{
-	if (is_sh73a0())
-		return sh73a0_get_core_count();
-
-	if (is_r8a7779())
-		return r8a7779_get_core_count();
-
-	if (is_emev2())
-		return emev2_get_core_count();
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
-
-	if (is_emev2())
-		emev2_smp_prepare_cpus();
-}
-
-int shmobile_platform_cpu_kill(unsigned int cpu)
-{
-	if (is_r8a7779())
-		return r8a7779_platform_cpu_kill(cpu);
-
-	if (is_emev2())
-		return emev2_platform_cpu_kill(cpu);
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
-
-	if (is_emev2())
-		emev2_secondary_init(cpu);
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
-	if (is_emev2())
-		return emev2_boot_secondary(cpu);
-
-	return -ENOSYS;
-}
-
-void __init smp_init_cpus(void)
+void __init shmobile_smp_init_cpus(unsigned int ncores)
 {
-	unsigned int ncores = shmobile_smp_get_core_count();
 	unsigned int i;
 
 	if (ncores > nr_cpu_ids) {
@@ -108,8 +29,3 @@ void __init smp_init_cpus(void)
 
 	set_smp_cross_call(gic_raise_softirq);
 }
-
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
-{
-	shmobile_smp_prepare_cpus();
-}
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index dae9aa6..ec77d75 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -439,7 +439,14 @@ void __init emev2_init_irq_dt(void)
 	of_irq_init(emev2_dt_irq_match);
 }
 
+struct arm_soc_desc emev2_soc_desc __initdata = {
+	.name		= "Renesas Emma EV2",
+	soc_smp_init_ops(emev2_soc_smp_init_ops)
+	soc_smp_ops(emev2_soc_smp_ops)
+};
+
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
+	.soc		= &emev2_soc_desc,
 	.init_early	= emev2_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= emev2_init_irq_dt,
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index e98e46f..5d430c8 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -296,3 +296,9 @@ void __init r8a7779_add_early_devices(void)
 	/* override timer setup with soc-specific code */
 	shmobile_timer.init = r8a7779_earlytimer_init;
 }
+
+struct arm_soc_desc r8a7779_soc_desc __initdata = {
+	.name		= "Renesas r8a7779",
+	soc_smp_init_ops(r8a7779_soc_smp_init_ops)
+	soc_smp_ops(r8a7779_soc_smp_ops)
+};
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 04a0dfe..88f5634 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -709,3 +709,9 @@ void __init sh73a0_add_early_devices(void)
 	/* override timer setup with soc-specific code */
 	shmobile_timer.init = sh73a0_earlytimer_init;
 }
+
+struct arm_soc_desc sh73a0_soc_desc __initdata = {
+	.name		= "Renesas sh73a0",
+	soc_smp_init_ops(sh73a0_soc_smp_init_ops)
+	soc_smp_ops(sh73a0_soc_smp_ops)
+};
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 6a35c4a..cdce4ec 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -50,7 +50,7 @@ static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 
 }
 
-unsigned int __init emev2_get_core_count(void)
+static unsigned int __init emev2_get_core_count(void)
 {
 	if (!scu_base) {
 		scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
@@ -67,12 +67,12 @@ int emev2_platform_cpu_kill(unsigned int cpu)
 	return 0; /* not supported yet */
 }
 
-void __cpuinit emev2_secondary_init(unsigned int cpu)
+static void __cpuinit emev2_secondary_init(unsigned int cpu)
 {
 	gic_secondary_init(0);
 }
 
-int __cpuinit emev2_boot_secondary(unsigned int cpu)
+static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	cpu = cpu_logical_map(cpu);
 
@@ -86,7 +86,7 @@ int __cpuinit emev2_boot_secondary(unsigned int cpu)
 	return 0;
 }
 
-void __init emev2_smp_prepare_cpus(void)
+static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpu = cpu_logical_map(0);
 
@@ -95,3 +95,21 @@ void __init emev2_smp_prepare_cpus(void)
 	/* enable cache coherency on CPU0 */
 	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 }
+
+static void __init emev2_smp_init_cpus(void)
+{
+	unsigned int ncores = emev2_get_core_count();
+
+	shmobile_smp_init_cpus(ncores);
+}
+
+struct arm_soc_smp_init_ops emev2_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= emev2_smp_init_cpus,
+	.smp_prepare_cpus	= emev2_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops emev2_soc_smp_ops __initdata = {
+	.smp_secondary_init	= emev2_secondary_init,
+	.smp_boot_secondary	= emev2_boot_secondary,
+	soc_hotplug_ops(shmobile)
+};
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 6d1d023..ea61000 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -87,7 +87,7 @@ static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 	__raw_writel(tmp, scu_base + 8);
 }
 
-unsigned int __init r8a7779_get_core_count(void)
+static unsigned int __init r8a7779_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
@@ -113,12 +113,12 @@ int r8a7779_platform_cpu_kill(unsigned int cpu)
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
@@ -137,7 +137,7 @@ int __cpuinit r8a7779_boot_secondary(unsigned int cpu)
 	return ret;
 }
 
-void __init r8a7779_smp_prepare_cpus(void)
+static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpu = cpu_logical_map(0);
 
@@ -156,3 +156,21 @@ void __init r8a7779_smp_prepare_cpus(void)
 	r8a7779_platform_cpu_kill(2);
 	r8a7779_platform_cpu_kill(3);
 }
+
+static void __init r8a7779_smp_init_cpus(void)
+{
+	unsigned int ncores = r8a7779_get_core_count();
+
+	shmobile_smp_init_cpus(ncores);
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
+	soc_hotplug_ops(shmobile)
+};
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index e36c41c..58df479 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <mach/common.h>
 #include <asm/smp_plat.h>
+#include <mach/sh73a0.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/gic.h>
@@ -64,19 +65,19 @@ static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 	__raw_writel(tmp, scu_base + 8);
 }
 
-unsigned int __init sh73a0_get_core_count(void)
+static unsigned int __init sh73a0_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
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
 
@@ -91,7 +92,7 @@ int __cpuinit sh73a0_boot_secondary(unsigned int cpu)
 	return 0;
 }
 
-void __init sh73a0_smp_prepare_cpus(void)
+static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpu = cpu_logical_map(0);
 
@@ -104,3 +105,21 @@ void __init sh73a0_smp_prepare_cpus(void)
 	/* enable cache coherency on CPU0 */
 	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 }
+
+static void __init sh73a0_smp_init_cpus(void)
+{
+	unsigned int ncores = sh73a0_get_core_count();
+
+	shmobile_smp_init_cpus(ncores);
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
+	soc_hotplug_ops(shmobile)
+};
-- 
1.7.10.1
