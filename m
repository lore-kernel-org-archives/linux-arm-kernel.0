From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Oct 2012 15:11:26 -0000
Subject: [RFC 06/11] ARM: Kirkwood: Convert dockstar to pinctrl.
In-Reply-To: <1350745663-5277-1-git-send-email-andrew@lunn.ch>
References: <1350745663-5277-1-git-send-email-andrew@lunn.ch>
Message-ID: <1350745663-5277-7-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-dockstar.dts |   21 +++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dockstar.c |   10 ----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index 08a5824..cc5e7ef 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -16,6 +16,27 @@
 	};
 
 	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			compatible = "marvell,88f6281-pinctrl";
+			reg = <0x10000 0x20>;
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
index f2fbb02..3bd916b 100644
--- a/arch/arm/mach-kirkwood/board-dockstar.c
+++ b/arch/arm/mach-kirkwood/board-dockstar.c
@@ -32,26 +32,16 @@
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
 	if (gpio_request(29, "USB Power Enable") != 0 ||
 	    gpio_direction_output(29, 1) != 0)
 		pr_err("can't setup GPIO 29 (USB Power Enable)\n");
-- 
1.7.10.4
