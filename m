From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Jan 2015 21:00:55 +0100
Subject: [PATCH v3 2/4] ARM: sunxi: dt: Add sample and output mmc clocks
In-Reply-To: <1421006457-23631-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1421006457-23631-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1421006457-23631-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sample and output clocks for the MMC phase support.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 72 ++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/sun5i-a10s.dtsi | 54 +++++++++++++++++++++--------
 arch/arm/boot/dts/sun5i-a13.dtsi  | 44 +++++++++++++++++-------
 arch/arm/boot/dts/sun6i-a31.dtsi  | 72 ++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/sun7i-a20.dtsi  | 72 ++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/sun8i-a23.dtsi  | 54 +++++++++++++++++++++--------
 6 files changed, 265 insertions(+), 103 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7fb4e912f510..232030433eb7 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -242,35 +242,43 @@
 		};
 
 		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc0";
+			clock-output-names = "mmc0",
+					     "mmc0_output",
+					     "mmc0_sample";
 		};
 
 		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc1";
+			clock-output-names = "mmc1",
+					     "mmc1_output",
+					     "mmc1_sample";
 		};
 
 		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc2";
+			clock-output-names = "mmc2",
+					     "mmc2_output",
+					     "mmc2_sample";
 		};
 
 		mmc3_clk: clk at 01c20094 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20094 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc3";
+			clock-output-names = "mmc3",
+					     "mmc3_output",
+					     "mmc3_sample";
 		};
 
 		ts_clk: clk at 01c20098 {
@@ -416,8 +424,14 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 8>,
+				 <&mmc0_clk 0>,
+				 <&mmc0_clk 1>,
+				 <&mmc0_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <32>;
 			status = "disabled";
 		};
@@ -425,8 +439,14 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb_gates 9>, <&mmc1_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 9>,
+				 <&mmc1_clk 0>,
+				 <&mmc1_clk 1>,
+				 <&mmc1_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <33>;
 			status = "disabled";
 		};
@@ -434,8 +454,14 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 10>,
+				 <&mmc2_clk 0>,
+				 <&mmc2_clk 1>,
+				 <&mmc2_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <34>;
 			status = "disabled";
 		};
@@ -443,8 +469,14 @@
 		mmc3: mmc at 01c12000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ahb_gates 11>, <&mmc3_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 11>,
+				 <&mmc3_clk 0>,
+				 <&mmc3_clk 1>,
+				 <&mmc3_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <35>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 7ab6d32078b6..1cdc6860e66f 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -214,27 +214,33 @@
 		};
 
 		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc0";
+			clock-output-names = "mmc0",
+					     "mmc0_output",
+					     "mmc0_sample";
 		};
 
 		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc1";
+			clock-output-names = "mmc1",
+					     "mmc1_output",
+					     "mmc1_sample";
 		};
 
 		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc2";
+			clock-output-names = "mmc2",
+					     "mmc2_output",
+					     "mmc2_sample";
 		};
 
 		ts_clk: clk at 01c20098 {
@@ -364,8 +370,14 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 8>,
+				 <&mmc0_clk 0>,
+				 <&mmc0_clk 1>,
+				 <&mmc0_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <32>;
 			status = "disabled";
 		};
@@ -373,8 +385,14 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb_gates 9>, <&mmc1_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 9>,
+				 <&mmc1_clk 0>,
+				 <&mmc1_clk 1>,
+				 <&mmc1_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <33>;
 			status = "disabled";
 		};
@@ -382,8 +400,14 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 10>,
+				 <&mmc2_clk 0>,
+				 <&mmc2_clk 1>,
+				 <&mmc2_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <34>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index dee2aa5bc9ed..dbf1cdd976d4 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -214,27 +214,33 @@
 		};
 
 		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc0";
+			clock-output-names = "mmc0",
+					     "mmc0_output",
+					     "mmc0_sample";
 		};
 
 		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc1";
+			clock-output-names = "mmc1",
+					     "mmc1_output",
+					     "mmc1_sample";
 		};
 
 		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc2";
+			clock-output-names = "mmc2",
+					     "mmc2_output",
+					     "mmc2_sample";
 		};
 
 		ts_clk: clk at 01c20098 {
@@ -348,8 +354,14 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 8>,
+				 <&mmc0_clk 0>,
+				 <&mmc0_clk 1>,
+				 <&mmc0_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <32>;
 			status = "disabled";
 		};
@@ -357,8 +369,14 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 10>,
+				 <&mmc2_clk 0>,
+				 <&mmc2_clk 1>,
+				 <&mmc2_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <34>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 69e5401df662..a51652258965 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -245,35 +245,43 @@
 		};
 
 		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc0";
+			clock-output-names = "mmc0",
+					     "mmc0_output",
+					     "mmc0_sample";
 		};
 
 		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc1";
+			clock-output-names = "mmc1",
+					     "mmc1_output",
+					     "mmc1_sample";
 		};
 
 		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc2";
+			clock-output-names = "mmc2",
+					     "mmc2_output",
+					     "mmc2_sample";
 		};
 
 		mmc3_clk: clk at 01c20094 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20094 0x4>;
 			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc3";
+			clock-output-names = "mmc3",
+					     "mmc3_output",
+					     "mmc3_sample";
 		};
 
 		spi0_clk: clk at 01c200a0 {
@@ -370,8 +378,14 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb1_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 8>,
+				 <&mmc0_clk 0>,
+				 <&mmc0_clk 1>,
+				 <&mmc0_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			resets = <&ahb1_rst 8>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
@@ -381,8 +395,14 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb1_gates 9>, <&mmc1_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 9>,
+				 <&mmc1_clk 0>,
+				 <&mmc1_clk 1>,
+				 <&mmc1_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			resets = <&ahb1_rst 9>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
@@ -392,8 +412,14 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb1_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 10>,
+				 <&mmc2_clk 0>,
+				 <&mmc2_clk 1>,
+				 <&mmc2_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			resets = <&ahb1_rst 10>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
@@ -403,8 +429,14 @@
 		mmc3: mmc at 01c12000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ahb1_gates 11>, <&mmc3_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 11>,
+				 <&mmc3_clk 0>,
+				 <&mmc3_clk 1>,
+				 <&mmc3_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			resets = <&ahb1_rst 11>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c2e964939991..edab255d2137 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -295,35 +295,43 @@
 		};
 
 		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc0";
+			clock-output-names = "mmc0",
+					     "mmc0_output",
+					     "mmc0_sample";
 		};
 
 		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc1";
+			clock-output-names = "mmc1",
+					     "mmc1_output",
+					     "mmc1_sample";
 		};
 
 		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc2";
+			clock-output-names = "mmc2",
+					     "mmc2_output",
+					     "mmc2_sample";
 		};
 
 		mmc3_clk: clk at 01c20094 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20094 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc3";
+			clock-output-names = "mmc3",
+					     "mmc3_output",
+					     "mmc3_sample";
 		};
 
 		ts_clk: clk at 01c20098 {
@@ -541,8 +549,14 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 8>,
+				 <&mmc0_clk 0>,
+				 <&mmc0_clk 1>,
+				 <&mmc0_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -550,8 +564,14 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb_gates 9>, <&mmc1_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 9>,
+				 <&mmc1_clk 0>,
+				 <&mmc1_clk 1>,
+				 <&mmc1_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -559,8 +579,14 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 10>,
+				 <&mmc2_clk 0>,
+				 <&mmc2_clk 1>,
+				 <&mmc2_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -568,8 +594,14 @@
 		mmc3: mmc at 01c12000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ahb_gates 11>, <&mmc3_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb_gates 11>,
+				 <&mmc3_clk 0>,
+				 <&mmc3_clk 1>,
+				 <&mmc3_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index e470dd5dbc70..f4cb33823b5b 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -213,27 +213,33 @@
 		};
 
 		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc0";
+			clock-output-names = "mmc0",
+					     "mmc0_output",
+					     "mmc0_sample";
 		};
 
 		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc1";
+			clock-output-names = "mmc1",
+					     "mmc1_output",
+					     "mmc1_sample";
 		};
 
 		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc2";
+			clock-output-names = "mmc2",
+					     "mmc2_output",
+					     "mmc2_sample";
 		};
 
 		mbus_clk: clk at 01c2015c {
@@ -263,8 +269,14 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb1_gates 8>, <&mmc0_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 8>,
+				 <&mmc0_clk 0>,
+				 <&mmc0_clk 1>,
+				 <&mmc0_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			resets = <&ahb1_rst 8>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
@@ -274,8 +286,14 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb1_gates 9>, <&mmc1_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 9>,
+				 <&mmc1_clk 0>,
+				 <&mmc1_clk 1>,
+				 <&mmc1_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			resets = <&ahb1_rst 9>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
@@ -285,8 +303,14 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb1_gates 10>, <&mmc2_clk>;
-			clock-names = "ahb", "mmc";
+			clocks = <&ahb1_gates 10>,
+				 <&mmc2_clk 0>,
+				 <&mmc2_clk 1>,
+				 <&mmc2_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
 			resets = <&ahb1_rst 10>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.2.1
