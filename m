From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 25 Apr 2014 21:32:46 +0900
Subject: [PATCH v2 10/10] ARM: EXYNOS: Add device tree based initialization
 support for PMU.
In-Reply-To: <1398429166-5539-1-git-send-email-pankaj.dubey@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1398429166-5539-11-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree based initialization for PMU and modifies
PMU initialization implementation in following way:

1: Let's initialize PMU based on device tree compatibility string.
2: Obtain PMU regmap handle using "syscon_early_regmap_lookup_by_phandle"
so that we can reduce dependency over machine header files.
3: Separate each SoC's PMU initialization function and bind this initialization
function with PMU compatibility string.
4 : It also removes uses of soc_is_exynosXXXX() thus making PMU implementation
independent of "plat/cpu.h".

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
---
 arch/arm/mach-exynos/pmu.c |  182 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 138 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 67116a5..abcf753 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -9,17 +9,31 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/regmap.h>
-
-#include <plat/cpu.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
 
 #include "common.h"
 #include "regs-pmu.h"
 
+enum exynos_pmu_id {
+	PMU_EXYNOS4210,
+	PMU_EXYNOS4X12,
+	PMU_EXYNOS4412,
+	PMU_EXYNOS5250,
+};
+
+struct exynos_pmu_data {
+	enum exynos_pmu_id	pmu_id;
+	struct regmap		*pmu_regmap;
+};
+
+struct exynos_pmu_data		*pmu_data;
 static const struct exynos_pmu_conf *exynos_pmu_config;
-static struct regmap *pmu_regmap;
+typedef void (*exynos_pmu_init_t)(void);
 
 static const struct exynos_pmu_conf exynos4210_pmu_config[] = {
 	/* { .reg = address, .val = { AFTR, LPA, SLEEP } */
@@ -348,28 +362,31 @@ static void exynos5_init_pmu(void)
 	 * Enable both SC_FEEDBACK and SC_COUNTER
 	 */
 	for (i = 0 ; i < ARRAY_SIZE(exynos5_list_both_cnt_feed) ; i++) {
-		regmap_read(pmu_regmap, exynos5_list_both_cnt_feed[i], &tmp);
+		regmap_read(pmu_data->pmu_regmap,
+				exynos5_list_both_cnt_feed[i], &tmp);
 		tmp |= (EXYNOS5_USE_SC_FEEDBACK |
 			EXYNOS5_USE_SC_COUNTER);
-		regmap_write(pmu_regmap, exynos5_list_both_cnt_feed[i], tmp);
+		regmap_write(pmu_data->pmu_regmap,
+				exynos5_list_both_cnt_feed[i], tmp);
 	}
 
 	/*
 	 * SKIP_DEACTIVATE_ACEACP_IN_PWDN_BITFIELD Enable
 	 */
-	regmap_read(pmu_regmap, EXYNOS5_ARM_COMMON_OPTION, &tmp);
+	regmap_read(pmu_data->pmu_regmap, EXYNOS5_ARM_COMMON_OPTION, &tmp);
 	tmp |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
-	regmap_write(pmu_regmap, EXYNOS5_ARM_COMMON_OPTION, tmp);
+	regmap_write(pmu_data->pmu_regmap, EXYNOS5_ARM_COMMON_OPTION, tmp);
 
 	/*
 	 * Disable WFI/WFE on XXX_OPTION
 	 */
 	for (i = 0 ; i < ARRAY_SIZE(exynos5_list_diable_wfi_wfe) ; i++) {
-		tmp = regmap_read(pmu_regmap, exynos5_list_diable_wfi_wfe[i],
-				&tmp);
+		tmp = regmap_read(pmu_data->pmu_regmap,
+				exynos5_list_diable_wfi_wfe[i], &tmp);
 		tmp &= ~(EXYNOS5_OPTION_USE_STANDBYWFE |
 			 EXYNOS5_OPTION_USE_STANDBYWFI);
-		regmap_write(pmu_regmap, exynos5_list_diable_wfi_wfe[i], tmp);
+		regmap_write(pmu_data->pmu_regmap,
+				exynos5_list_diable_wfi_wfe[i], tmp);
 	}
 }
 
@@ -377,52 +394,129 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
 
-	if (soc_is_exynos5250())
+	if (pmu_data->pmu_id == PMU_EXYNOS5250)
 		exynos5_init_pmu();
 
 	for (i = 0; (exynos_pmu_config[i].offset != PMU_TABLE_END) ; i++)
-		regmap_write(pmu_regmap, exynos_pmu_config[i].offset,
+		regmap_write(pmu_data->pmu_regmap, exynos_pmu_config[i].offset,
 				exynos_pmu_config[i].val[mode]);
 
-	if (soc_is_exynos4412()) {
+	if (pmu_data->pmu_id == PMU_EXYNOS4412) {
 		for (i = 0; exynos4412_pmu_config[i].offset != PMU_TABLE_END; i++)
-			regmap_write(pmu_regmap, exynos4412_pmu_config[i].offset,
+			regmap_write(pmu_data->pmu_regmap,
+					exynos4412_pmu_config[i].offset,
 					exynos4412_pmu_config[i].val[mode]);
 	}
 }
 
-static int __init exynos_pmu_init(void)
+static void exynos4210_pmu_init(void)
 {
-	unsigned int value;
-
 	exynos_pmu_config = exynos4210_pmu_config;
-	pmu_regmap = get_exynos_pmuregmap();
-
-	if (soc_is_exynos4210()) {
-		exynos_pmu_config = exynos4210_pmu_config;
-		pr_info("EXYNOS4210 PMU Initialize\n");
-	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
-		exynos_pmu_config = exynos4x12_pmu_config;
-		pr_info("EXYNOS4x12 PMU Initialize\n");
-	} else if (soc_is_exynos5250()) {
-		/*
-		 * When SYS_WDTRESET is set, watchdog timer reset request
-		 * is ignored by power management unit.
-		 */
-		regmap_read(pmu_regmap, EXYNOS5_AUTO_WDTRESET_DISABLE, &value);
-		value &= ~EXYNOS5_SYS_WDTRESET;
-		regmap_write(pmu_regmap, EXYNOS5_AUTO_WDTRESET_DISABLE, value);
-
-		regmap_read(pmu_regmap, EXYNOS5_MASK_WDTRESET_REQUEST, &value);
-		value &= ~EXYNOS5_SYS_WDTRESET;
-		regmap_write(pmu_regmap, EXYNOS5_MASK_WDTRESET_REQUEST, value);
-
-		exynos_pmu_config = exynos5250_pmu_config;
-		pr_info("EXYNOS5250 PMU Initialize\n");
-	} else {
-		pr_info("EXYNOS: PMU not supported\n");
+	pmu_data->pmu_id = PMU_EXYNOS4210;
+
+	pr_info("EXYNOS4210 PMU Initialize\n");
+}
+
+static void exynos4x12_pmu_init(void)
+{
+	exynos_pmu_config = exynos4x12_pmu_config;
+	pmu_data->pmu_id = PMU_EXYNOS4X12;
+
+	pr_info("EXYNOS4x12 PMU Initialize\n");
+}
+
+static void exynos4412_pmu_init(void)
+{
+	exynos_pmu_config = exynos4x12_pmu_config;
+	pmu_data->pmu_id = PMU_EXYNOS4412;
+
+	pr_info("EXYNOS4412 PMU Initialize\n");
+}
+
+static void exynos5250_pmu_init(void)
+{
+	unsigned int tmp;
+
+	/*
+	 * When SYS_WDTRESET is set, watchdog timer reset request
+	 * is ignored by power management unit.
+	 */
+	regmap_read(pmu_data->pmu_regmap, EXYNOS5_AUTO_WDTRESET_DISABLE, &tmp);
+	tmp &= ~EXYNOS5_SYS_WDTRESET;
+	regmap_write(pmu_data->pmu_regmap, EXYNOS5_AUTO_WDTRESET_DISABLE, tmp);
+
+	regmap_read(pmu_data->pmu_regmap, EXYNOS5_MASK_WDTRESET_REQUEST, &tmp);
+	tmp &= ~EXYNOS5_SYS_WDTRESET;
+	regmap_write(pmu_data->pmu_regmap, EXYNOS5_MASK_WDTRESET_REQUEST, tmp);
+
+	exynos_pmu_config = exynos5250_pmu_config;
+	pmu_data->pmu_id = PMU_EXYNOS5250;
+
+	pr_info("EXYNOS5250 PMU Initialize\n");
+}
+
+/*
+ * PMU platform driver and devicetree bindings.
+ */
+static struct of_device_id exynos_pmu_of_device_ids[] = {
+	{
+		.compatible = "samsung,exynos4210-pmu",
+		.data = (void *)exynos4210_pmu_init
+	},
+	{
+		.compatible = "samsung,exynos4212-pmu",
+		.data = (void *)exynos4x12_pmu_init
+	},
+	{
+		.compatible = "samsung,exynos4412-pmu",
+		.data = (void *)exynos4412_pmu_init
+	},
+	{
+		.compatible = "samsung,exynos5250-pmu",
+		.data = (void *)exynos5250_pmu_init
+	},
+	{},
+};
+
+static int exynos_pmu_probe(struct device_node *np)
+{
+	const struct of_device_id *match;
+	exynos_pmu_init_t exynos_pmu_init;
+
+	pmu_data = kzalloc(sizeof(struct exynos_pmu_data), GFP_KERNEL);
+	if (!pmu_data) {
+		pr_err("exynos_pmu driver probe failed\n");
+		return -ENOMEM;
 	}
 
+	match = of_match_node(exynos_pmu_of_device_ids, np);
+	if (!match) {
+		pr_err("fail to get matching of_match struct\n");
+		return -EINVAL;
+	}
+
+	exynos_pmu_init = match->data;
+
+	pmu_data->pmu_regmap = syscon_early_regmap_lookup_by_phandle(np,
+			"samsung,syscon-phandle");
+	if (IS_ERR(pmu_data->pmu_regmap)) {
+		pr_err("failed to find exynos_pmu_regmap\n");
+		return PTR_ERR(pmu_data->pmu_regmap);
+	}
+
+	exynos_pmu_init();
+
 	return 0;
+};
+
+static int __init exynos_pmu_of_init(void)
+{
+	int ret = 0;
+	struct device_node *np;
+
+	for_each_matching_node_and_match(np, exynos_pmu_of_device_ids, NULL)
+		ret = exynos_pmu_probe(np);
+
+	return ret ? ret:0;
 }
-arch_initcall(exynos_pmu_init);
+arch_initcall(exynos_pmu_of_init);
-- 
1.7.10.4
