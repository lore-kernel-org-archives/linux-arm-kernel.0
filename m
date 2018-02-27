From: stefan@agner.ch (Stefan Agner)
Date: Tue, 27 Feb 2018 17:30:49 +0100
Subject: [PATCH] ARM: dts: imx7s: add spba-bus abstraction
Message-ID: <20180227163049.18809-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the i.MX 7Solo/Dual Application Processor Reference
Manual the ECSPI1/2/3, UART1/2/3 and SAI1/2/3 peripherals are
connected through the SPBA bus. Other similar SoCs such as i.MX 6UL
add this bus abstraction. This adds the bus also to the i.MX 7
device tree.

The i.MX SDMA driver uses this abstraction to configure watermark
levels slightly differently, so this might change behavior slightly.
There have no issues been observed before or after the patch.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7s.dtsi | 214 ++++++++++++++++++++++---------------------
 1 file changed, 111 insertions(+), 103 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 46400ba2217a..724adb1f7423 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -718,118 +718,126 @@
 			reg = <0x30800000 0x400000>;
 			ranges;
 
-			ecspi1: ecspi at 30820000 {
+			spba-bus at 30800000 {
+				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
-				reg = <0x30820000 0x10000>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_ECSPI1_ROOT_CLK>,
-					<&clks IMX7D_ECSPI1_ROOT_CLK>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				#size-cells = <1>;
+				reg = <0x30800000 0x100000>;
+				ranges;
 
-			ecspi2: ecspi at 30830000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
-				reg = <0x30830000 0x10000>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_ECSPI2_ROOT_CLK>,
-					<&clks IMX7D_ECSPI2_ROOT_CLK>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				ecspi1: ecspi at 30820000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
+					reg = <0x30820000 0x10000>;
+					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_ECSPI1_ROOT_CLK>,
+						<&clks IMX7D_ECSPI1_ROOT_CLK>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			ecspi3: ecspi at 30840000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
-				reg = <0x30840000 0x10000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_ECSPI3_ROOT_CLK>,
-					<&clks IMX7D_ECSPI3_ROOT_CLK>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				ecspi2: ecspi at 30830000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
+					reg = <0x30830000 0x10000>;
+					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_ECSPI2_ROOT_CLK>,
+						<&clks IMX7D_ECSPI2_ROOT_CLK>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			uart1: serial at 30860000 {
-				compatible = "fsl,imx7d-uart",
-					     "fsl,imx6q-uart";
-				reg = <0x30860000 0x10000>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_UART1_ROOT_CLK>,
-					<&clks IMX7D_UART1_ROOT_CLK>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				ecspi3: ecspi at 30840000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx7d-ecspi", "fsl,imx51-ecspi";
+					reg = <0x30840000 0x10000>;
+					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_ECSPI3_ROOT_CLK>,
+						<&clks IMX7D_ECSPI3_ROOT_CLK>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			uart2: serial at 30890000 {
-				compatible = "fsl,imx7d-uart",
-					     "fsl,imx6q-uart";
-				reg = <0x30890000 0x10000>;
-				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_UART2_ROOT_CLK>,
-					<&clks IMX7D_UART2_ROOT_CLK>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				uart1: serial at 30860000 {
+					compatible = "fsl,imx7d-uart",
+						     "fsl,imx6q-uart";
+					reg = <0x30860000 0x10000>;
+					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_UART1_ROOT_CLK>,
+						<&clks IMX7D_UART1_ROOT_CLK>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			uart3: serial at 30880000 {
-				compatible = "fsl,imx7d-uart",
-					     "fsl,imx6q-uart";
-				reg = <0x30880000 0x10000>;
-				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_UART3_ROOT_CLK>,
-					<&clks IMX7D_UART3_ROOT_CLK>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
+				uart2: serial at 30890000 {
+					compatible = "fsl,imx7d-uart",
+						     "fsl,imx6q-uart";
+					reg = <0x30890000 0x10000>;
+					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_UART2_ROOT_CLK>,
+						<&clks IMX7D_UART2_ROOT_CLK>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			sai1: sai at 308a0000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx7d-sai", "fsl,imx6sx-sai";
-				reg = <0x308a0000 0x10000>;
-				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_SAI1_IPG_CLK>,
-					 <&clks IMX7D_SAI1_ROOT_CLK>,
-					 <&clks IMX7D_CLK_DUMMY>,
-					 <&clks IMX7D_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dma-names = "rx", "tx";
-				dmas = <&sdma 8 24 0>, <&sdma 9 24 0>;
-				status = "disabled";
-			};
+				uart3: serial at 30880000 {
+					compatible = "fsl,imx7d-uart",
+						     "fsl,imx6q-uart";
+					reg = <0x30880000 0x10000>;
+					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_UART3_ROOT_CLK>,
+						<&clks IMX7D_UART3_ROOT_CLK>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 
-			sai2: sai at 308b0000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx7d-sai", "fsl,imx6sx-sai";
-				reg = <0x308b0000 0x10000>;
-				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_SAI2_IPG_CLK>,
-					 <&clks IMX7D_SAI2_ROOT_CLK>,
-					 <&clks IMX7D_CLK_DUMMY>,
-					 <&clks IMX7D_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dma-names = "rx", "tx";
-				dmas = <&sdma 10 24 0>, <&sdma 11 24 0>;
-				status = "disabled";
-			};
+				sai1: sai at 308a0000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx7d-sai", "fsl,imx6sx-sai";
+					reg = <0x308a0000 0x10000>;
+					interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_SAI1_IPG_CLK>,
+						 <&clks IMX7D_SAI1_ROOT_CLK>,
+						 <&clks IMX7D_CLK_DUMMY>,
+						 <&clks IMX7D_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dma-names = "rx", "tx";
+					dmas = <&sdma 8 24 0>, <&sdma 9 24 0>;
+					status = "disabled";
+				};
 
-			sai3: sai at 308c0000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx7d-sai", "fsl,imx6sx-sai";
-				reg = <0x308c0000 0x10000>;
-				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_SAI3_IPG_CLK>,
-					 <&clks IMX7D_SAI3_ROOT_CLK>,
-					 <&clks IMX7D_CLK_DUMMY>,
-					 <&clks IMX7D_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dma-names = "rx", "tx";
-				dmas = <&sdma 12 24 0>, <&sdma 13 24 0>;
-				status = "disabled";
+				sai2: sai at 308b0000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx7d-sai", "fsl,imx6sx-sai";
+					reg = <0x308b0000 0x10000>;
+					interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_SAI2_IPG_CLK>,
+						 <&clks IMX7D_SAI2_ROOT_CLK>,
+						 <&clks IMX7D_CLK_DUMMY>,
+						 <&clks IMX7D_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dma-names = "rx", "tx";
+					dmas = <&sdma 10 24 0>, <&sdma 11 24 0>;
+					status = "disabled";
+				};
+
+				sai3: sai at 308c0000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx7d-sai", "fsl,imx6sx-sai";
+					reg = <0x308c0000 0x10000>;
+					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX7D_SAI3_IPG_CLK>,
+						 <&clks IMX7D_SAI3_ROOT_CLK>,
+						 <&clks IMX7D_CLK_DUMMY>,
+						 <&clks IMX7D_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dma-names = "rx", "tx";
+					dmas = <&sdma 12 24 0>, <&sdma 13 24 0>;
+					status = "disabled";
+				};
 			};
 
 			flexcan1: can at 30a00000 {
-- 
2.16.2
