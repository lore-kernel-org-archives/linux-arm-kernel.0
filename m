From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 19:35:49 +0200
Subject: [PATCH 14/16] ARM: Kirkwood: Describe ib62x0 LEDs in DT.
In-Reply-To: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
Message-ID: <1342805751-18048-15-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/boot/dts/kirkwood-ib62x0.dts |   17 ++++++++++++++++
 arch/arm/mach-kirkwood/board-ib62x0.c |   36 ---------------------------------
 2 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index 6726aa9..ab35288 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -62,4 +62,21 @@
 			gpios = <&gpio0 28 1>;
 		};
 	};
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		green-os {
+			label = "ib62x0:green:os";
+			gpios = <&gpio0 25 0>;
+			linux,default-trigger = "default-on";
+		};
+		red-os {
+			label = "ib62x0:red:os";
+			gpios = <&gpio0 22 0>;
+		};
+		usb-copy {
+			label = "ib62x0:red:usb_copy";
+			gpios = <&gpio0 27 0>;
+		};
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index f30065e..cfc47f8 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -19,7 +19,6 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
-#include <linux/leds.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
@@ -50,40 +49,6 @@ static unsigned int ib62x0_mpp_config[] __initdata = {
 	0
 };
 
-static struct gpio_led ib62x0_led_pins[] = {
-	{
-		.name			= "ib62x0:green:os",
-		.default_trigger	= "default-on",
-		.gpio			= 25,
-		.active_low		= 0,
-	},
-	{
-		.name			= "ib62x0:red:os",
-		.default_trigger	= "none",
-		.gpio			= 22,
-		.active_low		= 0,
-	},
-	{
-		.name			= "ib62x0:red:usb_copy",
-		.default_trigger	= "none",
-		.gpio			= 27,
-		.active_low		= 0,
-	},
-};
-
-static struct gpio_led_platform_data ib62x0_led_data = {
-	.leds		= ib62x0_led_pins,
-	.num_leds	= ARRAY_SIZE(ib62x0_led_pins),
-};
-
-static struct platform_device ib62x0_led_device = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &ib62x0_led_data,
-	}
-};
-
 static void ib62x0_power_off(void)
 {
 	gpio_set_value(IB62X0_GPIO_POWER_OFF, 1);
@@ -98,7 +63,6 @@ void __init ib62x0_init(void)
 
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&ib62x0_ge00_data);
-	platform_device_register(&ib62x0_led_device);
 	if (gpio_request(IB62X0_GPIO_POWER_OFF, "ib62x0:power:off") == 0 &&
 	    gpio_direction_output(IB62X0_GPIO_POWER_OFF, 0) == 0)
 		pm_power_off = ib62x0_power_off;
-- 
1.7.10
