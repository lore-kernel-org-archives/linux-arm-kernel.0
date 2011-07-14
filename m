From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Thu, 14 Jul 2011 09:27:15 -0400
Subject: [PATCH 5/6] ARM: S5P6440: Add LCD-LTE480 and enable Framebuffer
	support
In-Reply-To: <1310650036-28836-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1310650036-28836-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1310650036-28836-6-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch:
o Adds platform device support for LCD-LTE480.
o Adds platform data for FB with win_mode and default_bpp.
o Enables FB device support and platform-lcd support.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5p64x0/Kconfig         |    2 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c |   63 +++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 2ca5ac0..c69a32d 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -37,6 +37,7 @@ config S5P64X0_SETUP_I2C1
 config MACH_SMDK6440
 	bool "SMDK6440"
 	select CPU_S5P6440
+	select S3C_DEV_FB
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
@@ -44,6 +45,7 @@ config MACH_SMDK6440
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
+	select S5P64X0_SETUP_FB
 	select S5P64X0_SETUP_I2C1
 	help
 	  Machine support for the Samsung SMDK6440
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 2d559f1..a1f6f1e 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
+#include <linux/fb.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -34,6 +35,7 @@
 #include <mach/regs-clock.h>
 #include <mach/i2c.h>
 #include <mach/regs-gpio.h>
+#include <mach/regs-fb.h>
 
 #include <plat/regs-serial.h>
 #include <plat/gpio-cfg.h>
@@ -46,6 +48,9 @@
 #include <plat/adc.h>
 #include <plat/ts.h>
 #include <plat/s5p-time.h>
+#include <plat/fb.h>
+
+#include <video/platform_lcd.h>
 
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -130,6 +135,60 @@ static struct platform_device smdk6440_backlight_device = {
 	},
 };
 
+/* Frame Buffer */
+static struct s3c_fb_pd_win s5p6440_fb_win0 = {
+/* this is to ensure we use win0 */
+	.win_mode	= {
+		.left_margin	= 8,
+		.right_margin	= 13,
+		.upper_margin	= 7,
+		.lower_margin	= 5,
+		.hsync_len	= 3,
+		.vsync_len	= 1,
+		.xres		= 800,
+		.yres		= 480,
+		.refresh	= 80,
+	},
+	.max_bpp	= 24,
+	.default_bpp	= 24,
+};
+
+static struct s3c_fb_platdata s5p6440_lcd_pdata __initdata = {
+	.win[0]		= &s5p6440_fb_win0,
+	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
+	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
+	.setup_gpio	= s5p64x0_fb_gpio_setup_24bpp,
+};
+
+/* LCD power controller */
+static void s5p6440_lte480_reset_power(struct plat_lcd_data *pd,
+					unsigned int power)
+{
+	int err;
+
+	if (power) {
+		err = gpio_request(S5P6440_GPN(5), "GPN");
+		if (err)
+			printk(KERN_ERR "failed to request GPN for lcd reset\n");
+
+		gpio_direction_output(S5P6440_GPN(5), 1);
+		gpio_set_value(S5P6440_GPN(5), 0);
+		gpio_set_value(S5P6440_GPN(5), 1);
+		gpio_free(S5P6440_GPN(5));
+	}
+}
+
+static struct plat_lcd_data s5p6440_lcd_power_data = {
+	.set_power	= s5p6440_lte480_reset_power,
+};
+
+static struct platform_device smdk6440_lcd_lte480wv = {
+	.name			= "platform-lcd",
+	.dev.parent		= &s3c_device_fb.dev,
+	.dev.platform_data	= &s5p6440_lcd_power_data,
+};
+
+
 static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_rtc,
@@ -141,6 +200,8 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s5p6440_device_iis,
 	&s3c_device_timer[1],
 	&smdk6440_backlight_device,
+	&s3c_device_fb,
+	&smdk6440_lcd_lte480wv,
 };
 
 static struct s3c2410_platform_i2c s5p6440_i2c0_data __initdata = {
@@ -193,6 +254,8 @@ static void __init smdk6440_machine_init(void)
 			ARRAY_SIZE(smdk6440_i2c_devs0));
 	i2c_register_board_info(1, smdk6440_i2c_devs1,
 			ARRAY_SIZE(smdk6440_i2c_devs1));
+	s3c_fb_set_platdata(&s5p6440_lcd_pdata);
+	s5p64x0_fb_init(S5P64X0_SPCON0_LCD_SEL_RGB);
 
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
-- 
1.7.1
