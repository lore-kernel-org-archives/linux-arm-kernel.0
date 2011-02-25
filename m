From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 15:04:39 +0100
Subject: [PATCH v2 5/6] eukrea_mbimxsd51: add IPU support
In-Reply-To: <1298641111-12957-5-git-send-email-eric@eukrea.com>
References: <1298641111-12957-5-git-send-email-eric@eukrea.com>
Message-ID: <1298642679-23855-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- TFT lcd or DVI output selection
- if a TFT is used, add backight and lcd platform data

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : don't free gpio when lcd is selected

 arch/arm/mach-mx5/Kconfig                    |    1 +
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |  132 ++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index ded1d2d..c50089b 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -109,6 +109,7 @@ config MACH_EUKREA_MBIMXSD51_BASEBOARD
 	bool
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_IMX_SSI
+	select IMX_HAVE_PLATFORM_IMX_IPUV3
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index 712061c..778adee 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -30,6 +30,11 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/i2c.h>
+#include <linux/mfd/imx-ipu-v3.h>
+#include <linux/fb.h>
+#include <linux/delay.h>
+#include <video/platform_lcd.h>
+#include <linux/backlight.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -41,6 +46,7 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx51.h>
 #include <mach/audmux.h>
+#include <mach/ipu-v3.h>
 
 #include "devices-imx51.h"
 #include "devices.h"
@@ -72,10 +78,78 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	MX51_PAD_AUD3_BB_RXD__AUD3_RXD,
 	MX51_PAD_AUD3_BB_CK__AUD3_TXC,
 	MX51_PAD_AUD3_BB_FS__AUD3_TXFS,
+	/* LCD */
+	MX51_PAD_DISP1_DAT0__DISP1_DAT0,
+	MX51_PAD_DISP1_DAT1__DISP1_DAT1,
+	MX51_PAD_DISP1_DAT2__DISP1_DAT2,
+	MX51_PAD_DISP1_DAT3__DISP1_DAT3,
+	MX51_PAD_DISP1_DAT4__DISP1_DAT4,
+	MX51_PAD_DISP1_DAT5__DISP1_DAT5,
+	MX51_PAD_DISP1_DAT6__DISP1_DAT6,
+	MX51_PAD_DISP1_DAT7__DISP1_DAT7,
+	MX51_PAD_DISP1_DAT8__DISP1_DAT8,
+	MX51_PAD_DISP1_DAT9__DISP1_DAT9,
+	MX51_PAD_DISP1_DAT10__DISP1_DAT10,
+	MX51_PAD_DISP1_DAT11__DISP1_DAT11,
+	MX51_PAD_DISP1_DAT12__DISP1_DAT12,
+	MX51_PAD_DISP1_DAT13__DISP1_DAT13,
+	MX51_PAD_DISP1_DAT14__DISP1_DAT14,
+	MX51_PAD_DISP1_DAT15__DISP1_DAT15,
+	MX51_PAD_DISP1_DAT16__DISP1_DAT16,
+	MX51_PAD_DISP1_DAT17__DISP1_DAT17,
+	MX51_PAD_DI1_PIN3__DI1_PIN3,
+	MX51_PAD_DI1_PIN2__DI1_PIN2,
+	/* LCD Backlight */
+	MX51_PAD_DI1_D1_CS__GPIO3_4,
+	/* LCD RST */
+	MX51_PAD_CSI1_D9__GPIO3_13,
 };
 
 #define GPIO_LED1	IMX_GPIO_NR(3, 30)
 #define GPIO_SWITCH1	IMX_GPIO_NR(3, 31)
+#define GPIO_LCDRST	IMX_GPIO_NR(3, 13)
+#define GPIO_LCDBL	IMX_GPIO_NR(3, 4)
+
+static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
+				   unsigned int power)
+{
+	if (power)
+		gpio_direction_output(GPIO_LCDRST, 1);
+	else
+		gpio_direction_output(GPIO_LCDRST, 0);
+}
+
+static struct plat_lcd_data eukrea_mbimxsd_lcd_power_data = {
+	.set_power		= eukrea_mbimxsd_lcd_power_set,
+};
+
+static struct platform_device eukrea_mbimxsd_lcd_powerdev = {
+	.name			= "platform-lcd",
+	.dev.platform_data	= &eukrea_mbimxsd_lcd_power_data,
+};
+
+static void eukrea_mbimxsd_bl_set_intensity(int intensity)
+{
+	if (intensity)
+		gpio_direction_output(GPIO_LCDBL, 1);
+	else
+		gpio_direction_output(GPIO_LCDBL, 0);
+}
+
+static struct generic_bl_info eukrea_mbimxsd_bl_info = {
+	.name			= "eukrea_mbimxsd-bl",
+	.max_intensity		= 0xff,
+	.default_intensity	= 0xff,
+	.set_bl_intensity	= eukrea_mbimxsd_bl_set_intensity,
+};
+
+static struct platform_device eukrea_mbimxsd_bl_dev = {
+	.name			= "generic-bl",
+	.id			= 1,
+	.dev = {
+		.platform_data	= &eukrea_mbimxsd_bl_info,
+	},
+};
 
 static struct gpio_led eukrea_mbimxsd_leds[] = {
 	{
@@ -138,6 +212,50 @@ static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
 	},
 };
 
+static struct fb_videomode fb_modedb[] = {
+	{
+		.name		= "CMO-QVGA",
+		.refresh	= 60,
+		.xres		= 320,
+		.yres		= 240,
+		.pixclock	= KHZ2PICOS(6500),
+		.left_margin	= 68,
+		.right_margin	= 20,
+		.upper_margin	= 15,
+		.lower_margin	= 4,
+		.hsync_len	= 30,
+		.vsync_len	= 3,
+		.sync		= FB_SYNC_OE_LOW_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+};
+
+static struct ipuv3_fb_platform_data eukrea_mbimxsd_fb0_data = {
+	.interface_pix_fmt = IPU_PIX_FMT_RGB666,
+	.flags = IMX_IPU_FB_USE_MODEDB,
+	.modes = fb_modedb,
+	.num_modes = ARRAY_SIZE(fb_modedb),
+	.display = 0,
+};
+
+static struct imx_ipuv3_platform_data ipu_data = {
+	.fb_head0_platform_data = &eukrea_mbimxsd_fb0_data,
+};
+
+static int screen_type;
+
+static int __init eukrea_mbimx51sd_screen_type(char *options)
+{
+	if (!strcmp(options, "dvi"))
+		screen_type = 1;
+	else if (!strcmp(options, "tft"))
+		screen_type = 0;
+
+	return 0;
+}
+__setup("screen_type=", eukrea_mbimx51sd_screen_type);
+
 static const
 struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
 	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
@@ -186,8 +304,22 @@ void __init eukrea_mbimxsd51_baseboard_init(void)
 	gpio_direction_input(GPIO_SWITCH1);
 	gpio_free(GPIO_SWITCH1);
 
+	gpio_request(GPIO_LCDRST, "LCDRST");
+	gpio_direction_output(GPIO_LCDRST, 0);
+	gpio_request(GPIO_LCDBL, "LCDBL");
+	gpio_direction_output(GPIO_LCDBL, 0);
+	if (!screen_type) {
+		platform_device_register(&eukrea_mbimxsd_bl_dev);
+		platform_device_register(&eukrea_mbimxsd_lcd_powerdev);
+	} else {
+		gpio_free(GPIO_LCDRST);
+		gpio_free(GPIO_LCDBL);
+	}
+
 	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+
+	imx51_add_ipuv3(&ipu_data);
 }
-- 
1.7.4
