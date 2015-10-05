From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:51 +0200
Subject: [PATCH 11/17] ARM: pxa: palmte2: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-12-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a PWM lookup table to provide the PWM to the pwm-backlight device.
The driver has a legacy code path that is required only because boards
still use the legacy method of requesting PWMs by global ID. Replacing
these usages allows that legacy fallback to be removed.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-pxa/palmte2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 956fd24ee6fd..e64bb4326e69 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -21,6 +21,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/pda_power.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
 #include <linux/wm97xx.h>
@@ -138,6 +139,11 @@ static struct platform_device palmte2_pxa_keys = {
 /******************************************************************************
  * Backlight
  ******************************************************************************/
+static struct pwm_lookup palmte2_pwm_lookup[] = {
+	PWM_LOOKUP("pxa25x-pwm.0", 0, "pwm-backlight.0", NULL,
+		   PALMTE2_PERIOD_NS, PWM_POLARITY_NORMAL),
+};
+
 static struct gpio palmte_bl_gpios[] = {
 	{ GPIO_NR_PALMTE2_BL_POWER, GPIOF_INIT_LOW, "Backlight power" },
 	{ GPIO_NR_PALMTE2_LCD_POWER, GPIOF_INIT_LOW, "LCD power" },
@@ -161,10 +167,8 @@ static void palmte2_backlight_exit(struct device *dev)
 }
 
 static struct platform_pwm_backlight_data palmte2_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= PALMTE2_MAX_INTENSITY,
 	.dft_brightness	= PALMTE2_MAX_INTENSITY,
-	.pwm_period_ns	= PALMTE2_PERIOD_NS,
 	.enable_gpio	= -1,
 	.init		= palmte2_backlight_init,
 	.notify		= palmte2_backlight_notify,
@@ -355,6 +359,7 @@ static void __init palmte2_init(void)
 	pxa_set_ac97_info(&palmte2_ac97_pdata);
 	pxa_set_ficp_info(&palmte2_ficp_platform_data);
 
+	pwm_add_table(palmte2_pwm_lookup, ARRAY_SIZE(palmte2_pwm_lookup));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
-- 
2.5.0
