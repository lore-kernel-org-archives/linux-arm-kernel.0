From: stefan@agner.ch (Stefan Agner)
Date: Fri, 30 Jan 2015 11:33:05 +0100
Subject: [PATCH v4 3/3] ARM: dts: vf610: add Miscellaneous System Control
 Module (MSCM)
In-Reply-To: <1422613985-11726-1-git-send-email-stefan@agner.ch>
References: <1422613985-11726-1-git-send-email-stefan@agner.ch>
Message-ID: <1422613985-11726-4-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Miscellaneous System Control Module (MSCM) to the base
device tree for Vybrid SoC's. This module contains registers
to get information of the individual and current (accessing)
CPU. In a second block, there is an interrupt router, which
handles the routing of the interrupts between the two CPU cores
on VF6xx variants of the SoC. However, also on single core
variants the interrupt router needs to be configured in order
to receive interrupts on the CPU's interrupt controller. Almost
all peripheral interrupts are routed through the router, hence
the MSCM module is the default interrupt parent for this SoC.

In a earlier commit the interrupt nodes were moved out of the
peripheral nodes and specified in the CPU specific vf500.dtsi
device tree. This allowed to use the base device tree vfxxx.dtsi
also for a Cortex-M4 specific device tree, which uses different
interrupt nodes due to the NVIC interrupt controller. However,
since the interrupt parent for peripherals is the MSCM module
independently which CPU the device tree is used for, we can move
the interrupt nodes into the base device tree vfxxx.dtsi again.
Depending on which CPU this base device tree will be used with,
the correct parent interrupt controller has to be assigned to
the MSCM-IR node (GIC or NVIC). The driver takes care of the
parent interrupt controller specific needs (interrupt-cells).

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf500.dtsi | 128 ++-----------------------------------------
 arch/arm/boot/dts/vfxxx.dtsi |  48 ++++++++++++++++
 2 files changed, 52 insertions(+), 124 deletions(-)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index de67005..9747f97 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -24,14 +24,13 @@
 	};
 
 	soc {
-		interrupt-parent = <&intc>;
-
 		aips-bus at 40000000 {
 
 			intc: interrupt-controller at 40002000 {
 				compatible = "arm,cortex-a9-gic";
 				#interrupt-cells = <3>;
 				interrupt-controller;
+				interrupt-parent = <&intc>;
 				reg = <0x40003000 0x1000>,
 				      <0x40002100 0x100>;
 			};
@@ -40,132 +39,13 @@
 				compatible = "arm,cortex-a9-global-timer";
 				reg = <0x40002200 0x20>;
 				interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&intc>;
 				clocks = <&clks VF610_CLK_PLATFORM_BUS>;
 			};
 		};
 	};
 };
 
-&adc0 {
-	interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&adc1 {
-	interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&can0 {
-	interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&can1 {
-	interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&dspi0 {
-	interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&edma0 {
-	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "edma-tx", "edma-err";
-};
-
-&edma1 {
-	interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "edma-tx", "edma-err";
-};
-
-&esdhc1 {
-	interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&fec0 {
-	interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&fec1 {
-	interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&ftm {
-	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&gpio1 {
-	interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&gpio2 {
-	interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&gpio3 {
-	interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&gpio4 {
-	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&gpio5 {
-	interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&i2c0 {
-	interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&pit {
-	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&qspi0 {
-	interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&sai2 {
-	interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&uart0 {
-	interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&uart1 {
-	interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&uart2 {
-	interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&uart3 {
-	interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&uart4 {
-	interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&uart5 {
-	interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&usbdev0 {
-	interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&usbh1 {
-	interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&usbphy0 {
-	interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-&usbphy1 {
-	interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+&mscm_ir {
+	interrupt-parent = <&intc>;
 };
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 505969a..731ae9f 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -47,6 +47,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
+		interrupt-parent = <&mscm_ir>;
 		ranges;
 
 		aips0: aips-bus at 40000000 {
@@ -55,6 +56,19 @@
 			#size-cells = <1>;
 			ranges;
 
+			mscm_cpucfg: cpucfg at 40001000 {
+				compatible = "fsl,vf610-mscm-cpucfg", "syscon";
+				reg = <0x40001000 0x800>;
+			};
+
+			mscm_ir: interrupt-controller at 40001800 {
+				compatible = "fsl,vf610-mscm-ir";
+				reg = <0x40001800 0x400>;
+				fsl,cpucfg = <&mscm_cpucfg>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
 			edma0: dma-controller at 40018000 {
 				#dma-cells = <2>;
 				compatible = "fsl,vf610-edma";
@@ -62,6 +76,9 @@
 					<0x40024000 0x1000>,
 					<0x40025000 0x1000>;
 				dma-channels = <32>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>,
+						<9 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "edma-tx", "edma-err";
 				clock-names = "dmamux0", "dmamux1";
 				clocks = <&clks VF610_CLK_DMAMUX0>,
 					<&clks VF610_CLK_DMAMUX1>;
@@ -71,6 +88,7 @@
 			can0: flexcan at 40020000 {
 				compatible = "fsl,vf610-flexcan";
 				reg = <0x40020000 0x4000>;
+				interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_FLEXCAN0>,
 					 <&clks VF610_CLK_FLEXCAN0>;
 				clock-names = "ipg", "per";
@@ -80,6 +98,7 @@
 			uart0: serial at 40027000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x40027000 0x1000>;
+				interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART0>;
 				clock-names = "ipg";
 				dmas = <&edma0 0 2>,
@@ -91,6 +110,7 @@
 			uart1: serial at 40028000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x40028000 0x1000>;
+				interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART1>;
 				clock-names = "ipg";
 				dmas = <&edma0 0 4>,
@@ -102,6 +122,7 @@
 			uart2: serial at 40029000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x40029000 0x1000>;
+				interrupts = <63 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART2>;
 				clock-names = "ipg";
 				dmas = <&edma0 0 6>,
@@ -113,6 +134,7 @@
 			uart3: serial at 4002a000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x4002a000 0x1000>;
+				interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART3>;
 				clock-names = "ipg";
 				dmas = <&edma0 0 8>,
@@ -126,6 +148,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,vf610-dspi";
 				reg = <0x4002c000 0x1000>;
+				interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_DSPI0>;
 				clock-names = "dspi";
 				spi-num-chipselects = <5>;
@@ -135,6 +158,7 @@
 			sai2: sai at 40031000 {
 				compatible = "fsl,vf610-sai";
 				reg = <0x40031000 0x1000>;
+				interrupts = <86 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_SAI2>;
 				clock-names = "sai";
 				dma-names = "tx", "rx";
@@ -146,6 +170,7 @@
 			pit: pit at 40037000 {
 				compatible = "fsl,vf610-pit";
 				reg = <0x40037000 0x1000>;
+				interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_PIT>;
 				clock-names = "pit";
 			};
@@ -179,6 +204,7 @@
 			adc0: adc at 4003b000 {
 				compatible = "fsl,vf610-adc";
 				reg = <0x4003b000 0x1000>;
+				interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_ADC0>;
 				clock-names = "adc";
 				status = "disabled";
@@ -197,6 +223,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,vf610-qspi";
 				reg = <0x40044000 0x1000>;
+				interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_QSPI0_EN>,
 					<&clks VF610_CLK_QSPI0>;
 				clock-names = "qspi_en", "qspi";
@@ -214,6 +241,7 @@
 				reg = <0x40049000 0x1000 0x400ff000 0x40>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				gpio-ranges = <&iomuxc 0 0 32>;
@@ -224,6 +252,7 @@
 				reg = <0x4004a000 0x1000 0x400ff040 0x40>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupts = <108 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				gpio-ranges = <&iomuxc 0 32 32>;
@@ -234,6 +263,7 @@
 				reg = <0x4004b000 0x1000 0x400ff080 0x40>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupts = <109 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				gpio-ranges = <&iomuxc 0 64 32>;
@@ -244,6 +274,7 @@
 				reg = <0x4004c000 0x1000 0x400ff0c0 0x40>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				gpio-ranges = <&iomuxc 0 96 32>;
@@ -254,6 +285,7 @@
 				reg = <0x4004d000 0x1000 0x400ff100 0x40>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				gpio-ranges = <&iomuxc 0 128 7>;
@@ -267,6 +299,7 @@
 			usbphy0: usbphy at 40050800 {
 				compatible = "fsl,vf610-usbphy";
 				reg = <0x40050800 0x400>;
+				interrupts = <50 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_USBPHY0>;
 				fsl,anatop = <&anatop>;
 				status = "disabled";
@@ -275,6 +308,7 @@
 			usbphy1: usbphy at 40050c00 {
 				compatible = "fsl,vf610-usbphy";
 				reg = <0x40050c00 0x400>;
+				interrupts = <51 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_USBPHY1>;
 				fsl,anatop = <&anatop>;
 				status = "disabled";
@@ -285,6 +319,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,vf610-i2c";
 				reg = <0x40066000 0x1000>;
+				interrupts = <71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_I2C0>;
 				clock-names = "ipg";
 				dmas = <&edma0 0 50>,
@@ -304,6 +339,7 @@
 			usbdev0: usb at 40034000 {
 				compatible = "fsl,vf610-usb", "fsl,imx27-usb";
 				reg = <0x40034000 0x800>;
+				interrupts = <75 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_USBC0>;
 				fsl,usbphy = <&usbphy0>;
 				fsl,usbmisc = <&usbmisc0 0>;
@@ -333,6 +369,9 @@
 					<0x400a1000 0x1000>,
 					<0x400a2000 0x1000>;
 				dma-channels = <32>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
+						<11 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "edma-tx", "edma-err";
 				clock-names = "dmamux0", "dmamux1";
 				clocks = <&clks VF610_CLK_DMAMUX2>,
 					<&clks VF610_CLK_DMAMUX3>;
@@ -342,6 +381,7 @@
 			uart4: serial at 400a9000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x400a9000 0x1000>;
+				interrupts = <65 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART4>;
 				clock-names = "ipg";
 				status = "disabled";
@@ -350,6 +390,7 @@
 			uart5: serial at 400aa000 {
 				compatible = "fsl,vf610-lpuart";
 				reg = <0x400aa000 0x1000>;
+				interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_UART5>;
 				clock-names = "ipg";
 				status = "disabled";
@@ -358,6 +399,7 @@
 			adc1: adc at 400bb000 {
 				compatible = "fsl,vf610-adc";
 				reg = <0x400bb000 0x1000>;
+				interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_ADC1>;
 				clock-names = "adc";
 				status = "disabled";
@@ -366,6 +408,7 @@
 			esdhc1: esdhc at 400b2000 {
 				compatible = "fsl,imx53-esdhc";
 				reg = <0x400b2000 0x1000>;
+				interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_IPG_BUS>,
 					<&clks VF610_CLK_PLATFORM_BUS>,
 					<&clks VF610_CLK_ESDHC1>;
@@ -376,6 +419,7 @@
 			usbh1: usb at 400b4000 {
 				compatible = "fsl,vf610-usb", "fsl,imx27-usb";
 				reg = <0x400b4000 0x800>;
+				interrupts = <76 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_USBC1>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc1 0>;
@@ -394,6 +438,7 @@
 			ftm: ftm at 400b8000 {
 				compatible = "fsl,ftm-timer";
 				reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
+				interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "ftm-evt", "ftm-src",
 					"ftm-evt-counter-en", "ftm-src-counter-en";
 				clocks = <&clks VF610_CLK_FTM2>,
@@ -406,6 +451,7 @@
 			fec0: ethernet at 400d0000 {
 				compatible = "fsl,mvf600-fec";
 				reg = <0x400d0000 0x1000>;
+				interrupts = <78 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_ENET0>,
 					<&clks VF610_CLK_ENET0>,
 					<&clks VF610_CLK_ENET>;
@@ -416,6 +462,7 @@
 			fec1: ethernet at 400d1000 {
 				compatible = "fsl,mvf600-fec";
 				reg = <0x400d1000 0x1000>;
+				interrupts = <79 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_ENET1>,
 					<&clks VF610_CLK_ENET1>,
 					<&clks VF610_CLK_ENET>;
@@ -426,6 +473,7 @@
 			can1: flexcan at 400d4000 {
 				compatible = "fsl,vf610-flexcan";
 				reg = <0x400d4000 0x4000>;
+				interrupts = <59 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_FLEXCAN1>,
 					 <&clks VF610_CLK_FLEXCAN1>;
 				clock-names = "ipg", "per";
-- 
2.2.2
