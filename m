From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:03:32 +0200
Subject: [PATCH v5 09/46] misc: max77693-haptic: use pwm_get_args() where
 appropriate
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM framework has clarified the concept of reference PWM config
(the platform dependent config retrieved from the DT or the PWM
lookup table) and real PWM state.

Use pwm_get_args() when the PWM user wants to retrieve this reference
config and not the current state.

This is part of the rework allowing the PWM framework to support
hardware readout and expose real PWM state even when the PWM has
just been requested (before the user calls pwm_config/enable/disable()).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/input/misc/max77693-haptic.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 6d96bff..cf6aac0 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -70,10 +70,13 @@ struct max77693_haptic {
 
 static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
 {
-	int delta = (haptic->pwm_dev->period + haptic->pwm_duty) / 2;
+	struct pwm_args pargs = { };
+	int delta;
 	int error;
 
-	error = pwm_config(haptic->pwm_dev, delta, haptic->pwm_dev->period);
+	pwm_get_args(haptic->pwm_dev, &pargs);
+	delta = (pargs.period + haptic->pwm_duty) / 2;
+	error = pwm_config(haptic->pwm_dev, delta, pargs.period);
 	if (error) {
 		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
 		return error;
@@ -234,6 +237,7 @@ static int max77693_haptic_play_effect(struct input_dev *dev, void *data,
 				       struct ff_effect *effect)
 {
 	struct max77693_haptic *haptic = input_get_drvdata(dev);
+	struct pwm_args pargs = { };
 	u64 period_mag_multi;
 
 	haptic->magnitude = effect->u.rumble.strong_magnitude;
@@ -245,7 +249,8 @@ static int max77693_haptic_play_effect(struct input_dev *dev, void *data,
 	 * The formula to convert magnitude to pwm_duty as follows:
 	 * - pwm_duty = (magnitude * pwm_period) / MAX_MAGNITUDE(0xFFFF)
 	 */
-	period_mag_multi = (u64)haptic->pwm_dev->period * haptic->magnitude;
+	pwm_get_args(haptic->pwm_dev, &pargs);
+	period_mag_multi = (u64)pargs.period * haptic->magnitude;
 	haptic->pwm_duty = (unsigned int)(period_mag_multi >>
 						MAX_MAGNITUDE_SHIFT);
 
-- 
2.5.0
