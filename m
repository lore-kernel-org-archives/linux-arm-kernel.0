From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Feb 2014 11:32:20 +0800
Subject: [PATCH v3 2/8] ARM: dts: sun7i: Add GMAC clock node to sun7i DTSI
In-Reply-To: <1391398346-5094-1-git-send-email-wens@csie.org>
References: <1391398346-5094-1-git-send-email-wens@csie.org>
Message-ID: <1391398346-5094-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GMAC uses 1 of 2 sources for its transmit clock, depending on the
PHY interface mode. Add both sources as dummy clocks, and as parents
to the GMAC clock node.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 1595e9a..fc7f470 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -314,6 +314,34 @@
 		};
 
 		/*
+		 * The following two are dummy clocks, placeholders used
+		 * on gmac_tx clock. The actual frequency and availability
+		 * depends on the external PHY, operation mode and link
+		 * speed.
+		 */
+		mii_phy_tx_clk: clk at 2 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+			clock-output-names = "mii_phy_tx";
+		};
+
+		gmac_int_tx_clk: clk at 3 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <125000000>;
+			clock-output-names = "gmac_int_tx";
+		};
+
+		gmac_tx_clk: clk at 01c20164 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun7i-a20-gmac-clk";
+			reg = <0x01c20164 0x4>;
+			clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
+			clock-output-names = "gmac_tx";
+		};
+
+		/*
 		 * Dummy clock used by output clocks
 		 */
 		osc24M_32k: clk at 1 {
-- 
1.9.rc1
