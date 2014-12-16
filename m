From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Dec 2014 22:38:54 +0100
Subject: [PATCH v2 2/4] ARM: sunxi: dt: Add sample and output mmc clocks
In-Reply-To: <1418765936-12542-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1418765936-12542-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1418765936-12542-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sample and output clocks for the MMC phase support.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 72 ++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/sun5i-a10s.dtsi | 54 +++++++++++++++++++++--------
 arch/arm/boot/dts/sun5i-a13.dtsi  | 44 +++++++++++++++++-------
 arch/arm/boot/dts/sun6i-a31.dtsi  | 72 ++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/sun7i-a20.dtsi  | 72 ++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/sun8i-a23.dtsi  | 54 +++++++++++++++++++++--------
 6 files changed, 265 insertions(+), 103 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7b4099fcf817..bb6b6ae95d82 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -226,35 +226,43 @@
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
@@ -398,8 +406,14 @@
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
@@ -407,8 +421,14 @@
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
@@ -416,8 +436,14 @@
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
@@ -425,8 +451,14 @@
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
index 1b76667f3182..0e011427615f 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -211,27 +211,33 @@
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
@@ -359,8 +365,14 @@
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
@@ -368,8 +380,14 @@
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
@@ -377,8 +395,14 @@
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
index c35217ea1f64..cbb63b750e08 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -195,27 +195,33 @@
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
@@ -327,8 +333,14 @@
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
@@ -336,8 +348,14 @@
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
index 62d932e9b7d1..3e7db5191516 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -241,35 +241,43 @@
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
@@ -366,8 +374,14 @@
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
 			interrupts = <0 60 4>;
@@ -377,8 +391,14 @@
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
 			interrupts = <0 61 4>;
@@ -388,8 +408,14 @@
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
 			interrupts = <0 62 4>;
@@ -399,8 +425,14 @@
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
 			interrupts = <0 63 4>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e21ce5992d56..fa51bffcaf1d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -274,35 +274,43 @@
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
@@ -518,8 +526,14 @@
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
 			interrupts = <0 32 4>;
 			status = "disabled";
 		};
@@ -527,8 +541,14 @@
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
 			interrupts = <0 33 4>;
 			status = "disabled";
 		};
@@ -536,8 +556,14 @@
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
 			interrupts = <0 34 4>;
 			status = "disabled";
 		};
@@ -545,8 +571,14 @@
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
 			interrupts = <0 35 4>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 2fcccf0cbcee..43a0688fffa0 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -209,27 +209,33 @@
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
@@ -259,8 +265,14 @@
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
 			interrupts = <0 60 4>;
@@ -270,8 +282,14 @@
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
 			interrupts = <0 61 4>;
@@ -281,8 +299,14 @@
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
 			interrupts = <0 62 4>;
-- 
2.2.0
