From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 19:35:48 +0200
Subject: [PATCH 13/16] ARM: Kirkwood: Describe GoFlex Net LEDs and SATA in DT.
In-Reply-To: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
Message-ID: <1342805751-18048-14-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Josh Coombs <josh.coombs@gmail.com>
---
 arch/arm/boot/dts/kirkwood-goflexnet.dts |   50 ++++++++++++++++++
 arch/arm/mach-kirkwood/board-goflexnet.c |   84 ------------------------------
 2 files changed, 50 insertions(+), 84 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index c5d5a4e..f6974d1 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -45,5 +45,55 @@
 				reg = <0x02500000 0xd800000>;
 			};
 		};
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		health {
+			label = "status:green:health";
+			gpios = <&gpio1 14 1>;
+			linux,default-trigger = "default-on";
+		};
+		fault {
+			label = "status:orange:fault";
+			gpios = <&gpio1 15 1>;
+		};
+		left0 {
+			label = "status:white:left0";
+			gpios = <&gpio1 10 0>;
+		};
+		left1 {
+			label = "status:white:left1";
+			gpios = <&gpio1 11 0>;
+		};
+		left2 {
+			label = "status:white:left2";
+			gpios = <&gpio1 12 0>;
+		};
+		left3 {
+			label = "status:white:left3";
+			gpios = <&gpio1 13 0>;
+		};
+		right0 {
+			label = "status:white:right0";
+			gpios = <&gpio1 6 0>;
+		};
+		right1 {
+			label = "status:white:right1";
+			gpios = <&gpio1 7 0>;
+		};
+		right2 {
+			label = "status:white:right2";
+			gpios = <&gpio1 8 0>;
+		};
+		right3 {
+			label = "status:white:right3";
+			gpios = <&gpio1 9 0>;
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/board-goflexnet.c b/arch/arm/mach-kirkwood/board-goflexnet.c
index 3957ece..413e2c8 100644
--- a/arch/arm/mach-kirkwood/board-goflexnet.c
+++ b/arch/arm/mach-kirkwood/board-goflexnet.c
@@ -27,7 +27,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/gpio.h>
-#include <linux/leds.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -41,86 +40,6 @@ static struct mv643xx_eth_platform_data goflexnet_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
 
-static struct mv_sata_platform_data goflexnet_sata_data = {
-	.n_ports	= 2,
-};
-
-static struct gpio_led goflexnet_led_pins[] = {
-	{
-		.name			= "status:green:health",
-		.default_trigger	= "default-on",
-		.gpio			= 46,
-		.active_low		= 1,
-	},
-	{
-		.name			= "status:orange:fault",
-		.default_trigger	= "none",
-		.gpio			= 47,
-		.active_low		= 1,
-	},
-	{
-		.name			= "status:white:left0",
-		.default_trigger	= "none",
-		.gpio			= 42,
-		.active_low		= 0,
-	},
-	{
-		.name			= "status:white:left1",
-		.default_trigger	= "none",
-		.gpio			= 43,
-		.active_low		= 0,
-	},
-	{
-		.name			= "status:white:left2",
-		.default_trigger	= "none",
-		.gpio			= 44,
-		.active_low		= 0,
-	},
-	{
-		.name			= "status:white:left3",
-		.default_trigger	= "none",
-		.gpio			= 45,
-		.active_low		= 0,
-	},
-	{
-		.name			= "status:white:right0",
-		.default_trigger	= "none",
-		.gpio			= 38,
-		.active_low		= 0,
-	},
-	{
-		.name			= "status:white:right1",
-		.default_trigger	= "none",
-		.gpio			= 39,
-		.active_low		= 0,
-	},
-	{
-		.name			= "status:white:right2",
-		.default_trigger	= "none",
-		.gpio			= 40,
-		.active_low		= 0,
-	},
-	{
-		.name			= "status:white:right3",
-		.default_trigger	= "none",
-		.gpio			= 41,
-		.active_low		= 0,
-	},
-};
-
-static struct gpio_led_platform_data goflexnet_led_data = {
-	.leds		= goflexnet_led_pins,
-	.num_leds	= ARRAY_SIZE(goflexnet_led_pins),
-};
-
-static struct platform_device goflexnet_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &goflexnet_led_data,
-	}
-};
-
 static unsigned int goflexnet_mpp_config[] __initdata = {
 	MPP29_GPIO,	/* USB Power Enable */
 	MPP47_GPIO,	/* LED Orange */
@@ -149,7 +68,4 @@ void __init goflexnet_init(void)
 	kirkwood_ehci_init();
 
 	kirkwood_ge00_init(&goflexnet_ge00_data);
-	kirkwood_sata_init(&goflexnet_sata_data);
-
-	platform_device_register(&goflexnet_leds);
 }
-- 
1.7.10
