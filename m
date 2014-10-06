From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 06 Oct 2014 14:56:41 +0530
Subject: [PATCH v9 1/2] ARM: EXYNOS: Add platform driver support for Exynos PMU
In-Reply-To: <1412587602-7763-1-git-send-email-pankaj.dubey@samsung.com>
References: <1412587602-7763-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1412587602-7763-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies Exynos Power Management Unit (PMU) initialization
implementation in following way:

- Added platform driver support for Exynos PMU IP.
- Added platform struct exynos_pmu_data to hold platform specific data.
- For each SoC's PMU support now we can add platform data and statically
  bind PMU configuration and SoC specific initialization function.
- Separate each SoC's PMU initialization function and make it as part of
  platform data.
- It also removes uses of soc_is_exynosXYZ().

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    1 +
 arch/arm/mach-exynos/pmu.c   |  171 +++++++++++++++++++++++++++++++-----------
 2 files changed, 130 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 46f3c0d..0ca168e 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -24,6 +24,7 @@ menuconfig ARCH_EXYNOS
 	select PM_GENERIC_DOMAINS if PM_RUNTIME
 	select S5P_DEV_MFC
 	select SRAM
+	select MFD_SYSCON
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index cfc62e8..1f5aaa7 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * EXYNOS - CPU PMU(Power Management Unit) support
@@ -10,12 +10,26 @@
  */
 
 #include <linux/io.h>
-#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include "common.h"
 #include "regs-pmu.h"
 
-static const struct exynos_pmu_conf *exynos_pmu_config;
+struct exynos_pmu_data {
+	const struct exynos_pmu_conf *pmu_config;
+	const struct exynos_pmu_conf *pmu_config_extra;
+
+	void (*pmu_init)(void);
+	void (*powerdown_conf)(enum sys_powerdown);
+};
+
+struct exynos_pmu_context {
+	struct device *dev;
+	const struct exynos_pmu_data *pmu_data;
+};
+
+static struct exynos_pmu_context *pmu_context;
 
 static const struct exynos_pmu_conf exynos4210_pmu_config[] = {
 	/* { .offset = offset, .val = { AFTR, LPA, SLEEP } */
@@ -336,7 +350,7 @@ static unsigned int const exynos5_list_diable_wfi_wfe[] = {
 	EXYNOS5_ISP_ARM_OPTION,
 };
 
-static void exynos5_init_pmu(void)
+static void exynos5_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
 	unsigned int tmp;
@@ -344,7 +358,7 @@ static void exynos5_init_pmu(void)
 	/*
 	 * Enable both SC_FEEDBACK and SC_COUNTER
 	 */
-	for (i = 0 ; i < ARRAY_SIZE(exynos5_list_both_cnt_feed) ; i++) {
+	for (i = 0; i < ARRAY_SIZE(exynos5_list_both_cnt_feed); i++) {
 		tmp = pmu_raw_readl(exynos5_list_both_cnt_feed[i]);
 		tmp |= (EXYNOS5_USE_SC_FEEDBACK |
 			EXYNOS5_USE_SC_COUNTER);
@@ -361,7 +375,7 @@ static void exynos5_init_pmu(void)
 	/*
 	 * Disable WFI/WFE on XXX_OPTION
 	 */
-	for (i = 0 ; i < ARRAY_SIZE(exynos5_list_diable_wfi_wfe) ; i++) {
+	for (i = 0; i < ARRAY_SIZE(exynos5_list_diable_wfi_wfe); i++) {
 		tmp = pmu_raw_readl(exynos5_list_diable_wfi_wfe[i]);
 		tmp &= ~(EXYNOS5_OPTION_USE_STANDBYWFE |
 			 EXYNOS5_OPTION_USE_STANDBYWFI);
@@ -373,51 +387,124 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
 
-	if (soc_is_exynos5250())
-		exynos5_init_pmu();
+	const struct exynos_pmu_data *pmu_data = pmu_context->pmu_data;
 
-	for (i = 0; (exynos_pmu_config[i].offset != PMU_TABLE_END) ; i++)
-		pmu_raw_writel(exynos_pmu_config[i].val[mode],
-				exynos_pmu_config[i].offset);
+	if (pmu_data->powerdown_conf)
+		pmu_data->powerdown_conf(mode);
 
-	if (soc_is_exynos4412()) {
-		for (i = 0; exynos4412_pmu_config[i].offset != PMU_TABLE_END ; i++)
-			pmu_raw_writel(exynos4412_pmu_config[i].val[mode],
-					exynos4412_pmu_config[i].offset);
+	if (pmu_data->pmu_config) {
+		for (i = 0; (pmu_data->pmu_config[i].offset != PMU_TABLE_END); i++)
+			pmu_raw_writel(pmu_data->pmu_config[i].val[mode],
+					pmu_data->pmu_config[i].offset);
+	}
+
+	if (pmu_data->pmu_config_extra) {
+		for (i = 0; pmu_data->pmu_config_extra[i].offset != PMU_TABLE_END; i++)
+			pmu_raw_writel(pmu_data->pmu_config_extra[i].val[mode],
+					pmu_data->pmu_config_extra[i].offset);
 	}
 }
 
-static int __init exynos_pmu_init(void)
+static void exynos5250_pmu_init(void)
 {
 	unsigned int value;
+	/*
+	 * When SYS_WDTRESET is set, watchdog timer reset request
+	 * is ignored by power management unit.
+	 */
+	value = pmu_raw_readl(EXYNOS5_AUTO_WDTRESET_DISABLE);
+	value &= ~EXYNOS5_SYS_WDTRESET;
+	pmu_raw_writel(value, EXYNOS5_AUTO_WDTRESET_DISABLE);
+
+	value = pmu_raw_readl(EXYNOS5_MASK_WDTRESET_REQUEST);
+	value &= ~EXYNOS5_SYS_WDTRESET;
+	pmu_raw_writel(value, EXYNOS5_MASK_WDTRESET_REQUEST);
+}
+
+static const struct exynos_pmu_data exynos4210_pmu_data = {
+	.pmu_config	= exynos4210_pmu_config,
+};
+
+static const struct exynos_pmu_data exynos4212_pmu_data = {
+	.pmu_config	= exynos4x12_pmu_config,
+};
+
+static const struct exynos_pmu_data exynos4412_pmu_data = {
+	.pmu_config		= exynos4x12_pmu_config,
+	.pmu_config_extra	= exynos4412_pmu_config,
+};
+
+static const struct exynos_pmu_data exynos5250_pmu_data = {
+	.pmu_config	= exynos5250_pmu_config,
+	.pmu_init	= exynos5250_pmu_init,
+	.powerdown_conf	= exynos5_powerdown_conf,
+};
+
+/*
+ * PMU platform driver and devicetree bindings.
+ */
+static const struct of_device_id exynos_pmu_of_device_ids[] = {
+	{
+		.compatible = "samsung,exynos4210-pmu",
+		.data = &exynos4210_pmu_data,
+	}, {
+		.compatible = "samsung,exynos4212-pmu",
+		.data = &exynos4212_pmu_data,
+	}, {
+		.compatible = "samsung,exynos4412-pmu",
+		.data = &exynos4412_pmu_data,
+	}, {
+		.compatible = "samsung,exynos5250-pmu",
+		.data = &exynos5250_pmu_data,
+	},
+	{ /*sentinel*/ },
+};
 
-	exynos_pmu_config = exynos4210_pmu_config;
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
-		value = pmu_raw_readl(EXYNOS5_AUTO_WDTRESET_DISABLE);
-		value &= ~EXYNOS5_SYS_WDTRESET;
-		pmu_raw_writel(value, EXYNOS5_AUTO_WDTRESET_DISABLE);
-
-		value = pmu_raw_readl(EXYNOS5_MASK_WDTRESET_REQUEST);
-		value &= ~EXYNOS5_SYS_WDTRESET;
-		pmu_raw_writel(value, EXYNOS5_MASK_WDTRESET_REQUEST);
-
-		exynos_pmu_config = exynos5250_pmu_config;
-		pr_info("EXYNOS5250 PMU Initialize\n");
-	} else {
-		pr_info("EXYNOS: PMU not supported\n");
+static int exynos_pmu_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pmu_base_addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pmu_base_addr))
+		return PTR_ERR(pmu_base_addr);
+
+	pmu_context = devm_kzalloc(&pdev->dev,
+			sizeof(struct exynos_pmu_context),
+			GFP_KERNEL);
+	if (!pmu_context) {
+		dev_err(dev, "Cannot allocate memory.\n");
+		return -ENOMEM;
 	}
+	pmu_context->dev = dev;
+
+	match = of_match_node(exynos_pmu_of_device_ids, dev->of_node);
+
+	pmu_context->pmu_data = match->data;
 
+	if (pmu_context->pmu_data->pmu_init)
+		pmu_context->pmu_data->pmu_init();
+
+	platform_set_drvdata(pdev, pmu_context);
+
+	dev_dbg(dev, "Exynos PMU Driver probe done\n");
 	return 0;
 }
-arch_initcall(exynos_pmu_init);
+
+static struct platform_driver exynos_pmu_driver = {
+	.driver  = {
+		.name   = "exynos-pmu",
+		.owner	= THIS_MODULE,
+		.of_match_table = exynos_pmu_of_device_ids,
+	},
+	.probe = exynos_pmu_probe,
+};
+
+static int __init exynos_pmu_init(void)
+{
+	return platform_driver_register(&exynos_pmu_driver);
+
+}
+postcore_initcall(exynos_pmu_init);
-- 
1.7.9.5
