From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Oct 2015 15:21:01 +0100
Subject: [PATCH 15/19] ARM: sun5i: dt: Add display and TCON clocks
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1446214865-3972-16-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the display and TCON (channel 0 and channel 1) clocks that are going
to be needed to drive the display engine, tcon and TV encoders.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi |  8 +++---
 arch/arm/boot/dts/sun5i-a13.dtsi  |  3 ++-
 arch/arm/boot/dts/sun5i-r8.dtsi   |  5 ++--
 arch/arm/boot/dts/sun5i.dtsi      | 53 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index bddd0de88af6..0981a9e2db3b 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -65,8 +65,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
-				 <&ahb_gates 44>;
+			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
+				 <&ahb_gates 44>, <&de_be_clk>,
+				 <&tcon_ch1_clk>;
 			status = "disabled";
 		};
 
@@ -74,7 +75,8 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>;
+			clocks = <&ahb_gates 36>, <&ahb_gates 44>,
+				 <&de_be_clk>, <&tcon_ch0_clk>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index d910d3a6c41c..130644d7e054 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -61,7 +61,8 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>;
+			clocks = <&ahb_gates 36>, <&ahb_gates 44>, <&de_be_clk>,
+				 <&tcon_ch0_clk>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun5i-r8.dtsi b/arch/arm/boot/dts/sun5i-r8.dtsi
index 0ef865601ac9..b1e4e0170d51 100644
--- a/arch/arm/boot/dts/sun5i-r8.dtsi
+++ b/arch/arm/boot/dts/sun5i-r8.dtsi
@@ -51,8 +51,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
-				 <&ahb_gates 44>;
+			clocks = <&ahb_gates 34>, <&ahb_gates 36>,
+				 <&ahb_gates 44>, <&de_be_clk>,
+				 <&tcon_ch1_clk>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index bde9a545b79f..861c5a621e70 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -129,6 +129,15 @@
 			clock-output-names = "pll3";
 		};
 
+		pll3x2: pll3x2_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <2>;
+			clocks = <&pll3>;
+			clock-output-names = "pll3x2";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-pll1-clk";
@@ -161,6 +170,15 @@
 			clock-output-names = "pll7";
 		};
 
+		pll7x2: pll7x2_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <2>;
+			clocks = <&pll7>;
+			clock-output-names = "pll7x2";
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
@@ -320,6 +338,41 @@
 			clock-output-names = "usb_ohci0", "usb_phy";
 		};
 
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
+
 		codec_clk: clk at 01c20140 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-codec-clk";
-- 
2.6.2
