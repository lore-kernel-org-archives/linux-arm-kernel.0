From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 Dec 2016 18:38:42 +0530
Subject: [PATCH v8 7/8] ARM: EXYNOS: refactor smp specific code and routines
In-Reply-To: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
References: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1481375323-29724-8-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To remove dependency on soc_is_exynosMMMM macros and remove
multiple checks for such macros lets refactor code in platsmp.c.
This patch introduces new structure as exynos_cpu_info to
separate such variable information and routines which vary from
one Exynos SoC to other SoC. During smp_prepare_cpus lets match
SoC specific information to select appropriate exynos_cpu_info
and use it in all other places

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 244 +++++++++++++++++++++++++++++++++++------
 1 file changed, 210 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 4de254e..759a184 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/sys_soc.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
@@ -27,12 +28,26 @@
 #include <asm/smp_scu.h>
 #include <asm/firmware.h>
 
-#include <mach/map.h>
-
 #include "common.h"
 
 extern void exynos4_secondary_startup(void);
 
+/*
+ * struct exynos_cpu_info - Exynos CPU related info/operations
+ * @cpu_boot_reg: computes cpu boot address for requested cpu
+ * @cpu_power_down: handles cpu power down routine for requested cpu
+ * @cpu_power_up: handles cpu power up routine for requested cpu
+ * @cpu_restart: handles cpu restart routine for requested cpu
+ */
+struct exynos_cpu_info {
+	void __iomem* (*cpu_boot_reg)(u32 cpu);
+	void (*cpu_power_down)(u32 cpu);
+	void (*cpu_power_up)(u32 cpu);
+	void (*cpu_restart)(u32 cpu);
+};
+
+static const struct exynos_cpu_info *cpu_info;
+
 #ifdef CONFIG_HOTPLUG_CPU
 static inline void cpu_leave_lowpower(u32 core_id)
 {
@@ -81,19 +96,39 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-/**
- * exynos_core_power_down : power down the specified cpu
+/*
+ * exynos_cpu_power_down - power down the specified cpu
  * @cpu : the cpu to power down
  *
- * Power down the specified cpu. The sequence must be finished by a
- * call to cpu_do_idle()
- *
+ * The sequence must be finished by a call to cpu_do_idle()
  */
 void exynos_cpu_power_down(int cpu)
 {
+	if (cpu_info && cpu_info->cpu_power_down)
+		cpu_info->cpu_power_down(cpu);
+}
+
+/*
+ * exynos_common_cpu_power_down - common cpu power down routine for Exynos SoC
+ * @cpu : the cpu to power down
+ */
+static void exynos_common_cpu_power_down(u32 cpu)
+{
 	u32 core_conf;
 
-	if (cpu == 0 && (soc_is_exynos5420() || soc_is_exynos5800())) {
+	core_conf = pmu_raw_readl(EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+	core_conf &= ~S5P_CORE_LOCAL_PWR_EN;
+	pmu_raw_writel(core_conf, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+}
+
+/*
+ * exynos5420_cpu_power_down - Exynos5420/Exynos5800 specific cpu power down
+ * routine
+ * @cpu : the cpu to power down
+ */
+static void exynos5420_cpu_power_down(u32 cpu)
+{
+	if (cpu == 0) {
 		/*
 		 * Bypass power down for CPU0 during suspend. Check for
 		 * the SYS_PWR_REG value to decide if we are suspending
@@ -105,24 +140,39 @@ void exynos_cpu_power_down(int cpu)
 			return;
 	}
 
-	core_conf = pmu_raw_readl(EXYNOS_ARM_CORE_CONFIGURATION(cpu));
-	core_conf &= ~S5P_CORE_LOCAL_PWR_EN;
-	pmu_raw_writel(core_conf, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+	exynos_common_cpu_power_down(cpu);
 }
 
 /**
  * exynos_cpu_power_up : power up the specified cpu
  * @cpu : the cpu to power up
- *
- * Power up the specified cpu
  */
 void exynos_cpu_power_up(int cpu)
 {
+	if (cpu_info && cpu_info->cpu_power_up)
+		cpu_info->cpu_power_up(cpu);
+}
+
+/*
+ * exynos_common_cpu_power_up - common cpu power up routine for Exynos SoC
+ * @cpu : the cpu to power up
+ */
+static void exynos_common_cpu_power_up(u32 cpu)
+{
 	u32 core_conf = S5P_CORE_LOCAL_PWR_EN;
+	pmu_raw_writel(core_conf,
+			EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+}
 
-	if (soc_is_exynos3250())
-		core_conf |= S5P_CORE_AUTOWAKEUP_EN;
+/*
+ * exynos3250_cpu_power_up - Exynos3250 specific cpu power up routine
+ * @cpu : the cpu to power down
+ */
+static void exynos3250_cpu_power_up(u32 cpu)
+{
+	u32 core_conf = S5P_CORE_LOCAL_PWR_EN;
 
+	core_conf |= S5P_CORE_AUTOWAKEUP_EN;
 	pmu_raw_writel(core_conf,
 			EXYNOS_ARM_CORE_CONFIGURATION(cpu));
 }
@@ -130,7 +180,6 @@ void exynos_cpu_power_up(int cpu)
 /**
  * exynos_cpu_power_state : returns the power state of the cpu
  * @cpu : the cpu to retrieve the power state from
- *
  */
 int exynos_cpu_power_state(int cpu)
 {
@@ -189,39 +238,76 @@ int exynos_scu_enable(void)
 	return 0;
 }
 
-static void __iomem *cpu_boot_reg_base(void)
+static inline void __iomem *exynos_cpu_boot_reg(int cpu)
+{
+	if (cpu_info && cpu_info->cpu_boot_reg)
+		return cpu_info->cpu_boot_reg(cpu);
+	return NULL;
+}
+
+static void __iomem *exynos_common_cpu_boot_reg(u32 cpu)
 {
-	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
-		return pmu_base_addr + S5P_INFORM5;
+	if (!sysram_base_addr)
+		return IOMEM_ERR_PTR(-ENODEV);
+
 	return sysram_base_addr;
 }
 
-static inline void __iomem *cpu_boot_reg(int cpu)
+static void __iomem *exynos4210_cpu_boot_reg(u32 cpu)
 {
 	void __iomem *boot_reg;
 
-	boot_reg = cpu_boot_reg_base();
-	if (!boot_reg)
+	if (!pmu_base_addr)
 		return IOMEM_ERR_PTR(-ENODEV);
-	if (soc_is_exynos4412())
-		boot_reg += 4*cpu;
-	else if (soc_is_exynos5420() || soc_is_exynos5800())
-		boot_reg += 4;
+	boot_reg = pmu_base_addr + S5P_INFORM5;
+
+	return boot_reg;
+}
+
+static void __iomem *exynos4412_cpu_boot_reg(u32 cpu)
+{
+	void __iomem *boot_reg;
+
+	if (!sysram_base_addr)
+		return IOMEM_ERR_PTR(-ENODEV);
+
+	boot_reg = sysram_base_addr;
+	boot_reg += 4*cpu;
+
+	return boot_reg;
+}
+
+static void __iomem *exynos5420_cpu_boot_reg(u32 cpu)
+{
+	void __iomem *boot_reg;
+
+	if (!sysram_base_addr)
+		return IOMEM_ERR_PTR(-ENODEV);
+
+	boot_reg = sysram_base_addr;
+	boot_reg += 4;
+
 	return boot_reg;
 }
 
+/**
+ * exynos_core_restart : restart the specified cpu
+ * @core_id : the cpu to be restarted
+ */
+void exynos_core_restart(u32 core_id)
+{
+	if (cpu_info && cpu_info->cpu_restart)
+		cpu_info->cpu_restart(core_id);
+}
+
 /*
  * Set wake up by local power mode and execute software reset for given core.
- *
  * Currently this is needed only when booting secondary CPU on Exynos3250.
  */
-void exynos_core_restart(u32 core_id)
+static void exynos3250_core_restart(u32 core_id)
 {
 	u32 val;
 
-	if (!of_machine_is_compatible("samsung,exynos3250"))
-		return;
-
 	while (!pmu_raw_readl(S5P_PMU_SPARE2))
 		udelay(10);
 	udelay(10);
@@ -274,7 +360,7 @@ int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr)
 	if (ret && ret != -ENOSYS)
 		goto fail;
 	if (ret == -ENOSYS) {
-		void __iomem *boot_reg = cpu_boot_reg(core_id);
+		void __iomem *boot_reg = exynos_cpu_boot_reg(core_id);
 
 		if (IS_ERR(boot_reg)) {
 			ret = PTR_ERR(boot_reg);
@@ -299,7 +385,7 @@ int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr)
 	if (ret && ret != -ENOSYS)
 		goto fail;
 	if (ret == -ENOSYS) {
-		void __iomem *boot_reg = cpu_boot_reg(core_id);
+		void __iomem *boot_reg = exynos_cpu_boot_reg(core_id);
 
 		if (IS_ERR(boot_reg)) {
 			ret = PTR_ERR(boot_reg);
@@ -312,13 +398,93 @@ int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr)
 	return ret;
 }
 
+static const struct exynos_cpu_info exynos3250_cpu_info = {
+	.cpu_boot_reg = exynos_common_cpu_boot_reg,
+	.cpu_power_down = exynos_common_cpu_power_down,
+	.cpu_power_up = exynos3250_cpu_power_up,
+	.cpu_restart = exynos3250_core_restart,
+};
+
+static const struct exynos_cpu_info exynos5420_cpu_info = {
+	.cpu_boot_reg = exynos5420_cpu_boot_reg,
+	.cpu_power_down = exynos5420_cpu_power_down,
+	.cpu_power_up = exynos_common_cpu_power_up,
+};
+
+static const struct exynos_cpu_info exynos4210_cpu_info = {
+	.cpu_boot_reg = exynos4210_cpu_boot_reg,
+	.cpu_power_down = exynos_common_cpu_power_down,
+	.cpu_power_up = exynos_common_cpu_power_up,
+};
+
+static const struct exynos_cpu_info exynos4412_cpu_info = {
+	.cpu_boot_reg = exynos4412_cpu_boot_reg,
+	.cpu_power_down = exynos_common_cpu_power_down,
+	.cpu_power_up = exynos_common_cpu_power_up,
+};
+
+static const struct exynos_cpu_info exynos_common_cpu_info = {
+	.cpu_boot_reg = exynos_common_cpu_boot_reg,
+	.cpu_power_down = exynos_common_cpu_power_down,
+	.cpu_power_up = exynos_common_cpu_power_up,
+};
+
+static const struct soc_device_attribute exynos_soc_revision[] __initconst = {
+	{
+		.soc_id = "EXYNOS4210", .revision = "11",
+		.data = &exynos4210_cpu_info
+	}, {
+		.soc_id = "EXYNOS4210", .revision = "10",
+		.data = &exynos_common_cpu_info
+	}
+};
+
+static const struct of_device_id exynos_pmu_of_device_ids[] __initconst = {
+	{
+		.compatible = "samsung,exynos3250",
+		.data = &exynos3250_cpu_info
+	}, {
+		.compatible = "samsung,exynos4212",
+		.data = &exynos_common_cpu_info
+	}, {
+		.compatible = "samsung,exynos4412",
+		.data = &exynos4412_cpu_info
+	}, {
+		.compatible = "samsung,exynos5250",
+		.data = &exynos_common_cpu_info
+	}, {
+		.compatible = "samsung,exynos5260",
+		.data = &exynos_common_cpu_info
+	}, {
+		.compatible = "samsung,exynos5410",
+		.data = &exynos_common_cpu_info
+	}, {
+		.compatible = "samsung,exynos5420",
+		.data = &exynos5420_cpu_info
+	}, {
+		.compatible = "samsung,exynos5440",
+		.data = &exynos_common_cpu_info
+	}, {
+		.compatible = "samsung,exynos5800",
+		.data = &exynos5420_cpu_info
+	},
+	{ /*sentinel*/ },
+};
+
 static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
+	const struct soc_device_attribute *match;
 	u32 mpidr = cpu_logical_map(cpu);
 	u32 core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	int ret = -ENOSYS;
 
+	if (of_machine_is_compatible("samsung,exynos4210")) {
+		match = soc_device_match(exynos_soc_revision);
+		if (match)
+			cpu_info = (const struct exynos_cpu_info *) match->data;
+	}
+
 	/*
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
@@ -377,7 +543,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		call_firmware_op(cpu_boot, core_id);
 
-		if (soc_is_exynos3250())
+		if (of_machine_is_compatible("samsung,exynos3250"))
 			dsb_sev();
 		else
 			arch_send_wakeup_ipi_mask(cpumask_of(cpu));
@@ -403,6 +569,16 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 {
+	const struct of_device_id *match;
+	struct device_node *np;
+
+	np = of_find_matching_node_and_match(NULL,
+			exynos_pmu_of_device_ids, &match);
+	if (!np)
+		pr_err("failed to find supported CPU\n");
+	else
+		cpu_info = (const struct exynos_cpu_info *) match->data;
+
 	exynos_sysram_init();
 
 	exynos_set_delayed_reset_assertion(true);
-- 
2.7.4
