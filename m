From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Apr 2017 16:46:10 +0100
Subject: Applied "regulator: arizona-micsupp: Make arizona_micsupp independent
 of struct arizona" to the regulator tree
In-Reply-To: <1492512234-19210-5-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <E1d32fK-0001wu-UE@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: arizona-micsupp: Make arizona_micsupp independent of struct arizona

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

>From e165983e5102c953d68bd935048e95567564e438 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 18 Apr 2017 11:43:50 +0100
Subject: [PATCH] regulator: arizona-micsupp: Make arizona_micsupp independent
 of struct arizona

In preparation for supporting Madera codecs, remove the dependency on
struct arizona in the regulator callbacks and struct arizona_micsupp.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-micsupp.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index 5f8b5a713311..db4fecf228b7 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -34,7 +34,10 @@
 
 struct arizona_micsupp {
 	struct regulator_dev *regulator;
-	struct arizona *arizona;
+	struct regmap *regmap;
+	struct snd_soc_dapm_context **dapm;
+	unsigned int enable_reg;
+	struct device *dev;
 
 	struct regulator_consumer_supply supply;
 	struct regulator_init_data init_data;
@@ -46,21 +49,22 @@ static void arizona_micsupp_check_cp(struct work_struct *work)
 {
 	struct arizona_micsupp *micsupp =
 		container_of(work, struct arizona_micsupp, check_cp_work);
-	struct snd_soc_dapm_context *dapm = micsupp->arizona->dapm;
-	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
-	struct arizona *arizona = micsupp->arizona;
-	struct regmap *regmap = arizona->regmap;
-	unsigned int reg;
+	struct snd_soc_dapm_context *dapm = *micsupp->dapm;
+	struct snd_soc_component *component;
+	unsigned int val;
 	int ret;
 
-	ret = regmap_read(regmap, ARIZONA_MIC_CHARGE_PUMP_1, &reg);
+	ret = regmap_read(micsupp->regmap, micsupp->enable_reg, &val);
 	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to read CP state: %d\n", ret);
+		dev_err(micsupp->dev,
+			"Failed to read CP state: %d\n", ret);
 		return;
 	}
 
 	if (dapm) {
-		if ((reg & (ARIZONA_CPMIC_ENA | ARIZONA_CPMIC_BYPASS)) ==
+		component = snd_soc_dapm_to_component(dapm);
+
+		if ((val & (ARIZONA_CPMIC_ENA | ARIZONA_CPMIC_BYPASS)) ==
 		    ARIZONA_CPMIC_ENA)
 			snd_soc_component_force_enable_pin(component,
 							   "MICSUPP");
@@ -240,7 +244,9 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 	if (!micsupp)
 		return -ENOMEM;
 
-	micsupp->arizona = arizona;
+	micsupp->regmap = arizona->regmap;
+	micsupp->dapm = &arizona->dapm;
+	micsupp->dev = arizona->dev;
 	INIT_WORK(&micsupp->check_cp_work, arizona_micsupp_check_cp);
 
 	/*
@@ -263,6 +269,7 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 	micsupp->init_data.consumer_supplies = &micsupp->supply;
 	micsupp->supply.supply = "MICVDD";
 	micsupp->supply.dev_name = dev_name(arizona->dev);
+	micsupp->enable_reg = desc->enable_reg;
 
 	config.dev = arizona->dev;
 	config.driver_data = micsupp;
-- 
2.11.0
