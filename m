From: plaes@plaes.org (Priit Laes)
Date: Tue, 10 May 2016 22:24:06 +0300
Subject: [PATCH 1/2] ARM: sun4i: A10: Add display and TCON clocks
In-Reply-To: <1462908247-10474-1-git-send-email-plaes@plaes.org>
References: <1462908247-10474-1-git-send-email-plaes@plaes.org>
Message-ID: <1462908247-10474-2-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the display and TCON clocks that are needed to drive the display
engine, tcon and TV encoders.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 91 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index a03e56f..a9c3190 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -65,8 +65,8 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
-				 <&ahb_gates 44>, <&dram_gates 26>;
+			clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>,
+				 <&de_be0_clk>, <&tcon0_ch0_clk>, <&dram_gates 26>;
 			status = "disabled";
 		};
 
@@ -74,8 +74,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
+			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>, <&ahb_gates 46>,
+				 <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch0_clk>,
 				 <&dram_gates 25>, <&dram_gates 26>;
 			status = "disabled";
 		};
@@ -84,9 +85,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>,
-				 <&ahb_gates 46>, <&dram_gates 25>,
-				 <&dram_gates 26>;
+			clocks = <&ahb_gates 36>, <&ahb_gates 44>, <&ahb_gates 46>,
+				 <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch0_clk>,
+				 <&dram_gates 25>, <&dram_gates 26>;
 			status = "disabled";
 		};
 
@@ -94,8 +95,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
-			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
+			clocks = <&ahb_gates 34>, <&ahb_gates 36>,
 				 <&ahb_gates 44>, <&ahb_gates 46>,
+				 <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch0_clk>,
 				 <&dram_gates 5>, <&dram_gates 25>, <&dram_gates 26>;
 			status = "disabled";
 		};
@@ -574,6 +576,81 @@
 					     "dram_de_mp", "dram_ace";
 		};
 
+		de_be0_clk: clk at 01c20104 {
+			#clock-cells = <0>;
+			#reset-cells = <0>;
+			compatible = "allwinner,sun4i-a10-display-clk";
+			reg = <0x01c20104 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll5 1>;
+			clock-output-names = "de-be0";
+		};
+
+		de_be1_clk: clk at 01c20108 {
+			#clock-cells = <0>;
+			#reset-cells = <0>;
+			compatible = "allwinner,sun4i-a10-display-clk";
+			reg = <0x01c20108 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll5 1>;
+			clock-output-names = "de-be1";
+		};
+
+		de_fe0_clk: clk at 01c2010c {
+			#clock-cells = <0>;
+			#reset-cells = <0>;
+			compatible = "allwinner,sun4i-a10-display-clk";
+			reg = <0x01c2010c 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll5 1>;
+			clock-output-names = "de-fe0";
+		};
+
+		de_fe1_clk: clk at 01c20110 {
+			#clock-cells = <0>;
+			#reset-cells = <0>;
+			compatible = "allwinner,sun4i-a10-display-clk";
+			reg = <0x01c20110 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll5 1>;
+			clock-output-names = "de-fe1";
+		};
+
+
+		tcon0_ch0_clk: clk at 01c20118 {
+			#clock-cells = <0>;
+			#reset-cells = <1>;
+			compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
+			reg = <0x01c20118 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
+			clock-output-names = "tcon0-ch0-sclk";
+
+		};
+
+		tcon1_ch0_clk: clk at 01c2011c {
+			#clock-cells = <0>;
+			#reset-cells = <1>;
+			compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
+			reg = <0x01c2011c 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
+			clock-output-names = "tcon1-ch0-sclk";
+
+		};
+
+		tcon0_ch1_clk: clk at 01c2012c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
+			reg = <0x01c2012c 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
+			clock-output-names = "tcon0-ch1-sclk";
+
+		};
+
+		tcon1_ch1_clk: clk at 01c20130 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
+			reg = <0x01c20130 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
+			clock-output-names = "tcon1-ch1-sclk";
+
+		};
+
 		ve_clk: clk at 01c2013c {
 			#clock-cells = <0>;
 			#reset-cells = <0>;
-- 
2.8.2
