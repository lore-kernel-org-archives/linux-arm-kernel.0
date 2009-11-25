From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:24 +0100
Subject: [PATCH 10/17] ARM: pxa/raumfeld: add framebuffer and backlight devices
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-11-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |  121 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 66b9af1..d0c4eab 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -29,6 +29,7 @@
 #include <linux/leds.h>
 #include <linux/w1-gpio.h>
 #include <linux/sched.h>
+#include <linux/pwm_backlight.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +40,7 @@
 #include <mach/mfp-pxa300.h>
 #include <mach/pxa3xx_nand.h>
 #include <mach/ohci.h>
+#include <mach/pxafb.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -358,6 +360,124 @@ static void __init raumfeld_w1_init(void)
 	platform_device_register(&raumfeld_w1_gpio_device);
 }
 
+/**
+ * Framebuffer device
+ */
+static mfp_cfg_t raumfeld_lcd_pin_config[] __initdata = {
+	GPIO54_LCD_LDD_0,
+	GPIO55_LCD_LDD_1,
+	GPIO56_LCD_LDD_2,
+	GPIO57_LCD_LDD_3,
+	GPIO58_LCD_LDD_4,
+	GPIO59_LCD_LDD_5,
+	GPIO60_LCD_LDD_6,
+	GPIO61_LCD_LDD_7,
+	GPIO62_LCD_LDD_8,
+	GPIO63_LCD_LDD_9,
+	GPIO64_LCD_LDD_10,
+	GPIO65_LCD_LDD_11,
+	GPIO66_LCD_LDD_12,
+	GPIO67_LCD_LDD_13,
+	GPIO68_LCD_LDD_14,
+	GPIO69_LCD_LDD_15,
+	GPIO70_LCD_LDD_16,
+	GPIO71_LCD_LDD_17,
+	GPIO72_LCD_FCLK,
+	GPIO73_LCD_LCLK,
+	GPIO74_LCD_PCLK,
+	GPIO75_LCD_BIAS,
+};
+
+/* PWM controlled backlight */
+static struct platform_pwm_backlight_data raumfeld_pwm_backlight_data = {
+	.pwm_id		= 0,
+	.max_brightness	= 100,
+	.dft_brightness	= 100,
+	/* 10000 ns = 10 ms ^= 100 kHz */
+	.pwm_period_ns	= 10000,
+};
+
+static struct platform_device raumfeld_pwm_backlight_device = {
+	.name	= "pwm-backlight",
+	.dev	= {
+		.parent		= &pxa27x_device_pwm0.dev,
+		.platform_data	= &raumfeld_pwm_backlight_data,
+	}
+};
+
+/* LT3593 controlled backlight */
+static struct gpio_led raumfeld_lt3593_led = {
+	.name		= "backlight",
+	.gpio		= mfp_to_gpio(MFP_PIN_GPIO17),
+	.default_state	= LEDS_GPIO_DEFSTATE_ON,
+};
+
+static struct gpio_led_platform_data raumfeld_lt3593_platform_data = {
+	.leds		= &raumfeld_lt3593_led,
+	.num_leds	= 1,
+};
+
+static struct platform_device raumfeld_lt3593_device = {
+	.name	= "leds-lt3593",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &raumfeld_lt3593_platform_data,
+	},
+};
+
+static struct pxafb_mode_info sharp_lq043t3dx02_mode = {
+	.pixclock	= 111000,
+	.xres		= 480,
+	.yres		= 272,
+	.bpp		= 16,
+	.hsync_len	= 4,
+	.left_margin	= 2,
+	.right_margin	= 1,
+	.vsync_len	= 1,
+	.upper_margin	= 3,
+	.lower_margin	= 1,
+	.sync		= 0,
+};
+
+static struct pxafb_mach_info raumfeld_sharp_lcd_info = {
+	.modes		= &sharp_lq043t3dx02_mode,
+	.num_modes	= 1,
+	.video_mem_size = 0x400000,
+	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
+#ifdef CONFIG_PXA3XX_GCU
+	.acceleration_enabled = 1,
+#endif
+};
+
+static int gpio_display_enable = GPIO_DISPLAY_ENABLE;
+
+static void __init raumfeld_lcd_init(void)
+{
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_lcd_pin_config));
+	set_pxa_fb_info(&raumfeld_sharp_lcd_info);
+
+	/* Earlier devices had the backlight regulator controlled
+	 * via PWM, later versions use another controller for that */
+	if ((system_rev & 0xff) < 2) {
+		mfp_cfg_t raumfeld_pwm_pin_config = GPIO17_PWM0_OUT;
+		pxa3xx_mfp_config(&raumfeld_pwm_pin_config, 1);
+		platform_device_register(&raumfeld_pwm_backlight_device);
+	} else
+		platform_device_register(&raumfeld_lt3593_device);
+
+	gpio_request(mfp_to_gpio(GPIO_TFT_VA_EN), "display VA enable");
+	gpio_direction_output(mfp_to_gpio(GPIO_TFT_VA_EN), 1);
+	gpio_set_value(mfp_to_gpio(GPIO_TFT_VA_EN), 1);
+
+	gpio_request(mfp_to_gpio(gpio_display_enable), "display enable");
+	gpio_direction_output(mfp_to_gpio(gpio_display_enable), 1);
+	gpio_set_value(mfp_to_gpio(gpio_display_enable), 1);
+
+#ifdef CONFIG_PXA3XX_GCU
+	platform_device_register(&pxa3xx_device_gcu);
+#endif
+}
+
 static struct platform_device *raumfeld_common_devices[] = {
 	&raumfeld_gpio_keys_device,
 	&raumfeld_led_device,
@@ -402,6 +522,7 @@ static void __init raumfeld_controller_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_controller_devices));
 
 	raumfeld_common_init();
+	raumfeld_lcd_init();
 	raumfeld_w1_init();
 }
 
-- 
1.6.5.2
