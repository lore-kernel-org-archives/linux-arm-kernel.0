From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:49 +0200
Subject: [PATCH 09/17] ARM: pxa: palm27x: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-10-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/palm27x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index e54a296fb81f..13eba2b26e0a 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -15,6 +15,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/pda_power.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
 #include <linux/wm97xx.h>
@@ -270,6 +271,11 @@ void __init palm27x_ac97_init(int minv, int maxv, int jack, int reset)
  * Backlight
  ******************************************************************************/
 #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
+static struct pwm_lookup palm27x_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight.0", NULL, 3500 * 1024,
+		   PWM_POLARITY_NORMAL),
+};
+
 static int palm_bl_power;
 static int palm_lcd_power;
 
@@ -318,10 +324,8 @@ static void palm27x_backlight_exit(struct device *dev)
 }
 
 static struct platform_pwm_backlight_data palm27x_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 0xfe,
 	.dft_brightness	= 0x7e,
-	.pwm_period_ns	= 3500 * 1024,
 	.enable_gpio	= -1,
 	.init		= palm27x_backlight_init,
 	.notify		= palm27x_backlight_notify,
@@ -340,6 +344,7 @@ void __init palm27x_pwm_init(int bl, int lcd)
 {
 	palm_bl_power	= bl;
 	palm_lcd_power	= lcd;
+	pwm_add_lookup(palm27x_pwm_lookup, ARRAY_SIZE(palm27x_pwm_lookup));
 	platform_device_register(&palm27x_backlight);
 }
 #endif
-- 
2.5.0
