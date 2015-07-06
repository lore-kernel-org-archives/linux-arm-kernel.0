From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jul 2015 09:58:30 +0100
Subject: [RESEND 08/10] regulator: pwm-regulator: Add support for
 continuous-voltage
In-Reply-To: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436173112-21397-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current version of PWM regulator only supports a static table
approach, where pre-calculated values are supplied by the vendor and
obtained via DT.  The continuous-voltage method takes min_uV and
max_uV, and divides the difference between them up into a number of
slices.  The number of slices depend on how large the duty cycle
register is.  This information is provided by a DT property.

As the name alludes, this provides values for a continuous voltage
range between min_uV and max_uV, which has obvious benefits over
either limited voltage possibilities, or the requirement to provide
a large voltage-table.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 114 +++++++++++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 25560fc..b37b616 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -21,9 +22,16 @@
 #include <linux/pwm.h>
 
 struct pwm_regulator_data {
-	struct pwm_voltages *duty_cycle_table;
+	/*  Shared */
 	struct pwm_device *pwm;
+
+	/* Voltage table */
+	struct pwm_voltages *duty_cycle_table;
 	int state;
+
+	/* Continuous voltage */
+	u32 max_duty_cycle;
+	int volt_uV;
 };
 
 struct pwm_voltages {
@@ -31,6 +39,9 @@ struct pwm_voltages {
 	unsigned int dutycycle;
 };
 
+/**
+ * Voltage table call-backs
+ */
 static int pwm_regulator_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
@@ -78,6 +89,71 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 
 	return drvdata->duty_cycle_table[selector].uV;
 }
+
+/**
+ * Continuous voltage call-backs
+ */
+static int pwm_voltage_to_duty_cycle(struct regulator_dev *rdev,
+					int volt_mV)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	int min_mV = rdev->constraints->min_uV / 1000;
+	int max_mV = rdev->constraints->max_uV / 1000;
+	int max_duty_cycle = drvdata->max_duty_cycle;
+	int vdiff = min_mV - max_mV;
+	int pwm_code;
+	int tmp;
+
+	tmp = max_duty_cycle - min_mV * max_duty_cycle / vdiff;
+	pwm_code = tmp + max_duty_cycle * volt_mV / vdiff;
+
+	if (pwm_code < 0)
+		pwm_code = 0;
+	if (pwm_code > max_duty_cycle)
+		pwm_code = max_duty_cycle;
+
+	return pwm_code * 100 / max_duty_cycle;
+}
+
+static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+
+	return drvdata->volt_uV;
+}
+
+static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
+					int min_uV, int max_uV,
+					unsigned *selector)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	unsigned int ramp_delay = rdev->constraints->ramp_delay;
+	int duty_cycle;
+	int ret;
+
+	duty_cycle = pwm_voltage_to_duty_cycle(rdev, min_uV / 1000);
+
+	ret = pwm_config(drvdata->pwm,
+			 (drvdata->pwm->period / 100) * duty_cycle,
+			 drvdata->pwm->period);
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to configure PWM\n");
+		return ret;
+	}
+
+	ret = pwm_enable(drvdata->pwm);
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to enable PWM\n");
+		return ret;
+	}
+	drvdata->volt_uV = min_uV;
+
+	/* Delay required by PWM regulator to settle to the new voltage */
+	usleep_range(ramp_delay, ramp_delay + 1000);
+
+	return 0;
+}
+
 static struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.set_voltage_sel = pwm_regulator_set_voltage_sel,
 	.get_voltage_sel = pwm_regulator_get_voltage_sel,
@@ -85,6 +161,11 @@ static struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.map_voltage     = regulator_map_voltage_iterate,
 };
 
+static struct regulator_ops pwm_regulator_voltage_continuous_ops = {
+	.get_voltage = pwm_regulator_get_voltage,
+	.set_voltage = pwm_regulator_set_voltage,
+};
+
 static struct regulator_desc pwm_regulator_desc = {
 	.name		= "pwm-regulator",
 	.type		= REGULATOR_VOLTAGE,
@@ -129,6 +210,25 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 	return 0;
 }
 
+static int pwm_regulator_init_continuous(struct platform_device *pdev,
+					 struct pwm_regulator_data *drvdata)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	ret = of_property_read_u32(np, "max-duty-cycle",
+				   &drvdata->max_duty_cycle);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read \"pwm-max-value\"\n");
+		return ret;
+	}
+
+	pwm_regulator_desc.ops = &pwm_regulator_voltage_continuous_ops;
+	pwm_regulator_desc.continuous_voltage_range = true;
+
+	return 0;
+}
+
 static int pwm_regulator_probe(struct platform_device *pdev)
 {
 	struct pwm_regulator_data *drvdata;
@@ -146,14 +246,12 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	if (of_find_property(np, "voltage-table", NULL)) {
+	if (of_find_property(np, "voltage-table", NULL))
 		ret = pwm_regulator_init_table(pdev, drvdata);
-		if (ret)
-			return ret;
-	} else {
-		dev_err(&pdev->dev, "No \"voltage-table\" supplied\n");
-		return -EINVAL;
-	}
+	else
+		ret = pwm_regulator_init_continuous(pdev, drvdata);
+	if (ret)
+		return ret;
 
 	config.init_data = of_get_regulator_init_data(&pdev->dev, np,
 						      &pwm_regulator_desc);
-- 
1.9.1
