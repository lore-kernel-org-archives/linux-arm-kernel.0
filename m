From: zonque@gmail.com (Daniel Mack)
Date: Wed, 25 May 2011 13:37:32 +0200
Subject: [PATCH 2/3] ARM: pxa: raumfeld: display initialisation fixes
In-Reply-To: <1306323453-6371-1-git-send-email-zonque@gmail.com>
References: <BANLkTikwkr8etp_fBnsUxiSq28VUyTbONQ@mail.gmail.com>
	<1306323453-6371-1-git-send-email-zonque@gmail.com>
Message-ID: <1306323453-6371-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sven Neumann <s.neumann@raumfeld.com>

The display requires some milliseconds between GPIO_TFT_VA_EN
and GPIO_DISPLAY_ENABLE. Reorder initialisation to comply with
the display spec.

Also tune timings for better compliance with the spec.

Signed-off-by: Sven Neumann <s.neumann@raumfeld.com>
Acked-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 8b2ace5..cdec616 100644
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
@@ -597,30 +597,31 @@ static void __init raumfeld_lcd_init(void)
 {
 	int ret;
 
-	pxa_set_fb_info(NULL, &raumfeld_sharp_lcd_info);
-
-	/* Hardware revision 2 has the backlight regulator controlled
-	 * by an LT3593, earlier and later devices use PWM for that. */
-	if ((system_rev & 0xff) == 2) {
-		platform_device_register(&raumfeld_lt3593_device);
-	} else {
-		mfp_cfg_t raumfeld_pwm_pin_config = GPIO17_PWM0_OUT;
-		pxa3xx_mfp_config(&raumfeld_pwm_pin_config, 1);
-		platform_device_register(&raumfeld_pwm_backlight_device);
-	}
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
+	pxa_set_fb_info(NULL, &raumfeld_sharp_lcd_info);
 	platform_device_register(&pxa3xx_device_gcu);
 }
 
-- 
1.7.5.1
