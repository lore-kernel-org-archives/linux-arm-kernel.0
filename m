From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Mon, 19 Sep 2011 13:54:00 -0400
Subject: [PATCH V5 5/6] ARM: S5P6440: Add LCD-LTE480 and enable Framebuffer
	support
In-Reply-To: <1316454841-20869-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1316454841-20869-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1316454841-20869-6-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch:
	-- Adds platform device support for LCD-LTE480.
	-- Adds platform data for FB with win_mode and default_bpp.
	-- Enables FB device support and platform-lcd support.
	-- Adds SPCON settings for LCD.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/mach-s5p64x0/Kconfig                  |    2 +
 arch/arm/mach-s5p64x0/include/mach/regs-gpio.h |    4 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c          |   74 ++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 7bec400..3adc4b8 100644
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
@@ -45,6 +46,7 @@ config MACH_SMDK6440
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
+	select S5P64X0_SETUP_FB_24BPP
 	select S5P64X0_SETUP_I2C1
 	help
 	  Machine support for the Samsung SMDK6440
diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h b/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
index 6ce2547..88269ec 100644
--- a/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
@@ -34,6 +34,10 @@
 #define S5P6450_GPQ_BASE		(S5P_VA_GPIO + 0x0180)
 #define S5P6450_GPS_BASE		(S5P_VA_GPIO + 0x0300)
 
+#define S5P64X0_SPCON0			(S5P_VA_GPIO + 0x1A0)
+#define S5P64X0_SPCON0_LCD_SEL_MASK	(0x3 << 0)
+#define S5P64X0_SPCON0_LCD_SEL_RGB	(0x1 << 0)
+
 /* External interrupt control registers for group0 */
 
 #define EINT0CON0_OFFSET		(0x900)
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 340f30f..b0465d4 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
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
 
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -92,6 +97,59 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 	},
 };
 
+/* Frame Buffer */
+static struct s3c_fb_pd_win smdk6440_fb_win0 = {
+	.win_mode = {
+		.left_margin	= 8,
+		.right_margin	= 13,
+		.upper_margin	= 7,
+		.lower_margin	= 5,
+		.hsync_len	= 3,
+		.vsync_len	= 1,
+		.xres		= 800,
+		.yres		= 480,
+	},
+	.max_bpp	= 32,
+	.default_bpp	= 24,
+};
+
+static struct s3c_fb_platdata smdk6440_lcd_pdata __initdata = {
+	.win[0]		= &smdk6440_fb_win0,
+	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
+	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
+	.setup_gpio	= s5p64x0_fb_gpio_setup_24bpp,
+};
+
+/* LCD power controller */
+static void smdk6440_lte480_reset_power(struct plat_lcd_data *pd,
+					 unsigned int power)
+{
+	int err;
+
+	if (power) {
+		err = gpio_request(S5P6440_GPN(5), "GPN");
+		if (err) {
+			printk(KERN_ERR "failed to request GPN for lcd reset\n");
+			return;
+		}
+
+		gpio_direction_output(S5P6440_GPN(5), 1);
+		gpio_set_value(S5P6440_GPN(5), 0);
+		gpio_set_value(S5P6440_GPN(5), 1);
+		gpio_free(S5P6440_GPN(5));
+	}
+}
+
+static struct plat_lcd_data smdk6440_lcd_power_data = {
+	.set_power	= smdk6440_lte480_reset_power,
+};
+
+static struct platform_device smdk6440_lcd_lte480wv = {
+	.name			= "platform-lcd",
+	.dev.parent		= &s3c_device_fb.dev,
+	.dev.platform_data	= &smdk6440_lcd_power_data,
+};
+
 static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_rtc,
@@ -101,6 +159,8 @@ static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_wdt,
 	&samsung_asoc_dma,
 	&s5p6440_device_iis,
+	&s3c_device_fb,
+	&smdk6440_lcd_lte480wv,
 };
 
 static struct s3c2410_platform_i2c s5p6440_i2c0_data __initdata = {
@@ -147,6 +207,17 @@ static void __init smdk6440_map_io(void)
 	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
 }
 
+static void s5p6440_set_lcd_interface(void)
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
 static void __init smdk6440_machine_init(void)
 {
 	s3c24xx_ts_set_platdata(NULL);
@@ -160,6 +231,9 @@ static void __init smdk6440_machine_init(void)
 
 	samsung_bl_set(&smdk6440_bl_gpio_info, &smdk6440_bl_data);
 
+	s5p6440_set_lcd_interface();
+	s3c_fb_set_platdata(&smdk6440_lcd_pdata);
+
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
 
-- 
1.7.0.4
