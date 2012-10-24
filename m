From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:53:50 +0200
Subject: [PATCH 5/9] ARM: Kirkwood: Convert dreamplug to pinctrl.
In-Reply-To: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
Message-ID: <1351090434-30499-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |   26 ++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dreamplug.c |   14 --------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 26e281f..4d1ef46 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -16,6 +16,32 @@
 	};
 
 	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			compatible = "marvell,88f6281-pinctrl";
+			reg = <0x10000 0x20>;
+
+			pinctrl-0 = < &pmx_spi
+				      &pmx_led_bluetooth &pmx_led_wifi
+				      &pmx_led_wifi_ap >;
+			pinctrl-names = "default";
+
+			pmx_spi: pmx-spi {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
+				marvell,function = "spi";
+			};
+			pmx_led_bluetooth: pmx-led-bluetooth {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+			pmx_led_wifi: pmx-led-wifi {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+			pmx_led_wifi_ap: pmx-led-wifi-ap {
+				marvell,pins = "mpp49";
+				marvell,function = "gpio";
+			};
+		};
 		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "ok";
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index 20af53a..db0c280 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -32,7 +32,6 @@
 #include <mach/bridge-regs.h>
 #include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
-#include "mpp.h"
 
 static struct mv643xx_eth_platform_data dreamplug_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
@@ -46,24 +45,11 @@ static struct mvsdio_platform_data dreamplug_mvsdio_data = {
 	/* unfortunately the CD signal has not been connected */
 };
 
-static unsigned int dreamplug_mpp_config[] __initdata = {
-	MPP0_SPI_SCn,
-	MPP1_SPI_MOSI,
-	MPP2_SPI_SCK,
-	MPP3_SPI_MISO,
-	MPP47_GPIO,	/* Bluetooth LED */
-	MPP48_GPIO,	/* Wifi LED */
-	MPP49_GPIO,	/* Wifi AP LED */
-	0
-};
-
 void __init dreamplug_init(void)
 {
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
-	kirkwood_mpp_conf(dreamplug_mpp_config);
-
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
-- 
1.7.10.4
