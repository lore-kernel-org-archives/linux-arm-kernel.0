From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:33:59 +0100
Subject: [PATCH 14/18] arm: kirkwood: topkick: use Device Tree to probe SDIO
In-Reply-To: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355841243-3254-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mvsdio driver has a Device Tree binding, and the SDIO
controller is declared in kirkwood.dtsi, migrate the topkick board to
use the Device Tree to probe the SDIO controller.

The patch has been tested on the Topkick hardware. However, due to an
apparently unrelated problem, it is unable to detect the Wifi chip
connected on the SDIO bus.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-topkick.dts     |    7 +++++++
 arch/arm/mach-kirkwood/board-usi_topkick.c |    5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index c0de5a7..cb04f47 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -54,6 +54,13 @@
 			status = "okay";
 			nr-ports = <1>;
 		};
+
+
+		mvsdio at 90000 {
+			status = "okay";
+			/* No CD or WP GPIOs */
+		};
+
 	};
 
 	gpio-leds {
diff --git a/arch/arm/mach-kirkwood/board-usi_topkick.c b/arch/arm/mach-kirkwood/board-usi_topkick.c
index 15e69fc..89316da 100644
--- a/arch/arm/mach-kirkwood/board-usi_topkick.c
+++ b/arch/arm/mach-kirkwood/board-usi_topkick.c
@@ -22,10 +22,6 @@ static struct mv643xx_eth_platform_data topkick_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
 
-static struct mvsdio_platform_data topkick_mvsdio_data = {
-	/* unfortunately the CD signal has not been connected */
-};
-
 /*
  * GPIO LED layout
  *
@@ -77,5 +73,4 @@ void __init usi_topkick_init(void)
 	gpio_set_value(TOPKICK_SATA0_PWR_ENABLE, 1);
 
 	kirkwood_ge00_init(&topkick_ge00_data);
-	kirkwood_sdio_init(&topkick_mvsdio_data);
 }
-- 
1.7.9.5
