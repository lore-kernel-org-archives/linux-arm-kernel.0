From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 26 Oct 2018 20:41:56 +0200
Subject: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
In-Reply-To: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy PWM API should be removed in the long run, so convert a user
to the atomic PWM API.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-s3c24xx/mach-rx1950.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 7f5a18fa305b..5c4459f9a5f7 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -375,6 +375,7 @@ static struct pwm_lookup rx1950_pwm_lookup[] = {
 		   PWM_POLARITY_NORMAL),
 };
 
+static struct pwm_state lcd_pwm_state;
 static struct pwm_device *lcd_pwm;
 
 static void rx1950_lcd_power(int enable)
@@ -428,15 +429,17 @@ static void rx1950_lcd_power(int enable)
 
 		/* GPB1->OUTPUT, GPB1->0 */
 		gpio_direction_output(S3C2410_GPB(1), 0);
-		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
-		pwm_disable(lcd_pwm);
+		lcd_pwm_state.duty_cycle = 0;
+		lcd_pwm_state.enabled = false;
+		pwm_apply_state(lcd_pwm, &lcd_pwm_state);
 
 		/* GPC0->0, GPC10->0 */
 		gpio_direction_output(S3C2410_GPC(0), 0);
 		gpio_direction_output(S3C2410_GPC(10), 0);
 	} else {
-		pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD);
-		pwm_enable(lcd_pwm);
+		lcd_pwm_state.duty_cycle = LCD_PWM_DUTY;
+		lcd_pwm_state.enabled = true;
+		pwm_apply_state(lcd_pwm, &lcd_pwm_state);
 
 		gpio_direction_output(S3C2410_GPC(0), 1);
 		gpio_direction_output(S3C2410_GPC(5), 1);
@@ -491,11 +494,8 @@ static int rx1950_backlight_init(struct device *dev)
 		return PTR_ERR(lcd_pwm);
 	}
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
-	 */
-	pwm_apply_args(lcd_pwm);
+	pwm_get_state_default(lcd_pwm, &lcd_pwm_state);
+	lcd_pwm_state.period = LCD_PWM_PERIOD;
 
 	rx1950_lcd_power(1);
 	rx1950_bl_power(1);
-- 
2.19.1
