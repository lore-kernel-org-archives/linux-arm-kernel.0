From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 20 Feb 2014 09:01:01 +0900
Subject: [PATCH] ARM: shmobile: MCPM and CCI prototype
Message-ID: <20140220000101.3595.13281.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This is a prototype hack to tie in the CCI driver via MCPM
on r8a7790 and the Lager platform. Needs much more work
especially when it comes to combined RST and APMU support
which is needed for JTAG support.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi               |   28 +++++++
 arch/arm/mach-shmobile/Kconfig               |    2 
 arch/arm/mach-shmobile/headsmp.S             |    7 +
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/platsmp-apmu.c        |   93 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/platsmp.c             |    4 +
 6 files changed, 132 insertions(+), 3 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2014-02-20 08:30:37.000000000 +0900
@@ -34,6 +34,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu1: cpu at 1 {
@@ -41,6 +42,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu2: cpu at 2 {
@@ -48,6 +50,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu3: cpu at 3 {
@@ -55,6 +58,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu4: cpu at 4 {
@@ -62,6 +66,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu5: cpu at 5 {
@@ -69,6 +74,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu6: cpu at 6 {
@@ -76,6 +82,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu7: cpu at 7 {
@@ -83,6 +90,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 	};
 
@@ -98,6 +106,26 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	cci at f0090000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0xf0090000 0 0x1000>;
+		ranges = <0x0 0x0 0xf0090000 0x10000>;
+
+		cci_control1: slave-if at 4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+
+		cci_control2: slave-if at 5000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
+		};
+	};
+
 	gpio0: gpio at e6050000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6050000 0 0x50>;
--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-02-20 08:30:37.000000000 +0900
@@ -32,10 +32,12 @@ config ARCH_R7S72100
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
 	select RENESAS_IRQC
+	select ARM_CCI
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
 	select RENESAS_IRQC
+	select ARM_CCI
 
 comment "Renesas ARM SoCs Board Type"
 
--- 0001/arch/arm/mach-shmobile/headsmp.S
+++ work/arch/arm/mach-shmobile/headsmp.S	2014-02-20 08:30:37.000000000 +0900
@@ -19,6 +19,13 @@ ENTRY(shmobile_invalidate_start)
 	b	secondary_startup
 ENDPROC(shmobile_invalidate_start)
 
+#ifdef CONFIG_MCPM
+ENTRY(shmobile_invalidate_mcpm_entry)
+	bl	v7_invalidate_l1
+	b	mcpm_entry_point
+ENDPROC(shmobile_invalidate_mcpm_entry)
+#endif
+
 /*
  * Reset vector for secondary CPUs.
  * This will be mapped at address 0 by SBAR register.
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2014-02-20 08:30:37.000000000 +0900
@@ -16,6 +16,7 @@ extern void shmobile_smp_hook(unsigned i
 			      unsigned long arg);
 extern int shmobile_smp_cpu_disable(unsigned int cpu);
 extern void shmobile_invalidate_start(void);
+extern void shmobile_invalidate_mcpm_entry(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
--- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2014-02-20 08:56:01.000000000 +0900
@@ -7,22 +7,28 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/arm-cci.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
+#include <asm/mcpm.h>
 #include <asm/smp_plat.h>
 #include <mach/common.h>
 
-static struct {
+static struct apmu_cpu {
 	void __iomem *iomem;
 	int bit;
 } apmu_cpus[CONFIG_NR_CPUS];
 
+#define MAX_NR_CLUSTERS 2
+static struct apmu_cpu *apmu_clst2cpu[MAX_NR_CLUSTERS][CONFIG_NR_CPUS];
+
 #define WUPCR_OFFS 0x10
 #define PSTR_OFFS 0x40
 #define CPUNCR_OFFS(n) (0x100 + (0x10 * (n)))
@@ -69,14 +75,23 @@ static int apmu_wrap(int cpu, int (*fn)(
 
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
+	u32 id;
+	int mcpm_cpu, mcpm_cluster;
+
 	if (apmu_cpus[cpu].iomem)
 		return;
 
 	apmu_cpus[cpu].iomem = ioremap_nocache(res->start, resource_size(res));
 	apmu_cpus[cpu].bit = bit;
 
-	pr_debug("apmu ioremap %d %d 0x%08x 0x%08x\n", cpu, bit,
-		 res->start, resource_size(res));
+	id = cpu_logical_map(cpu);
+	mcpm_cpu = MPIDR_AFFINITY_LEVEL(id, 0);
+	mcpm_cluster = MPIDR_AFFINITY_LEVEL(id, 1);
+
+	pr_debug("apmu ioremap %d %d 0x%08x 0x%08x %d %d\n", cpu, bit,
+		 res->start, resource_size(res), mcpm_cluster, mcpm_cpu);
+
+	apmu_clst2cpu[mcpm_cluster][mcpm_cpu] = &apmu_cpus[cpu];
 }
 
 static struct {
@@ -124,6 +139,75 @@ static void apmu_parse_cfg(void (*fn)(st
 	}
 }
 
+#ifdef CONFIG_MCPM
+/*
+ * Enable cluster-level coherency, in preparation for turning on the MMU.
+ */
+static void __naked apmu_power_up_setup(unsigned int affinity_level)
+{
+	asm volatile (" \n"
+"	cmp	r0, #1 \n"
+"	bxne	lr \n"
+"	b	cci_enable_port_for_self ");
+}
+
+static int __init foo_pm_init(void)
+{
+	if (!cci_probed())
+		return -ENODEV;
+
+	mcpm_sync_init(apmu_power_up_setup);
+	return 0;
+}
+
+early_initcall(foo_pm_init); /* FIXME: special init ordering really needed? */
+
+static int apmu_power_up(unsigned int cpu, unsigned int cluster)
+{
+	struct apmu_cpu *ac = apmu_clst2cpu[cluster][cpu];
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+
+	if (!ac)
+		return -EINVAL;
+
+	shmobile_smp_hook(ac - &apmu_cpus[0],
+			  virt_to_phys(shmobile_invalidate_mcpm_entry), 0);
+
+	return apmu_wrap(ac - &apmu_cpus[0], apmu_power_on);
+}
+
+static const struct mcpm_platform_ops apmu_pm_power_ops = {
+	.power_up		= apmu_power_up,
+};
+
+static void __init shmobile_smp_apmu_mcpm_hook(void)
+{
+	/*
+	 * The best way to detect a multi-cluster configuration at the moment
+	 * is to look for the presence of a CCI in the system.
+	 * Override the default smp_ops if so.
+	 */
+	struct device_node *node;
+	int ret;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
+	if (!node && !of_device_is_available(node))
+		return;
+
+	mcpm_smp_set_ops();
+
+	ret = mcpm_platform_register(&apmu_pm_power_ops);
+	if (!ret)
+		pr_info("APMU MCPM power management initialized\n");
+}
+
+#else
+static void __init shmobile_smp_apmu_mcpm_hook(void)
+{
+}
+#endif
+
 void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus)
 {
 	/* install boot code shared by all CPUs */
@@ -132,6 +216,9 @@ void __init shmobile_smp_apmu_prepare_cp
 
 	/* perform per-cpu setup */
 	apmu_parse_cfg(apmu_init_cpu);
+
+	/* hook in MCPM if needed */
+	shmobile_smp_apmu_mcpm_hook();
 }
 
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
--- 0001/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2014-02-20 08:30:37.000000000 +0900
@@ -28,6 +28,10 @@ void shmobile_smp_hook(unsigned int cpu,
 	shmobile_smp_fn[cpu] = fn;
 	shmobile_smp_arg[cpu] = arg;
 	flush_cache_all();
+
+	sync_cache_w(&shmobile_smp_mpidr[cpu]);
+	sync_cache_w(&shmobile_smp_fn[cpu]);
+	sync_cache_w(&shmobile_smp_arg[cpu]);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
