From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 17:00:51 +0100
Subject: [PATCH v2 09/14] ARM: Kirkwood: Convert GoFlex Net to pinctrl.
In-Reply-To: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
References: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353168058-14043-10-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Joshua Coombs <josh.coombs@gmail.com>
---
 arch/arm/boot/dts/kirkwood-goflexnet.dts |   56 ++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-goflexnet.c |   18 ----------
 2 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index 84de887..1b133e0 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
 
 / {
 	model = "Seagate GoFlex Net";
@@ -16,6 +17,61 @@
 	};
 
 	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pinctrl-0 = < &pmx_usb_power_enable &pmx_led_orange
+				      &pmx_led_left_cap_0 &pmx_led_left_cap_1
+				      &pmx_led_left_cap_2 &pmx_led_left_cap_3
+				      &pmx_led_right_cap_0 &pmx_led_right_cap_1
+				      &pmx_led_right_cap_2 &pmx_led_right_cap_3
+				    >;
+			pinctrl-names = "default";
+
+			pmx_usb_power_enable: pmx-usb-power-enable {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+			pmx_led_right_cap_0: pmx-led_right_cap_0 {
+				marvell,pins = "mpp38";
+				marvell,function = "gpio";
+			};
+			pmx_led_right_cap_1: pmx-led_right_cap_1 {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+			pmx_led_right_cap_2: pmx-led_right_cap_2 {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+			pmx_led_right_cap_3: pmx-led_right_cap_3 {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+			pmx_led_left_cap_0: pmx-led_left_cap_0 {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+			pmx_led_left_cap_1: pmx-led_left_cap_1 {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+			pmx_led_left_cap_2: pmx-led_left_cap_2 {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+			pmx_led_left_cap_3: pmx-led_left_cap_3 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+			pmx_led_green: pmx-led_green {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+			pmx_led_orange: pmx-led_orange {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+		};
 		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "ok";
diff --git a/arch/arm/mach-kirkwood/board-goflexnet.c b/arch/arm/mach-kirkwood/board-goflexnet.c
index 7257a35..e00bb3e 100644
--- a/arch/arm/mach-kirkwood/board-goflexnet.c
+++ b/arch/arm/mach-kirkwood/board-goflexnet.c
@@ -33,34 +33,16 @@
 #include <mach/bridge-regs.h>
 #include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
-#include "mpp.h"
 
 static struct mv643xx_eth_platform_data goflexnet_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
 
-static unsigned int goflexnet_mpp_config[] __initdata = {
-	MPP29_GPIO,	/* USB Power Enable */
-	MPP47_GPIO,	/* LED Orange */
-	MPP46_GPIO,	/* LED Green */
-	MPP45_GPIO,	/* LED Left Capacity 3 */
-	MPP44_GPIO,	/* LED Left Capacity 2 */
-	MPP43_GPIO,	/* LED Left Capacity 1 */
-	MPP42_GPIO,	/* LED Left Capacity 0 */
-	MPP41_GPIO,	/* LED Right Capacity 3 */
-	MPP40_GPIO,	/* LED Right Capacity 2 */
-	MPP39_GPIO,	/* LED Right Capacity 1 */
-	MPP38_GPIO,	/* LED Right Capacity 0 */
-	0
-};
-
 void __init goflexnet_init(void)
 {
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	kirkwood_mpp_conf(goflexnet_mpp_config);
-
 	kirkwood_ehci_init();
 
 	kirkwood_ge00_init(&goflexnet_ge00_data);
-- 
1.7.10.4
