From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Dec 2012 15:49:11 +0100
Subject: [PATCH v2 12/20] arm: kirkwood: dreamplug: use Device Tree to probe
 SDIO
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1356101359-6054-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mvsdio driver has a Device Tree binding, and the SDIO
controller is declared in kirkwood.dtsi, migrate the dreamplug board
to use the Device Tree to probe the SDIO controller and to mux this
interface properly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
---
Changes since v1:
 * Remove the useless header inclusion from board-dreamplug.c, now
   that the SDIO interface is probed from the Device Tree.
 * Reference the pmx_sdio muxing option from the DT node describing
   the SDIO interface, in order to get proper muxing of this
   interface.
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |    7 +++++++
 arch/arm/mach-kirkwood/board-dreamplug.c |    6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index f2d386c..ef2d8c7 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -74,6 +74,13 @@
 			status = "okay";
 			nr-ports = <1>;
 		};
+
+		mvsdio at 90000 {
+			pinctrl-0 = <&pmx_sdio>;
+			pinctrl-names = "default";
+			status = "okay";
+			/* No CD or WP GPIOs */
+		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index 08248e2..0903242 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
-#include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
 
 static struct mv643xx_eth_platform_data dreamplug_ge00_data = {
@@ -26,10 +25,6 @@ static struct mv643xx_eth_platform_data dreamplug_ge01_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
 };
 
-static struct mvsdio_platform_data dreamplug_mvsdio_data = {
-	/* unfortunately the CD signal has not been connected */
-};
-
 void __init dreamplug_init(void)
 {
 	/*
@@ -37,5 +32,4 @@ void __init dreamplug_init(void)
 	 */
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
-	kirkwood_sdio_init(&dreamplug_mvsdio_data);
 }
-- 
1.7.9.5
