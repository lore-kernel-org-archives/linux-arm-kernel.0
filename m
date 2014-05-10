From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 May 2014 15:56:33 +0900
Subject: [PATCH v4 06/11] ARM: EXYNOS: Add support for mapping PMU base address
 via DT
In-Reply-To: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399704998-13321-7-git-send-email-pankaj.dubey@samsung.com>
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
 arch/arm/Kconfig              |    1 +
 arch/arm/mach-exynos/common.h |    2 ++
 arch/arm/mach-exynos/exynos.c |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 732a134..a4eac2f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -855,6 +855,7 @@ config ARCH_EXYNOS
 	select SPARSE_IRQ
 	select SRAM
 	select USE_OF
+	select MFD_SYSCON
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 69739e4..d533e2d 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -57,4 +57,6 @@ struct exynos_pmu_conf {
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 extern void exynos_enter_aftr(void);
 
+extern struct regmap *get_exynos_pmuregmap(void);
+
 #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index e4a4be0..3b1d245 100644
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
@@ -210,6 +213,14 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
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
@@ -263,6 +274,32 @@ static int __init exynos4_l2x0_cache_init(void)
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
+				NULL);
+	}
+
+	if (IS_ERR(exynos_pmu_regmap))
+		pr_err("failed to find exynos_pmu_regmap\n");
+}
+
 static void __init exynos_dt_machine_init(void)
 {
 	struct device_node *i2c_np;
@@ -291,6 +328,8 @@ static void __init exynos_dt_machine_init(void)
 		}
 	}
 
+	exynos_map_pmu();
+
 	if (!soc_is_exynos5440())
 		platform_device_register(&exynos_cpuidle);
 
-- 
1.7.10.4
