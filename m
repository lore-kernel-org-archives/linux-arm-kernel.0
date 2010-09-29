From: augulis.darius@gmail.com (Darius Augulis)
Date: Wed, 29 Sep 2010 22:36:01 +0300
Subject: [PATCH 7/9] ARM: S3C64XX: add frame buffer support for mach-mini6410
In-Reply-To: <20100929192354.25307.40197.stgit@darius-desktop>
References: <20100929192354.25307.40197.stgit@darius-desktop>
Message-ID: <20100929193554.25307.78991.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for frame buffer device for mach-mini6410.
Patch also adds support for feature string parsing
for mini6410. The feature string is kernel command
line passed and currently lets select only LCD
configuration. At the moment there is support for
two LCD configurations - 4.3" and 7.0". Feature
parser is mach-mini2440 based.

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 arch/arm/mach-s3c64xx/Kconfig         |    2 +
 arch/arm/mach-s3c64xx/mach-mini6410.c |  129 +++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 3bbd204..b514e3a 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -106,6 +106,8 @@ config MACH_MINI6410
 	select S3C64XX_SETUP_SDHCI
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_FB
+	select S3C64XX_SETUP_FB_24BPP
 	help
 	  Machine support for the FriendlyARM MINI6410
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 7408d55..331f7e0 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -14,6 +14,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/fb.h>
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -28,12 +29,15 @@
 #include <asm/mach/map.h>
 
 #include <mach/map.h>
+#include <mach/regs-fb.h>
 #include <mach/regs-gpio.h>
+#include <mach/regs-modem.h>
 #include <mach/regs-srom.h>
 #include <mach/s3c6410.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/fb.h>
 #include <plat/nand.h>
 #include <plat/regs-serial.h>
 
@@ -141,26 +145,148 @@ static struct s3c2410_platform_nand mini6410_nand_info = {
 	.sets		= mini6410_nand_sets,
 };
 
+static struct s3c_fb_pd_win mini6410_fb_win[] = {
+	{
+		.win_mode	= {	/* 4.3" 480x272 */
+			.left_margin	= 3,
+			.right_margin	= 2,
+			.upper_margin	= 1,
+			.lower_margin	= 1,
+			.hsync_len	= 40,
+			.vsync_len	= 1,
+			.xres		= 480,
+			.yres		= 272,
+		},
+		.max_bpp	= 32,
+		.default_bpp	= 16,
+	}, {
+		.win_mode	= {	/* 7.0" 800x480 */
+			.left_margin	= 8,
+			.right_margin	= 13,
+			.upper_margin	= 7,
+			.lower_margin	= 5,
+			.hsync_len	= 3,
+			.vsync_len	= 1,
+			.xres		= 800,
+			.yres		= 480,
+		},
+		.max_bpp	= 32,
+		.default_bpp	= 16,
+	},
+};
+
+static struct s3c_fb_platdata mini6410_lcd_pdata __initdata = {
+	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+	.win[0]		= &mini6410_fb_win[0],
+	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
+	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
+};
+
 static struct platform_device *mini6410_devices[] __initdata = {
 	&mini6410_device_eth,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_ohci,
 	&s3c_device_nand,
+	&s3c_device_fb,
 };
 
 static void __init mini6410_map_io(void)
 {
+	u32 tmp;
+
 	s3c64xx_init_io(NULL, 0);
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(mini6410_uartcfgs, ARRAY_SIZE(mini6410_uartcfgs));
+
+	/* set the LCD type */
+	tmp = __raw_readl(S3C64XX_SPCON);
+	tmp &= ~S3C64XX_SPCON_LCD_SEL_MASK;
+	tmp |= S3C64XX_SPCON_LCD_SEL_RGB;
+	__raw_writel(tmp, S3C64XX_SPCON);
+
+	/* remove the LCD bypass */
+	tmp = __raw_readl(S3C64XX_MODEM_MIFPCON);
+	tmp &= ~MIFPCON_LCD_BYPASS;
+	__raw_writel(tmp, S3C64XX_MODEM_MIFPCON);
+}
+
+/*
+ * mini6410_features string
+ *
+ * 0-9 LCD configuration
+ *
+ */
+static char mini6410_features_str[12] __initdata = "0";
+
+static int __init mini6410_features_setup(char *str)
+{
+	if (str)
+		strlcpy(mini6410_features_str, str,
+			sizeof(mini6410_features_str));
+	return 1;
+}
+
+__setup("mini6410=", mini6410_features_setup);
+
+#define FEATURE_SCREEN (1 << 0)
+
+struct mini6410_features_t {
+	int done;
+	int lcd_index;
+};
+
+static void mini6410_parse_features(
+		struct mini6410_features_t *features,
+		const char *features_str)
+{
+	const char *fp = features_str;
+
+	features->done = 0;
+	features->lcd_index = 0;
+
+	while (*fp) {
+		char f = *fp++;
+
+		switch (f) {
+		case '0'...'9':	/* tft screen */
+			if (features->done & FEATURE_SCREEN) {
+				printk(KERN_INFO "MINI6410: '%c' ignored, "
+					"screen type already set\n", f);
+			} else {
+				int li = f - '0';
+				if (li >= ARRAY_SIZE(mini6410_fb_win))
+					printk(KERN_INFO "MINI6410: '%c' out "
+						"of range LCD mode\n", f);
+				else {
+					features->lcd_index = li;
+				}
+			}
+			features->done |= FEATURE_SCREEN;
+			break;
+		}
+	}
 }
 
 static void __init mini6410_machine_init(void)
 {
 	u32 cs1;
+	struct mini6410_features_t features = { 0 };
+
+	printk(KERN_INFO "MINI6410: Option string mini6410=%s\n",
+			mini6410_features_str);
+
+	/* Parse the feature string */
+	mini6410_parse_features(&features, mini6410_features_str);
+
+	mini6410_lcd_pdata.win[0] = &mini6410_fb_win[features.lcd_index];
+
+	printk(KERN_INFO "MINI6410: selected LCD display is %dx%d\n",
+		mini6410_lcd_pdata.win[0]->win_mode.xres,
+		mini6410_lcd_pdata.win[0]->win_mode.yres);
 
 	s3c_nand_set_platdata(&mini6410_nand_info);
+	s3c_fb_set_platdata(&mini6410_lcd_pdata);
 
 	/* configure nCS1 width to 16 bits */
 
@@ -182,6 +308,9 @@ static void __init mini6410_machine_init(void)
 		(4 << S3C64XX_SROM_BCX__TCOS__SHIFT) |
 		(0 << S3C64XX_SROM_BCX__TACS__SHIFT), S3C64XX_SROM_BC1);
 
+	gpio_request(S3C64XX_GPF(15), "LCD power");
+	gpio_request(S3C64XX_GPE(0), "LCD power");
+
 	platform_add_devices(mini6410_devices, ARRAY_SIZE(mini6410_devices));
 }
 
