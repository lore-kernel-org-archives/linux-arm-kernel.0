From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 12 Feb 2016 17:59:59 +0000
Subject: [RFC PATCH 3/4] clk: sunxi: revert .dtsi changes for DTs with a
 sun6i_a31_pll6 clock
In-Reply-To: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
References: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1455300000-18723-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changes made to the driver broke compatibilty with older DTs.
For most of the boards the new driver does not bring any advantage,
so for the sake of compatibility bring them back to the previous
version.
This also affects the new H3 .dtsi - at least for this patch, the
next one will fix this.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                  | 36 +++++++++++-----------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi              | 25 +++++----------
 arch/arm/boot/dts/sun8i-a23.dtsi                  |  2 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                  |  4 +--
 arch/arm/boot/dts/sun8i-h3.dtsi                   | 37 +++++++++--------------
 drivers/clk/sunxi/clk-sunxi.c                     |  8 ++++-
 7 files changed, 51 insertions(+), 63 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 966dcaf..c09f59b 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -88,7 +88,7 @@ Required properties for all clocks:
 - #clock-cells : from common clock binding; shall be set to 0 except for
 	the following compatibles where it shall be set to 1:
 	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
-	"allwinner,sun4i-pll6-clk",
+	"allwinner,sun4i-pll6-clk", "allwinner,sun6i-a31-pll6-clk",
 	"allwinner,*-usb-clk", "allwinner,*-mmc-clk",
 	"allwinner,*-mmc-config-clk"
 - clock-output-names : shall be the corresponding names of the outputs.
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 7a198dc..1867af2 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -65,7 +65,7 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&pll6>;
+			clocks = <&pll6 0>;
 			status = "disabled";
 		};
 
@@ -73,7 +73,7 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll6>;
+			clocks = <&pll6 0>;
 			status = "disabled";
 		};
 	};
@@ -201,11 +201,11 @@
 		};
 
 		pll6: clk at 01c20028 {
-			#clock-cells = <0>;
+			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll6";
+			clock-output-names = "pll6", "pll6x2";
 		};
 
 		cpu: cpu at 01c20050 {
@@ -235,7 +235,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
 			clock-output-names = "ahb1";
 
 			/*
@@ -244,7 +244,7 @@
 			 * controller requires AHB1 clocked from PLL6.
 			 */
 			assigned-clocks = <&ahb1>;
-			assigned-clock-parents = <&pll6>;
+			assigned-clock-parents = <&pll6 0>;
 		};
 
 		ahb1_gates: clk at 01c20060 {
@@ -307,7 +307,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
 			clock-output-names = "apb2";
 		};
 
@@ -331,7 +331,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc0",
 					     "mmc0_output",
 					     "mmc0_sample";
@@ -341,7 +341,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc1",
 					     "mmc1_output",
 					     "mmc1_sample";
@@ -351,7 +351,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc2",
 					     "mmc2_output",
 					     "mmc2_sample";
@@ -361,7 +361,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20094 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc3",
 					     "mmc3_output",
 					     "mmc3_sample";
@@ -371,7 +371,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "ss";
 		};
 
@@ -379,7 +379,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi0";
 		};
 
@@ -387,7 +387,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi1";
 		};
 
@@ -395,7 +395,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi2";
 		};
 
@@ -403,7 +403,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200ac 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi3";
 		};
 
@@ -1052,8 +1052,8 @@
 			ar100: ar100_clk {
 				compatible = "allwinner,sun6i-a31-ar100-clk";
 				#clock-cells = <0>;
-				clocks = <&osc32k>, <&osc24M>, <&pll6>,
-					 <&pll6>;
+				clocks = <&osc32k>, <&osc24M>, <&pll6 0>,
+					 <&pll6 0>;
 				clock-output-names = "ar100";
 			};
 
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 783b4b8..7e05e09 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -60,7 +60,7 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll6>;
+			clocks = <&pll6 0>;
 			status = "disabled";
 		};
 	};
@@ -129,20 +129,11 @@
 		};
 
 		pll6: clk at 01c20028 {
-			#clock-cells = <0>;
+			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll6";
-		};
-
-                pll6x2: pll6x2_clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clock-div = <1>;
-			clock-mult = <2>;
-			clocks = <&pll6>;
-			clock-output-names = "pll6-2x";
+			clock-output-names = "pll6", "pll6x2";
 		};
 
 		cpu: cpu_clk at 01c20050 {
@@ -172,7 +163,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
 			clock-output-names = "ahb1";
 		};
 
@@ -199,7 +190,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
 			clock-output-names = "apb2";
 		};
 
@@ -222,7 +213,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc0",
 					     "mmc0_output",
 					     "mmc0_sample";
@@ -232,7 +223,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc1",
 					     "mmc1_output",
 					     "mmc1_sample";
@@ -242,7 +233,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc2",
 					     "mmc2_output",
 					     "mmc2_sample";
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 5e589c1..92e6616 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -79,7 +79,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
 			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6x2>, <&pll5>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
 			clock-output-names = "mbus";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index f3eb618..001d840 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -103,7 +103,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "ss";
 		};
 
@@ -111,7 +111,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
 			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6x2>, <&pll5>, <&pll11>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5>, <&pll11>;
 			clock-output-names = "mbus";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 6f6b4e4..1524130e 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -121,11 +121,11 @@
 		};
 
 		pll6: clk at 01c20028 {
-			#clock-cells = <0>;
+			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll6";
+			clock-output-names = "pll6", "pll6x2";
 		};
 
 		pll6d2: pll6d2_clk {
@@ -133,24 +133,15 @@
 			compatible = "fixed-factor-clock";
 			clock-div = <2>;
 			clock-mult = <1>;
-			clocks = <&pll6>;
-			clock-output-names = "pll6-d2";
+			clocks = <&pll6 0>;
+			clock-output-names = "pll6d2";
 		};
 
-		pll6x2: pll6x2_clk {
+		/* dummy clock until pll6 can be reused */
+		pll8: pll8_clk {
 			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
-			clock-div = <1>;
-			clock-mult = <2>;
-			clocks = <&pll6>;
-			clock-output-names = "pll6-2x";
-		};
-
-		pll8: clk at 01c20044 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun6i-a31-pll6-clk";
-			reg = <0x01c20044 0x4>;
-			clocks = <&osc24M>;
+			compatible = "fixed-clock";
+			clock-frequency = <1>;
 			clock-output-names = "pll8";
 		};
 
@@ -174,7 +165,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
 			clock-output-names = "ahb1";
 		};
 
@@ -198,7 +189,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
 			clock-output-names = "apb2";
 		};
 
@@ -252,7 +243,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6>, <&pll8>;
+			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
 			clock-output-names = "mmc0",
 					     "mmc0_output",
 					     "mmc0_sample";
@@ -262,7 +253,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6>, <&pll8>;
+			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
 			clock-output-names = "mmc1",
 					     "mmc1_output",
 					     "mmc1_sample";
@@ -272,7 +263,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6>, <&pll8>;
+			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
 			clock-output-names = "mmc2",
 					     "mmc2_output",
 					     "mmc2_sample";
@@ -282,7 +273,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
 			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6x2>, <&pll5>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
 			clock-output-names = "mbus";
 		};
 	};
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 12131ba..0ed0a8e 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -648,7 +648,7 @@ static void __init sun6i_pll_clk_setup(struct device_node *node)
 {
 	sunxi_factors_clk_setup(node, &sun6i_a31_pll_data);
 }
-CLK_OF_DECLARE(sun6i_pll, "allwinner,sun6i-a31-pll6-clk",
+CLK_OF_DECLARE(sun6i_pll, "allwinner,sun6i-a31-pll-clk",
 	       sun6i_pll_clk_setup);
 
 static void __init sun5i_ahb_clk_setup(struct device_node *node)
@@ -1152,3 +1152,9 @@ static void __init sun4i_pll6_clk_setup(struct device_node *node)
 CLK_OF_DECLARE(sun4i_pll6, "allwinner,sun4i-a10-pll6-clk",
 	       sun4i_pll6_clk_setup);
 
+static void __init sun6i_pll6_clk_setup(struct device_node *node)
+{
+	sunxi_divs_clk_setup(node, &sun6i_a31_pll6_divs_data);
+}
+CLK_OF_DECLARE(sun6i_pll6, "allwinner,sun6i-a31-pll6-clk",
+	       sun6i_pll6_clk_setup);
-- 
2.6.4
