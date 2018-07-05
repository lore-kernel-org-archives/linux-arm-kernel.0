From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu,  5 Jul 2018 22:05:49 +0300
Subject: [PATCH v2 2/3] ARM: dts: imx31: add device tree description of basic
 controllers
In-Reply-To: <20180703192934.6080-3-vz@mleia.com>
References: <20180703192934.6080-3-vz@mleia.com>
Message-ID: <20180705190549.22651-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds a number of basic peripherals found on i.MX31 SoC:
* GPIO controllers,
* I2C master controllers,
* SPI master controllers,
* ATA controller,
* SDHC controllers,
* RTC, watchdog and PWM contollers,
* SDMA,
* IRAM,
* NAND and WEIM controllers on EMI.

The added controller devices were tested on Freescale i.MX31 powered
LogicPD Lite SoM and baseboard.

DMA functionality was tested on SDHC and SPI controllers so far,
thus dmas properties are added to those device nodes only.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* removed mmc0 and mmc1 aliases,
* added #address-cells, #size-cells and ranges properties to iram device node

 arch/arm/boot/dts/imx31.dtsi | 223 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 4642c81..ca1419c 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
+// Copyright 2016-2018 Vladimir Zapolskiy <vz@mleia.com>
 // Copyright 2012 Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
 
 / {
@@ -15,11 +16,20 @@
 	memory { device_type = "memory"; };
 
 	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		i2c0 = &i2c1;
+		i2c1 = &i2c2;
+		i2c2 = &i2c3;
 		serial0 = &uart1;
 		serial1 = &uart2;
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+		spi0 = &spi1;
+		spi1 = &spi2;
+		spi2 = &spi3;
 	};
 
 	cpus {
@@ -47,6 +57,14 @@
 		interrupt-parent = <&avic>;
 		ranges;
 
+		iram: iram at 1fffc000 {
+			compatible = "mmio-sram";
+			reg = <0x1fffc000 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1fffc000 0x4000>;
+		};
+
 		aips at 43f00000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
@@ -54,6 +72,34 @@
 			reg = <0x43f00000 0x100000>;
 			ranges;
 
+			i2c1: i2c at 43f80000 {
+				compatible = "fsl,imx31-i2c", "fsl,imx21-i2c";
+				reg = <0x43f80000 0x4000>;
+				interrupts = <10>;
+				clocks = <&clks 33>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 43f84000 {
+				compatible = "fsl,imx31-i2c", "fsl,imx21-i2c";
+				reg = <0x43f84000 0x4000>;
+				interrupts = <3>;
+				clocks = <&clks 35>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			ata: ata at 43f8c000 {
+				compatible = "fsl,imx31-pata", "fsl,imx27-pata";
+				reg = <0x43f8c000 0x4000>;
+				interrupts = <15>;
+				clocks = <&clks 26>;
+				status = "disabled";
+			};
+
 			uart1: serial at 43f90000 {
 				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
 				reg = <0x43f90000 0x4000>;
@@ -72,6 +118,29 @@
 				status = "disabled";
 			};
 
+			i2c2: i2c at 43f98000 {
+				compatible = "fsl,imx31-i2c", "fsl,imx21-i2c";
+				reg = <0x43f98000 0x4000>;
+				interrupts = <4>;
+				clocks = <&clks 34>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi1: spi at 43fa4000 {
+				compatible = "fsl,imx31-cspi";
+				reg = <0x43fa4000 0x4000>;
+				interrupts = <14>;
+				clocks = <&clks 10>, <&clks 53>;
+				clock-names = "ipg", "per";
+				dmas = <&sdma 8 8 0>, <&sdma 9 8 0>;
+				dma-names = "rx", "tx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			kpp: kpp at 43fa8000 {
 				compatible = "fsl,imx31-kpp", "fsl,imx21-kpp";
 				reg = <0x43fa8000 0x4000>;
@@ -106,6 +175,28 @@
 			reg = <0x50000000 0x100000>;
 			ranges;
 
+			sdhci1: sdhci at 50004000 {
+				compatible = "fsl,imx31-mmc";
+				reg = <0x50004000 0x4000>;
+				interrupts = <9>;
+				clocks = <&clks 10>, <&clks 20>;
+				clock-names = "ipg", "per";
+				dmas = <&sdma 20 3 0>;
+				dma-names = "rx-tx";
+				status = "disabled";
+			};
+
+			sdhci2: sdhci at 50008000 {
+				compatible = "fsl,imx31-mmc";
+				reg = <0x50008000 0x4000>;
+				interrupts = <8>;
+				clocks = <&clks 10>, <&clks 21>;
+				clock-names = "ipg", "per";
+				dmas = <&sdma 21 3 0>;
+				dma-names = "rx-tx";
+				status = "disabled";
+			};
+
 			uart3: serial at 5000c000 {
 				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
 				reg = <0x5000c000 0x4000>;
@@ -115,6 +206,19 @@
 				status = "disabled";
 			};
 
+			spi2: cspi at 50010000 {
+				compatible = "fsl,imx31-cspi";
+				reg = <0x50010000 0x4000>;
+				interrupts = <13>;
+				clocks = <&clks 10>, <&clks 54>;
+				clock-names = "ipg", "per";
+				dmas = <&sdma 6 8 0>, <&sdma 7 8 0>;
+				dma-names = "rx", "tx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			iim: iim at 5001c000 {
 				compatible = "fsl,imx31-iim", "fsl,imx27-iim";
 				reg = <0x5001c000 0x1000>;
@@ -137,6 +241,19 @@
 				#clock-cells = <1>;
 			};
 
+			spi3: cspi at 53f84000 {
+				compatible = "fsl,imx31-cspi";
+				reg = <0x53f84000 0x4000>;
+				interrupts = <17>;
+				clocks = <&clks 10>, <&clks 28>;
+				clock-names = "ipg", "per";
+				dmas = <&sdma 10 8 0>, <&sdma 11 8 0>;
+				dma-names = "rx", "tx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			gpt: timer at 53f90000 {
 				compatible = "fsl,imx31-gpt";
 				reg = <0x53f90000 0x4000>;
@@ -144,6 +261,112 @@
 				clocks = <&clks 10>, <&clks 22>;
 				clock-names = "ipg", "per";
 			};
+
+			gpio3: gpio at 53fa4000 {
+				compatible = "fsl,imx31-gpio";
+				reg = <0x53fa4000 0x4000>;
+				interrupts = <56>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			rng at 53fb0000 {
+				compatible = "fsl,imx31-rnga";
+				reg = <0x53fb0000 0x4000>;
+				interrupts = <22>;
+				clocks = <&clks 29>;
+			};
+
+			gpio1: gpio at 53fcc000 {
+				compatible = "fsl,imx31-gpio";
+				reg = <0x53fcc000 0x4000>;
+				interrupts = <52>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio2: gpio at 53fd0000 {
+				compatible = "fsl,imx31-gpio";
+				reg = <0x53fd0000 0x4000>;
+				interrupts = <51>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			sdma: sdma at 53fd4000 {
+				compatible = "fsl,imx31-sdma";
+				reg = <0x53fd4000 0x4000>;
+				interrupts = <34>;
+				clocks = <&clks 10>, <&clks 27>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx31.bin";
+			};
+
+			rtc: rtc at 53fd8000 {
+				compatible = "fsl,imx31-rtc", "fsl,imx21-rtc";
+				reg = <0x53fd8000 0x4000>;
+				interrupts = <25>;
+				clocks = <&clks 2>, <&clks 40>;
+				clock-names = "ref", "ipg";
+			};
+
+			wdog: wdog at 53fdc000 {
+				compatible = "fsl,imx31-wdt", "fsl,imx21-wdt";
+				reg = <0x53fdc000 0x4000>;
+				clocks = <&clks 41>;
+			};
+
+			pwm: pwm at 53fe0000 {
+				compatible = "fsl,imx31-pwm", "fsl,imx27-pwm";
+				reg = <0x53fe0000 0x4000>;
+				interrupts = <26>;
+				clocks = <&clks 10>, <&clks 42>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+		};
+
+		emi at b8000000 { /* External Memory Interface */
+			compatible = "simple-bus";
+			reg = <0xb8000000 0x5000>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nfc: nand at b8000000 {
+				compatible = "fsl,imx31-nand", "fsl,imx27-nand";
+				reg = <0xb8000000 0x1000>;
+				interrupts = <33>;
+				clocks = <&clks 9>;
+				dmas = <&sdma 30 17 0>;
+				dma-names = "rx-tx";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				status = "disabled";
+			};
+
+			weim: weim at b8002000 {
+				compatible = "fsl,imx31-weim", "fsl,imx27-weim";
+				reg = <0xb8002000 0x1000>;
+				clocks = <&clks 56>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges = <0 0 0xa0000000 0x08000000
+					  1 0 0xa8000000 0x08000000
+					  2 0 0xb0000000 0x02000000
+					  3 0 0xb2000000 0x02000000
+					  4 0 0xb4000000 0x02000000
+					  5 0 0xb6000000 0x02000000>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.10.2
