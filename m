From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  5 Jun 2015 19:42:47 +0100
Subject: [PATCH 4/8] regulator: pwm-regulator: Diffientiate between dev
 (device) and rdev (regulator_dev)
In-Reply-To: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1433529771-24496-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 36f9684..ae32086 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -31,17 +31,17 @@ struct pwm_voltages {
 	unsigned int dutycycle;
 };
 
-static int pwm_regulator_get_voltage_sel(struct regulator_dev *dev)
+static int pwm_regulator_get_voltage_sel(struct regulator_dev *rdev)
 {
-	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 
 	return drvdata->state;
 }
 
-static int pwm_regulator_set_voltage_sel(struct regulator_dev *dev,
+static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
 					 unsigned selector)
 {
-	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 	unsigned int pwm_reg_period;
 	int dutycycle;
 	int ret;
@@ -53,7 +53,7 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *dev,
 
 	ret = pwm_config(drvdata->pwm, dutycycle, pwm_reg_period);
 	if (ret) {
-		dev_err(&dev->dev, "Failed to configure PWM\n");
+		dev_err(&rdev->dev, "Failed to configure PWM\n");
 		return ret;
 	}
 
@@ -61,19 +61,19 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *dev,
 
 	ret = pwm_enable(drvdata->pwm);
 	if (ret) {
-		dev_err(&dev->dev, "Failed to enable PWM\n");
+		dev_err(&rdev->dev, "Failed to enable PWM\n");
 		return ret;
 	}
 
 	return 0;
 }
 
-static int pwm_regulator_list_voltage(struct regulator_dev *dev,
+static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 				      unsigned selector)
 {
-	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 
-	if (selector >= dev->desc->n_voltages)
+	if (selector >= rdev->desc->n_voltages)
 		return -EINVAL;
 
 	return drvdata->duty_cycle_table[selector].uV;
-- 
1.9.1
