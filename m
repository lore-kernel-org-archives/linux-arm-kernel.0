From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Apr 2017 16:45:59 +0100
Subject: Applied "regulator: arizona-ldo1: Factor out generic initialization"
 to the regulator tree
In-Reply-To: <1492512234-19210-9-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <E1d32f9-0001oK-3Q@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: arizona-ldo1: Factor out generic initialization

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

>From af367afafb5ba7ae26defd35e4ba42cfe157ef72 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 18 Apr 2017 11:43:54 +0100
Subject: [PATCH] regulator: arizona-ldo1: Factor out generic initialization

In preparation for sharing this driver with Madera codecs, factor out
the parts of initialization that aren't dependent on struct arizona.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c | 114 ++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 48 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 678f81fda22a..96fddfff5dc4 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -234,67 +234,40 @@ static int arizona_ldo1_of_get_pdata(struct arizona_ldo1_pdata *pdata,
 	return 0;
 }
 
-static int arizona_ldo1_probe(struct platform_device *pdev)
+static int arizona_ldo1_common_init(struct platform_device *pdev,
+				    struct arizona_ldo1 *ldo1,
+				    const struct regulator_desc *desc,
+				    struct arizona_ldo1_pdata *pdata,
+				    bool *external_dcvdd)
 {
-	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
-	const struct regulator_desc *desc;
+	struct device *parent_dev = pdev->dev.parent;
 	struct regulator_config config = { };
-	struct arizona_ldo1 *ldo1;
-	bool external_dcvdd = false;
 	int ret;
 
-	ldo1 = devm_kzalloc(&pdev->dev, sizeof(*ldo1), GFP_KERNEL);
-	if (!ldo1)
-		return -ENOMEM;
-
-	ldo1->regmap = arizona->regmap;
-
-	/*
-	 * Since the chip usually supplies itself we provide some
-	 * default init_data for it.  This will be overridden with
-	 * platform data if provided.
-	 */
-	switch (arizona->type) {
-	case WM5102:
-	case WM8997:
-	case WM8998:
-	case WM1814:
-		desc = &arizona_ldo1_hc;
-		ldo1->init_data = arizona_ldo1_dvfs;
-		break;
-	case WM5110:
-	case WM8280:
-		desc = &arizona_ldo1;
-		ldo1->init_data = arizona_ldo1_wm5110;
-		break;
-	default:
-		desc = &arizona_ldo1;
-		ldo1->init_data = arizona_ldo1_default;
-		break;
-	}
+	*external_dcvdd = false;
 
-	ldo1->init_data.consumer_supplies = &ldo1->supply;
 	ldo1->supply.supply = "DCVDD";
-	ldo1->supply.dev_name = dev_name(arizona->dev);
+	ldo1->init_data.consumer_supplies = &ldo1->supply;
+	ldo1->supply.dev_name = dev_name(parent_dev);
 
-	config.dev = arizona->dev;
+	config.dev = parent_dev;
 	config.driver_data = ldo1;
-	config.regmap = arizona->regmap;
+	config.regmap = ldo1->regmap;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		if (!dev_get_platdata(arizona->dev)) {
-			ret = arizona_ldo1_of_get_pdata(&arizona->pdata.ldo1,
+		if (!dev_get_platdata(parent_dev)) {
+			ret = arizona_ldo1_of_get_pdata(pdata,
 							&config, desc,
-							&external_dcvdd);
+							external_dcvdd);
 			if (ret < 0)
 				return ret;
 		}
 	}
 
-	config.ena_gpio = arizona->pdata.ldo1.ldoena;
+	config.ena_gpio = pdata->ldoena;
 
-	if (arizona->pdata.ldo1.init_data)
-		config.init_data = arizona->pdata.ldo1.init_data;
+	if (pdata->init_data)
+		config.init_data = pdata->init_data;
 	else
 		config.init_data = &ldo1->init_data;
 
@@ -303,9 +276,7 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	 * consumers then DCVDD is supplied externally.
 	 */
 	if (config.init_data->num_consumer_supplies == 0)
-		arizona->external_dcvdd = true;
-	else
-		arizona->external_dcvdd = external_dcvdd;
+		*external_dcvdd = true;
 
 	ldo1->regulator = devm_regulator_register(&pdev->dev, desc, &config);
 
@@ -313,7 +284,7 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 
 	if (IS_ERR(ldo1->regulator)) {
 		ret = PTR_ERR(ldo1->regulator);
-		dev_err(arizona->dev, "Failed to register LDO1 supply: %d\n",
+		dev_err(&pdev->dev, "Failed to register LDO1 supply: %d\n",
 			ret);
 		return ret;
 	}
@@ -323,6 +294,53 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int arizona_ldo1_probe(struct platform_device *pdev)
+{
+	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
+	struct arizona_ldo1 *ldo1;
+	const struct regulator_desc *desc;
+	bool external_dcvdd;
+	int ret;
+
+	ldo1 = devm_kzalloc(&pdev->dev, sizeof(*ldo1), GFP_KERNEL);
+	if (!ldo1)
+		return -ENOMEM;
+
+	ldo1->regmap = arizona->regmap;
+
+	/*
+	 * Since the chip usually supplies itself we provide some
+	 * default init_data for it.  This will be overridden with
+	 * platform data if provided.
+	 */
+	switch (arizona->type) {
+	case WM5102:
+	case WM8997:
+	case WM8998:
+	case WM1814:
+		desc = &arizona_ldo1_hc;
+		ldo1->init_data = arizona_ldo1_dvfs;
+		break;
+	case WM5110:
+	case WM8280:
+		desc = &arizona_ldo1;
+		ldo1->init_data = arizona_ldo1_wm5110;
+		break;
+	default:
+		desc = &arizona_ldo1;
+		ldo1->init_data = arizona_ldo1_default;
+		break;
+	}
+
+	ret = arizona_ldo1_common_init(pdev, ldo1, desc,
+				       &arizona->pdata.ldo1,
+				       &external_dcvdd);
+	if (ret == 0)
+		arizona->external_dcvdd = external_dcvdd;
+
+	return ret;
+}
+
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
 	.driver		= {
-- 
2.11.0
