From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 16 Jul 2015 23:46:55 +0530
Subject: [PATCH 2/5] regulator: 88pm800: Update driver to use
 devm_regulator_register fn
In-Reply-To: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1437070618-21330-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces standard regulator_register with
devm_regulator_register() fn, as using devm_regulator_register() fn
simplifies the driver return/exit path.

As part of this update, patch also cleanups up all unnecessary changes
which is result of this patch -

  - Remove _remove() fn, as devm_ variant takes care of it.
  - Remove pm800_regulators.regulators[] field, as it was only
    needed during cleanup, so we no longer need this.
    This also saved some amount of memory.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/regulator/88pm800.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index 11f7ab2..3b37170 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -78,7 +78,6 @@ struct pm800_regulator_info {
 };
 
 struct pm800_regulators {
-	struct regulator_dev *regulators[PM800_ID_RG_MAX];
 	struct pm80x_chip *chip;
 	struct regmap *map;
 };
@@ -318,6 +317,8 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pm800_data);
 
 	for (i = 0; i < PM800_ID_RG_MAX; i++) {
+		struct regulator_dev *regulator;
+
 		if (!pdata || pdata->num_regulators == 0)
 			init_data = pm800_regulator_matches[i].init_data;
 		else
@@ -331,16 +332,12 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 		config.regmap = pm800_data->map;
 		config.of_node = pm800_regulator_matches[i].of_node;
 
-		pm800_data->regulators[i] =
-				regulator_register(&info->desc, &config);
-		if (IS_ERR(pm800_data->regulators[i])) {
-			ret = PTR_ERR(pm800_data->regulators[i]);
+		regulator = devm_regulator_register(&pdev->dev,
+					&info->desc, &config);
+		if (IS_ERR(regulator)) {
+			ret = PTR_ERR(regulator);
 			dev_err(&pdev->dev, "Failed to register %s\n",
 				info->desc.name);
-
-			while (--i >= 0)
-				regulator_unregister(pm800_data->regulators[i]);
-
 			return ret;
 		}
 	}
@@ -348,23 +345,11 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pm800_regulator_remove(struct platform_device *pdev)
-{
-	struct pm800_regulators *pm800_data = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < PM800_ID_RG_MAX; i++)
-		regulator_unregister(pm800_data->regulators[i]);
-
-	return 0;
-}
-
 static struct platform_driver pm800_regulator_driver = {
 	.driver		= {
 		.name	= "88pm80x-regulator",
 	},
 	.probe		= pm800_regulator_probe,
-	.remove		= pm800_regulator_remove,
 };
 
 module_platform_driver(pm800_regulator_driver);
-- 
1.9.1
