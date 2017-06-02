From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri,  2 Jun 2017 16:51:13 +0800
Subject: [PATCH v2 2/6] mfd: hi6421-pmic: add support for HiSilicon Hi6421v530
In-Reply-To: <20170602085117.27474-1-guodong.xu@linaro.org>
References: <20170602085117.27474-1-guodong.xu@linaro.org>
Message-ID: <20170602085117.27474-3-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for HiSilicon Hi6421v530 PMIC. Hi6421v530 communicates with
main SoC via memory-mapped I/O.

Hi6421v530 and Hi6421 are PMIC chips from the same vendor, HiSilicon,
but at different revisions. They share the same memory-mapped I/O
design. They differ in integrated devices, such as regulator details,
LDO voltage points.

Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/mfd/hi6421-pmic-core.c  | 56 +++++++++++++++++++++++++++++++----------
 include/linux/mfd/hi6421-pmic.h |  5 ++++
 2 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
index 3fd703f..6d40485 100644
--- a/drivers/mfd/hi6421-pmic-core.c
+++ b/drivers/mfd/hi6421-pmic-core.c
@@ -26,7 +26,7 @@
 #include <linux/err.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/mfd/hi6421-pmic.h>
@@ -35,6 +35,10 @@ static const struct mfd_cell hi6421_devs[] = {
 	{ .name = "hi6421-regulator", },
 };
 
+static const struct mfd_cell hi6421v530_devs[] = {
+	{ .name = "hi6421v530-regulator", },
+};
+
 static const struct regmap_config hi6421_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -42,12 +46,30 @@ static const struct regmap_config hi6421_regmap_config = {
 	.max_register = HI6421_REG_TO_BUS_ADDR(HI6421_REG_MAX),
 };
 
+static const struct of_device_id of_hi6421_pmic_match_tbl[] = {
+	{ .compatible = "hisilicon,hi6421-pmic",
+					.data = (void *)HI6421 },
+	{ .compatible = "hisilicon,hi6421v530-pmic",
+					.data = (void *)HI6421_V530 },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_hi6421_pmic_match_tbl);
+
 static int hi6421_pmic_probe(struct platform_device *pdev)
 {
 	struct hi6421_pmic *pmic;
 	struct resource *res;
 	void __iomem *base;
-	int ret;
+	const struct of_device_id *id;
+	unsigned long type;
+	const struct mfd_cell *subdevs = NULL;
+	int n_subdevs, ret;
+
+	id = of_match_device(of_hi6421_pmic_match_tbl, &pdev->dev);
+	if (id)
+		type = (unsigned long)id->data;
+	else
+		return -EINVAL;
 
 	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
@@ -66,18 +88,32 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
 		return PTR_ERR(pmic->regmap);
 	}
 
-	/* set over-current protection debounce 8ms */
-	regmap_update_bits(pmic->regmap, HI6421_OCP_DEB_CTRL_REG,
+	platform_set_drvdata(pdev, pmic);
+
+	switch (type) {
+	case HI6421:
+		/* set over-current protection debounce 8ms */
+		regmap_update_bits(pmic->regmap, HI6421_OCP_DEB_CTRL_REG,
 				(HI6421_OCP_DEB_SEL_MASK
 				 | HI6421_OCP_EN_DEBOUNCE_MASK
 				 | HI6421_OCP_AUTO_STOP_MASK),
 				(HI6421_OCP_DEB_SEL_8MS
 				 | HI6421_OCP_EN_DEBOUNCE_ENABLE));
 
-	platform_set_drvdata(pdev, pmic);
+		subdevs = hi6421_devs;
+		n_subdevs = ARRAY_SIZE(hi6421_devs);
+		break;
+	case HI6421_V530:
+		subdevs = hi6421v530_devs;
+		n_subdevs = ARRAY_SIZE(hi6421v530_devs);
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown device type %ld\n", type);
+		return -EINVAL;
+	}
 
-	ret = devm_mfd_add_devices(&pdev->dev, 0, hi6421_devs,
-				   ARRAY_SIZE(hi6421_devs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(&pdev->dev, 0, subdevs,
+				   n_subdevs, NULL, 0, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "add mfd devices failed: %d\n", ret);
 		return ret;
@@ -86,12 +122,6 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id of_hi6421_pmic_match_tbl[] = {
-	{ .compatible = "hisilicon,hi6421-pmic", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, of_hi6421_pmic_match_tbl);
-
 static struct platform_driver hi6421_pmic_driver = {
 	.driver = {
 		.name	= "hi6421_pmic",
diff --git a/include/linux/mfd/hi6421-pmic.h b/include/linux/mfd/hi6421-pmic.h
index 587273e..2457438 100644
--- a/include/linux/mfd/hi6421-pmic.h
+++ b/include/linux/mfd/hi6421-pmic.h
@@ -38,4 +38,9 @@ struct hi6421_pmic {
 	struct regmap		*regmap;
 };
 
+enum hi6421_type {
+	HI6421      = 1,
+	HI6421_V530 = 2,
+};
+
 #endif		/* __HI6421_PMIC_H */
-- 
2.10.2
