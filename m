From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Apr 2017 16:46:04 +0100
Subject: Applied "regulator: arizona-ldo1: Move pdata into a separate
 structure" to the regulator tree
In-Reply-To: <1492512234-19210-7-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <E1d32fE-0001tP-VM@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: arizona-ldo1: Move pdata into a separate structure

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From aaa84e6a0399df374634c42590e644a698fcc3ff Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 18 Apr 2017 11:43:52 +0100
Subject: [PATCH] regulator: arizona-ldo1: Move pdata into a separate structure

In preparation for sharing this driver with Madera, move the pdata
for the LDO1 regulator out of struct arizona_pdata into a dedicated
pdata struct for this driver. As a result the code in
arizona_ldo1_of_get_pdata() can be made independent of struct arizona.

This patch also updates the definition of struct arizona_pdata and
the use of this pdata in mach-crag6410-module.c

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |  8 ++++--
 drivers/regulator/arizona-ldo1.c             | 39 +++++++++++++++-------------
 include/linux/mfd/arizona/pdata.h            |  4 +--
 include/linux/regulator/arizona-ldo1.h       | 24 +++++++++++++++++
 4 files changed, 53 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/regulator/arizona-ldo1.h

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index ccc3ab8d58e7..ea5f2169c850 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -209,7 +209,9 @@ static const struct i2c_board_info wm1277_devs[] = {
 };
 
 static struct arizona_pdata wm5102_reva_pdata = {
-	.ldoena = S3C64XX_GPN(7),
+	.ldo1 = {
+		.ldoena = S3C64XX_GPN(7),
+	},
 	.gpio_base = CODEC_GPIO_BASE,
 	.irq_flags = IRQF_TRIGGER_HIGH,
 	.micd_pol_gpio = CODEC_GPIO_BASE + 4,
@@ -239,7 +241,9 @@ static struct spi_board_info wm5102_reva_spi_devs[] = {
 };
 
 static struct arizona_pdata wm5102_pdata = {
-	.ldoena = S3C64XX_GPN(7),
+	.ldo1 = {
+		.ldoena = S3C64XX_GPN(7),
+	},
 	.gpio_base = CODEC_GPIO_BASE,
 	.irq_flags = IRQF_TRIGGER_HIGH,
 	.micd_pol_gpio = CODEC_GPIO_BASE + 2,
diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index b726fa17f7b2..f5bc75ab85fa 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -25,6 +25,8 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 
+#include <linux/regulator/arizona-ldo1.h>
+
 #include <linux/mfd/arizona/core.h>
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
@@ -186,20 +188,19 @@ static const struct regulator_init_data arizona_ldo1_wm5110 = {
 	.num_consumer_supplies = 1,
 };
 
-static int arizona_ldo1_of_get_pdata(struct device *dev,
-				     struct arizona *arizona,
+static int arizona_ldo1_of_get_pdata(struct arizona_ldo1_pdata *pdata,
 				     struct regulator_config *config,
-				     const struct regulator_desc *desc)
+				     const struct regulator_desc *desc,
+				     bool *external_dcvdd)
 {
-	struct arizona_pdata *pdata = &arizona->pdata;
 	struct arizona_ldo1 *ldo1 = config->driver_data;
-	struct device_node *np = arizona->dev->of_node;
+	struct device_node *np = config->dev->of_node;
 	struct device_node *init_node, *dcvdd_node;
 	struct regulator_init_data *init_data;
 
 	pdata->ldoena = of_get_named_gpio(np, "wlf,ldoena", 0);
 	if (pdata->ldoena < 0) {
-		dev_warn(arizona->dev,
+		dev_warn(config->dev,
 			 "LDOENA GPIO property missing/malformed: %d\n",
 			 pdata->ldoena);
 		pdata->ldoena = 0;
@@ -213,19 +214,19 @@ static int arizona_ldo1_of_get_pdata(struct device *dev,
 	if (init_node) {
 		config->of_node = init_node;
 
-		init_data = of_get_regulator_init_data(dev, init_node, desc);
-
+		init_data = of_get_regulator_init_data(config->dev, init_node,
+						       desc);
 		if (init_data) {
 			init_data->consumer_supplies = &ldo1->supply;
 			init_data->num_consumer_supplies = 1;
 
 			if (dcvdd_node && dcvdd_node != init_node)
-				arizona->external_dcvdd = true;
+				*external_dcvdd = true;
 
-			pdata->ldo1 = init_data;
+			pdata->init_data = init_data;
 		}
 	} else if (dcvdd_node) {
-		arizona->external_dcvdd = true;
+		*external_dcvdd = true;
 	}
 
 	of_node_put(dcvdd_node);
@@ -239,10 +240,9 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	const struct regulator_desc *desc;
 	struct regulator_config config = { };
 	struct arizona_ldo1 *ldo1;
+	bool external_dcvdd = false;
 	int ret;
 
-	arizona->external_dcvdd = false;
-
 	ldo1 = devm_kzalloc(&pdev->dev, sizeof(*ldo1), GFP_KERNEL);
 	if (!ldo1)
 		return -ENOMEM;
@@ -283,17 +283,18 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_OF)) {
 		if (!dev_get_platdata(arizona->dev)) {
-			ret = arizona_ldo1_of_get_pdata(&pdev->dev, arizona,
-							&config, desc);
+			ret = arizona_ldo1_of_get_pdata(&arizona->pdata.ldo1,
+							&config, desc,
+							&external_dcvdd);
 			if (ret < 0)
 				return ret;
 		}
 	}
 
-	config.ena_gpio = arizona->pdata.ldoena;
+	config.ena_gpio = arizona->pdata.ldo1.ldoena;
 
-	if (arizona->pdata.ldo1)
-		config.init_data = arizona->pdata.ldo1;
+	if (arizona->pdata.ldo1.init_data)
+		config.init_data = arizona->pdata.ldo1.init_data;
 	else
 		config.init_data = &ldo1->init_data;
 
@@ -303,6 +304,8 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	 */
 	if (config.init_data->num_consumer_supplies == 0)
 		arizona->external_dcvdd = true;
+	else
+		arizona->external_dcvdd = external_dcvdd;
 
 	ldo1->regulator = devm_regulator_register(&pdev->dev, desc, &config);
 
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index 43e875f9850c..bfeecf179895 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -12,6 +12,7 @@
 #define _ARIZONA_PDATA_H
 
 #include <dt-bindings/mfd/arizona.h>
+#include <linux/regulator/arizona-ldo1.h>
 #include <linux/regulator/arizona-micsupp.h>
 
 #define ARIZONA_GPN_DIR_MASK                     0x8000  /* GPN_DIR */
@@ -77,13 +78,12 @@ struct arizona_micd_range {
 
 struct arizona_pdata {
 	int reset;      /** GPIO controlling /RESET, if any */
-	int ldoena;     /** GPIO controlling LODENA, if any */
 
 	/** Regulator configuration for MICVDD */
 	struct arizona_micsupp_pdata micvdd;
 
 	/** Regulator configuration for LDO1 */
-	struct regulator_init_data *ldo1;
+	struct arizona_ldo1_pdata ldo1;
 
 	/** If a direct 32kHz clock is provided on an MCLK specify it here */
 	int clk32k_src;
diff --git a/include/linux/regulator/arizona-ldo1.h b/include/linux/regulator/arizona-ldo1.h
new file mode 100644
index 000000000000..c685f1277c63
--- /dev/null
+++ b/include/linux/regulator/arizona-ldo1.h
@@ -0,0 +1,24 @@
+/*
+ * Platform data for Arizona LDO1 regulator
+ *
+ * Copyright 2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARIZONA_LDO1_H
+#define ARIZONA_LDO1_H
+
+struct regulator_init_data;
+
+struct arizona_ldo1_pdata {
+	/** GPIO controlling LDOENA, if any */
+	int ldoena;
+
+	/** Regulator configuration for LDO1 */
+	const struct regulator_init_data *init_data;
+};
+
+#endif
-- 
2.11.0
