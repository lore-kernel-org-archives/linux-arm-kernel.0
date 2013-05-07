From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Tue,  7 May 2013 17:52:21 +0200
Subject: [PATCH 3/3] ARM: kirkwood: remove clock gating disabling for
 km_kirkwood
In-Reply-To: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
References: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <1367941941-19152-4-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new clock gating controller is available for the prestera-kw kirkwood
variant. This controller does not enable the unavailable clk gates.

This patch removes the fixes from the board-km_kirkwood file and enables
the correct clk gating controller for kirkwood-98dx4122.dtsi.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi   |  7 +++++++
 arch/arm/mach-kirkwood/board-km_kirkwood.c | 15 ---------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
index 3271e4c..8c73673 100644
--- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
+++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
@@ -27,5 +27,12 @@
 				marvell,function = "uart1";
 			};
 		};
+
+		gate_clk: clock-gating-control at 2011c {
+			compatible = "marvell,prestera-kw-gating-clock";
+			reg = <0x2011c 0x4>;
+			clocks = <&core_clk 0>;
+			#clock-cells = <1>;
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/board-km_kirkwood.c b/arch/arm/mach-kirkwood/board-km_kirkwood.c
index 44e4605..f1a6ab7 100644
--- a/arch/arm/mach-kirkwood/board-km_kirkwood.c
+++ b/arch/arm/mach-kirkwood/board-km_kirkwood.c
@@ -25,20 +25,5 @@ static struct mv643xx_eth_platform_data km_kirkwood_ge00_data = {
 
 void __init km_kirkwood_init(void)
 {
-	struct clk *sata_clk;
-	/*
-	 * Our variant of kirkwood (integrated in the Bobcat) hangs on accessing
-	 * SATA bits (14-15) of the Clock Gating Control Register. Since these
-	 * devices are also not present in this variant, their clocks get
-	 * disabled because unused when clk_disable_unused() gets called.
-	 * That's why we change the flags to these clocks to CLK_IGNORE_UNUSED
-	 */
-	sata_clk = clk_get_sys("sata_mv.0", "0");
-	if (!IS_ERR(sata_clk))
-		sata_clk->flags |= CLK_IGNORE_UNUSED;
-	sata_clk = clk_get_sys("sata_mv.0", "1");
-	if (!IS_ERR(sata_clk))
-		sata_clk->flags |= CLK_IGNORE_UNUSED;
-
 	kirkwood_ge00_init(&km_kirkwood_ge00_data);
 }
-- 
1.8.0.1
