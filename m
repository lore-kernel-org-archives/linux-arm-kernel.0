From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 11 Dec 2014 21:21:42 +0100
Subject: [RFC 3/3] ARM: dts: socfpga: Add AXI bridges
In-Reply-To: <1418329302-20813-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1418329302-20813-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1418329302-20813-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 12e4e437050f..bfbdb326f531 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -67,6 +67,54 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		lwhps2fpga: axibridge at ff400000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "altr,lwhps2fpga-axi-bridge";
+			reg = <0xff400000 0x100000>,
+			      <0xff200000 0x200000>;
+			reg-names = "gpv", "data";
+			clocks = <&l4_mp_clk>;
+			resets = <&rst LWHPS2FPGA_RESET>;
+			reset-names = "lwhps2fpga";
+			altr,l3-gpv = <&l3regs>;
+			status = "disabled";
+			ranges;
+		};
+
+		hps2fpga: axibridge at ff500000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "altr,hps2fpga-axi-bridge";
+			reg = <0xff500000 0x100000>,
+			      <0xc0000000 0x3c000000>;
+			reg-names = "gpv", "data";
+			clocks = <&l4_mp_clk>, <&l3_main_clk>;
+			clock-names = "gpv_clk", "data_clk";
+			resets = <&rst HPS2FPGA_RESET>;
+			reset-names = "hps2fpga";
+			altr,bridge-gpv = <&lwhps2fpga>;
+			altr,l3-gpv = <&l3regs>;
+			bus-width = <64>;
+			status = "disabled";
+			ranges;
+		};
+
+		fpga2hps: axibridge at ff600000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "altr,fpga2hps-axi-bridge";
+			reg = <0xff600000 0x100000>;
+			reg-names = "gpv";
+			clocks = <&l4_mp_clk>, <&l3_main_clk>;
+			clock-names = "gpv_clk", "data_clk";
+			resets = <&rst FPGA2HPS_RESET>;
+			reset-names = "fpga2hps";
+			altr,bridge-gpv = <&lwhps2fpga>;
+			bus-width = <64>;
+			status = "disabled";
+		};
+
 		amba {
 			compatible = "arm,amba-bus";
 			#address-cells = <1>;
-- 
2.1.3
