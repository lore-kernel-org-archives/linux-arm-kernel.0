From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Nov 2014 15:58:58 +0800
Subject: [PATCH v4] ARM: dts: sun8i: Add PLL6 and MBUS clock nodes
Message-ID: <1416815938-29842-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the clock driver supports PLL6 and MBUS on sun8i correctly,
add the corresponding clock nodes to the dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This was originally a 2 patch series. The mbus clock driver was merged
during the last release. This patch requires the sun6i ahb1 clk unifying
series.

Changes since v3:

  - Rebased onto latest sun6i ahb1 clk unify patches, using the new divs
    clocks style pll6.

---
 arch/arm/boot/dts/sun8i-a23.dtsi | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 726b613..2fcccf0 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -110,11 +110,19 @@
 		};
 
 		/* dummy clock until actually implemented */
-		pll6: pll6_clk {
+		pll5: pll5_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-			clock-frequency = <600000000>;
-			clock-output-names = "pll6";
+			clock-frequency = <0>;
+			clock-output-names = "pll5";
+		};
+
+		pll6: clk at 01c20028 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun6i-a31-pll6-clk";
+			reg = <0x01c20028 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll6", "pll6x2";
 		};
 
 		cpu: cpu_clk at 01c20050 {
@@ -144,7 +152,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
 			clock-output-names = "ahb1";
 		};
 
@@ -185,7 +193,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
 			clock-output-names = "apb2";
 		};
 
@@ -204,7 +212,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc0";
 		};
 
@@ -212,7 +220,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc1";
 		};
 
@@ -220,9 +228,17 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc2";
 		};
+
+		mbus_clk: clk at 01c2015c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun8i-a23-mbus-clk";
+			reg = <0x01c2015c 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
+			clock-output-names = "mbus";
+		};
 	};
 
 	soc at 01c00000 {
-- 
2.1.3
