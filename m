From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 23 Mar 2013 13:38:15 +0100
Subject: [PATCH] ARM: zynq: add gem support
Message-ID: <1364042295-16710-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zynq includes a Cadence GEM IP core. This is compatible with the macb driver.
Add it to the zynq-7000 DT.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 0dd2dc7..88564fa 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -54,6 +54,26 @@
 			clocks = <&uart_clk 1>;
 		};
 
+		gem0: ethernet at e000b000 {
+			compatible = "cdns,gem";
+			reg = <0xe000b000 0x4000>;
+			status = "disabled";
+			interrupts = <0 22 4>;
+			clocks = <&gem0_clk 0>, <&gem0_clk 0>;
+			clock-names = "pclk", "hclk";
+			phy-mode = "rgmii";
+		};
+
+		gem1: ethernet at e000c000 {
+			compatible = "cdns,gem";
+			reg = <0xe000c000 0x4000>;
+			status = "disabled";
+			interrupts = <0 45 4>;
+			clocks = <&gem1_clk 0>, <&gem1_clk 0>;
+			clock-names = "pclk", "hclk";
+			phy-mode = "rgmii";
+		};
+
 		slcr: slcr at f8000000 {
 			compatible = "xlnx,zynq-slcr";
 			reg = <0xF8000000 0x1000>;
@@ -89,6 +109,22 @@
 					reg = <0x108 0x118>;
 					clock-output-names = "iopll";
 				};
+				gem0_clk: gem0_clk {
+					#clock-cells = <1>;
+					compatible = "xlnx,zynq-periph-clock";
+					clocks = <&iopll &armpll &ddrpll>;
+					reg = <0x140>;
+					clock-output-names = "gem0_ref_clk1",
+							     "gem0_ref_clk2";
+				};
+				gem1_clk: gem1_clk {
+					#clock-cells = <1>;
+					compatible = "xlnx,zynq-periph-clock";
+					clocks = <&iopll &armpll &ddrpll>;
+					reg = <0x144>;
+					clock-output-names = "gem1_ref_clk1",
+							     "gem1_ref_clk2";
+				};
 				uart_clk: uart_clk {
 					#clock-cells = <1>;
 					compatible = "xlnx,zynq-periph-clock";
-- 
1.8.2.rc2
