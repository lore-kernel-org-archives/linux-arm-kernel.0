From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Dec 2012 15:49:15 +0100
Subject: [PATCH v2 16/20] arm: kirkwood: topkick: use Device Tree to probe SDIO
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1356101359-6054-17-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mvsdio driver has a Device Tree binding, and the SDIO
controller is declared in kirkwood.dtsi, migrate the topkick board to
use the Device Tree to probe the SDIO controller and mux the pins of
the SDIO interface properly.

The patch has been tested on the Topkick hardware. However, due to an
apparently unrelated problem, it is unable to detect the Wifi chip
connected on the SDIO bus.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
---
Changes since v1:
 * Remove the useless header inclusion from board-usi_topkick.c, now
   that the SDIO interface is probed from the Device Tree.
 * Reference the pmx_sdio muxing option from the DT node describing
   the SDIO interface, in order to get proper muxing of this
   interface.
---
 arch/arm/boot/dts/kirkwood-topkick.dts     |    9 +++++++++
 arch/arm/mach-kirkwood/board-usi_topkick.c |    6 ------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index 8f4a5b8..82329b5 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -55,6 +55,15 @@
 			status = "okay";
 			nr-ports = <1>;
 		};
+
+
+		mvsdio at 90000 {
+			pinctrl-0 = <&pmx_sdio>;
+			pinctrl-names = "default";
+			status = "okay";
+			/* No CD or WP GPIOs */
+		};
+
 	};
 
 	gpio-leds {
diff --git a/arch/arm/mach-kirkwood/board-usi_topkick.c b/arch/arm/mach-kirkwood/board-usi_topkick.c
index 15e69fc..6c83416 100644
--- a/arch/arm/mach-kirkwood/board-usi_topkick.c
+++ b/arch/arm/mach-kirkwood/board-usi_topkick.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
-#include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
@@ -22,10 +21,6 @@ static struct mv643xx_eth_platform_data topkick_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
 
-static struct mvsdio_platform_data topkick_mvsdio_data = {
-	/* unfortunately the CD signal has not been connected */
-};
-
 /*
  * GPIO LED layout
  *
@@ -77,5 +72,4 @@ void __init usi_topkick_init(void)
 	gpio_set_value(TOPKICK_SATA0_PWR_ENABLE, 1);
 
 	kirkwood_ge00_init(&topkick_ge00_data);
-	kirkwood_sdio_init(&topkick_mvsdio_data);
 }
-- 
1.7.9.5
