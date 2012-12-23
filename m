From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sun, 23 Dec 2012 11:34:37 +0900
Subject: [PATCH 4/4] ARM: Kirkwood: Convert openblocks A6 board to pinctrl
In-Reply-To: <1356230077-15340-1-git-send-email-iwamatsu@nigauri.org>
References: <1356230077-15340-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <1356230077-15340-4-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts |  116 ++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-openblocks_a6.c |   44 ----------
 2 files changed, 116 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 49d3d74..ede7fe0d 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -75,6 +75,122 @@
 				reg = <0x30>;
 			};
 		};
+
+		pinctrl: pinctrl at 10000 {
+			pinctrl-0 = < &pmx_nand &pmx_uart0
+				&pmx_uart1 &pmx_twsi1
+				&pmx_dip_sw0 &pmx_dip_sw1
+				&pmx_dip_sw2 &pmx_dip_sw3
+				&pmx_gpio_0 &pmx_gpio_1
+				&pmx_gpio_2 &pmx_gpio_3
+				&pmx_gpio_4 &pmx_gpio_5
+				&pmx_gpio_6 &pmx_gpio_7
+				&pmx_led_red &pmx_led_green
+				&pmx_led_yellow >;
+			pinctrl-names = "default";
+
+			pmx_uart0: pmx-uart0 {
+				marvell,pins = "mpp10", "mpp11", "mpp15",
+					"mpp16";
+				marvell,function = "uart0";
+			};
+
+			pmx_uart1: pmx-uart1 {
+				marvell,pins = "mpp13", "mpp14", "mpp8",
+					"mpp9";
+				marvell,function = "uart1";
+			};
+
+			pmx_sysrst: pmx-sysrst {
+				marvell,pins = "mpp6";
+				marvell,function = "sysrst";
+			};
+
+			pmx_dip_sw0: pmx-dip-sw0 {
+				marvell,pins = "mpp20";
+				marvell,function = "gpio";
+			};
+
+			pmx_dip_sw1: pmx-dip-sw1 {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+
+			pmx_dip_sw2: pmx-dip-sw2 {
+				marvell,pins = "mpp22";
+				marvell,function = "gpio";
+			};
+
+			pmx_dip_sw3: pmx-dip-sw3 {
+				marvell,pins = "mpp23";
+				marvell,function = "gpio";
+			};
+
+			pmx_gpio_0: pmx-gpio-0 {
+				marvell,pins = "mpp24";
+				marvell,function = "gpio";
+			};
+
+			pmx_gpio_1: pmx-gpio-1 {
+				marvell,pins = "mpp25";
+				marvell,function = "gpio";
+			};
+
+			pmx_gpio_2: pmx-gpio-2 {
+				marvell,pins = "mpp26";
+				marvell,function = "gpio";
+			};
+
+			pmx_gpio_3: pmx-gpio-3 {
+				marvell,pins = "mpp27";
+				marvell,function = "gpio";
+			};
+
+			pmx_gpio_4: pmx-gpio-4 {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+
+			pmx_gpio_5: pmx-gpio-5 {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+
+			pmx_gpio_6: pmx-gpio-6 {
+				marvell,pins = "mpp30";
+				marvell,function = "gpio";
+			};
+
+			pmx_gpio_7: pmx-gpio-7 {
+				marvell,pins = "mpp31";
+				marvell,function = "gpio";
+			};
+
+			pmx_gpio_init: pmx-init {
+				marvell,pins = "mpp38";
+				marvell,function = "gpio";
+			};
+
+			pmx_usb_oc: pmx-usb-oc {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_red: pmx-led-red {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_green: pmx-led-green {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_yellow: pmx-led-yellow {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/mach-kirkwood/board-openblocks_a6.c b/arch/arm/mach-kirkwood/board-openblocks_a6.c
index 815fc64..b11d8fd 100644
--- a/arch/arm/mach-kirkwood/board-openblocks_a6.c
+++ b/arch/arm/mach-kirkwood/board-openblocks_a6.c
@@ -11,60 +11,16 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/clk.h>
-#include <linux/clk-private.h>
 #include "common.h"
-#include "mpp.h"
 
 static struct mv643xx_eth_platform_data openblocks_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
 
-static unsigned int openblocks_a6_mpp_config[] __initdata = {
-	MPP0_NF_IO2,
-	MPP1_NF_IO3,
-	MPP2_NF_IO4,
-	MPP3_NF_IO5,
-	MPP4_NF_IO6,
-	MPP5_NF_IO7,
-	MPP6_SYSRST_OUTn,
-	MPP8_UART1_RTS,
-	MPP9_UART1_CTS,
-	MPP10_UART0_TXD,
-	MPP11_UART0_RXD,
-	MPP13_UART1_TXD,
-	MPP14_UART1_RXD,
-	MPP15_UART0_RTS,
-	MPP16_UART0_CTS,
-	MPP18_NF_IO0,
-	MPP19_NF_IO1,
-	MPP20_GPIO, /* DIP SW0 */
-	MPP21_GPIO, /* DIP SW1 */
-	MPP22_GPIO, /* DIP SW2 */
-	MPP23_GPIO, /* DIP SW3 */
-	MPP24_GPIO, /* GPIO 0 */
-	MPP25_GPIO, /* GPIO 1 */
-	MPP26_GPIO, /* GPIO 2 */
-	MPP27_GPIO, /* GPIO 3 */
-	MPP28_GPIO, /* GPIO 4 */
-	MPP29_GPIO, /* GPIO 5 */
-	MPP30_GPIO, /* GPIO 6 */
-	MPP31_GPIO, /* GPIO 7 */
-	MPP36_TW1_SDA,
-	MPP37_TW1_SCK,
-	MPP38_GPIO, /* INIT */
-	MPP39_GPIO, /* USB OC */
-	MPP41_GPIO, /* LED: Red */
-	MPP42_GPIO, /* LED: Green */
-	MPP43_GPIO, /* LED: Yellow */
-	0,
-};
-
 void __init openblocks_a6_init(void)
 {
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	kirkwood_mpp_conf(openblocks_a6_mpp_config);
 	kirkwood_ge00_init(&openblocks_ge00_data);
 }
-- 
1.7.10.4
