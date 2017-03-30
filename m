From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:47:03 +0530
Subject: [PATCH v9 09/12] ARM: EXYNOS: introduce exynos_cpu_info struct
In-Reply-To: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131438epcas1p459ce93da17fcd05249eddaef18d5021e@epcas1p4.samsung.com>
Message-ID: <1490879826-16754-10-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various Exynos SoC has different CPU related information, such as CPU
boot register, programming sequence making CPU up/down. Currently this
is handled by adding lots of soc_is_exynosMMM checks in the code, in
an attempt to remove the dependency of such helper functions specific to
each SoC, let's separate this information pertaining to CPU by introducing
a new "struct exynos_cpu_info". This struct will contain differences
associated with CPU on various Exynos SoC. This can be matched by using
generic API "soc_device_match".

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 146 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 135 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index cb6d199..ff369b9 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/sys_soc.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include <asm/cacheflush.h>
@@ -33,6 +34,16 @@
 
 extern void exynos4_secondary_startup(void);
 
+/*
+ * struct exynos_cpu_info - Exynos CPU related info/operations
+ * @cpu_boot_reg: computes cpu boot address for requested cpu
+ */
+struct exynos_cpu_info {
+	void __iomem* (*cpu_boot_reg)(u32 cpu);
+};
+
+static const struct exynos_cpu_info *cpu_info;
+
 #ifdef CONFIG_HOTPLUG_CPU
 static inline void cpu_leave_lowpower(u32 core_id)
 {
@@ -168,27 +179,57 @@ int exynos_cluster_power_state(int cluster)
 		S5P_CORE_LOCAL_PWR_EN);
 }
 
-static void __iomem *cpu_boot_reg_base(void)
+static void __iomem *exynos4210_rev11_cpu_boot_reg(u32 cpu)
 {
-	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
-		return pmu_base_addr + S5P_INFORM5;
-	return sysram_base_addr;
+	void __iomem *boot_reg = pmu_base_addr;
+
+	if (!boot_reg)
+		return IOMEM_ERR_PTR(-ENODEV);
+
+	boot_reg += S5P_INFORM5;
+
+	return boot_reg;
 }
 
-static inline void __iomem *cpu_boot_reg(int cpu)
+static void __iomem *exynos4412_cpu_boot_reg(u32 cpu)
 {
-	void __iomem *boot_reg;
+	void __iomem *boot_reg = sysram_base_addr;
 
-	boot_reg = cpu_boot_reg_base();
 	if (!boot_reg)
 		return IOMEM_ERR_PTR(-ENODEV);
-	if (soc_is_exynos4412())
-		boot_reg += 4*cpu;
-	else if (soc_is_exynos5420() || soc_is_exynos5800())
-		boot_reg += 4;
+
+	boot_reg += 4*cpu;
+
 	return boot_reg;
 }
 
+static void __iomem *exynos5420_cpu_boot_reg(u32 cpu)
+{
+	void __iomem *boot_reg = sysram_base_addr;
+
+	if (!sysram_base_addr)
+		return IOMEM_ERR_PTR(-ENODEV);
+
+	boot_reg += 4;
+
+	return boot_reg;
+}
+
+static void __iomem *exynos_common_cpu_boot_reg(u32 cpu)
+{
+	if (!sysram_base_addr)
+		return IOMEM_ERR_PTR(-ENODEV);
+
+	return sysram_base_addr;
+}
+
+static inline void __iomem *cpu_boot_reg(int cpu)
+{
+	if (cpu_info && cpu_info->cpu_boot_reg)
+		return cpu_info->cpu_boot_reg(cpu);
+	return NULL;
+}
+
 /*
  * Set wake up by local power mode and execute software reset for given core.
  *
@@ -296,13 +337,84 @@ int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr)
 	return ret;
 }
 
+static const struct exynos_cpu_info exynos3250_cpu_info = {
+	.cpu_boot_reg = exynos_common_cpu_boot_reg,
+};
+
+static const struct exynos_cpu_info exynos5420_cpu_info = {
+	.cpu_boot_reg = exynos5420_cpu_boot_reg,
+};
+
+static const struct exynos_cpu_info exynos4210_rev11_cpu_info = {
+	.cpu_boot_reg = exynos4210_rev11_cpu_boot_reg,
+};
+
+static const struct exynos_cpu_info exynos4412_cpu_info = {
+	.cpu_boot_reg = exynos4412_cpu_boot_reg,
+};
+
+static const struct exynos_cpu_info exynos_common_cpu_info = {
+	.cpu_boot_reg = exynos_common_cpu_boot_reg,
+};
+
+static const struct soc_device_attribute exynos_soc_revision[] = {
+	{
+		.soc_id = "EXYNOS4210",
+		.revision = "11",
+		.data = &exynos4210_rev11_cpu_info
+	}, {
+		.soc_id = "EXYNOS4210",
+		.revision = "10",
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
@@ -387,6 +499,18 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 {
+	const struct of_device_id *match;
+	struct device_node *np;
+
+	if (!of_machine_is_compatible("samsung,exynos4210")) {
+		np = of_find_matching_node_and_match(NULL,
+				exynos_pmu_of_device_ids, &match);
+		if (!np)
+			pr_err("failed to find supported CPU\n");
+		else
+			cpu_info = (const struct exynos_cpu_info *) match->data;
+	}
+
 	exynos_sysram_init();
 
 	exynos_set_delayed_reset_assertion(true);
-- 
2.7.4
