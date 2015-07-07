From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Jul 2015 16:06:52 +0100
Subject: [PATCH v2 8/9] regulator: pwm-regulator: Simplify voltage to
 duty-cycle call
In-Reply-To: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
References: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1436281613-899-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we reverse some of the logic and change the formula used,
we can simplify the function greatly.

It is intentional that this function is supplied and then re-worked
within the same patch-set.  The submission in the previous patch is
the tried and tested (i.e. in real releases) method written by ST.
This patch contains a simplification provided later.  It looks and
performs better, but doesn't have the same time-under-test that the
original method does.  The idea is that we keep some history in
order to provide an easy way back i.e. revert.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index dac145d..d5cb267 100644
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
-	tmp = ((max_duty_cycle - min_mV) * max_duty_cycle) / vdiff;
-	pwm_code = ((tmp + max_duty_cycle) * volt_mV) / vdiff;
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
