From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:33:57 +0100
Subject: [PATCH 12/18] arm: kirkwood: dreamplug: use Device Tree to probe SDIO
In-Reply-To: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355841243-3254-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mvsdio driver has a Device Tree binding, and the SDIO
controller is declared in kirkwood.dtsi, migrate the dreamplug board
to use the Device Tree to probe the SDIO controller.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |    5 +++++
 arch/arm/mach-kirkwood/board-dreamplug.c |    5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index f2d386c..0fceb76 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -74,6 +74,11 @@
 			status = "okay";
 			nr-ports = <1>;
 		};
+
+		mvsdio at 90000 {
+			status = "okay";
+			/* No CD or WP GPIOs */
+		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
index 08248e2..b712b7f 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-kirkwood/board-dreamplug.c
@@ -26,10 +26,6 @@ static struct mv643xx_eth_platform_data dreamplug_ge01_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
 };
 
-static struct mvsdio_platform_data dreamplug_mvsdio_data = {
-	/* unfortunately the CD signal has not been connected */
-};
-
 void __init dreamplug_init(void)
 {
 	/*
@@ -37,5 +33,4 @@ void __init dreamplug_init(void)
 	 */
 	kirkwood_ge00_init(&dreamplug_ge00_data);
 	kirkwood_ge01_init(&dreamplug_ge01_data);
-	kirkwood_sdio_init(&dreamplug_mvsdio_data);
 }
-- 
1.7.9.5
