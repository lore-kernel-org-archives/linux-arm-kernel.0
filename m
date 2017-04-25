From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Apr 2017 16:46:02 +0100
Subject: Applied "regulator: arizona-ldo1: Make arizona_ldo1 independent of
 struct arizona" to the regulator tree
In-Reply-To: <1492512234-19210-8-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <E1d32fC-0001qC-0e@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: arizona-ldo1: Make arizona_ldo1 independent of struct arizona

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

>From 80a55f41aef4ee808f53f1a356491d7eaeefdd3c Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 18 Apr 2017 11:43:53 +0100
Subject: [PATCH] regulator: arizona-ldo1: Make arizona_ldo1 independent of
 struct arizona

In preparation for supporting Madera codecs, remove the dependency on
struct arizona in the regulator callbacks and struct arizona_ldo1.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index f5bc75ab85fa..678f81fda22a 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -33,7 +33,7 @@
 
 struct arizona_ldo1 {
 	struct regulator_dev *regulator;
-	struct arizona *arizona;
+	struct regmap *regmap;
 
 	struct regulator_consumer_supply supply;
 	struct regulator_init_data init_data;
@@ -67,7 +67,7 @@ static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
 					   unsigned sel)
 {
 	struct arizona_ldo1 *ldo = rdev_get_drvdata(rdev);
-	struct regmap *regmap = ldo->arizona->regmap;
+	struct regmap *regmap = ldo->regmap;
 	unsigned int val;
 	int ret;
 
@@ -93,7 +93,7 @@ static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
 static int arizona_ldo1_hc_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct arizona_ldo1 *ldo = rdev_get_drvdata(rdev);
-	struct regmap *regmap = ldo->arizona->regmap;
+	struct regmap *regmap = ldo->regmap;
 	unsigned int val;
 	int ret;
 
@@ -247,7 +247,7 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	if (!ldo1)
 		return -ENOMEM;
 
-	ldo1->arizona = arizona;
+	ldo1->regmap = arizona->regmap;
 
 	/*
 	 * Since the chip usually supplies itself we provide some
-- 
2.11.0
