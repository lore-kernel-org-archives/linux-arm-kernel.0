From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  7 Jun 2012 17:09:28 +0100
Subject: [PATCH v7 11/12] ARM: SoC: convert imx6q to SoC descriptor
In-Reply-To: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339085369-26073-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the imx6q platform to use the SoC descriptor to provide
its SMP and CPU hotplug operations.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-imx/hotplug.c             |    6 +++---
 arch/arm/mach-imx/mach-imx6q.c          |    8 ++++++++
 arch/arm/mach-imx/platsmp.c             |   20 ++++++++++++++++----
 arch/arm/plat-mxc/include/mach/common.h |   10 ++++++++++
 4 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index 89493ab..474b11d 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -14,7 +14,7 @@
 #include <asm/cacheflush.h>
 #include <mach/common.h>
 
-int platform_cpu_kill(unsigned int cpu)
+int imx_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -24,7 +24,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void imx_cpu_die(unsigned int cpu)
 {
 	flush_cache_all();
 	imx_enable_cpu(cpu, false);
@@ -34,7 +34,7 @@ void platform_cpu_die(unsigned int cpu)
 	panic("cpu %d unexpectedly exit from shutdown\n", cpu);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int imx_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index b47e98b..bb2a11b 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -25,6 +25,7 @@
 #include <linux/phy.h>
 #include <linux/micrel_phy.h>
 #include <asm/smp_twd.h>
+#include <asm/soc.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
@@ -180,7 +181,14 @@ static const char *imx6q_dt_compat[] __initdata = {
 	NULL,
 };
 
+static struct arm_soc_desc imx6q_soc_desc __initdata = {
+	.name	= "Freescale i.MX6 Quad",
+	soc_smp_init_ops(imx_soc_smp_init_ops)
+	soc_smp_ops(imx_soc_smp_ops)
+};
+
 DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad (Device Tree)")
+	.soc		= &imx6q_soc_desc,
 	.map_io		= imx6q_map_io,
 	.init_irq	= imx6q_init_irq,
 	.handle_irq	= imx6q_handle_irq,
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index ab98c6f..36f03e2 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -14,6 +14,7 @@
 #include <linux/smp.h>
 #include <asm/page.h>
 #include <asm/smp_scu.h>
+#include <asm/soc.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
@@ -41,7 +42,7 @@ void __init imx_scu_map_io(void)
 	scu_base = IMX_IO_ADDRESS(base);
 }
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit imx_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -51,7 +52,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	gic_secondary_init(0);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int __cpuinit imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	imx_set_cpu_jump(cpu, v7_secondary_startup);
 	imx_enable_cpu(cpu, true);
@@ -62,7 +63,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+static void __init imx_smp_init_cpus(void)
 {
 	int i, ncores;
 
@@ -79,7 +80,18 @@ void imx_smp_prepare(void)
 	scu_enable(scu_base);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init imx_smp_prepare_cpus(unsigned int max_cpus)
 {
 	imx_smp_prepare();
 }
+
+struct arm_soc_smp_init_ops imx_soc_smp_init_ops __initdata = {
+	.smp_init_cpus		= imx_smp_init_cpus,
+	.smp_prepare_cpus	= imx_smp_prepare_cpus,
+};
+
+struct arm_soc_smp_ops imx_soc_smp_ops __initdata = {
+	.smp_secondary_init	= imx_secondary_init,
+	.smp_boot_secondary	= imx_boot_secondary,
+	soc_hotplug_ops(imx)
+};
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index cf663d8..760d460 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -144,6 +144,10 @@ extern void imx53_smd_common_init(void);
 extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
 extern void imx6q_clock_map_io(void);
 
+extern int imx_cpu_kill(unsigned int cpu);
+extern void imx_cpu_die(unsigned int cpu);
+extern int imx_cpu_disable(unsigned int cpu);
+
 #ifdef CONFIG_PM
 extern void imx6q_pm_init(void);
 #else
@@ -156,4 +160,10 @@ extern int mx51_neon_fixup(void);
 static inline int mx51_neon_fixup(void) { return 0; }
 #endif
 
+struct arm_soc_smp_init_ops;
+struct arm_soc_smp_ops;
+
+extern struct arm_soc_smp_init_ops imx_soc_smp_init_ops;
+extern struct arm_soc_smp_ops imx_soc_smp_ops;
+
 #endif
-- 
1.7.10.1
