From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:54 +0200
Subject: [PATCH 14/17] ARM: pxa: tavorevb: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-15-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/tavorevb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index a71da84e784b..349a13a76215 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/smc91x.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 
 #include <asm/mach-types.h>
@@ -168,21 +169,24 @@ static inline void tavorevb_init_keypad(void) {}
 #endif /* CONFIG_KEYBOARD_PXA27x || CONFIG_KEYBOARD_PXA27x_MODULE */
 
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+static struct pwm_lookup tavorevb_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 1, "pwm-backlight.0", NULL, 100000,
+		   PWM_POLARITY_NORMAL),
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight.1", NULL, 100000,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data tavorevb_backlight_data[] = {
 	[0] = {
 		/* primary backlight */
-		.pwm_id		= 2,
 		.max_brightness	= 100,
 		.dft_brightness	= 100,
-		.pwm_period_ns	= 100000,
 		.enable_gpio	= -1,
 	},
 	[1] = {
 		/* secondary backlight */
-		.pwm_id		= 0,
 		.max_brightness	= 100,
 		.dft_brightness	= 100,
-		.pwm_period_ns	= 100000,
 		.enable_gpio	= -1,
 	},
 };
@@ -470,6 +474,7 @@ static struct pxafb_mach_info tavorevb_lcd_info = {
 
 static void __init tavorevb_init_lcd(void)
 {
+	pwm_add_table(tavorevb_pwm_lookup, ARRAY_SIZE(tavorevb_pwm_lookup));
 	platform_device_register(&tavorevb_backlight_devices[0]);
 	platform_device_register(&tavorevb_backlight_devices[1]);
 	pxa_set_fb_info(NULL, &tavorevb_lcd_info);
-- 
2.5.0
