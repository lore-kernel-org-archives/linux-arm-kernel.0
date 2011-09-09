From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Fri, 09 Sep 2011 14:01:41 -0400
Subject: [PATCH V4 6/6] ARM: S5P6450: Add LCD-LTE480 and enable Framebuffer
	support
In-Reply-To: <1315591301-17166-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1315591301-17166-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1315591301-17166-7-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch:
	-- Adds platform device support for LCD-LTE480.
	-- Adds platform data for FB with win_mode and default_bpp.
	-- Enables FB device support and platform-lcd support.
	-- Adds SPCON settings for LCD.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5p64x0/Kconfig         |    2 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c |   76 +++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 3adc4b8..ecb4e44 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -54,6 +54,7 @@ config MACH_SMDK6440
 config MACH_SMDK6450
 	bool "SMDK6450"
 	select CPU_S5P6450
+	select S3C_DEV_FB
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
@@ -62,6 +63,7 @@ config MACH_SMDK6450
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
+	select S5P64X0_SETUP_FB_24BPP
 	select S5P64X0_SETUP_I2C1
 	help
 	  Machine support for the Samsung SMDK6450
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index ee0da14..fea249e 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -23,6 +23,9 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
+#include <linux/fb.h>
+
+#include <video/platform_lcd.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -47,6 +50,8 @@
 #include <plat/ts.h>
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
+#include <plat/fb.h>
+#include <plat/regs-fb.h>
 
 #define SMDK6450_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -110,6 +115,60 @@ static struct s3c2410_uartcfg smdk6450_uartcfgs[] __initdata = {
 #endif
 };
 
+/* Frame Buffer */
+static struct s3c_fb_pd_win smdk6450_fb_win0 = {
+	.win_mode	= {
+		.left_margin	= 8,
+		.right_margin	= 13,
+		.upper_margin	= 7,
+		.lower_margin	= 5,
+		.hsync_len	= 3,
+		.vsync_len	= 1,
+		.xres		= 800,
+		.yres		= 480,
+		.refresh	= 60,
+	},
+	.max_bpp	= 32,
+	.default_bpp	= 24,
+};
+
+static struct s3c_fb_platdata smdk6450_lcd_pdata __initdata = {
+	.win[0]		= &smdk6450_fb_win0,
+	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
+	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
+	.setup_gpio	= s5p64x0_fb_gpio_setup_24bpp,
+};
+
+/* LCD power controller */
+static void smdk6450_lte480_reset_power(struct plat_lcd_data *pd,
+					 unsigned int power)
+{
+	int err;
+
+	if (power) {
+		err = gpio_request(S5P6450_GPN(5), "GPN");
+		if (err) {
+			printk(KERN_ERR "failed to request GPN for lcd reset\n");
+			return;
+		}
+
+		gpio_direction_output(S5P6450_GPN(5), 1);
+		gpio_set_value(S5P6450_GPN(5), 0);
+		gpio_set_value(S5P6450_GPN(5), 1);
+		gpio_free(S5P6450_GPN(5));
+	}
+}
+
+static struct plat_lcd_data smdk6450_lcd_power_data = {
+	.set_power	= smdk6450_lte480_reset_power,
+};
+
+static struct platform_device smdk6450_lcd_lte480wv = {
+	.name			= "platform-lcd",
+	.dev.parent		= &s3c_device_fb.dev,
+	.dev.platform_data	= &smdk6450_lcd_power_data,
+};
+
 static struct platform_device *smdk6450_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_rtc,
@@ -119,6 +178,9 @@ static struct platform_device *smdk6450_devices[] __initdata = {
 	&s3c_device_wdt,
 	&samsung_asoc_dma,
 	&s5p6450_device_iis0,
+	&s3c_device_fb,
+	&smdk6450_lcd_lte480wv,
+
 	/* s5p6450_device_spi0 will be added */
 };
 
@@ -166,6 +228,17 @@ static void __init smdk6450_map_io(void)
 	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
 }
 
+static void s5p6450_set_lcd_interface()
+{
+	unsigned int cfg;
+
+	/* select TFT LCD type (RGB I/F) */
+	cfg = __raw_readl(S5P64X0_SPCON0);
+	cfg &= ~S5P64X0_SPCON0_LCD_SEL_MASK;
+	cfg |= S5P64X0_SPCON0_LCD_SEL_RGB;
+	__raw_writel(cfg, S5P64X0_SPCON0);
+}
+
 static void __init smdk6450_machine_init(void)
 {
 	s3c24xx_ts_set_platdata(NULL);
@@ -179,6 +252,9 @@ static void __init smdk6450_machine_init(void)
 
 	samsung_bl_set(&smdk6450_bl_gpio_info, &smdk6450_bl_data);
 
+	s5p6450_set_lcd_interface();
+	s3c_fb_set_platdata(&smdk6450_lcd_pdata);
+
 	platform_add_devices(smdk6450_devices, ARRAY_SIZE(smdk6450_devices));
 }
 
-- 
1.7.0.4
