From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 23 Sep 2013 23:40:58 +0200
Subject: [PATCH 01/10] pwm-backlight: Refactor backlight power on/off
In-Reply-To: <1379972467-11243-1-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
Message-ID: <1379972467-11243-2-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for adding an optional regulator and enable GPIO to the
driver, split the power on and power off sequences into separate
functions to reduce code duplication at the multiple call sites.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c | 59 ++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 36db5d9..8a49b30 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -35,6 +35,30 @@ struct pwm_bl_data {
 	void			(*exit)(struct device *);
 };
 
+static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness,
+				   int max)
+{
+	int duty_cycle, err;
+
+	if (pb->levels) {
+		duty_cycle = pb->levels[brightness];
+		max = pb->levels[max];
+	} else {
+		duty_cycle = brightness;
+	}
+
+	duty_cycle = (duty_cycle * (pb->period - pb->lth_brightness) / max) +
+		     pb->lth_brightness;
+
+	pwm_config(pb->pwm, duty_cycle, pb->period);
+	pwm_enable(pb->pwm);
+}
+
+static void pwm_backlight_power_off(struct pwm_bl_data *pb)
+{
+	pwm_disable(pb->pwm);
+}
+
 static int pwm_backlight_update_status(struct backlight_device *bl)
 {
 	struct pwm_bl_data *pb = bl_get_data(bl);
@@ -49,24 +73,10 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 	if (pb->notify)
 		brightness = pb->notify(pb->dev, brightness);
 
-	if (brightness == 0) {
-		pwm_config(pb->pwm, 0, pb->period);
-		pwm_disable(pb->pwm);
-	} else {
-		int duty_cycle;
-
-		if (pb->levels) {
-			duty_cycle = pb->levels[brightness];
-			max = pb->levels[max];
-		} else {
-			duty_cycle = brightness;
-		}
-
-		duty_cycle = pb->lth_brightness +
-		     (duty_cycle * (pb->period - pb->lth_brightness) / max);
-		pwm_config(pb->pwm, duty_cycle, pb->period);
-		pwm_enable(pb->pwm);
-	}
+	if (brightness > 0)
+		pwm_backlight_power_on(pb, brightness, max);
+	else
+		pwm_backlight_power_off(pb);
 
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, brightness);
@@ -267,10 +277,11 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 	struct pwm_bl_data *pb = bl_get_data(bl);
 
 	backlight_device_unregister(bl);
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
+	pwm_backlight_power_off(pb);
+
 	if (pb->exit)
 		pb->exit(&pdev->dev);
+
 	return 0;
 }
 
@@ -282,10 +293,12 @@ static int pwm_backlight_suspend(struct device *dev)
 
 	if (pb->notify)
 		pb->notify(pb->dev, 0);
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
+
+	pwm_backlight_power_off(pb);
+
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, 0);
+
 	return 0;
 }
 
@@ -294,6 +307,7 @@ static int pwm_backlight_resume(struct device *dev)
 	struct backlight_device *bl = dev_get_drvdata(dev);
 
 	backlight_update_status(bl);
+
 	return 0;
 }
 #endif
@@ -317,4 +331,3 @@ module_platform_driver(pwm_backlight_driver);
 MODULE_DESCRIPTION("PWM based Backlight Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pwm-backlight");
-
-- 
1.8.4
