From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 30 Apr 2014 14:17:32 +0900
Subject: [PATCH v3 07/12] ARM: EXYNOS: Add support for mapping PMU base address
 via DT
In-Reply-To: <1398835057-3860-1-git-send-email-pankaj.dubey@samsung.com>
References: <1398835057-3860-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1398835057-3860-8-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Young-Gun Jang <yg1004.jang@samsung.com>

Add support for mapping Samsung Power Management Unit (PMU)
base address from device tree. This patch also adds helper
function as "get_exynos_pmuregmap". This function can be used
by other machine files such as "pm.c", "hotplug.c" for accessing
PMU regmap handle.

Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/Kconfig  |    2 ++
 arch/arm/mach-exynos/common.h |    2 ++
 arch/arm/mach-exynos/exynos.c |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index fc8bf18..2f60c90 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -26,6 +26,7 @@ config ARCH_EXYNOS4
 	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM_RUNTIME
 	select S5P_DEV_MFC
+	select MFD_SYSCON
 	help
 	  Samsung EXYNOS4 SoCs based systems
 
@@ -36,6 +37,7 @@ config ARCH_EXYNOS5
 	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
 	select PINCTRL
+	select MFD_SYSCON
 	help
 	  Samsung EXYNOS5 (Cortex-A15) SoC based systems
 
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 8a4aa0b..33a2bee 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -55,4 +55,6 @@ struct exynos_pmu_conf {
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 extern void exynos_enter_aftr(void);
 
+extern struct regmap *get_exynos_pmuregmap(void);
+
 #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index a7b45db..9045fd6 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/mfd/syscon.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -36,6 +37,8 @@
 #define L2_AUX_VAL 0x7C470001
 #define L2_AUX_MASK 0xC200ffff
 
+static struct regmap *exynos_pmu_regmap;
+
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -260,6 +263,14 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 	return 1;
 }
 
+static const struct of_device_id exynos_dt_pmu_match[] = {
+	{ .compatible = "samsung,exynos4210-pmu" },
+	{ .compatible = "samsung,exynos4212-pmu" },
+	{ .compatible = "samsung,exynos4412-pmu" },
+	{ .compatible = "samsung,exynos5250-pmu" },
+	{},
+};
+
 /*
  * exynos_map_io
  *
@@ -327,6 +338,32 @@ static int __init exynos4_l2x0_cache_init(void)
 }
 early_initcall(exynos4_l2x0_cache_init);
 
+
+struct regmap *get_exynos_pmuregmap()
+{
+	return exynos_pmu_regmap;
+}
+
+void __init exynos_map_pmu(void)
+{
+	struct device_node *np = NULL;
+
+	early_syscon_init();
+
+	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
+
+	if (!np) {
+		pr_err("Failed to find PMU node\n");
+		return;
+	} else {
+		exynos_pmu_regmap = syscon_early_regmap_lookup_by_phandle(np,
+				"samsung,syscon-phandle");
+	}
+
+	if (IS_ERR(exynos_pmu_regmap))
+		pr_err("failed to find exynos_pmu_regmap\n");
+}
+
 static void __init exynos_dt_machine_init(void)
 {
 	struct device_node *i2c_np;
@@ -355,6 +392,8 @@ static void __init exynos_dt_machine_init(void)
 		}
 	}
 
+	exynos_map_pmu();
+
 	if (!soc_is_exynos5440())
 		platform_device_register(&exynos_cpuidle);
 
-- 
1.7.10.4
