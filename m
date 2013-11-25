From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 25 Nov 2013 21:43:44 +0100
Subject: [PATCH 2/3] leds/pwm: Don't disable pwm when setting brightness to 0
In-Reply-To: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1385412225-29740-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes disabling the LED on i.MX28. The PWM hardware delays using
the newly set pwm-config until the beginning of a new period. It's very
likely that pwm_disable is called before the current period ends. In
case the LED was on brightness=max before the LED stays on because in
the disabled PWM block the period never ends.

Also only call pwm_enable only once in the probe call back and the
matching pwm_disable in .remove(). Moreover the pwm is explicitly
initialized to off.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/leds-pwm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 2848171..cdc3e4d 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -45,11 +45,6 @@ static void __led_pwm_set(struct led_pwm_data *led_dat)
 	int new_duty = led_dat->duty;
 
 	pwm_config(led_dat->pwm, new_duty, led_dat->period);
-
-	if (new_duty == 0)
-		pwm_disable(led_dat->pwm);
-	else
-		pwm_enable(led_dat->pwm);
 }
 
 static void led_pwm_work(struct work_struct *work)
@@ -180,6 +175,10 @@ static int led_pwm_probe(struct platform_device *pdev)
 			led_dat->cdev.max_brightness = cur_led->max_brightness;
 			led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
 
+			led_dat->duty = 0;
+			__led_pwm_set(led_dat);
+			pwm_enable(led_dat->pwm);
+
 			led_dat->can_sleep = pwm_can_sleep(led_dat->pwm);
 			if (led_dat->can_sleep)
 				INIT_WORK(&led_dat->work, led_pwm_work);
@@ -215,6 +214,7 @@ static int led_pwm_remove(struct platform_device *pdev)
 		led_classdev_unregister(&priv->leds[i].cdev);
 		if (priv->leds[i].can_sleep)
 			cancel_work_sync(&priv->leds[i].work);
+		pwm_disable(priv->leds[i].pwm);
 	}
 
 	return 0;
-- 
1.8.4.2
