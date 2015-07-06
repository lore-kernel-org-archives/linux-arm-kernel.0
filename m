From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jul 2015 09:58:31 +0100
Subject: [RESEND 09/10] regulator: pwm-regulator: Simplify voltage to
 duty-cycle call
In-Reply-To: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436173112-21397-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we reverse some of the logic and change the formula used,
we can simplify the function greatly.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index b37b616..d5cb267 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -93,26 +93,13 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 /**
  * Continuous voltage call-backs
  */
-static int pwm_voltage_to_duty_cycle(struct regulator_dev *rdev,
-					int volt_mV)
+static int pwm_voltage_to_duty_cycle(struct regulator_dev *rdev, int req_uV)
 {
-	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
-	int min_mV = rdev->constraints->min_uV / 1000;
-	int max_mV = rdev->constraints->max_uV / 1000;
-	int max_duty_cycle = drvdata->max_duty_cycle;
-	int vdiff = min_mV - max_mV;
-	int pwm_code;
-	int tmp;
-
-	tmp = max_duty_cycle - min_mV * max_duty_cycle / vdiff;
-	pwm_code = tmp + max_duty_cycle * volt_mV / vdiff;
-
-	if (pwm_code < 0)
-		pwm_code = 0;
-	if (pwm_code > max_duty_cycle)
-		pwm_code = max_duty_cycle;
-
-	return pwm_code * 100 / max_duty_cycle;
+	int min_uV = rdev->constraints->min_uV;
+	int max_uV = rdev->constraints->max_uV;
+	int diff = max_uV - min_uV;
+
+	return 100 - ((((req_uV * 100) - (min_uV * 100)) / diff));
 }
 
 static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
@@ -131,7 +118,7 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 	int duty_cycle;
 	int ret;
 
-	duty_cycle = pwm_voltage_to_duty_cycle(rdev, min_uV / 1000);
+	duty_cycle = pwm_voltage_to_duty_cycle(rdev, min_uV);
 
 	ret = pwm_config(drvdata->pwm,
 			 (drvdata->pwm->period / 100) * duty_cycle,
-- 
1.9.1
