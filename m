From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Apr 2017 16:46:07 +0100
Subject: Applied "regulator: arizona-micsupp: Factor out generic
 initialization" to the regulator tree
In-Reply-To: <1492512234-19210-6-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <E1d32fH-0001vf-Tc@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: arizona-micsupp: Factor out generic initialization

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

>From 7d8d14b51921cbfe082a796e55c22d0c1dd8fc26 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 18 Apr 2017 11:43:51 +0100
Subject: [PATCH] regulator: arizona-micsupp: Factor out generic initialization

In preparation for sharing this driver with Madera codecs, factor out
the parts of initialization that aren't dependent on struct arizona.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-micsupp.c | 82 +++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index db4fecf228b7..120de94caf02 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -231,52 +231,27 @@ static int arizona_micsupp_of_get_pdata(struct arizona_micsupp_pdata *pdata,
 	return 0;
 }
 
-static int arizona_micsupp_probe(struct platform_device *pdev)
+static int arizona_micsupp_common_init(struct platform_device *pdev,
+				       struct arizona_micsupp *micsupp,
+				       const struct regulator_desc *desc,
+				       struct arizona_micsupp_pdata *pdata)
 {
-	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
-	const struct regulator_desc *desc;
 	struct regulator_config config = { };
-	struct arizona_micsupp_pdata *pdata = &arizona->pdata.micvdd;
-	struct arizona_micsupp *micsupp;
 	int ret;
 
-	micsupp = devm_kzalloc(&pdev->dev, sizeof(*micsupp), GFP_KERNEL);
-	if (!micsupp)
-		return -ENOMEM;
-
-	micsupp->regmap = arizona->regmap;
-	micsupp->dapm = &arizona->dapm;
-	micsupp->dev = arizona->dev;
 	INIT_WORK(&micsupp->check_cp_work, arizona_micsupp_check_cp);
 
-	/*
-	 * Since the chip usually supplies itself we provide some
-	 * default init_data for it.  This will be overridden with
-	 * platform data if provided.
-	 */
-	switch (arizona->type) {
-	case WM5110:
-	case WM8280:
-		desc = &arizona_micsupp_ext;
-		micsupp->init_data = arizona_micsupp_ext_default;
-		break;
-	default:
-		desc = &arizona_micsupp;
-		micsupp->init_data = arizona_micsupp_default;
-		break;
-	}
-
 	micsupp->init_data.consumer_supplies = &micsupp->supply;
 	micsupp->supply.supply = "MICVDD";
-	micsupp->supply.dev_name = dev_name(arizona->dev);
+	micsupp->supply.dev_name = dev_name(micsupp->dev);
 	micsupp->enable_reg = desc->enable_reg;
 
-	config.dev = arizona->dev;
+	config.dev = micsupp->dev;
 	config.driver_data = micsupp;
-	config.regmap = arizona->regmap;
+	config.regmap = micsupp->regmap;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		if (!dev_get_platdata(arizona->dev)) {
+		if (!dev_get_platdata(micsupp->dev)) {
 			ret = arizona_micsupp_of_get_pdata(pdata, &config,
 							   desc);
 			if (ret < 0)
@@ -289,8 +264,8 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 	else
 		config.init_data = &micsupp->init_data;
 
-	/* Default to regulated mode until the API supports bypass */
-	regmap_update_bits(arizona->regmap, ARIZONA_MIC_CHARGE_PUMP_1,
+	/* Default to regulated mode */
+	regmap_update_bits(micsupp->regmap, micsupp->enable_reg,
 			   ARIZONA_CPMIC_BYPASS, 0);
 
 	micsupp->regulator = devm_regulator_register(&pdev->dev,
@@ -301,7 +276,7 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 
 	if (IS_ERR(micsupp->regulator)) {
 		ret = PTR_ERR(micsupp->regulator);
-		dev_err(arizona->dev, "Failed to register mic supply: %d\n",
+		dev_err(micsupp->dev, "Failed to register mic supply: %d\n",
 			ret);
 		return ret;
 	}
@@ -311,6 +286,41 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int arizona_micsupp_probe(struct platform_device *pdev)
+{
+	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
+	const struct regulator_desc *desc;
+	struct arizona_micsupp *micsupp;
+
+	micsupp = devm_kzalloc(&pdev->dev, sizeof(*micsupp), GFP_KERNEL);
+	if (!micsupp)
+		return -ENOMEM;
+
+	micsupp->regmap = arizona->regmap;
+	micsupp->dapm = &arizona->dapm;
+	micsupp->dev = arizona->dev;
+
+	/*
+	 * Since the chip usually supplies itself we provide some
+	 * default init_data for it.  This will be overridden with
+	 * platform data if provided.
+	 */
+	switch (arizona->type) {
+	case WM5110:
+	case WM8280:
+		desc = &arizona_micsupp_ext;
+		micsupp->init_data = arizona_micsupp_ext_default;
+		break;
+	default:
+		desc = &arizona_micsupp;
+		micsupp->init_data = arizona_micsupp_default;
+		break;
+	}
+
+	return arizona_micsupp_common_init(pdev, micsupp, desc,
+					   &arizona->pdata.micvdd);
+}
+
 static struct platform_driver arizona_micsupp_driver = {
 	.probe = arizona_micsupp_probe,
 	.driver		= {
-- 
2.11.0
