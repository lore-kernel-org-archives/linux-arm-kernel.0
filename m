From: tony@atomide.com (Tony Lindgren)
Date: Wed, 07 Jul 2010 12:44:46 +0300
Subject: [PATCH 12/13] OMAP4: Add GPIO LED support for SDP board
In-Reply-To: <20100707094308.2562.91921.stgit@baageli.muru.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
Message-ID: <20100707094446.2562.47199.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hemanth V <hemanthv@ti.com>

This patch adds support for GPIO LEDs present on OMAP4
SDP and Blaze boards. This basically adds platform data
required by leds-gpio driver

Signed-off-by: Hemanth V <hemanthv@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   50 +++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index eb1775e..f287461 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
+#include <linux/leds.h>
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -40,6 +41,54 @@
 #define ETH_KS8851_POWER_ON		48
 #define ETH_KS8851_QUART		138
 
+static struct gpio_led sdp4430_gpio_leds[] = {
+	{
+		.name	= "omap4:green:debug0",
+		.gpio	= 61,
+	},
+	{
+		.name	= "omap4:green:debug1",
+		.gpio	= 30,
+	},
+	{
+		.name	= "omap4:green:debug2",
+		.gpio	= 7,
+	},
+	{
+		.name	= "omap4:green:debug3",
+		.gpio	= 8,
+	},
+	{
+		.name	= "omap4:green:debug4",
+		.gpio	= 50,
+	},
+	{
+		.name	= "omap4:blue:user",
+		.gpio	= 169,
+	},
+	{
+		.name	= "omap4:red:user",
+		.gpio	= 170,
+	},
+	{
+		.name	= "omap4:green:user",
+		.gpio	= 139,
+	},
+
+};
+
+static struct gpio_led_platform_data sdp4430_led_data = {
+	.leds	= sdp4430_gpio_leds,
+	.num_leds	= ARRAY_SIZE(sdp4430_gpio_leds),
+};
+
+static struct platform_device sdp4430_leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &sdp4430_led_data,
+	},
+};
 static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
 	{
 		.modalias               = "ks8851",
@@ -112,6 +161,7 @@ static struct platform_device sdp4430_lcd_device = {
 
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
+	&sdp4430_leds_gpio,
 };
 
 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
