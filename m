From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 17:00:53 +0100
Subject: [PATCH v2 11/14] ARM: Kirkwood: Convert lsxl boards to pinctrl.
In-Reply-To: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
References: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353168058-14043-12-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/kirkwood-lsxl.dtsi |   66 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-lsxl.c  |   19 ----------
 2 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 65a8c52..f5362c4 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -1,4 +1,5 @@
 /include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
 
 / {
 	chosen {
@@ -6,6 +7,71 @@
 	};
 
 	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pinctrl-0 = < &pmx_power_hdd &pmx_usb_vbus
+				      &pmx_fan_low &pmx_fan_high
+				      &pmx_led_function_red &pmx_led_alarm
+				      &pmx_led_info &pmx_led_power
+				      &pmx_fan_lock &pmx_button_function
+				      &pmx_power_switch &pmx_power_auto_switch
+				      &pmx_led_function_blue >;
+			pinctrl-names = "default";
+
+			pmx_power_hdd: pmx-power-hdd {
+				marvell,pins = "mpp10";
+				marvell,function = "gpo";
+			};
+			pmx_usb_vbus: pmx-usb-vbus {
+				marvell,pins = "mpp11";
+				marvell,function = "gpio";
+			};
+			pmx_fan_high: pmx-fan-high {
+				marvell,pins = "mpp18";
+				marvell,function = "gpo";
+			};
+			pmx_fan_low: pmx-fan-low {
+				marvell,pins = "mpp19";
+				marvell,function = "gpo";
+			};
+			pmx_led_function_blue: pmx-led-function-blue {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+			pmx_led_alarm: pmx-led-alarm {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+			pmx_led_info: pmx-led-info {
+				marvell,pins = "mpp38";
+				marvell,function = "gpio";
+			};
+			pmx_led_power: pmx-led-power {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+			pmx_fan_lock: pmx-fan-lock {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+			pmx_button_function: pmx-button-function {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+			pmx_power_switch: pmx-power-switch {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+			pmx_power_auto_switch: pmx-power-auto-switch {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+			pmx_led_function_red: pmx-led-function_red {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+
+		};
 		sata at 80000 {
 			status = "okay";
 			nr-ports = <1>;
diff --git a/arch/arm/mach-kirkwood/board-lsxl.c b/arch/arm/mach-kirkwood/board-lsxl.c
index b9845c0..8346699 100644
--- a/arch/arm/mach-kirkwood/board-lsxl.c
+++ b/arch/arm/mach-kirkwood/board-lsxl.c
@@ -25,7 +25,6 @@
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include "common.h"
-#include "mpp.h"
 
 static struct mv643xx_eth_platform_data lsxl_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
@@ -35,23 +34,6 @@ static struct mv643xx_eth_platform_data lsxl_ge01_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
 };
 
-static unsigned int lsxl_mpp_config[] __initdata = {
-	MPP10_GPO,	/* HDD Power Enable */
-	MPP11_GPIO,	/* USB Vbus Enable */
-	MPP18_GPO,	/* FAN High Enable# */
-	MPP19_GPO,	/* FAN Low Enable# */
-	MPP36_GPIO,	/* Function Blue LED */
-	MPP37_GPIO,	/* Alarm LED */
-	MPP38_GPIO,	/* Info LED */
-	MPP39_GPIO,	/* Power LED */
-	MPP40_GPIO,	/* Fan Lock */
-	MPP41_GPIO,	/* Function Button */
-	MPP42_GPIO,	/* Power Switch */
-	MPP43_GPIO,	/* Power Auto Switch */
-	MPP48_GPIO,	/* Function Red LED */
-	0
-};
-
 #define LSXL_GPIO_FAN_HIGH	18
 #define LSXL_GPIO_FAN_LOW	19
 #define LSXL_GPIO_FAN_LOCK	40
@@ -115,7 +97,6 @@ void __init lsxl_init(void)
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	kirkwood_mpp_conf(lsxl_mpp_config);
 
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&lsxl_ge00_data);
-- 
1.7.10.4
