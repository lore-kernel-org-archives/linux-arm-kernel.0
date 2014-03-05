From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Mar 2014 00:27:12 +0800
Subject: [PATCH 2/5] ARM: sun6i: dt: Add GMAC clock node to the A31 DTSI
In-Reply-To: <1394036835-22007-1-git-send-email-wens@csie.org>
References: <1394036835-22007-1-git-send-email-wens@csie.org>
Message-ID: <1394036835-22007-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GMAC uses 1 of 2 sources for its transmit clock, depending on the
PHY interface mode. Add both sources as dummy clocks, and as parents
to the GMAC clock node.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 4d2a2bf..ee09e4c 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -229,6 +229,34 @@
 			clocks = <&osc24M>, <&pll6>;
 			clock-output-names = "spi3";
 		};
+
+		/*
+		 * The following two are dummy clocks, placeholders used in the gmac_tx
+		 * clock. The gmac driver will choose one parent depending on the PHY
+		 * interface mode, using clk_set_rate auto-reparenting.
+		 * The actual TX clock rate is not controlled by the gmac_tx clock.
+		 */
+		mii_phy_tx_clk: clk at 1 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+			clock-output-names = "mii_phy_tx";
+		};
+
+		gmac_int_tx_clk: clk at 2 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <125000000>;
+			clock-output-names = "gmac_int_tx";
+		};
+
+		gmac_tx_clk: clk at 01c200d0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun7i-a20-gmac-clk";
+			reg = <0x01c200d0 0x4>;
+			clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
+			clock-output-names = "gmac_tx";
+		};
 	};
 
 	soc at 01c00000 {
-- 
1.9.0
