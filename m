From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:04:06 +0200
Subject: [PATCH v5 43/46] backlight: pwm_bl: switch to the atomic PWM API
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-44-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm_config/enable/disable() have been deprecated and should be replaced
by pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/backlight/pwm_bl.c | 43 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 2479c11..b069fb2 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -43,8 +43,22 @@ struct pwm_bl_data {
 	void			(*exit)(struct device *);
 };
 
+static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
+{
+	unsigned int lth = pb->lth_brightness;
+	int duty_cycle;
+
+	if (pb->levels)
+		duty_cycle = pb->levels[brightness];
+	else
+		duty_cycle = brightness;
+
+	return (duty_cycle * (pb->period - lth) / pb->scale) + lth;
+}
+
 static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 {
+	struct pwm_state pstate;
 	int err;
 
 	if (pb->enabled)
@@ -57,17 +71,24 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (pb->enable_gpio)
 		gpiod_set_value(pb->enable_gpio, 1);
 
-	pwm_enable(pb->pwm);
+	pwm_get_state(pb->pwm, &pstate);
+	pstate.duty_cycle = compute_duty_cycle(pb, brightness);
+	pstate.enabled = true;
+	pwm_apply_state(pb->pwm, &pstate);
 	pb->enabled = true;
 }
 
 static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 {
+	struct pwm_state pstate;
+
 	if (!pb->enabled)
 		return;
 
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
+	pwm_get_state(pb->pwm, &pstate);
+	pstate.duty_cycle = 0;
+	pstate.enabled = false;
+	pwm_apply_state(pb->pwm, &pstate);
 
 	if (pb->enable_gpio)
 		gpiod_set_value(pb->enable_gpio, 0);
@@ -76,24 +97,10 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	pb->enabled = false;
 }
 
-static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
-{
-	unsigned int lth = pb->lth_brightness;
-	int duty_cycle;
-
-	if (pb->levels)
-		duty_cycle = pb->levels[brightness];
-	else
-		duty_cycle = brightness;
-
-	return (duty_cycle * (pb->period - lth) / pb->scale) + lth;
-}
-
 static int pwm_backlight_update_status(struct backlight_device *bl)
 {
 	struct pwm_bl_data *pb = bl_get_data(bl);
 	int brightness = bl->props.brightness;
-	int duty_cycle;
 
 	if (bl->props.power != FB_BLANK_UNBLANK ||
 	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
@@ -104,8 +111,6 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		brightness = pb->notify(pb->dev, brightness);
 
 	if (brightness > 0) {
-		duty_cycle = compute_duty_cycle(pb, brightness);
-		pwm_config(pb->pwm, duty_cycle, pb->period);
 		pwm_backlight_power_on(pb, brightness);
 	} else
 		pwm_backlight_power_off(pb);
-- 
2.5.0
