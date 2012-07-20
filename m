From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 19:35:45 +0200
Subject: [PATCH 10/16] ARM: Kirkwood: Describe IB62x0 gpio-keys in DT.
In-Reply-To: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
Message-ID: <1342805751-18048-11-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the GPIO controllers have been converted over to DT,
described the gpio-keys in DT.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/boot/dts/kirkwood-ib62x0.dts |   16 ++++++++++++++++
 arch/arm/mach-kirkwood/board-ib62x0.c |   31 -------------------------------
 2 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index f8e2bc6..6726aa9 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -46,4 +46,20 @@
 
 		};
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "USB Copy";
+			linux,code = <133>;
+			gpios = <&gpio0 29 1>;
+		};
+		button at 2 {
+			label = "Reset";
+			linux,code = <0x198>;
+			gpios = <&gpio0 28 1>;
+		};
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index 56d198e..f30065e 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -18,7 +18,6 @@
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
-#include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <asm/mach-types.h>
@@ -85,35 +84,6 @@ static struct platform_device ib62x0_led_device = {
 	}
 };
 
-static struct gpio_keys_button ib62x0_button_pins[] = {
-	{
-		.code		= KEY_COPY,
-		.gpio		= 29,
-		.desc		= "USB Copy",
-		.active_low	= 1,
-	},
-	{
-		.code		= KEY_RESTART,
-		.gpio		= 28,
-		.desc		= "Reset",
-		.active_low	= 1,
-	},
-};
-
-static struct gpio_keys_platform_data ib62x0_button_data = {
-	.buttons	= ib62x0_button_pins,
-	.nbuttons	= ARRAY_SIZE(ib62x0_button_pins),
-};
-
-static struct platform_device ib62x0_button_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.num_resources	= 0,
-	.dev		= {
-		.platform_data	= &ib62x0_button_data,
-	}
-};
-
 static void ib62x0_power_off(void)
 {
 	gpio_set_value(IB62X0_GPIO_POWER_OFF, 1);
@@ -129,7 +99,6 @@ void __init ib62x0_init(void)
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&ib62x0_ge00_data);
 	platform_device_register(&ib62x0_led_device);
-	platform_device_register(&ib62x0_button_device);
 	if (gpio_request(IB62X0_GPIO_POWER_OFF, "ib62x0:power:off") == 0 &&
 	    gpio_direction_output(IB62X0_GPIO_POWER_OFF, 0) == 0)
 		pm_power_off = ib62x0_power_off;
-- 
1.7.10
