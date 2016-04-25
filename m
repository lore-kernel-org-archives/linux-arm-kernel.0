From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Apr 2016 15:22:43 +0200
Subject: [PATCH v4 02/11] ARM: sun5i: a13: Add display and TCON clocks
In-Reply-To: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1461590572-4027-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the display and TCON (channel 0 and channel 1) clocks that are going
to be needed to drive the display engine, tcon and TV encoders.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 39 +++++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/sun5i-r8.dtsi  |  5 +++--
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 39f23b1ebc8f..263d46dbc7e6 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -61,8 +61,8 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>,
-				 <&dram_gates 26>;
+			clocks = <&ahb_gates 36>, <&ahb_gates 44>, <&de_be_clk>,
+				 <&tcon_ch0_clk>, <&dram_gates 26>;
 			status = "disabled";
 		};
 	};
@@ -170,6 +170,41 @@
 					     "dram_ace",
 					     "dram_iep";
 		};
+
+		de_be_clk: clk at 01c20104 {
+			#clock-cells = <0>;
+			#reset-cells = <0>;
+			compatible = "allwinner,sun4i-a10-display-clk";
+			reg = <0x01c20104 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll5 1>;
+			clock-output-names = "de-be";
+		};
+
+		de_fe_clk: clk at 01c2010c {
+			#clock-cells = <0>;
+			#reset-cells = <0>;
+			compatible = "allwinner,sun4i-a10-display-clk";
+			reg = <0x01c2010c 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll5 1>;
+			clock-output-names = "de-fe";
+		};
+
+		tcon_ch0_clk: clk at 01c20118 {
+			#clock-cells = <0>;
+			#reset-cells = <1>;
+			compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
+			reg = <0x01c20118 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
+			clock-output-names = "tcon-ch0-sclk";
+		};
+
+		tcon_ch1_clk: clk at 01c2012c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
+			reg = <0x01c2012c 0x4>;
+			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
+			clock-output-names = "tcon-ch1-sclk";
+		};
 	};
 
 	soc at 01c00000 {
diff --git a/arch/arm/boot/dts/sun5i-r8.dtsi b/arch/arm/boot/dts/sun5i-r8.dtsi
index e346ba76db5d..691d3de75b35 100644
--- a/arch/arm/boot/dts/sun5i-r8.dtsi
+++ b/arch/arm/boot/dts/sun5i-r8.dtsi
@@ -51,8 +51,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
-				 <&ahb_gates 44>, <&dram_gates 26>;
+			clocks = <&ahb_gates 34>, <&ahb_gates 36>,
+				 <&ahb_gates 44>, <&de_be_clk>,
+				 <&tcon_ch1_clk>, <&dram_gates 26>;
 			status = "disabled";
 		};
 	};
-- 
2.8.1
