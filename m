From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Fri, 24 Feb 2017 21:41:25 +0100
Subject: [PATCH] ARM: dts: socfpga: Use preprocessor defines for IRQs
Message-ID: <1487968885-21452-1-git-send-email-florian.vaussard@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using defines makes it easier to read interrupt descriptors. Apply to
both regular and GIC interrupts.

This patch was tested by comparing all the original and the new SocFPGA
DTBs. They are binary identical.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 arch/arm/boot/dts/socfpga.dtsi                    | 89 +++++++++++++----------
 arch/arm/boot/dts/socfpga_arria10.dtsi            | 76 +++++++++----------
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts |  2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts     |  2 +-
 4 files changed, 89 insertions(+), 80 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 2c43c4d..d5bdeea 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -16,6 +16,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/altr,rst-mgr.h>
 
 / {
@@ -77,14 +78,14 @@
 			pdma: pdma at ffe01000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffe01000 0x1000>;
-				interrupts = <0 104 4>,
-					     <0 105 4>,
-					     <0 106 4>,
-					     <0 107 4>,
-					     <0 108 4>,
-					     <0 109 4>,
-					     <0 110 4>,
-					     <0 111 4>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 				#dma-cells = <1>;
 				#dma-channels = <8>;
 				#dma-requests = <32>;
@@ -104,7 +105,10 @@
 		can0: can at ffc00000 {
 			compatible = "bosch,d_can";
 			reg = <0xffc00000 0x1000>;
-			interrupts = <0 131 4>, <0 132 4>, <0 133 4>, <0 134 4>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&can0_clk>;
 			status = "disabled";
 		};
@@ -112,7 +116,10 @@
 		can1: can at ffc01000 {
 			compatible = "bosch,d_can";
 			reg = <0xffc01000 0x1000>;
-			interrupts = <0 135 4>, <0 136 4>, <0 137 4>, <0 138 4>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&can1_clk>;
 			status = "disabled";
 		};
@@ -539,14 +546,14 @@
 			compatible = "altr,socfpga-fpga-mgr";
 			reg = <0xff706000 0x1000
 			       0xffb90000 0x4>;
-			interrupts = <0 175 4>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		gmac0: ethernet at ff700000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
 			altr,sysmgr-syscon = <&sysmgr 0x60 0>;
 			reg = <0xff700000 0x2000>;
-			interrupts = <0 115 4>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
 			clocks = <&emac0_clk>;
@@ -564,7 +571,7 @@
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
 			altr,sysmgr-syscon = <&sysmgr 0x60 2>;
 			reg = <0xff702000 0x2000>;
-			interrupts = <0 120 4>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
 			clocks = <&emac1_clk>;
@@ -594,7 +601,7 @@
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <0 164 4>;
+				interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -614,7 +621,7 @@
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <0 165 4>;
+				interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -634,7 +641,7 @@
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <0 166 4>;
+				interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -644,7 +651,7 @@
 			compatible = "snps,designware-i2c";
 			reg = <0xffc04000 0x1000>;
 			clocks = <&l4_sp_clk>;
-			interrupts = <0 158 0x4>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -654,7 +661,7 @@
 			compatible = "snps,designware-i2c";
 			reg = <0xffc05000 0x1000>;
 			clocks = <&l4_sp_clk>;
-			interrupts = <0 159 0x4>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -664,7 +671,7 @@
 			compatible = "snps,designware-i2c";
 			reg = <0xffc06000 0x1000>;
 			clocks = <&l4_sp_clk>;
-			interrupts = <0 160 0x4>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -674,7 +681,7 @@
 			compatible = "snps,designware-i2c";
 			reg = <0xffc07000 0x1000>;
 			clocks = <&l4_sp_clk>;
-			interrupts = <0 161 0x4>;
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
@@ -687,21 +694,23 @@
 			l2-ecc at ffd08140 {
 				compatible = "altr,socfpga-l2-ecc";
 				reg = <0xffd08140 0x4>;
-				interrupts = <0 36 1>, <0 37 1>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
 			};
 
 			ocram-ecc at ffd08144 {
 				compatible = "altr,socfpga-ocram-ecc";
 				reg = <0xffd08144 0x4>;
 				iram = <&ocram>;
-				interrupts = <0 178 1>, <0 179 1>;
+				interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
 			};
 		};
 
 		L2: l2-cache at fffef000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xfffef000 0x1000>;
-			interrupts = <0 38 0x04>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-level = <2>;
 			arm,tag-latency = <1 1 1>;
@@ -724,7 +733,7 @@
 		mmc: dwmmc0 at ff704000 {
 			compatible = "altr,socfpga-dw-mshc";
 			reg = <0xff704000 0x1000>;
-			interrupts = <0 139 4>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 			fifo-depth = <0x400>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -740,7 +749,7 @@
 			reg = <0xff900000 0x100000>,
 			      <0xffb80000 0x10000>;
 			reg-names = "nand_data", "denali_reg";
-			interrupts = <0x0 0x90 0x4>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			dma-mask = <0xffffffff>;
 			clocks = <&nand_clk>;
 			status = "disabled";
@@ -757,7 +766,7 @@
 			#size-cells = <0>;
 			reg = <0xff705000 0x1000>,
 			      <0xffa00000 0x1000>;
-			interrupts = <0 151 4>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <128>;
 			cdns,fifo-width = <4>;
 			cdns,trigger-address = <0x00000000>;
@@ -785,7 +794,7 @@
 		sdramedac {
 			compatible = "altr,sdram-edac";
 			altr,sdr-syscon = <&sdr>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		spi0: spi at fff00000 {
@@ -793,7 +802,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xfff00000 0x1000>;
-			interrupts = <0 154 4>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 			num-cs = <4>;
 			clocks = <&spi_m_clk>;
 			status = "disabled";
@@ -804,7 +813,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xfff01000 0x1000>;
-			interrupts = <0 155 4>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			num-cs = <4>;
 			clocks = <&spi_m_clk>;
 			status = "disabled";
@@ -819,13 +828,13 @@
 		timer at fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xfffec600 0x100>;
-			interrupts = <1 13 0xf04>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&mpu_periph_clk>;
 		};
 
 		timer0: timer0 at ffc08000 {
 			compatible = "snps,dw-apb-timer";
-			interrupts = <0 167 4>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffc08000 0x1000>;
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
@@ -833,7 +842,7 @@
 
 		timer1: timer1 at ffc09000 {
 			compatible = "snps,dw-apb-timer";
-			interrupts = <0 168 4>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffc09000 0x1000>;
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
@@ -841,7 +850,7 @@
 
 		timer2: timer2 at ffd00000 {
 			compatible = "snps,dw-apb-timer";
-			interrupts = <0 169 4>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffd00000 0x1000>;
 			clocks = <&osc1>;
 			clock-names = "timer";
@@ -849,7 +858,7 @@
 
 		timer3: timer3 at ffd01000 {
 			compatible = "snps,dw-apb-timer";
-			interrupts = <0 170 4>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffd01000 0x1000>;
 			clocks = <&osc1>;
 			clock-names = "timer";
@@ -858,7 +867,7 @@
 		uart0: serial0 at ffc02000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02000 0x1000>;
-			interrupts = <0 162 4>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&l4_sp_clk>;
@@ -870,7 +879,7 @@
 		uart1: serial1 at ffc03000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc03000 0x1000>;
-			interrupts = <0 163 4>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&l4_sp_clk>;
@@ -888,7 +897,7 @@
 		usb0: usb at ffb00000 {
 			compatible = "snps,dwc2";
 			reg = <0xffb00000 0xffff>;
-			interrupts = <0 125 4>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&usb_mp_clk>;
 			clock-names = "otg";
 			resets = <&rst USB0_RESET>;
@@ -901,7 +910,7 @@
 		usb1: usb at ffb40000 {
 			compatible = "snps,dwc2";
 			reg = <0xffb40000 0xffff>;
-			interrupts = <0 128 4>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&usb_mp_clk>;
 			clock-names = "otg";
 			resets = <&rst USB1_RESET>;
@@ -914,7 +923,7 @@
 		watchdog0: watchdog at ffd02000 {
 			compatible = "snps,dw-wdt";
 			reg = <0xffd02000 0x1000>;
-			interrupts = <0 171 4>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc1>;
 			status = "disabled";
 		};
@@ -922,7 +931,7 @@
 		watchdog1: watchdog at ffd03000 {
 			compatible = "snps,dw-wdt";
 			reg = <0xffd03000 0x1000>;
-			interrupts = <0 172 4>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc1>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 6b0b746..b0c8935 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -66,15 +66,15 @@
 			pdma: pdma at ffda1000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffda1000 0x1000>;
-				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 84 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 85 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 86 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 87 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 88 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 89 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 90 IRQ_TYPE_LEVEL_HIGH>,
-					     <0 91 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 				#dma-cells = <1>;
 				#dma-channels = <8>;
 				#dma-requests = <32>;
@@ -418,7 +418,7 @@
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
 			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
 			reg = <0xff800000 0x2000>;
-			interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			/* Filled in by bootloader */
 			mac-address = [00 00 00 00 00 00];
@@ -438,7 +438,7 @@
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
 			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
 		        reg = <0xff802000 0x2000>;
-			interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			/* Filled in by bootloader */
 			mac-address = [00 00 00 00 00 00];
@@ -458,7 +458,7 @@
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
 			altr,sysmgr-syscon = <&sysmgr 0x4C 0>;
 			reg = <0xff804000 0x2000>;
-			interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			/* Filled in by bootloader */
 			mac-address = [00 00 00 00 00 00];
@@ -487,7 +487,7 @@
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -506,7 +506,7 @@
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -525,7 +525,7 @@
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-				interrupts = <0 114 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -543,7 +543,7 @@
 			#size-cells = <0>;
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02200 0x100>;
-			interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&l4_sp_clk>;
 			status = "disabled";
 		};
@@ -553,7 +553,7 @@
 			#size-cells = <0>;
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02300 0x100>;
-			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&l4_sp_clk>;
 			status = "disabled";
 		};
@@ -563,7 +563,7 @@
 			#size-cells = <0>;
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02400 0x100>;
-			interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&l4_sp_clk>;
 			status = "disabled";
 		};
@@ -573,7 +573,7 @@
 			#size-cells = <0>;
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02500 0x100>;
-			interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&l4_sp_clk>;
 			status = "disabled";
 		};
@@ -583,7 +583,7 @@
 			#size-cells = <0>;
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02600 0x100>;
-			interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&l4_sp_clk>;
 			status = "disabled";
 		};
@@ -593,7 +593,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xffda5000 0x100>;
-			interrupts = <0 102 4>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			num-chipselect = <4>;
 			bus-num = <0>;
 			/*32bit_access;*/
@@ -611,7 +611,7 @@
 		L2: l2-cache at fffff000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xfffff000 0x1000>;
-			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-level = <2>;
 			prefetch-data = <1>;
@@ -624,7 +624,7 @@
 			#size-cells = <0>;
 			compatible = "altr,socfpga-dw-mshc";
 			reg = <0xff808000 0x1000>;
-			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			fifo-depth = <0x400>;
 			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
 			clock-names = "biu", "ciu";
@@ -638,7 +638,7 @@
 			reg = <0xffb90000 0x72000>,
 			      <0xffb80000 0x10000>;
 			reg-names = "nand_data", "denali_reg";
-			interrupts = <0 99 4>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			dma-mask = <0xffffffff>;
 			clocks = <&nand_clk>;
 			status = "disabled";
@@ -654,8 +654,8 @@
 			altr,sysmgr-syscon = <&sysmgr>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 0 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			ranges;
@@ -720,7 +720,7 @@
 			#size-cells = <0>;
 			reg = <0xff809000 0x100>,
 			      <0xffa00000 0x100000>;
-			interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <128>;
 			cdns,fifo-width = <4>;
 			cdns,trigger-address = <0x00000000>;
@@ -750,13 +750,13 @@
 		timer at ffffc600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xffffc600 0x100>;
-			interrupts = <1 13 0xf04>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&mpu_periph_clk>;
 		};
 
 		timer0: timer0 at ffc02700 {
 			compatible = "snps,dw-apb-timer";
-			interrupts = <0 115 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffc02700 0x100>;
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
@@ -764,7 +764,7 @@
 
 		timer1: timer1 at ffc02800 {
 			compatible = "snps,dw-apb-timer";
-			interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffc02800 0x100>;
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
@@ -772,7 +772,7 @@
 
 		timer2: timer2 at ffd00000 {
 			compatible = "snps,dw-apb-timer";
-			interrupts = <0 117 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffd00000 0x100>;
 			clocks = <&l4_sys_free_clk>;
 			clock-names = "timer";
@@ -780,7 +780,7 @@
 
 		timer3: timer3 at ffd00100 {
 			compatible = "snps,dw-apb-timer";
-			interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffd01000 0x100>;
 			clocks = <&l4_sys_free_clk>;
 			clock-names = "timer";
@@ -789,7 +789,7 @@
 		uart0: serial0 at ffc02000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02000 0x100>;
-			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&l4_sp_clk>;
@@ -799,7 +799,7 @@
 		uart1: serial1 at ffc02100 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02100 0x100>;
-			interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&l4_sp_clk>;
@@ -815,7 +815,7 @@
 		usb0: usb at ffb00000 {
 			compatible = "snps,dwc2";
 			reg = <0xffb00000 0xffff>;
-			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&usb_clk>;
 			clock-names = "otg";
 			resets = <&rst USB0_RESET>;
@@ -828,7 +828,7 @@
 		usb1: usb at ffb40000 {
 			compatible = "snps,dwc2";
 			reg = <0xffb40000 0xffff>;
-			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&usb_clk>;
 			clock-names = "otg";
 			resets = <&rst USB1_RESET>;
@@ -841,7 +841,7 @@
 		watchdog0: watchdog at ffd00200 {
 			compatible = "snps,dw-wdt";
 			reg = <0xffd00200 0x100>;
-			interrupts = <0 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&l4_sys_free_clk>;
 			status = "disabled";
 		};
@@ -849,7 +849,7 @@
 		watchdog1: watchdog at ffd00300 {
 			compatible = "snps,dw-wdt";
 			reg = <0xffd00300 0x100>;
-			interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&l4_sys_free_clk>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
index 5ecd2ef..371cacc 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
@@ -93,7 +93,7 @@
 		reg = <0x53>;
 
 		interrupt-parent = <&portc>;
-		interrupts = <3 2>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index a0c90b3b..00a6d74 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -165,7 +165,7 @@
 		reg = <0x53>;
 
 		interrupt-parent = <&portc>;
-		interrupts = <3 2>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 	};
 };
 
-- 
2.7.4
