From: sbkim73@samsung.com (Sangbeom Kim)
Date: Thu, 21 Oct 2010 13:28:03 +0900
Subject: [PATCH v2 4/4] ARM: S5PV310: Add platform data for S5PV310 FIMD and
	LTE480WV platform-lcd
Message-ID: <1287635283-4702-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghun Han <jonghun.han@samsung.com>

Some platform data for S5PV310 FIMD0 are added.
LTE480WV lcd pannel used by SMDKV310 are added via platform-lcd interface.

Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
Changes since v1:
- moved to change plat/fb.h from 4th patch as per Marek's suggestion

 arch/arm/mach-s5pv310/mach-smdkv310.c |   72 +++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 10f8056..8a83eec 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -9,7 +9,9 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/lcd.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 
@@ -17,13 +19,17 @@
 #include <asm/mach-types.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#include <video/platform_lcd.h>
+
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/fb.h>
 #include <plat/sdhci.h>
 
 #include <mach/map.h>
+#include <mach/regs-fb.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -106,7 +112,71 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
+static void lcd_lte480wv_set_power(struct plat_lcd_data *pd,
+				  unsigned int power)
+{
+	if (power) {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request(S5PV310_GPD0(1), "GPD0");
+		gpio_direction_output(S5PV310_GPD0(1), 1);
+		gpio_free(S5PV310_GPD0(1));
+#endif
+		/* fire nRESET on power up */
+		gpio_request(S5PV310_GPX0(6), "GPX0");
+
+		gpio_direction_output(S5PV310_GPX0(6), 1);
+		mdelay(100);
+
+		gpio_set_value(S5PV310_GPX0(6), 0);
+		mdelay(10);
+
+		gpio_set_value(S5PV310_GPX0(6), 1);
+		mdelay(10);
+
+		gpio_free(S5PV310_GPX0(6));
+	} else {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request(S5PV310_GPD0(1), "GPD0");
+		gpio_direction_output(S5PV310_GPD0(1), 0);
+		gpio_free(S5PV310_GPD0(1));
+#endif
+	}
+}
+
+static struct plat_lcd_data smdkv310_lcd_lte480wv_data = {
+	.set_power	= lcd_lte480wv_set_power,
+};
+
+static struct platform_device smdkv310_lcd_lte480wv = {
+	.name			= "platform-lcd",
+	.dev.parent		= &s5p_device_fimd0.dev,
+	.dev.platform_data	= &smdkv310_lcd_lte480wv_data,
+};
+
+static struct s3c_fb_pd_win smdkv310_fb_win0 = {
+	.win_mode = {
+		.left_margin	= 13,
+		.right_margin	= 8,
+		.upper_margin	= 7,
+		.lower_margin	= 5,
+		.hsync_len	= 3,
+		.vsync_len	= 1,
+		.xres	= 800,
+		.yres	= 480,
+	},
+	.max_bpp	= 32,
+	.default_bpp	= 24,
+};
+static struct s3c_fb_platdata smdkv310_lcd0_pdata __initdata = {
+	.win[0]		= &smdkv310_fb_win0,
+	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
+	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
+	.setup_gpio	= s5pv310_fimd0_gpio_setup_24bpp,
+};
+
 static struct platform_device *smdkv310_devices[] __initdata = {
+	&s5p_device_fimd0,
+	&smdkv310_lcd_lte480wv,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
@@ -133,6 +203,8 @@ static void __init smdkv310_machine_init(void)
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
 
+	s5p_fimd0_set_platdata(&smdkv310_lcd0_pdata);
+
 	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
 }
 
-- 
1.6.2.5
