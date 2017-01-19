From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 19 Jan 2017 14:48:41 +0100
Subject: [PATCH v3 01/13] soc: samsung: pmu: Provide global function to get PMU
 regmap
In-Reply-To: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134904eucas1p153a1d5b2ff9826c88293b6a8fe5140bc@eucas1p1.samsung.com>
Message-ID: <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMU is something like a SoC wide service, so add a helper function to get
PMU regmap. This will be used by other Exynos device drivers. This way it
can be avoided to model this dependency in device tree (as phandles to PMU
node) for almost every device in the SoC.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/soc/samsung/exynos-pmu.c       | 11 +++++++++++
 include/linux/soc/samsung/exynos-pmu.h | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 0acdfd82e751..5c269bf23210 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -11,6 +11,7 @@
 
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 
@@ -92,6 +93,16 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 	{ /*sentinel*/ },
 };
 
+struct regmap *exynos_get_pmu_regmap(void)
+{
+	struct device_node *np = of_find_matching_node(NULL,
+						      exynos_pmu_of_device_ids);
+	if (np)
+		return syscon_node_to_regmap(np);
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
+
 static int exynos_pmu_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
index e2e9de1acc5b..e57eb4b6cc5a 100644
--- a/include/linux/soc/samsung/exynos-pmu.h
+++ b/include/linux/soc/samsung/exynos-pmu.h
@@ -12,6 +12,8 @@
 #ifndef __LINUX_SOC_EXYNOS_PMU_H
 #define __LINUX_SOC_EXYNOS_PMU_H
 
+struct regmap;
+
 enum sys_powerdown {
 	SYS_AFTR,
 	SYS_LPA,
@@ -20,5 +22,13 @@ enum sys_powerdown {
 };
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
+#ifdef CONFIG_EXYNOS_PMU
+extern struct regmap *exynos_get_pmu_regmap(void);
+#else
+static inline struct regmap *exynos_get_pmu_regmap(void)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
 
 #endif /* __LINUX_SOC_EXYNOS_PMU_H */
-- 
1.9.1
