From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:35:32 +0900
Subject: [PATCH 7/7] ARM: mach-shmobile: ag5evm: Use bd6107 backlight driver
In-Reply-To: <cover.1374207161.git.horms+renesas@verge.net.au>
References: <cover.1374207161.git.horms+renesas@verge.net.au>
Message-ID: <0fb19cdabfc3f8884bac53fd81b02bf61c7904af.1374207161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the backlight callback with a bd6107 backlight platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   65 ++++++++-------------------------
 1 file changed, 16 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index c754071..f6d6449 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -41,6 +41,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
+#include <linux/platform_data/bd6107.h>
 #include <linux/sh_clk.h>
 #include <linux/irqchip/arm-gic.h>
 #include <video/sh_mobile_lcdc.h>
@@ -291,47 +292,7 @@ static struct platform_device mipidsi0_device = {
 	},
 };
 
-static unsigned char lcd_backlight_seq[3][2] = {
-	{ 0x04, 0x07 },
-	{ 0x23, 0x80 },
-	{ 0x03, 0x01 },
-};
-
-static int lcd_backlight_set_brightness(int brightness)
-{
-	struct i2c_adapter *adap;
-	struct i2c_msg msg;
-	unsigned int i;
-	int ret;
-
-	if (brightness == 0) {
-		/* Reset the chip */
-		gpio_set_value(235, 0);
-		mdelay(24);
-		gpio_set_value(235, 1);
-		return 0;
-	}
-
-	adap = i2c_get_adapter(1);
-	if (adap == NULL)
-		return -ENODEV;
-
-	for (i = 0; i < ARRAY_SIZE(lcd_backlight_seq); i++) {
-		msg.addr = 0x6d;
-		msg.buf = &lcd_backlight_seq[i][0];
-		msg.len = 2;
-		msg.flags = 0;
-
-		ret = i2c_transfer(adap, &msg, 1);
-		if (ret < 0)
-			break;
-	}
-
-	i2c_put_adapter(adap);
-	return ret < 0 ? ret : 0;
-}
-
-/* LCDC0 */
+/* LCDC0 and backlight */
 static const struct fb_videomode lcdc0_modes[] = {
 	{
 		.name		= "R63302(QHD)",
@@ -361,11 +322,6 @@ static struct sh_mobile_lcdc_info lcdc0_info = {
 			.width = 44,
 			.height = 79,
 		},
-		.bl_info = {
-			.name = "sh_mobile_lcdc_bl",
-			.max_brightness = 1,
-			.set_brightness = lcd_backlight_set_brightness,
-		},
 		.tx_dev = &mipidsi0_device,
 	}
 };
@@ -394,6 +350,17 @@ static struct platform_device lcdc0_device = {
 	},
 };
 
+static struct bd6107_platform_data backlight_data = {
+	.fbdev = &lcdc0_device.dev,
+	.reset = 235,
+	.def_value = 0,
+};
+
+static struct i2c_board_info backlight_board_info = {
+	I2C_BOARD_INFO("bd6107", 0x6d),
+	.platform_data = &backlight_data,
+};
+
 /* Fixed 2.8V regulators to be used by SDHI0 */
 static struct regulator_consumer_supply fixed2v8_power_consumers[] =
 {
@@ -648,15 +615,15 @@ static void __init ag5evm_init(void)
 	gpio_set_value(217, 1);
 	mdelay(100);
 
-	/* LCD backlight controller */
-	gpio_request_one(235, GPIOF_OUT_INIT_LOW, NULL); /* RESET */
-	lcd_backlight_set_brightness(0);
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff);
 #endif
 	sh73a0_add_standard_devices();
+
+	i2c_register_board_info(1, &backlight_board_info, 1);
+
 	platform_add_devices(ag5evm_devices, ARRAY_SIZE(ag5evm_devices));
 }
 
-- 
1.7.10.4
