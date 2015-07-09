From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Jul 2015 16:35:28 +0100
Subject: [PATCH 3/3] regulator: pwm-regulator: Small clean-ups
In-Reply-To: <1436456128-18278-1-git-send-email-lee.jones@linaro.org>
References: <1436456128-18278-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436456128-18278-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove over-bracketing, use framework API to fetch PWM period and
be more forthcoming that pwm_voltage_to_duty_cycle() actually returns
duty cycle as a percentage, rather than a register value.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index d92e667..936e387 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -92,13 +92,13 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 /**
  * Continuous voltage call-backs
  */
-static int pwm_voltage_to_duty_cycle(struct regulator_dev *rdev, int req_uV)
+static int pwm_voltage_to_duty_cycle_percentage(struct regulator_dev *rdev, int req_uV)
 {
 	int min_uV = rdev->constraints->min_uV;
 	int max_uV = rdev->constraints->max_uV;
 	int diff = max_uV - min_uV;
 
-	return 100 - ((((req_uV * 100) - (min_uV * 100)) / diff));
+	return 100 - (((req_uV * 100) - (min_uV * 100)) / diff);
 }
 
 static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
@@ -114,14 +114,13 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
 	unsigned int ramp_delay = rdev->constraints->ramp_delay;
+	unsigned int period = pwm_get_period(drvdata->pwm);
 	int duty_cycle;
 	int ret;
 
-	duty_cycle = pwm_voltage_to_duty_cycle(rdev, min_uV);
+	duty_cycle = pwm_voltage_to_duty_cycle_percentage(rdev, min_uV);
 
-	ret = pwm_config(drvdata->pwm,
-			 (drvdata->pwm->period / 100) * duty_cycle,
-			 drvdata->pwm->period);
+	ret = pwm_config(drvdata->pwm, (period / 100) * duty_cycle, period);
 	if (ret) {
 		dev_err(&rdev->dev, "Failed to configure PWM\n");
 		return ret;
-- 
1.9.1
