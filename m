From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Mar 2016 22:04:09 +0200
Subject: [PATCH v5 46/46] ARM: s3c24xx: rx1950: switch to the atomic PWM API
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459368249-13241-47-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace pwm_disable/enable/config() by pwm_apply_state().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-s3c24xx/mach-rx1950.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 774c982..2dc9487 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -384,10 +384,15 @@ static struct pwm_device *lcd_pwm;
 
 static void rx1950_lcd_power(int enable)
 {
+	struct pwm_state pstate;
 	int i;
 	static int enabled;
+
 	if (enabled == enable)
 		return;
+
+	pwm_get_state(lcd_pwm, &pstate);
+
 	if (!enable) {
 
 		/* GPC11-GPC15->OUTPUT */
@@ -433,15 +438,21 @@ static void rx1950_lcd_power(int enable)
 
 		/* GPB1->OUTPUT, GPB1->0 */
 		gpio_direction_output(S3C2410_GPB(1), 0);
-		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
+
+		pstate.enabled = false;
+		pstate.period = LCD_PWM_PERIOD;
+		pstate.duty_cycle = 0;
+		pwm_apply_state(lcd_pwm, &pstate);
 		pwm_disable(lcd_pwm);
 
 		/* GPC0->0, GPC10->0 */
 		gpio_direction_output(S3C2410_GPC(0), 0);
 		gpio_direction_output(S3C2410_GPC(10), 0);
 	} else {
-		pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD);
-		pwm_enable(lcd_pwm);
+		pstate.enabled = true;
+		pstate.period = LCD_PWM_PERIOD;
+		pstate.duty_cycle = LCD_PWM_DUTY;
+		pwm_apply_state(lcd_pwm, &pstate);
 
 		gpio_direction_output(S3C2410_GPC(0), 1);
 		gpio_direction_output(S3C2410_GPC(5), 1);
-- 
2.5.0
