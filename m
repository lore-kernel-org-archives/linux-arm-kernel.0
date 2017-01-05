From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  4 Jan 2017 18:21:32 -0600
Subject: [PATCH 10/12] ARM: dts: socfpga: add base fpga region and fpga bridges
In-Reply-To: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
References: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1483575694-29599-11-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@opensource.altera.com>

Add h2f and lwh2f bridges.
Add base FPGA Region to support DT overlays for FPGA programming.
Add l3regs.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index de29172..dccc281 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -93,6 +93,16 @@
 			};
 		};
 
+		base_fpga_region {
+			compatible = "fpga-region";
+			fpga-mgr = <&fpgamgr0>;
+			fpga-bridges = <&fpga_bridge0>, <&fpga_bridge1>;
+
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			ranges = <0 0xff200000 0x100000>;
+		};
+
 		can0: can at ffc00000 {
 			compatible = "bosch,d_can";
 			reg = <0xffc00000 0x1000>;
@@ -513,6 +523,22 @@
 				};
 		};
 
+		fpga_bridge0: fpga_bridge at ff400000 {
+			compatible = "altr,socfpga-lwhps2fpga-bridge";
+			reg = <0xff400000 0x100000>;
+			resets = <&rst LWHPS2FPGA_RESET>;
+			reset-names = "lwhps2fpga";
+			clocks = <&l4_main_clk>;
+		};
+
+		fpga_bridge1: fpga_bridge at ff500000 {
+			compatible = "altr,socfpga-hps2fpga-bridge";
+			reg = <0xff500000 0x10000>;
+			resets = <&rst HPS2FPGA_RESET>;
+			reset-names = "hps2fpga";
+			clocks = <&l4_main_clk>;
+		};
+
 		fpgamgr0: fpgamgr at ff706000 {
 			compatible = "altr,socfpga-fpga-mgr";
 			reg = <0xff706000 0x1000
@@ -694,6 +720,11 @@
 			arm,prefetch-offset = <7>;
 		};
 
+		l3regs at 0xff800000 {
+			compatible = "altr,l3regs", "syscon";
+			reg = <0xff800000 0x1000>;
+		};
+
 		mmc: dwmmc0 at ff704000 {
 			compatible = "altr,socfpga-dw-mshc";
 			reg = <0xff704000 0x1000>;
-- 
2.7.4
