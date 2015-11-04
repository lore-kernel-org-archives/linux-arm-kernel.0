From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  4 Nov 2015 07:44:56 -0800
Subject: [PATCH] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <1445964626-6484-2-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-2-git-send-email-jenskuske@gmail.com>
Message-ID: <1446651896-22902-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the fixed dividers from the PLL6 driver to be able to have a
reusable driver that can be used across several SoCs that share the same
controller, but don't have the same set of dividers for this clock, and to
also be reused multiple times in the same SoC, since we're droping the
clock name.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Hi Jens,

Here is an alternative (untested) patch to deal with the PLL6 issue you're
experiencing with the H3.

It doesn't rely on parsing clock-output-names that turns out to be pretty
fragile.

Let me know what you think,
Maxime

 arch/arm/boot/dts/sun6i-a31.dtsi     | 45 +++++++++++++++++++++---------------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 25 +++++++++++++-------
 arch/arm/boot/dts/sun8i-a23.dtsi     |  2 +-
 arch/arm/boot/dts/sun8i-a33.dtsi     |  4 ++--
 drivers/clk/sunxi/clk-sunxi.c        | 12 +---------
 5 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index b6ad7850fac6..85486797112e 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -65,7 +65,7 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&pll6 0>;
+			clocks = <&pll6d2>;
 			status = "disabled";
 		};
 
@@ -73,7 +73,7 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll6 0>;
+			clocks = <&pll6d2>;
 			status = "disabled";
 		};
 	};
@@ -201,11 +201,20 @@
 		};
 
 		pll6: clk at 01c20028 {
-			#clock-cells = <1>;
+			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll6", "pll6x2";
+			clock-output-names = "pll6";
+		};
+
+                pll6d2: pll6d2_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clocks = <&pll6d2>;
+			clock-output-names = "pll6d2";
 		};
 
 		cpu: cpu at 01c20050 {
@@ -235,7 +244,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6d2>;
 			clock-output-names = "ahb1";
 
 			/*
@@ -244,7 +253,7 @@
 			 * controller requires AHB1 clocked from PLL6.
 			 */
 			assigned-clocks = <&ahb1>;
-			assigned-clock-parents = <&pll6 0>;
+			assigned-clock-parents = <&pll6d2>;
 		};
 
 		ahb1_gates: clk at 01c20060 {
@@ -307,7 +316,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
+			clocks = <&osc32k>, <&osc24M>, <&pll6d2>, <&pll6d2>;
 			clock-output-names = "apb2";
 		};
 
@@ -331,7 +340,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "mmc0",
 					     "mmc0_output",
 					     "mmc0_sample";
@@ -341,7 +350,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "mmc1",
 					     "mmc1_output",
 					     "mmc1_sample";
@@ -351,7 +360,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "mmc2",
 					     "mmc2_output",
 					     "mmc2_sample";
@@ -361,7 +370,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20094 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "mmc3",
 					     "mmc3_output",
 					     "mmc3_sample";
@@ -371,7 +380,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "ss";
 		};
 
@@ -379,7 +388,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "spi0";
 		};
 
@@ -387,7 +396,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "spi1";
 		};
 
@@ -395,7 +404,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "spi2";
 		};
 
@@ -403,7 +412,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200ac 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "spi3";
 		};
 
@@ -1042,8 +1051,8 @@
 			ar100: ar100_clk {
 				compatible = "allwinner,sun6i-a31-ar100-clk";
 				#clock-cells = <0>;
-				clocks = <&osc32k>, <&osc24M>, <&pll6 0>,
-					 <&pll6 0>;
+				clocks = <&osc32k>, <&osc24M>, <&pll6d2>,
+					 <&pll6d2>;
 				clock-output-names = "ar100";
 			};
 
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 0c0964d4fa1f..f325a336a8e1 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -60,7 +60,7 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll6 0>;
+			clocks = <&pll6d2>;
 			status = "disabled";
 		};
 	};
@@ -129,11 +129,20 @@
 		};
 
 		pll6: clk at 01c20028 {
-			#clock-cells = <1>;
+			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll6", "pll6x2";
+			clock-output-names = "pll6";
+		};
+
+                pll6d2: pll6d2_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clocks = <&pll6>;
+			clock-output-names = "pll6d2";
 		};
 
 		cpu: cpu_clk at 01c20050 {
@@ -163,7 +172,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6d2>;
 			clock-output-names = "ahb1";
 		};
 
@@ -190,7 +199,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
+			clocks = <&osc32k>, <&osc24M>, <&pll6d2>, <&pll6d2>;
 			clock-output-names = "apb2";
 		};
 
@@ -213,7 +222,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "mmc0",
 					     "mmc0_output",
 					     "mmc0_sample";
@@ -223,7 +232,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "mmc1",
 					     "mmc1_output",
 					     "mmc1_sample";
@@ -233,7 +242,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "mmc2",
 					     "mmc2_output",
 					     "mmc2_sample";
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 92e6616979ea..709d7a833531 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -79,7 +79,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
 			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
+			clocks = <&osc24M>, <&pll6>, <&pll5>;
 			clock-output-names = "mbus";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 001d8402ca18..a40d458aa81f 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -103,7 +103,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
+			clocks = <&osc24M>, <&pll6d2>;
 			clock-output-names = "ss";
 		};
 
@@ -111,7 +111,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
 			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5>, <&pll11>;
+			clocks = <&osc24M>, <&pll6>, <&pll5>, <&pll11>;
 			clock-output-names = "mbus";
 		};
 	};
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 9c79af0c03b2..e4efc02e4cac 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -718,7 +718,6 @@ static const struct factors_data sun6i_a31_pll6_data __initconst = {
 	.enable = 31,
 	.table = &sun6i_a31_pll6_config,
 	.getter = sun6i_a31_get_pll6_factors,
-	.name = "pll6x2",
 };
 
 static const struct factors_data sun5i_a13_ahb_data __initconst = {
@@ -951,15 +950,6 @@ static const struct divs_data pll6_divs_data __initconst = {
 	}
 };
 
-static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
-	.factors = &sun6i_a31_pll6_data,
-	.ndivs = 2,
-	.div = {
-		{ .fixed = 2 }, /* normal output */
-		{ .self = 1 }, /* base factor clock, 2x */
-	}
-};
-
 /**
  * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
  *
@@ -1101,6 +1091,7 @@ free_clkdata:
 static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-a10-pll1-clk", .data = &sun4i_pll1_data,},
 	{.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
+	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
 	{.compatible = "allwinner,sun8i-a23-pll1-clk", .data = &sun8i_a23_pll1_data,},
 	{.compatible = "allwinner,sun7i-a20-pll4-clk", .data = &sun7i_a20_pll4_data,},
 	{.compatible = "allwinner,sun5i-a13-ahb-clk", .data = &sun5i_a13_ahb_data,},
@@ -1122,7 +1113,6 @@ static const struct of_device_id clk_div_match[] __initconst = {
 static const struct of_device_id clk_divs_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-a10-pll5-clk", .data = &pll5_divs_data,},
 	{.compatible = "allwinner,sun4i-a10-pll6-clk", .data = &pll6_divs_data,},
-	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_divs_data,},
 	{}
 };
 
-- 
2.6.2
