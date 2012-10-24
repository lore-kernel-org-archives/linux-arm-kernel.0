From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:53:52 +0200
Subject: [PATCH 7/9] ARM: Kirkwood: Convert ib62x0 to pinctrl.
In-Reply-To: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
Message-ID: <1351090434-30499-8-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-ib62x0.dts |   41 +++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-ib62x0.c |   21 -----------------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index 66794ed..713b39b 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -16,6 +16,47 @@
 	};
 
 	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			compatible = "marvell,88f6281-pinctrl";
+			reg = <0x10000 0x20>;
+
+			pinctrl-0 = < &pmx_nand
+				      &pmx_led_os_red &pmx_power_off
+				      &pmx_led_os_green &pmx_led_usb_transfer
+				      &pmx_button_reset &pmx_button_usb_copy >;
+			pinctrl-names = "default";
+
+			pmx_nand: pmx-nand {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
+					       "mpp04", "mpp5", "mpp18",
+					       "mpp19";
+				marvell,function = "nand";
+			};
+			pmx_led_os_red: pmx-led-os-red {
+				marvell,pins = "mpp22";
+				marvell,function = "gpio";
+			};
+			pmx_power_off: pmx-power-off {
+				marvell,pins = "mpp24";
+				marvell,function = "gpio";
+			};
+			pmx_led_os_green: pmx-led-os-green {
+				marvell,pins = "mpp25";
+				marvell,function = "gpio";
+			};
+			pmx_led_usb_transfer: pmx-led-usb-transfer {
+				marvell,pins = "mpp27";
+				marvell,function = "gpio";
+			};
+			pmx_button_reset: pmx-button-reset {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+			pmx_button_usb_copy: pmx-button-usb-copy {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+		};
 		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "okay";
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-kirkwood/board-ib62x0.c
index cfc47f8..1b2a4a4 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-kirkwood/board-ib62x0.c
@@ -23,7 +23,6 @@
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include "common.h"
-#include "mpp.h"
 
 #define IB62X0_GPIO_POWER_OFF	24
 
@@ -31,24 +30,6 @@ static struct mv643xx_eth_platform_data ib62x0_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
 };
 
-static unsigned int ib62x0_mpp_config[] __initdata = {
-	MPP0_NF_IO2,
-	MPP1_NF_IO3,
-	MPP2_NF_IO4,
-	MPP3_NF_IO5,
-	MPP4_NF_IO6,
-	MPP5_NF_IO7,
-	MPP18_NF_IO0,
-	MPP19_NF_IO1,
-	MPP22_GPIO,	/* OS LED red */
-	MPP24_GPIO,	/* Power off device */
-	MPP25_GPIO,	/* OS LED green */
-	MPP27_GPIO,	/* USB transfer LED */
-	MPP28_GPIO,	/* Reset button */
-	MPP29_GPIO,	/* USB Copy button */
-	0
-};
-
 static void ib62x0_power_off(void)
 {
 	gpio_set_value(IB62X0_GPIO_POWER_OFF, 1);
@@ -59,8 +40,6 @@ void __init ib62x0_init(void)
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	kirkwood_mpp_conf(ib62x0_mpp_config);
-
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&ib62x0_ge00_data);
 	if (gpio_request(IB62X0_GPIO_POWER_OFF, "ib62x0:power:off") == 0 &&
-- 
1.7.10.4
