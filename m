From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 19:35:47 +0200
Subject: [PATCH 12/16] ARM: Kirkwood: Describe Dreamplug LEDs in DT.
In-Reply-To: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
Message-ID: <1342805751-18048-13-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |   16 ++++++++++++++
 arch/arm/mach-kirkwood/board-dreamplug.c |   34 ------------------------------
 2 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 24de2b5..77fec4e 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -55,4 +55,20 @@
 		};
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		bluetooth {
+			label = "dreamplug:blue:bluetooth";
+			gpios = <&gpio1 15 1>;
+		};
+		wifi {
+			label = "dreamplug:green:wifi";
+			gpios = <&gpio1 16 1>;
+		};
+		wifi-ap {
+			label = "dreamplug:green:wifi_ap";
+			gpios = <&gpio1 17 1>;
+		};
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index e494393..aeb234d 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -22,7 +22,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/gpio.h>
-#include <linux/leds.h>
 #include <linux/mtd/physmap.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
@@ -47,37 +46,6 @@ static struct mvsdio_platform_data dreamplug_mvsdio_data = {
 	/* unfortunately the CD signal has not been connected */
 };
 
-static struct gpio_led dreamplug_led_pins[] = {
-	{
-		.name			= "dreamplug:blue:bluetooth",
-		.gpio			= 47,
-		.active_low		= 1,
-	},
-	{
-		.name			= "dreamplug:green:wifi",
-		.gpio			= 48,
-		.active_low		= 1,
-	},
-	{
-		.name			= "dreamplug:green:wifi_ap",
-		.gpio			= 49,
-		.active_low		= 1,
-	},
-};
-
-static struct gpio_led_platform_data dreamplug_led_data = {
-	.leds		= dreamplug_led_pins,
-	.num_leds	= ARRAY_SIZE(dreamplug_led_pins),
-};
-
-static struct platform_device dreamplug_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &dreamplug_led_data,
-	}
-};
-
 static unsigned int dreamplug_mpp_config[] __initdata = {
 	MPP0_SPI_SCn,
 	MPP1_SPI_MOSI,
@@ -100,6 +68,4 @@ void __init dreamplug_init(void)
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
 	kirkwood_sdio_init(&dreamplug_mvsdio_data);
-
-	platform_device_register(&dreamplug_leds);
 }
-- 
1.7.10
