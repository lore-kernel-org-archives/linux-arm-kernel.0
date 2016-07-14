From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Jul 2016 23:19:44 +0300
Subject: [PATCH 1/3] ARM: dts: r8a7792: add CAN clocks
In-Reply-To: <34968644.DhifNderY8@wasted.cogentembedded.com>
References: <34968644.DhifNderY8@wasted.cogentembedded.com>
Message-ID: <2649698.YI9UQEvgG8@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car CAN controllers can derive  the CAN  bus  clock not only from
their peripheral  clock input (clkp1) but also from the other internal
clock (clkp2) and the external clock fed on the CAN_CLK pin.  Describe
those  clocks in  the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -530,6 +530,13 @@
 			clock-div = <8>;
 			clock-mult = <1>;
 		};
+		rcan_clk: rcan {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-div = <49>;
+			clock-mult = <1>;
+		};
 
 		/* Gate clocks */
 		mstp1_clks: mstp1_clks at e6150134 {
@@ -600,7 +607,8 @@
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
 			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
 				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>;
+				 <&cp_clk>, <&cp_clk>, <&p_clk>, <&p_clk>,
+				 <&cp_clk>, <&cp_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7792_CLK_GPIO7 R8A7792_CLK_GPIO6
@@ -608,12 +616,14 @@
 				R8A7792_CLK_GPIO3 R8A7792_CLK_GPIO2
 				R8A7792_CLK_GPIO1 R8A7792_CLK_GPIO0
 				R8A7792_CLK_GPIO11 R8A7792_CLK_GPIO10
+				R8A7792_CLK_CAN1 R8A7792_CLK_CAN0
 				R8A7792_CLK_GPIO9 R8A7792_CLK_GPIO8
 			>;
 			clock-output-names =
 				"gpio7", "gpio6", "gpio5", "gpio4",
 				"gpio3", "gpio2", "gpio1", "gpio0",
-				"gpio11", "gpio10", "gpio9", "gpio8";
+				"gpio11", "gpio10", "can1", "can0",
+				"gpio9", "gpio8";
 		};
 	};
 
@@ -630,6 +640,14 @@
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External CAN clock */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
 		clock-frequency = <0>;
 	};
 };
