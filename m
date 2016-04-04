From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:23:10 +0900
Subject: [PATCH 38/47] ARM: dts: r8a7794: add CAN clocks to device tree
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <cfd83f62939527762a685e1779b3379b91c3848f.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CAN nodes to r8a7794 device tree.
Based on work by Sergei Shtylyov for the r8a7791 SoC.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 33 ++++++++++++++++++++++++-------
 include/dt-bindings/clock/r8a7794-clock.h |  3 +++
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 1219f7509433..840971ce48f2 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -873,6 +873,22 @@
 			clock-output-names = "extal";
 		};
 
+		/* External USB clock - can be overridden by the board */
+		usb_extal_clk: usb_extal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+		};
+
+		/* External CAN clock */
+		can_clk: can {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+			status = "disabled";
+		};
+
 		/* External SCIF clock */
 		scif_clk: scif {
 			compatible = "fixed-clock";
@@ -887,10 +903,11 @@
 			compatible = "renesas,r8a7794-cpg-clocks",
 				     "renesas,rcar-gen2-cpg-clocks";
 			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>;
+			clocks = <&extal_clk &usb_extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
-					     "lb", "qspi", "sdh", "sd0", "z";
+					     "lb", "qspi", "sdh", "sd0", "z",
+					     "rcan";
 			#power-domain-cells = <0>;
 		};
 		/* Variable factor clocks */
@@ -1166,20 +1183,22 @@
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
 			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&cpg_clocks R8A7794_CLK_QSPI>, <&hp_clk>, <&hp_clk>,
-				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&p_clk>,
+				 <&p_clk>, <&cpg_clocks R8A7794_CLK_QSPI>,
+				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
+				 <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			clock-indices = <R8A7794_CLK_GPIO6 R8A7794_CLK_GPIO5
 					 R8A7794_CLK_GPIO4 R8A7794_CLK_GPIO3
 					 R8A7794_CLK_GPIO2 R8A7794_CLK_GPIO1
-					 R8A7794_CLK_GPIO0 R8A7794_CLK_QSPI_MOD
+					 R8A7794_CLK_GPIO0 R8A7794_CLK_RCAN1
+					 R8A7794_CLK_RCAN0 R8A7794_CLK_QSPI_MOD
 					 R8A7794_CLK_I2C5 R8A7794_CLK_I2C4
 					 R8A7794_CLK_I2C3 R8A7794_CLK_I2C2
 					 R8A7794_CLK_I2C1 R8A7794_CLK_I2C0>;
 			clock-output-names =
 				"gpio6", "gpio5", "gpio4", "gpio3", "gpio2",
-				"gpio1", "gpio0", "qspi_mod",
+				"gpio1", "gpio0", "rcan1", "rcan0", "qspi_mod",
 				"i2c5", "i2c4", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
 		mstp11_clks: mstp11_clks at e615099c {
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index f843de6bf377..9703fbdb81c8 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -21,6 +21,7 @@
 #define R8A7794_CLK_SDH			6
 #define R8A7794_CLK_SD0			7
 #define R8A7794_CLK_Z			8
+#define R8A7794_CLK_RCAN		9
 
 /* MSTP0 */
 #define R8A7794_CLK_MSIOF0		0
@@ -95,6 +96,8 @@
 #define R8A7794_CLK_GPIO2		10
 #define R8A7794_CLK_GPIO1		11
 #define R8A7794_CLK_GPIO0		12
+#define R8A7794_CLK_RCAN1		15
+#define R8A7794_CLK_RCAN0		16
 #define R8A7794_CLK_QSPI_MOD		17
 #define R8A7794_CLK_I2C5		25
 #define R8A7794_CLK_I2C4		27
-- 
2.1.4
