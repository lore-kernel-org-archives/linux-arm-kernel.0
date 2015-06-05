From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  5 Jun 2015 19:42:45 +0100
Subject: [PATCH 2/8] regulator: pwm-regulator: Remove unnecessary descriptor
 attribute from ddata
In-Reply-To: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1433529771-24496-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Regulator Device keeps a full copy of it's own, which can be easily accessed.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index cf2a39b..4a071b6 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -21,7 +21,6 @@
 #include <linux/pwm.h>
 
 struct pwm_regulator_data {
-	struct regulator_desc desc;
 	struct pwm_voltages *duty_cycle_table;
 	struct pwm_device *pwm;
 	bool enabled;
@@ -78,7 +77,7 @@ static int pwm_regulator_list_voltage(struct regulator_dev *dev,
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
 
-	if (selector >= drvdata->desc.n_voltages)
+	if (selector >= dev->desc->n_voltages)
 		return -EINVAL;
 
 	return drvdata->duty_cycle_table[selector].uV;
@@ -91,7 +90,7 @@ static struct regulator_ops pwm_regulator_voltage_ops = {
 	.map_voltage     = regulator_map_voltage_iterate,
 };
 
-static const struct regulator_desc pwm_regulator_desc = {
+static struct regulator_desc pwm_regulator_desc = {
 	.name		= "pwm-regulator",
 	.ops		= &pwm_regulator_voltage_ops,
 	.type		= REGULATOR_VOLTAGE,
@@ -117,8 +116,6 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	memcpy(&drvdata->desc, &pwm_regulator_desc, sizeof(pwm_regulator_desc));
-
 	/* determine the number of voltage-table */
 	prop = of_find_property(np, "voltage-table", &length);
 	if (!prop) {
@@ -133,7 +130,7 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	drvdata->desc.n_voltages = length / sizeof(*drvdata->duty_cycle_table);
+	pwm_regulator_desc.n_voltages = length / sizeof(*drvdata->duty_cycle_table);
 
 	drvdata->duty_cycle_table = devm_kzalloc(&pdev->dev,
 						 length, GFP_KERNEL);
@@ -150,7 +147,7 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	}
 
 	config.init_data = of_get_regulator_init_data(&pdev->dev, np,
-						      &drvdata->desc);
+						      &pwm_regulator_desc);
 	if (!config.init_data)
 		return -ENOMEM;
 
@@ -165,10 +162,10 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	}
 
 	regulator = devm_regulator_register(&pdev->dev,
-					    &drvdata->desc, &config);
+					    &pwm_regulator_desc, &config);
 	if (IS_ERR(regulator)) {
 		dev_err(&pdev->dev, "Failed to register regulator %s\n",
-			drvdata->desc.name);
+			pwm_regulator_desc.name);
 		return PTR_ERR(regulator);
 	}
 
-- 
1.9.1
