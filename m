From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 14:27:27 +1000
Subject: [PATCH 09/22] ARM: dts: r8a7793: add CAN clocks to device tree
In-Reply-To: <cover.1461558315.git.horms+renesas@verge.net.au>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
Message-ID: <7892e6c1be78a7b008722badd99e5abd0ad6007b.1461558315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car CAN controllers can derive the CAN bus clock not only from their
peripheral clock input (clkp1) but also from the other internal clock
(clkp2) and external clock fed on CAN_CLK pin. Describe those clocks in
the device tree along with  the USB_EXTAL clock from which clkp2 is
derived.

Based on work by Sergei Shtylyov for the r8a7791 SoC.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 95bbed95b0c1..0e609bdafaa9 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -839,6 +839,22 @@
 			clock-frequency = <0>;
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
@@ -853,7 +869,7 @@
 			compatible = "renesas,r8a7793-cpg-clocks",
 				     "renesas,rcar-gen2-cpg-clocks";
 			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>;
+			clocks = <&extal_clk &usb_extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z",
@@ -1081,6 +1097,7 @@
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
 			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
 				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&p_clk>, <&p_clk>,
 				 <&cpg_clocks R8A7793_CLK_QSPI>, <&hp_clk>,
 				 <&cp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
 				 <&hp_clk>, <&hp_clk>;
@@ -1090,7 +1107,8 @@
 				R8A7793_CLK_GPIO5 R8A7793_CLK_GPIO4
 				R8A7793_CLK_GPIO3 R8A7793_CLK_GPIO2
 				R8A7793_CLK_GPIO1 R8A7793_CLK_GPIO0
-				R8A7793_CLK_QSPI_MOD R8A7793_CLK_I2C5
+				R8A7793_CLK_QSPI_MOD R8A7793_CLK_RCAN1
+				R8A7793_CLK_RCAN0 R8A7793_CLK_I2C5
 				R8A7793_CLK_IICDVFS R8A7793_CLK_I2C4
 				R8A7793_CLK_I2C3 R8A7793_CLK_I2C2
 				R8A7793_CLK_I2C1 R8A7793_CLK_I2C0
@@ -1098,8 +1116,9 @@
 			clock-output-names =
 				"gpio7", "gpio6", "gpio5", "gpio4",
 				"gpio3", "gpio2", "gpio1", "gpio0",
-				"qspi_mod", "i2c5", "i2c6", "i2c4",
-				"i2c3", "i2c2", "i2c1", "i2c0";
+				"rcan1", "rcan0", "qspi_mod", "i2c5",
+				"i2c6", "i2c4", "i2c3", "i2c2", "i2c1",
+				"i2c0";
 		};
 		mstp10_clks: mstp10_clks at e6150998 {
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
2.7.0.rc3.207.g0ac5344
