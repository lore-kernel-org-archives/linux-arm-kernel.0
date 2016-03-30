From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:04:00 +0200
Subject: [PATCH v5 37/46] input: misc: max8997: switch to the atomic PWM API
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-38-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm_config/enable/disable() have been deprecated and should be replaced
by pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/input/misc/max8997_haptic.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index a806ba3..fcc0eb7 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -72,8 +72,12 @@ static int max8997_haptic_set_duty_cycle(struct max8997_haptic *chip)
 	int ret = 0;
 
 	if (chip->mode == MAX8997_EXTERNAL_MODE) {
-		unsigned int duty = chip->pwm_period * chip->level / 100;
-		ret = pwm_config(chip->pwm, duty, chip->pwm_period);
+		struct pwm_state pstate;
+
+		pwm_get_state(chip->pwm, &pstate);
+		pstate.period = chip->pwm_period;
+		pstate.duty_cycle = chip->pwm_period * chip->level / 100;
+		ret = pwm_apply_state(chip->pwm, &pstate);
 	} else {
 		int i;
 		u8 duty_index = 0;
@@ -188,7 +192,11 @@ static void max8997_haptic_enable(struct max8997_haptic *chip)
 		}
 		max8997_haptic_configure(chip);
 		if (chip->mode == MAX8997_EXTERNAL_MODE) {
-			error = pwm_enable(chip->pwm);
+			struct pwm_state pstate;
+
+			pwm_get_state(chip->pwm, &pstate);
+			pstate.enabled = true;
+			error = pwm_apply_state(chip->pwm, &pstate);
 			if (error) {
 				dev_err(chip->dev, "Failed to enable PWM\n");
 				regulator_disable(chip->regulator);
@@ -209,8 +217,13 @@ static void max8997_haptic_disable(struct max8997_haptic *chip)
 	if (chip->enabled) {
 		chip->enabled = false;
 		max8997_haptic_configure(chip);
-		if (chip->mode == MAX8997_EXTERNAL_MODE)
-			pwm_disable(chip->pwm);
+		if (chip->mode == MAX8997_EXTERNAL_MODE) {
+			struct pwm_state pstate;
+
+			pwm_get_state(chip->pwm, &pstate);
+			pstate.enabled = false;
+			pwm_apply_state(chip->pwm, &pstate);
+		}
 		regulator_disable(chip->regulator);
 	}
 
-- 
2.5.0
