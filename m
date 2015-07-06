From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jul 2015 09:58:29 +0100
Subject: [RESEND 07/10] regulator: pwm-regulator: Separate voltage-table
 initialisation
In-Reply-To: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436173112-21397-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take this out of the main .probe() routine in order to facilitate the
introduction of different ways to obtain 'duty cycle' information.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 77 +++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index ffa9612..25560fc 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -78,8 +78,7 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 
 	return drvdata->duty_cycle_table[selector].uV;
 }
-
-static struct regulator_ops pwm_regulator_voltage_ops = {
+static struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.set_voltage_sel = pwm_regulator_set_voltage_sel,
 	.get_voltage_sel = pwm_regulator_get_voltage_sel,
 	.list_voltage    = pwm_regulator_list_voltage,
@@ -88,20 +87,55 @@ static struct regulator_ops pwm_regulator_voltage_ops = {
 
 static struct regulator_desc pwm_regulator_desc = {
 	.name		= "pwm-regulator",
-	.ops		= &pwm_regulator_voltage_ops,
 	.type		= REGULATOR_VOLTAGE,
 	.owner		= THIS_MODULE,
 	.supply_name    = "pwm",
 };
 
+static int pwm_regulator_init_table(struct platform_device *pdev,
+				    struct pwm_regulator_data *drvdata)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct pwm_voltages *duty_cycle_table;
+	int length;
+	int ret;
+
+	of_find_property(np, "voltage-table", &length);
+
+	if ((length < sizeof(*duty_cycle_table)) ||
+	    (length % sizeof(*duty_cycle_table))) {
+		dev_err(&pdev->dev,
+			"voltage-table length(%d) is invalid\n",
+			length);
+		return -EINVAL;
+	}
+
+	duty_cycle_table = devm_kzalloc(&pdev->dev, length, GFP_KERNEL);
+	if (!duty_cycle_table)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "voltage-table",
+					 (u32 *)duty_cycle_table,
+					 length / sizeof(u32));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read voltage-table\n");
+		return ret;
+	}
+
+	drvdata->duty_cycle_table	= duty_cycle_table;
+	pwm_regulator_desc.ops		= &pwm_regulator_voltage_table_ops;
+	pwm_regulator_desc.n_voltages	= length / sizeof(*duty_cycle_table);
+
+	return 0;
+}
+
 static int pwm_regulator_probe(struct platform_device *pdev)
 {
 	struct pwm_regulator_data *drvdata;
-	struct property *prop;
 	struct regulator_dev *regulator;
 	struct regulator_config config = { };
 	struct device_node *np = pdev->dev.of_node;
-	int length, ret;
+	int ret;
 
 	if (!np) {
 		dev_err(&pdev->dev, "Device Tree node missing\n");
@@ -112,36 +146,15 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	/* determine the number of voltage-table */
-	prop = of_find_property(np, "voltage-table", &length);
-	if (!prop) {
-		dev_err(&pdev->dev, "No voltage-table\n");
-		return -EINVAL;
-	}
-
-	if ((length < sizeof(*drvdata->duty_cycle_table)) ||
-	    (length % sizeof(*drvdata->duty_cycle_table))) {
-		dev_err(&pdev->dev, "voltage-table length(%d) is invalid\n",
-			length);
+	if (of_find_property(np, "voltage-table", NULL)) {
+		ret = pwm_regulator_init_table(pdev, drvdata);
+		if (ret)
+			return ret;
+	} else {
+		dev_err(&pdev->dev, "No \"voltage-table\" supplied\n");
 		return -EINVAL;
 	}
 
-	pwm_regulator_desc.n_voltages = length / sizeof(*drvdata->duty_cycle_table);
-
-	drvdata->duty_cycle_table = devm_kzalloc(&pdev->dev,
-						 length, GFP_KERNEL);
-	if (!drvdata->duty_cycle_table)
-		return -ENOMEM;
-
-	/* read voltage table from DT property */
-	ret = of_property_read_u32_array(np, "voltage-table",
-					 (u32 *)drvdata->duty_cycle_table,
-					 length / sizeof(u32));
-	if (ret < 0) {
-		dev_err(&pdev->dev, "read voltage-table failed\n");
-		return ret;
-	}
-
 	config.init_data = of_get_regulator_init_data(&pdev->dev, np,
 						      &pwm_regulator_desc);
 	if (!config.init_data)
-- 
1.9.1
