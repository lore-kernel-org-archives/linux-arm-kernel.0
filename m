From: zonque@gmail.com (Daniel Mack)
Date: Tue, 24 May 2011 14:13:42 +0200
Subject: [PATCH 1/2] ARM: pxa: raumfeld: follow upcoming hardware change
Message-ID: <1306239223-8293-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sven Neumann <s.neumann@raumfeld.com>

The backlight control is going to change back to PWM in the
upcoming Raumfeld Controller hardware revision.

Signed-off-by: Sven Neumann <s.neumann@raumfeld.com>
Acked-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 15bca98..b18b486 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -574,10 +574,10 @@ static struct pxafb_mode_info sharp_lq043t3dx02_mode = {
 	.xres		= 480,
 	.yres		= 272,
 	.bpp		= 16,
-	.hsync_len	= 4,
+	.hsync_len	= 41,
 	.left_margin	= 2,
 	.right_margin	= 1,
-	.vsync_len	= 1,
+	.vsync_len	= 10,
 	.upper_margin	= 3,
 	.lower_margin	= 1,
 	.sync		= 0,
@@ -599,27 +599,30 @@ static void __init raumfeld_lcd_init(void)
 
 	pxa_set_fb_info(NULL, &raumfeld_sharp_lcd_info);
 
-	/* Earlier devices had the backlight regulator controlled
-	 * via PWM, later versions use another controller for that */
-	if ((system_rev & 0xff) < 2) {
-		mfp_cfg_t raumfeld_pwm_pin_config = GPIO17_PWM0_OUT;
-		pxa3xx_mfp_config(&raumfeld_pwm_pin_config, 1);
-		platform_device_register(&raumfeld_pwm_backlight_device);
-	} else
-		platform_device_register(&raumfeld_lt3593_device);
-
 	ret = gpio_request(GPIO_TFT_VA_EN, "display VA enable");
 	if (ret < 0)
 		pr_warning("Unable to request GPIO_TFT_VA_EN\n");
 	else
 		gpio_direction_output(GPIO_TFT_VA_EN, 1);
 
+	msleep(100);
+
 	ret = gpio_request(GPIO_DISPLAY_ENABLE, "display enable");
 	if (ret < 0)
 		pr_warning("Unable to request GPIO_DISPLAY_ENABLE\n");
 	else
 		gpio_direction_output(GPIO_DISPLAY_ENABLE, 1);
 
+	/* Hardware revision 2 has the backlight regulator controlled
+	 * by an LT3593, earlier and later devices use PWM for that. */
+	if ((system_rev & 0xff) == 2) {
+		platform_device_register(&raumfeld_lt3593_device);
+	} else {
+		mfp_cfg_t raumfeld_pwm_pin_config = GPIO17_PWM0_OUT;
+		pxa3xx_mfp_config(&raumfeld_pwm_pin_config, 1);
+		platform_device_register(&raumfeld_pwm_backlight_device);
+	}
+
 	platform_device_register(&pxa3xx_device_gcu);
 }
 
-- 
1.7.5.1
