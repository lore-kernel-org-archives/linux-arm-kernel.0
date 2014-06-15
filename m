From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 15 Jun 2014 20:42:27 +0800
Subject: [PATCH 2/2] ARM: dts: imx6qdl: use DT macro for clock ID
In-Reply-To: <1402836147-29625-1-git-send-email-shawn.guo@freescale.com>
References: <1402836147-29625-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1402836147-29625-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to use DT macro for clock ID, so that device tree source is more
readable.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi  |  18 +++---
 arch/arm/boot/dts/imx6q.dtsi   |  27 +++++---
 arch/arm/boot/dts/imx6qdl.dtsi | 140 ++++++++++++++++++++++++++---------------
 3 files changed, 117 insertions(+), 68 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 0a9c49d69d41..74e978841d77 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -35,8 +35,11 @@
 				396000	1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
-			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
-				 <&clks 17>, <&clks 170>;
+			clocks = <&clks IMX6QDL_CLK_ARM>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
+				 <&clks IMX6QDL_CLK_STEP>,
+				 <&clks IMX6QDL_CLK_PLL1_SW>,
+				 <&clks IMX6QDL_CLK_PLL1_SYS>;
 			clock-names = "arm", "pll2_pfd2_396m", "step",
 				      "pll1_sw", "pll1_sys";
 			arm-supply = <&reg_arm>;
@@ -56,7 +59,7 @@
 		ocram: sram at 00900000 {
 			compatible = "mmio-sram";
 			reg = <0x00900000 0x20000>;
-			clocks = <&clks 142>;
+			clocks = <&clks IMX6QDL_CLK_OCRAM>;
 		};
 
 		aips1: aips-bus at 02000000 {
@@ -87,7 +90,8 @@
 				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
 				reg = <0x021f8000 0x4000>;
 				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 116>;
+				/* Same clock as i.MX6Q ECSPI5 */
+				clocks = <&clks IMX6QDL_CLK_ECSPI5>;
 				status = "disabled";
 			};
 		};
@@ -104,9 +108,9 @@
 };
 
 &ldb {
-	clocks = <&clks 33>, <&clks 34>,
-		 <&clks 39>, <&clks 40>,
-		 <&clks 135>, <&clks 136>;
+	clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>, <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
+		 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
+		 <&clks IMX6QDL_CLK_LDB_DI0>, <&clks IMX6QDL_CLK_LDB_DI1>;
 	clock-names = "di0_pll", "di1_pll",
 		      "di0_sel", "di1_sel",
 		      "di0", "di1";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index fb6185fc9379..4a6cbd086da9 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -43,8 +43,11 @@
 				396000	1175000
 			>;
 			clock-latency = <61036>; /* two CLK32 periods */
-			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
-				 <&clks 17>, <&clks 170>;
+			clocks = <&clks IMX6QDL_CLK_ARM>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
+				 <&clks IMX6QDL_CLK_STEP>,
+				 <&clks IMX6QDL_CLK_PLL1_SW>,
+				 <&clks IMX6QDL_CLK_PLL1_SYS>;
 			clock-names = "arm", "pll2_pfd2_396m", "step",
 				      "pll1_sw", "pll1_sys";
 			arm-supply = <&reg_arm>;
@@ -78,7 +81,7 @@
 		ocram: sram at 00900000 {
 			compatible = "mmio-sram";
 			reg = <0x00900000 0x40000>;
-			clocks = <&clks 142>;
+			clocks = <&clks IMX6QDL_CLK_OCRAM>;
 		};
 
 		aips-bus at 02000000 { /* AIPS1 */
@@ -89,7 +92,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02018000 0x4000>;
 					interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks 116>, <&clks 116>;
+					clocks = <&clks IMX6QDL_CLK_ECSPI5>,
+						 <&clks IMX6QDL_CLK_ECSPI5>;
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
@@ -140,7 +144,9 @@
 			compatible = "fsl,imx6q-ahci";
 			reg = <0x02200000 0x4000>;
 			interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =  <&clks 154>, <&clks 187>, <&clks 105>;
+			clocks = <&clks IMX6QDL_CLK_SATA>,
+				 <&clks IMX6QDL_CLK_SATA_REF_100M>,
+				 <&clks IMX6QDL_CLK_AHB>;
 			clock-names = "sata", "sata_ref", "ahb";
 			status = "disabled";
 		};
@@ -152,7 +158,9 @@
 			reg = <0x02800000 0x400000>;
 			interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>,
 				     <0 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
+			clocks = <&clks IMX6QDL_CLK_IPU2>,
+				 <&clks IMX6QDL_CLK_IPU2_DI0>,
+				 <&clks IMX6QDL_CLK_IPU2_DI1>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 4>;
 
@@ -238,9 +246,10 @@
 };
 
 &ldb {
-	clocks = <&clks 33>, <&clks 34>,
-		 <&clks 39>, <&clks 40>, <&clks 41>, <&clks 42>,
-		 <&clks 135>, <&clks 136>;
+	clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>, <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
+		 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
+		 <&clks IMX6QDL_CLK_IPU2_DI0_SEL>, <&clks IMX6QDL_CLK_IPU2_DI1_SEL>,
+		 <&clks IMX6QDL_CLK_LDB_DI0>, <&clks IMX6QDL_CLK_LDB_DI1>;
 	clock-names = "di0_pll", "di1_pll",
 		      "di0_sel", "di1_sel", "di2_sel", "di3_sel",
 		      "di0", "di1";
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2fe1287d92f4..4a196d477132 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -10,6 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/clock/imx6qdl-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -94,7 +95,7 @@
 			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
 			#dma-cells = <1>;
 			dma-channels = <4>;
-			clocks = <&clks 106>;
+			clocks = <&clks IMX6QDL_CLK_APBH_DMA>;
 		};
 
 		gpmi: gpmi-nand at 00112000 {
@@ -105,8 +106,11 @@
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <0 15 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "bch";
-			clocks = <&clks 152>, <&clks 153>, <&clks 151>,
-				 <&clks 150>, <&clks 149>;
+			clocks = <&clks IMX6QDL_CLK_GPMI_IO>,
+				 <&clks IMX6QDL_CLK_GPMI_APB>,
+				 <&clks IMX6QDL_CLK_GPMI_BCH>,
+				 <&clks IMX6QDL_CLK_GPMI_BCH_APB>,
+				 <&clks IMX6QDL_CLK_PER1_BCH>;
 			clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
 				      "gpmi_bch_apb", "per1_bch";
 			dmas = <&dma_apbh 0>;
@@ -118,7 +122,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
 			interrupts = <1 13 0xf01>;
-			clocks = <&clks 15>;
+			clocks = <&clks IMX6QDL_CLK_TWD>;
 		};
 
 		L2: l2-cache at 00a02000 {
@@ -149,7 +153,9 @@
 			                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
 			                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 			                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clks 144>, <&clks 206>, <&clks 189>;
+			clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
+				 <&clks IMX6QDL_CLK_LVDS1_GATE>,
+				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy";
 			status = "disabled";
 		};
@@ -180,11 +186,11 @@
 					dmas = <&sdma 14 18 0>,
 					       <&sdma 15 18 0>;
 					dma-names = "rx", "tx";
-					clocks = <&clks 197>, <&clks 3>,
-						 <&clks 197>, <&clks 107>,
-						 <&clks 0>,   <&clks 118>,
-						 <&clks 0>,  <&clks 139>,
-						 <&clks 0>;
+					clocks = <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_OSC>,
+						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
+						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI>,
+						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_MLB>,
+						 <&clks IMX6QDL_CLK_DUMMY>;
 					clock-names = "core",  "rxtx0",
 						      "rxtx1", "rxtx2",
 						      "rxtx3", "rxtx4",
@@ -199,7 +205,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02008000 0x4000>;
 					interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks 112>, <&clks 112>;
+					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
+						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
 					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 					dma-names = "rx", "tx";
@@ -212,7 +219,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x0200c000 0x4000>;
 					interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks 113>, <&clks 113>;
+					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
+						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
 					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
 					dma-names = "rx", "tx";
@@ -225,7 +233,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02010000 0x4000>;
 					interrupts = <0 33 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks 114>, <&clks 114>;
+					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
+						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
 					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
 					dma-names = "rx", "tx";
@@ -238,7 +247,8 @@
 					compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi";
 					reg = <0x02014000 0x4000>;
 					interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks 115>, <&clks 115>;
+					clocks = <&clks IMX6QDL_CLK_ECSPI4>,
+						 <&clks IMX6QDL_CLK_ECSPI4>;
 					clock-names = "ipg", "per";
 					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
 					dma-names = "rx", "tx";
@@ -249,7 +259,8 @@
 					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <0 26 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks 160>, <&clks 161>;
+					clocks = <&clks IMX6QDL_CLK_UART_IPG>,
+						 <&clks IMX6QDL_CLK_UART_SERIAL>;
 					clock-names = "ipg", "per";
 					dmas = <&sdma 25 4 0>, <&sdma 26 4 0>;
 					dma-names = "rx", "tx";
@@ -267,7 +278,7 @@
 							"fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks 178>;
+					clocks = <&clks IMX6QDL_CLK_SSI1_IPG>;
 					dmas = <&sdma 37 1 0>,
 					       <&sdma 38 1 0>;
 					dma-names = "rx", "tx";
@@ -282,7 +293,7 @@
 							"fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks 179>;
+					clocks = <&clks IMX6QDL_CLK_SSI2_IPG>;
 					dmas = <&sdma 41 1 0>,
 					       <&sdma 42 1 0>;
 					dma-names = "rx", "tx";
@@ -297,7 +308,7 @@
 							"fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks 180>;
+					clocks = <&clks IMX6QDL_CLK_SSI3_IPG>;
 					dmas = <&sdma 45 1 0>,
 					       <&sdma 46 1 0>;
 					dma-names = "rx", "tx";
@@ -331,7 +342,8 @@
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02080000 0x4000>;
 				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 62>, <&clks 145>;
+				clocks = <&clks IMX6QDL_CLK_IPG>,
+					 <&clks IMX6QDL_CLK_PWM1>;
 				clock-names = "ipg", "per";
 			};
 
@@ -340,7 +352,8 @@
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02084000 0x4000>;
 				interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 62>, <&clks 146>;
+				clocks = <&clks IMX6QDL_CLK_IPG>,
+					 <&clks IMX6QDL_CLK_PWM2>;
 				clock-names = "ipg", "per";
 			};
 
@@ -349,7 +362,8 @@
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02088000 0x4000>;
 				interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 62>, <&clks 147>;
+				clocks = <&clks IMX6QDL_CLK_IPG>,
+					 <&clks IMX6QDL_CLK_PWM3>;
 				clock-names = "ipg", "per";
 			};
 
@@ -358,7 +372,8 @@
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x0208c000 0x4000>;
 				interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 62>, <&clks 148>;
+				clocks = <&clks IMX6QDL_CLK_IPG>,
+					 <&clks IMX6QDL_CLK_PWM4>;
 				clock-names = "ipg", "per";
 			};
 
@@ -366,7 +381,8 @@
 				compatible = "fsl,imx6q-flexcan";
 				reg = <0x02090000 0x4000>;
 				interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 108>, <&clks 109>;
+				clocks = <&clks IMX6QDL_CLK_CAN1_IPG>,
+					 <&clks IMX6QDL_CLK_CAN1_SERIAL>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -375,7 +391,8 @@
 				compatible = "fsl,imx6q-flexcan";
 				reg = <0x02094000 0x4000>;
 				interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 110>, <&clks 111>;
+				clocks = <&clks IMX6QDL_CLK_CAN2_IPG>,
+					 <&clks IMX6QDL_CLK_CAN2_SERIAL>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -384,7 +401,8 @@
 				compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 119>, <&clks 120>;
+				clocks = <&clks IMX6QDL_CLK_GPT_IPG>,
+					 <&clks IMX6QDL_CLK_GPT_IPG_PER>;
 				clock-names = "ipg", "per";
 			};
 
@@ -469,21 +487,21 @@
 				compatible = "fsl,imx6q-kpp", "fsl,imx21-kpp";
 				reg = <0x020b8000 0x4000>;
 				interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 62>;
+				clocks = <&clks IMX6QDL_CLK_IPG>;
 			};
 
 			wdog1: wdog at 020bc000 {
 				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 0>;
+				clocks = <&clks IMX6QDL_CLK_DUMMY>;
 			};
 
 			wdog2: wdog at 020c0000 {
 				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 0>;
+				clocks = <&clks IMX6QDL_CLK_DUMMY>;
 				status = "disabled";
 			};
 
@@ -601,14 +619,14 @@
 				interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
 				fsl,tempmon = <&anatop>;
 				fsl,tempmon-data = <&ocotp>;
-				clocks = <&clks 172>;
+				clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 			};
 
 			usbphy1: usbphy at 020c9000 {
 				compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020c9000 0x1000>;
 				interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 182>;
+				clocks = <&clks IMX6QDL_CLK_USBPHY1>;
 				fsl,anatop = <&anatop>;
 			};
 
@@ -616,7 +634,7 @@
 				compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020ca000 0x1000>;
 				interrupts = <0 45 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 183>;
+				clocks = <&clks IMX6QDL_CLK_USBPHY2>;
 				fsl,anatop = <&anatop>;
 			};
 
@@ -729,7 +747,8 @@
 				reg = <0x00120000 0x9000>;
 				interrupts = <0 115 0x04>;
 				gpr = <&gpr>;
-				clocks = <&clks 123>, <&clks 124>;
+				clocks = <&clks IMX6QDL_CLK_HDMI_IAHB>,
+					 <&clks IMX6QDL_CLK_HDMI_ISFR>;
 				clock-names = "iahb", "isfr";
 				status = "disabled";
 
@@ -764,7 +783,8 @@
 				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 155>, <&clks 155>;
+				clocks = <&clks IMX6QDL_CLK_SDMA>,
+					 <&clks IMX6QDL_CLK_SDMA>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
@@ -792,7 +812,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184000 0x200>;
 				interrupts = <0 43 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 162>;
+				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
@@ -802,7 +822,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 162>;
+				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy2>;
 				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
@@ -812,7 +832,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 162>;
+				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 2>;
 				status = "disabled";
 			};
@@ -821,7 +841,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 162>;
+				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 				fsl,usbmisc = <&usbmisc 3>;
 				status = "disabled";
 			};
@@ -830,7 +850,7 @@
 				#index-cells = <1>;
 				compatible = "fsl,imx6q-usbmisc";
 				reg = <0x02184800 0x200>;
-				clocks = <&clks 162>;
+				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 			};
 
 			fec: ethernet at 02188000 {
@@ -839,7 +859,9 @@
 				interrupts-extended =
 					<&intc 0 118 IRQ_TYPE_LEVEL_HIGH>,
 					<&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 117>, <&clks 117>, <&clks 190>;
+				clocks = <&clks IMX6QDL_CLK_ENET>,
+					 <&clks IMX6QDL_CLK_ENET>,
+					 <&clks IMX6QDL_CLK_ENET_REF>;
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
@@ -855,7 +877,9 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 163>, <&clks 163>, <&clks 163>;
+				clocks = <&clks IMX6QDL_CLK_USDHC1>,
+					 <&clks IMX6QDL_CLK_USDHC1>,
+					 <&clks IMX6QDL_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
 				status = "disabled";
@@ -865,7 +889,9 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 164>, <&clks 164>, <&clks 164>;
+				clocks = <&clks IMX6QDL_CLK_USDHC2>,
+					 <&clks IMX6QDL_CLK_USDHC2>,
+					 <&clks IMX6QDL_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
 				status = "disabled";
@@ -875,7 +901,9 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 165>, <&clks 165>, <&clks 165>;
+				clocks = <&clks IMX6QDL_CLK_USDHC3>,
+					 <&clks IMX6QDL_CLK_USDHC3>,
+					 <&clks IMX6QDL_CLK_USDHC3>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
 				status = "disabled";
@@ -885,7 +913,9 @@
 				compatible = "fsl,imx6q-usdhc";
 				reg = <0x0219c000 0x4000>;
 				interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 166>, <&clks 166>, <&clks 166>;
+				clocks = <&clks IMX6QDL_CLK_USDHC4>,
+					 <&clks IMX6QDL_CLK_USDHC4>,
+					 <&clks IMX6QDL_CLK_USDHC4>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
 				status = "disabled";
@@ -897,7 +927,7 @@
 				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
 				reg = <0x021a0000 0x4000>;
 				interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 125>;
+				clocks = <&clks IMX6QDL_CLK_I2C1>;
 				status = "disabled";
 			};
 
@@ -907,7 +937,7 @@
 				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
 				reg = <0x021a4000 0x4000>;
 				interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 126>;
+				clocks = <&clks IMX6QDL_CLK_I2C2>;
 				status = "disabled";
 			};
 
@@ -917,7 +947,7 @@
 				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
 				reg = <0x021a8000 0x4000>;
 				interrupts = <0 38 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 127>;
+				clocks = <&clks IMX6QDL_CLK_I2C3>;
 				status = "disabled";
 			};
 
@@ -938,7 +968,7 @@
 				compatible = "fsl,imx6q-weim";
 				reg = <0x021b8000 0x4000>;
 				interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 196>;
+				clocks = <&clks IMX6QDL_CLK_EIM_SLOW>;
 			};
 
 			ocotp: ocotp at 021bc000 {
@@ -998,7 +1028,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021e8000 0x4000>;
 				interrupts = <0 27 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 160>, <&clks 161>;
+				clocks = <&clks IMX6QDL_CLK_UART_IPG>,
+					 <&clks IMX6QDL_CLK_UART_SERIAL>;
 				clock-names = "ipg", "per";
 				dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
 				dma-names = "rx", "tx";
@@ -1009,7 +1040,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021ec000 0x4000>;
 				interrupts = <0 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 160>, <&clks 161>;
+				clocks = <&clks IMX6QDL_CLK_UART_IPG>,
+					 <&clks IMX6QDL_CLK_UART_SERIAL>;
 				clock-names = "ipg", "per";
 				dmas = <&sdma 29 4 0>, <&sdma 30 4 0>;
 				dma-names = "rx", "tx";
@@ -1020,7 +1052,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f0000 0x4000>;
 				interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 160>, <&clks 161>;
+				clocks = <&clks IMX6QDL_CLK_UART_IPG>,
+					 <&clks IMX6QDL_CLK_UART_SERIAL>;
 				clock-names = "ipg", "per";
 				dmas = <&sdma 31 4 0>, <&sdma 32 4 0>;
 				dma-names = "rx", "tx";
@@ -1031,7 +1064,8 @@
 				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f4000 0x4000>;
 				interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks 160>, <&clks 161>;
+				clocks = <&clks IMX6QDL_CLK_UART_IPG>,
+					 <&clks IMX6QDL_CLK_UART_SERIAL>;
 				clock-names = "ipg", "per";
 				dmas = <&sdma 33 4 0>, <&sdma 34 4 0>;
 				dma-names = "rx", "tx";
@@ -1046,7 +1080,9 @@
 			reg = <0x02400000 0x400000>;
 			interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>,
 				     <0 5 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
+			clocks = <&clks IMX6QDL_CLK_IPU1>,
+				 <&clks IMX6QDL_CLK_IPU1_DI0>,
+				 <&clks IMX6QDL_CLK_IPU1_DI1>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
 
-- 
1.8.3.2
