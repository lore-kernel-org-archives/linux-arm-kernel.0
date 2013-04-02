From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:09:16 +0900
Subject: [PATCH 08/28] ARM: shmobile: marzen: Add GPIO LEDs
In-Reply-To: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879376-10020-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The board has 3 LEDs connected to GPIOs. Add a led-gpio device to
support them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 5852331..a88f7f3 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/leds.h>
 #include <linux/dma-mapping.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
@@ -168,12 +169,43 @@ static struct platform_device usb_phy_device = {
 	.num_resources	= ARRAY_SIZE(usb_phy_resources),
 };
 
+/* LEDS */
+static struct gpio_led marzen_leds[] = {
+	{
+		.name		= "led2",
+		.gpio		= 157,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "led3",
+		.gpio		= 158,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "led4",
+		.gpio		= 159,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+};
+
+static struct gpio_led_platform_data marzen_leds_pdata = {
+	.leds		= marzen_leds,
+	.num_leds	= ARRAY_SIZE(marzen_leds),
+};
+
+static struct platform_device leds_device = {
+	.name	= "leds-gpio",
+	.id	= 0,
+	.dev	= {
+		.platform_data  = &marzen_leds_pdata,
+	},
+};
+
 static struct platform_device *marzen_devices[] __initdata = {
 	&eth_device,
 	&sdhi0_device,
 	&thermal_device,
 	&hspi_device,
 	&usb_phy_device,
+	&leds_device,
 };
 
 /* USB */
-- 
1.7.10.4
