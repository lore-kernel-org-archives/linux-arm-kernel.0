From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Jan 2013 05:32:22 +0000
Subject: [RFC V2 PATCH 1/8] ARM: kirkwood: topkick: init mvsdio via DT
In-Reply-To: <cover.1359091286.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
Message-ID: <e99a647c7c1eae5dfee3b1ccf9f6803c3c859962.1359091286.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-topkick.dts     | 7 +++++++
 arch/arm/mach-kirkwood/board-usi_topkick.c | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index cd15452..23c2ddc 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -54,6 +54,13 @@
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
diff --git a/arch/arm/mach-kirkwood/board-usi_topkick.c b/arch/arm/mach-kirkwood/board-usi_topkick.c
index 23d2dd1..95f0711 100644
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
@@ -73,5 +68,4 @@ void __init usi_topkick_init(void)
 
 
 	kirkwood_ge00_init(&topkick_ge00_data);
-	kirkwood_sdio_init(&topkick_mvsdio_data);
 }
-- 
1.8.1.1
