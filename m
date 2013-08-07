From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:45:10 +0900
Subject: [PATCH] ARM: shmobile: Shared APMU SMP support code
Message-ID: <20130807224510.9832.38560.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce shared APMU SMP code for mach-shmobile. Both SMP boot up
and CPU Hotplug is supported. DT is used for configuration of the
APMU hardware block, as the following r8a73a4 example shows:

       apmu at e6152000 {
               compatible = "renesas,r8a73a4-apmu", "renesas,apmu";
               reg = <0 0xe6152000 0 0x88>;
               cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
       };

The code is designed around CONFIG_NR_CPUS and should in theory support
any number of APMUs. At this point only the APMU that includes the
boot CPU is enabled - this to prevent non-deterministic scheduling on
upstream in case of multi-cluster hardware with varying performance.
 
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-devel-20130806v4 and
 [PATCH 00/05] ARM: shmobile: Yet another SMP series
 [PATCH 00/02] ARM: shmobile: Rename to r8a73a4/r8a7790_init_early()

 arch/arm/mach-shmobile/include/mach/common.h |    5 
 arch/arm/mach-shmobile/platsmp-apmu.c        |  197 ++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)

--- 0007/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-08-08 07:36:45.000000000 +0900
@@ -22,6 +22,11 @@ extern int shmobile_smp_scu_boot_seconda
 					   struct task_struct *idle);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
+extern void shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus);
+extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
+					    struct task_struct *idle);
+extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
+extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
--- /dev/null
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2013-08-08 07:32:45.000000000 +0900
@@ -0,0 +1,197 @@
+/*
+ * SMP support for SoCs with APMU
+ *
+ * Copyright (C) 2013  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/smp_plat.h>
+#include <mach/common.h>
+
+static struct {
+	void __iomem *iomem;
+	int bit;
+} apmu_cpus[CONFIG_NR_CPUS];
+
+#define WUPCR_OFFS 0x10
+#define PSTR_OFFS 0x40
+#define CPUNCR_OFFS(n) (0x100 + (0x10 * (n)))
+
+static int apmu_power_on(void __iomem *p, int bit)
+{
+	/* request power on */
+	writel_relaxed(BIT(bit), p + WUPCR_OFFS);
+
+	/* wait for APMU to finish */
+	while (readl_relaxed(p + WUPCR_OFFS) != 0)
+		;
+
+	return 0;
+}
+
+static int apmu_power_off(void __iomem *p, int bit)
+{
+	/* request Core Standby for next WFI */
+	writel_relaxed(3, p + CPUNCR_OFFS(bit));
+	return 0;
+}
+
+static int apmu_power_off_poll(void __iomem *p, int bit)
+{
+	int k;
+
+	for (k = 0; k < 1000; k++) {
+		if (((readl_relaxed(p + PSTR_OFFS) >> (bit * 4)) & 0x03) == 3)
+			return 1;
+
+		mdelay(1);
+	}
+
+	return 0;
+}
+
+static int apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu))
+{
+	void __iomem *p = apmu_cpus[cpu].iomem;
+
+	return p ? fn(p, apmu_cpus[cpu].bit) : -EINVAL;
+}
+
+static void apmu_init_cpu(struct device_node *np, int cpu, int bit)
+{
+	struct resource res;
+
+	if (apmu_cpus[cpu].iomem)
+		return;
+
+	if (!of_address_to_resource(np, 0, &res))
+		apmu_cpus[cpu].iomem = ioremap_nocache(res.start,
+						       resource_size(&res));
+	apmu_cpus[cpu].bit = bit;
+
+	pr_debug("apmu ioremap %d %d 0x%08x 0x%08x\n", cpu, bit,
+		 res.start, resource_size(&res));
+}
+
+static struct of_device_id apmu_ids[] = {
+	{ .compatible = "renesas,apmu" },
+	{ /*sentinel*/ }
+};
+
+static void apmu_parse_dt(void (*fn)(struct device_node *np, int cpu, int bit))
+{
+	struct device_node *np_apmu, *np_cpu;
+	u32 id;
+	int bit, index;
+	bool is_allowed;
+
+	for_each_matching_node(np_apmu, apmu_ids) {
+		/* only enable the cluster that includes the boot CPU */
+		is_allowed = false;
+		for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
+			np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
+			if (np_cpu) {
+				if (!of_property_read_u32(np_cpu, "reg", &id)) {
+					if (id == cpu_logical_map(0))
+						is_allowed = true;
+				}
+				of_node_put(np_cpu);
+			}
+		}
+		if (!is_allowed)
+			continue;
+
+		for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
+			np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
+			if (np_cpu) {
+				if (!of_property_read_u32(np_cpu, "reg", &id)) {
+					index = get_logical_index(id);
+					if (index >= 0)
+						fn(np_apmu, index, bit);
+				}
+				of_node_put(np_cpu);
+			}
+		}
+		of_node_put(np_apmu);
+	}
+}
+
+void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus)
+{
+	/* install boot code shared by all CPUs */
+	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
+	shmobile_boot_arg = MPIDR_HWID_BITMASK;
+
+	/* perform per-cpu setup */
+	apmu_parse_dt(apmu_init_cpu);
+}
+
+int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	/* For this particular CPU register boot vector */
+	shmobile_smp_hook(cpu, virt_to_phys(shmobile_invalidate_start), 0);
+
+	return apmu_wrap(cpu, apmu_power_on);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+/* nicked from arch/arm/mach-exynos/hotplug.c */
+static inline void cpu_enter_lowpower_a15(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"       mrc     p15, 0, %0, c1, c0, 0\n"
+	"       bic     %0, %0, %1\n"
+	"       mcr     p15, 0, %0, c1, c0, 0\n"
+	: "=&r" (v)
+	: "Ir" (CR_C)
+	: "cc");
+
+	flush_cache_louis();
+
+	asm volatile(
+	/*
+	 * Turn off coherency
+	 */
+	"       mrc     p15, 0, %0, c1, c0, 1\n"
+	"       bic     %0, %0, %1\n"
+	"       mcr     p15, 0, %0, c1, c0, 1\n"
+	: "=&r" (v)
+	: "Ir" (0x40)
+	: "cc");
+
+	isb();
+	dsb();
+}
+
+void shmobile_smp_apmu_cpu_die(unsigned int cpu)
+{
+	/* For this particular CPU deregister boot vector */
+	shmobile_smp_hook(cpu, 0, 0);
+
+	/* Select next sleep mode using the APMU */
+	apmu_wrap(cpu, apmu_power_off);
+
+	/* Do ARM specific CPU shutdown */
+	cpu_enter_lowpower_a15();
+
+	/* jump to shared mach-shmobile sleep / reset code */
+	shmobile_smp_sleep();
+}
+
+int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
+{
+	return apmu_wrap(cpu, apmu_power_off_poll);
+}
+#endif
