From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Mar 2016 10:52:55 +0900
Subject: [PATCH v2 1/2] ARM: dts: r8a7793: add CAN clocks to device tree
In-Reply-To: <1458093176-1926-1-git-send-email-horms+renesas@verge.net.au>
References: <1458093176-1926-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458093176-1926-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car CAN controllers can derive the CAN bus clock not only from their
peripheral clock input (clkp1) but also from the other internal clock
(clkp2) and external clock fed on CAN_CLK pin. Describe those clocks in
the device tree along with  the USB_EXTAL clock from which clkp2 is
derived.

Based on work by Sergei Shtylyov for the r8a7791 SoC.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* Rebase
* Name clock nodes can and usb_extal
* Do not add clock-output-names property to new nodes
* Add MSTP9 clocks

Notes:
* "rcan" is already present in the clock-output-names property of
  the cpg_clocks node
* R8A7793_CLK_RCAN* are already present in
  include/dt-bindings/clock/r8a7793-clock.h
---
 arch/arm/boot/dts/r8a7793.dtsi | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index b48215945241..3d21a00f5b38 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -843,6 +843,22 @@
 			clock-output-names = "audio_clk_c";
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
@@ -857,7 +873,7 @@
 			compatible = "renesas,r8a7793-cpg-clocks",
 				     "renesas,rcar-gen2-cpg-clocks";
 			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>;
+			clocks = <&extal_clk &usb_extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z",
@@ -1098,6 +1114,7 @@
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
 			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
 				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&p_clk>, <&p_clk>,
 				 <&cpg_clocks R8A7793_CLK_QSPI>, <&hp_clk>,
 				 <&cp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
 				 <&hp_clk>, <&hp_clk>;
@@ -1107,7 +1124,8 @@
 				R8A7793_CLK_GPIO5 R8A7793_CLK_GPIO4
 				R8A7793_CLK_GPIO3 R8A7793_CLK_GPIO2
 				R8A7793_CLK_GPIO1 R8A7793_CLK_GPIO0
-				R8A7793_CLK_QSPI_MOD R8A7793_CLK_I2C5
+				R8A7793_CLK_QSPI_MOD R8A7793_CLK_RCAN1
+				R8A7793_CLK_RCAN0 R8A7793_CLK_I2C5
 				R8A7793_CLK_IICDVFS R8A7793_CLK_I2C4
 				R8A7793_CLK_I2C3 R8A7793_CLK_I2C2
 				R8A7793_CLK_I2C1 R8A7793_CLK_I2C0
@@ -1115,8 +1133,9 @@
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
2.1.4
