From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  5 Jun 2015 19:42:46 +0100
Subject: [PATCH 3/8] regulator: pwm-regulator: Remove superfluous is_enabled
 check
In-Reply-To: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1433529771-24496-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core framework already takes care of this.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 4a071b6..36f9684 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -23,7 +23,6 @@
 struct pwm_regulator_data {
 	struct pwm_voltages *duty_cycle_table;
 	struct pwm_device *pwm;
-	bool enabled;
 	int state;
 };
 
@@ -60,13 +59,10 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *dev,
 
 	drvdata->state = selector;
 
-	if (!drvdata->enabled) {
-		ret = pwm_enable(drvdata->pwm);
-		if (ret) {
-			dev_err(&dev->dev, "Failed to enable PWM\n");
-			return ret;
-		}
-		drvdata->enabled = true;
+	ret = pwm_enable(drvdata->pwm);
+	if (ret) {
+		dev_err(&dev->dev, "Failed to enable PWM\n");
+		return ret;
 	}
 
 	return 0;
-- 
1.9.1
