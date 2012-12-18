From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:33:58 +0100
Subject: [PATCH 13/18] arm: kirkwood: mplcec4: use Device Tree to probe SDIO
In-Reply-To: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355841243-3254-14-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mvsdio driver has a Device Tree binding, and the SDIO
controller is declared in kirkwood.dtsi, migrate the mplcec4 board to
use the Device Tree to probe the SDIO controller.

This patch has not been tested, it remains to be tested by a person
having access to the hardware.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Stefan Peter <s.peter@mpl.ch>
---
 arch/arm/boot/dts/kirkwood-mplcec4.dts |    6 ++++++
 arch/arm/mach-kirkwood/board-mplcec4.c |    6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 262c654..ed10977 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -133,6 +133,12 @@
 			status = "okay";
 
 		};
+
+		mvsdio at 90000 {
+			status = "okay";
+			cd-gpios = <&gpio1 15 0>;
+			/* No WP GPIO */
+		};
 	};
 
 	gpio-leds {
diff --git a/arch/arm/mach-kirkwood/board-mplcec4.c b/arch/arm/mach-kirkwood/board-mplcec4.c
index 56bfe5a..183ff8a 100644
--- a/arch/arm/mach-kirkwood/board-mplcec4.c
+++ b/arch/arm/mach-kirkwood/board-mplcec4.c
@@ -24,11 +24,6 @@ static struct mv643xx_eth_platform_data mplcec4_ge01_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(2),
 };
 
-static struct mvsdio_platform_data mplcec4_mvsdio_data = {
-	.gpio_card_detect = 47,	/* MPP47 used as SD card detect */
-};
-
-
 void __init mplcec4_init(void)
 {
 	/*
@@ -36,7 +31,6 @@ void __init mplcec4_init(void)
 	 */
 	kirkwood_ge00_init(&mplcec4_ge00_data);
 	kirkwood_ge01_init(&mplcec4_ge01_data);
-	kirkwood_sdio_init(&mplcec4_mvsdio_data);
 	kirkwood_pcie_init(KW_PCIE0);
 }
 
-- 
1.7.9.5
