From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 17:00:49 +0100
Subject: [PATCH v2 07/14] ARM: Kirkwood: Convert dockstar to pinctrl.
In-Reply-To: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
References: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353168058-14043-8-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/kirkwood-dockstar.dts |   20 ++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dockstar.c |   10 ----------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index c0fbfdc..2e3dd34 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 /include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
 
 / {
 	model = "Seagate FreeAgent Dockstar";
@@ -16,6 +17,25 @@
 	};
 
 	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pinctrl-0 = < &pmx_usb_power_enable
+				      &pmx_led_green &pmx_led_orange >;
+			pinctrl-names = "default";
+
+			pmx_usb_power_enable: pmx-usb-power-enable {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+			pmx_led_green: pmx-led-green {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+			pmx_led_orange: pmx-led-orange {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+		};
 		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "ok";
diff --git a/arch/arm/mach-kirkwood/board-dockstar.c b/arch/arm/mach-kirkwood/board-dockstar.c
index 5c60fa1..a01f2fb 100644
--- a/arch/arm/mach-kirkwood/board-dockstar.c
+++ b/arch/arm/mach-kirkwood/board-dockstar.c
@@ -31,26 +31,16 @@
 #include <mach/bridge-regs.h>
 #include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
-#include "mpp.h"
 
 static struct mv643xx_eth_platform_data dockstar_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
 
-static unsigned int dockstar_mpp_config[] __initdata = {
-	MPP29_GPIO,	/* USB Power Enable */
-	MPP46_GPIO,	/* LED green */
-	MPP47_GPIO,	/* LED orange */
-	0
-};
-
 void __init dockstar_dt_init(void)
 {
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	kirkwood_mpp_conf(dockstar_mpp_config);
-
 	kirkwood_ehci_init();
 
 	kirkwood_ge00_init(&dockstar_ge00_data);
-- 
1.7.10.4
