From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 14 Jun 2016 11:13:20 +0200
Subject: [PATCH v3 12/14] regulator: pwm: Retrieve correct voltage
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465895602-31008-13-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The continuous PWM voltage regulator is caching the voltage value in
the ->volt_uV field. While most of the time this value should reflect the
real voltage, sometime it can be sightly different if the PWM device
rounded the set_duty_cycle request.
Moreover, this value is not valid until someone has modified the regulator
output.

Remove the ->volt_uV field and always rely on the PWM state to calculate
the regulator output.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
Mark,

I know you already added your Tested-by/Acked-by tags on this patch
but this version has slightly change and is now making use of the
pwm_get_relative_duty_cycle() helper instead of manually converting
the absolute duty_cycle value into a relative one.
---
 drivers/regulator/pwm-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 2000118..80d083f 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -35,9 +35,6 @@ struct pwm_regulator_data {
 	struct regulator_ops ops;
 
 	int state;
-
-	/* Continuous voltage */
-	int volt_uV;
 };
 
 struct pwm_voltages {
@@ -135,8 +132,13 @@ static int pwm_regulator_is_enabled(struct regulator_dev *dev)
 static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	int min_uV = rdev->constraints->min_uV;
+	int diff = rdev->constraints->max_uV - min_uV;
+	struct pwm_state pstate;
 
-	return drvdata->volt_uV;
+	pwm_get_state(drvdata->pwm, &pstate);
+
+	return min_uV + pwm_get_relative_duty_cycle(&pstate, diff);
 }
 
 static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
@@ -162,8 +164,6 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 		return ret;
 	}
 
-	drvdata->volt_uV = min_uV;
-
 	/* Delay required by PWM regulator to settle to the new voltage */
 	usleep_range(ramp_delay, ramp_delay + 1000);
 
-- 
2.7.4
