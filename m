From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Sep 2014 00:48:06 +0800
Subject: [PATCH 2/2] ARM: dts: sun8i: Add PLL6 and MBUS clock nodes
In-Reply-To: <1410540486-22243-1-git-send-email-wens@csie.org>
References: <1410540486-22243-1-git-send-email-wens@csie.org>
Message-ID: <1410540486-22243-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the clock driver supports PLL6 and MBUS on sun8i correctly,
add the corresponding clock nodes to the dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index fc0d023..c32091e 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -74,13 +74,30 @@
 		};
 
 		/* dummy clock until actually implemented */
-		pll6: pll6_clk {
+		pll5: pll5_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-			clock-frequency = <600000000>;
+			clock-frequency = <0>;
+			clock-output-names = "pll5";
+		};
+
+		pll6: clk at 01c20028 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun6i-a31-pll6-clk";
+			reg = <0x01c20028 0x4>;
+			clocks = <&osc24M>;
 			clock-output-names = "pll6";
 		};
 
+		pll6x2: pll6x2_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <1>;
+			clock-mult = <2>;
+			clocks = <&pll6>;
+			clock-output-names = "pll6x2";
+		};
+
 		cpu: cpu_clk at 01c20050 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-cpu-clk";
@@ -243,6 +260,14 @@
 			clocks = <&mmc2_clk>;
 			clock-output-names = "mmc2_sample";
 		};
+
+		mbus_clk: clk at 01c2015c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun8i-a23-mbus-clk";
+			reg = <0x01c2015c 0x4>;
+			clocks = <&osc24M>, <&pll6x2>, <&pll5>;
+			clock-output-names = "mbus";
+		};
 	};
 
 	soc at 01c00000 {
-- 
2.1.0
