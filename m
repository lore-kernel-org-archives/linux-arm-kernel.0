From: w.egorov@phytec.de (Wadim Egorov)
Date: Fri, 15 Apr 2016 11:16:27 +0200
Subject: [PATCH 3/6] regulator: rk808: Make rk808 generic,
 rename rk808-regulator.c
In-Reply-To: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
References: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
Message-ID: <1460711790-22646-4-git-send-email-w.egorov@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch just renames the rk808 driver so we can reuse this driver
to add more regulator devices from the RK8XX PMIC family later.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/configs/multi_v7_defconfig                |  2 +-
 drivers/mfd/rk8xx.c                                |  4 +--
 drivers/regulator/Kconfig                          |  4 +--
 drivers/regulator/Makefile                         |  2 +-
 .../{rk808-regulator.c => rk8xx-regulator.c}       | 36 +++++++++++-----------
 5 files changed, 24 insertions(+), 24 deletions(-)
 rename drivers/regulator/{rk808-regulator.c => rk8xx-regulator.c} (95%)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ca995e9..d774ba0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -474,7 +474,7 @@ CONFIG_REGULATOR_AXP20X=m
 CONFIG_REGULATOR_BCM590XX=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_FAN53555=y
-CONFIG_REGULATOR_RK808=y
+CONFIG_REGULATOR_RK8XX=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_MFD_SYSCON=y
 CONFIG_POWER_RESET_SYSCON=y
diff --git a/drivers/mfd/rk8xx.c b/drivers/mfd/rk8xx.c
index 57fee1e..c7990fb 100644
--- a/drivers/mfd/rk8xx.c
+++ b/drivers/mfd/rk8xx.c
@@ -82,7 +82,7 @@ static struct resource rtc_resources[] = {
 
 static const struct mfd_cell rk808s[] = {
 	{ .name = "rk808-clkout", },
-	{ .name = "rk808-regulator", },
+	{ .name = "rk8xx-regulator", },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
@@ -92,7 +92,7 @@ static const struct mfd_cell rk808s[] = {
 
 static const struct mfd_cell rk818s[] = {
 	{ .name = "rk808-clkout", },
-	{ .name = "rk808-regulator", },
+	{ .name = "rk8xx-regulator", },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index f834079..c5b525b 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -608,8 +608,8 @@ config REGULATOR_RC5T583
 	  through regulator interface. The device supports multiple DCDC/LDO
 	  outputs which can be controlled by i2c communication.
 
-config REGULATOR_RK808
-	tristate "Rockchip RK808 Power regulators"
+config REGULATOR_RK8XX
+	tristate "Rockchip RK8XX Power regulators"
 	depends on MFD_RK8XX
 	help
 	  Select this option to enable the power regulator of ROCKCHIP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 61bfbb9..5d6ffed 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_REGULATOR_PBIAS) += pbias-regulator.o
 obj-$(CONFIG_REGULATOR_PCAP) += pcap-regulator.o
 obj-$(CONFIG_REGULATOR_PCF50633) += pcf50633-regulator.o
 obj-$(CONFIG_REGULATOR_RC5T583)  += rc5t583-regulator.o
-obj-$(CONFIG_REGULATOR_RK808)   += rk808-regulator.o
+obj-$(CONFIG_REGULATOR_RK8XX)   += rk8xx-regulator.o
 obj-$(CONFIG_REGULATOR_RN5T618) += rn5t618-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk8xx-regulator.c
similarity index 95%
rename from drivers/regulator/rk808-regulator.c
rename to drivers/regulator/rk8xx-regulator.c
index d86a3dc..fc75957 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk8xx-regulator.c
@@ -1,5 +1,5 @@
 /*
- * Regulator driver for Rockchip RK808
+ * Regulator driver for Rockchip's RK8XX PMIC family
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  *
@@ -523,7 +523,7 @@ static struct of_regulator_match rk808_reg_matches[] = {
 	[RK808_ID_SWITCH2]	= { .name = "SWITCH_REG2" },
 };
 
-static int rk808_regulator_dt_parse_pdata(struct device *dev,
+static int rk8xx_regulator_dt_parse_pdata(struct device *dev,
 				   struct device *client_dev,
 				   struct regmap *map,
 				   struct rk808_regulator_data *pdata)
@@ -566,12 +566,12 @@ dt_parse_end:
 	return ret;
 }
 
-static int rk808_regulator_probe(struct platform_device *pdev)
+static int rk8xx_regulator_probe(struct platform_device *pdev)
 {
-	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
-	struct i2c_client *client = rk808->i2c;
+	struct rk808 *rk8xx = dev_get_drvdata(pdev->dev.parent);
+	struct i2c_client *client = rk8xx->i2c;
 	struct regulator_config config = {};
-	struct regulator_dev *rk808_rdev;
+	struct regulator_dev *rk8xx_rdev;
 	struct rk808_regulator_data *pdata;
 	int ret, i;
 
@@ -579,8 +579,8 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	ret = rk808_regulator_dt_parse_pdata(&pdev->dev, &client->dev,
-					     rk808->regmap, pdata);
+	ret = rk8xx_regulator_dt_parse_pdata(&pdev->dev, &client->dev,
+					     rk8xx->regmap, pdata);
 	if (ret < 0)
 		return ret;
 
@@ -594,34 +594,34 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 
 		config.dev = &client->dev;
 		config.driver_data = pdata;
-		config.regmap = rk808->regmap;
+		config.regmap = rk8xx->regmap;
 		config.of_node = rk808_reg_matches[i].of_node;
 		config.init_data = rk808_reg_matches[i].init_data;
 
-		rk808_rdev = devm_regulator_register(&pdev->dev,
+		rk8xx_rdev = devm_regulator_register(&pdev->dev,
 						     &rk808_reg[i], &config);
-		if (IS_ERR(rk808_rdev)) {
+		if (IS_ERR(rk8xx_rdev)) {
 			dev_err(&client->dev,
 				"failed to register %d regulator\n", i);
-			return PTR_ERR(rk808_rdev);
+			return PTR_ERR(rk8xx_rdev);
 		}
 	}
 
 	return 0;
 }
 
-static struct platform_driver rk808_regulator_driver = {
-	.probe = rk808_regulator_probe,
+static struct platform_driver rk8xx_regulator_driver = {
+	.probe = rk8xx_regulator_probe,
 	.driver = {
-		.name = "rk808-regulator",
+		.name = "rk8xx-regulator",
 		.owner = THIS_MODULE,
 	},
 };
 
-module_platform_driver(rk808_regulator_driver);
+module_platform_driver(rk8xx_regulator_driver);
 
-MODULE_DESCRIPTION("regulator driver for the rk808 series PMICs");
+MODULE_DESCRIPTION("regulator driver for the rk8xx series PMICs");
 MODULE_AUTHOR("Chris Zhong<zyw@rock-chips.com>");
 MODULE_AUTHOR("Zhang Qing<zhangqing@rock-chips.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:rk808-regulator");
+MODULE_ALIAS("platform:rk8xx-regulator");
-- 
1.9.1
