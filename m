From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 22 Jun 2014 12:34:49 +0400
Subject: [PATCH 1/2] ARM: i.MX27: Introduce DT include for clock provider
Message-ID: <1403426090-29806-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clock defines in order to make devicetrees more human readable.
Additional changes included in this patch (imx27.dtsi):
- Fix IPG clock for UART6.
- Use EMI_AHB_GATE clock for WEIM.
- Added GPIO_IPG_GATE clock for GPIO nodes. Currently this clock is
  not used by the driver, but it can be added in the future.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/clock/imx27-clock.txt      | 127 +-------
 arch/arm/boot/dts/imx27-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   2 +-
 arch/arm/boot/dts/imx27.dtsi                       | 115 ++++---
 arch/arm/mach-imx/clk-imx27.c                      | 347 ++++++++++-----------
 include/dt-bindings/clock/imx27-clock.h            | 107 +++++++
 7 files changed, 362 insertions(+), 340 deletions(-)
 create mode 100644 include/dt-bindings/clock/imx27-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx27-clock.txt b/Documentation/devicetree/bindings/clock/imx27-clock.txt
index 6bc9fd2..cc05de9 100644
--- a/Documentation/devicetree/bindings/clock/imx27-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx27-clock.txt
@@ -7,117 +7,22 @@ Required properties:
 - #clock-cells: Should be <1>
 
 The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  The following is a full list of i.MX27
-clocks and IDs.
-
-	Clock		    ID
-	-----------------------
-	dummy                0
-	ckih                 1
-	ckil                 2
-	mpll                 3
-	spll                 4
-	mpll_main2           5
-	ahb                  6
-	ipg                  7
-	nfc_div              8
-	per1_div             9
-	per2_div             10
-	per3_div             11
-	per4_div             12
-	vpu_sel              13
-	vpu_div              14
-	usb_div              15
-	cpu_sel              16
-	clko_sel             17
-	cpu_div              18
-	clko_div             19
-	ssi1_sel             20
-	ssi2_sel             21
-	ssi1_div             22
-	ssi2_div             23
-	clko_en              24
-	ssi2_ipg_gate        25
-	ssi1_ipg_gate        26
-	slcdc_ipg_gate       27
-	sdhc3_ipg_gate       28
-	sdhc2_ipg_gate       29
-	sdhc1_ipg_gate       30
-	scc_ipg_gate         31
-	sahara_ipg_gate      32
-	rtc_ipg_gate         33
-	pwm_ipg_gate         34
-	owire_ipg_gate       35
-	lcdc_ipg_gate        36
-	kpp_ipg_gate         37
-	iim_ipg_gate         38
-	i2c2_ipg_gate        39
-	i2c1_ipg_gate        40
-	gpt6_ipg_gate        41
-	gpt5_ipg_gate        42
-	gpt4_ipg_gate        43
-	gpt3_ipg_gate        44
-	gpt2_ipg_gate        45
-	gpt1_ipg_gate        46
-	gpio_ipg_gate        47
-	fec_ipg_gate         48
-	emma_ipg_gate        49
-	dma_ipg_gate         50
-	cspi3_ipg_gate       51
-	cspi2_ipg_gate       52
-	cspi1_ipg_gate       53
-	nfc_baud_gate        54
-	ssi2_baud_gate       55
-	ssi1_baud_gate       56
-	vpu_baud_gate        57
-	per4_gate            58
-	per3_gate            59
-	per2_gate            60
-	per1_gate            61
-	usb_ahb_gate         62
-	slcdc_ahb_gate       63
-	sahara_ahb_gate      64
-	lcdc_ahb_gate        65
-	vpu_ahb_gate         66
-	fec_ahb_gate         67
-	emma_ahb_gate        68
-	emi_ahb_gate         69
-	dma_ahb_gate         70
-	csi_ahb_gate         71
-	brom_ahb_gate        72
-	ata_ahb_gate         73
-	wdog_ipg_gate        74
-	usb_ipg_gate         75
-	uart6_ipg_gate       76
-	uart5_ipg_gate       77
-	uart4_ipg_gate       78
-	uart3_ipg_gate       79
-	uart2_ipg_gate       80
-	uart1_ipg_gate       81
-	ckih_div1p5          82
-	fpm                  83
-	mpll_osc_sel         84
-	mpll_sel             85
-	spll_gate            86
-	mshc_div             87
-	rtic_ipg_gate        88
-	mshc_ipg_gate        89
-	rtic_ahb_gate        90
-	mshc_baud_gate       91
+ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx27-clock.h
+for the full list of i.MX27 clock IDs.
 
 Examples:
+	clks: ccm at 10027000{
+		compatible = "fsl,imx27-ccm";
+		reg = <0x10027000 0x1000>;
+		#clock-cells = <1>;
+	};
 
-clks: ccm at 10027000{
-	compatible = "fsl,imx27-ccm";
-	reg = <0x10027000 0x1000>;
-	#clock-cells = <1>;
-};
-
-uart1: serial at 1000a000 {
-	compatible = "fsl,imx27-uart", "fsl,imx21-uart";
-	reg = <0x1000a000 0x1000>;
-	interrupts = <20>;
-	clocks = <&clks 81>, <&clks 61>;
-	clock-names = "ipg", "per";
-	status = "disabled";
-};
+	uart1: serial at 1000a000 {
+		compatible = "fsl,imx27-uart", "fsl,imx21-uart";
+		reg = <0x1000a000 0x1000>;
+		interrupts = <20>;
+		clocks = <&clks IMX27_CLK_UART1_IPG_GATE>,
+			 <&clks IMX27_CLK_PER1_GATE>;
+		clock-names = "ipg", "per";
+		status = "disabled";
+	};
diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 4c31771..49450db 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -28,7 +28,7 @@
 		usbphy0: usbphy at 0 {
 			compatible = "usb-nop-xceiv";
 			reg = <0>;
-			clocks = <&clks 0>;
+			clocks = <&clks IMX27_CLK_DUMMY>;
 			clock-names = "main_clk";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index fe02bc7..538568b 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -61,7 +61,7 @@
 			compatible = "usb-nop-xceiv";
 			reg = <2>;
 			vcc-supply = <&reg_5v0>;
-			clocks = <&clks 0>;
+			clocks = <&clks IMX27_CLK_DUMMY>;
 			clock-names = "main_clk";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 31e9f70..9ba0523 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -51,7 +51,7 @@
 			compatible = "usb-nop-xceiv";
 			reg = <0>;
 			vcc-supply = <&sw3_reg>;
-			clocks = <&clks 0>;
+			clocks = <&clks IMX27_CLK_DUMMY>;
 			clock-names = "main_clk";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index a75555c..107d713 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -11,9 +11,11 @@
 
 #include "skeleton.dtsi"
 #include "imx27-pinfunc.h"
+
+#include <dt-bindings/clock/imx27-clock.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
@@ -68,7 +70,7 @@
 				399000 1450000
 			>;
 			clock-latency = <62500>;
-			clocks = <&clks 18>;
+			clocks = <&clks IMX27_CLK_CPU_DIV>;
 			voltage-tolerance = <5>;
 		};
 	};
@@ -91,7 +93,8 @@
 				compatible = "fsl,imx27-dma";
 				reg = <0x10001000 0x1000>;
 				interrupts = <32>;
-				clocks = <&clks 50>, <&clks 70>;
+				clocks = <&clks IMX27_CLK_DMA_IPG_GATE>,
+					 <&clks IMX27_CLK_DMA_AHB_GATE>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <1>;
 				#dma-channels = <16>;
@@ -101,14 +104,15 @@
 				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
 				reg = <0x10002000 0x1000>;
 				interrupts = <27>;
-				clocks = <&clks 74>;
+				clocks = <&clks IMX27_CLK_WDOG_IPG_GATE>;
 			};
 
 			gpt1: timer at 10003000 {
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x10003000 0x1000>;
 				interrupts = <26>;
-				clocks = <&clks 46>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_GPT1_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 			};
 
@@ -116,7 +120,8 @@
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x10004000 0x1000>;
 				interrupts = <25>;
-				clocks = <&clks 45>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_GPT2_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 			};
 
@@ -124,7 +129,8 @@
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x10005000 0x1000>;
 				interrupts = <24>;
-				clocks = <&clks 44>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_GPT3_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 			};
 
@@ -133,7 +139,8 @@
 				compatible = "fsl,imx27-pwm";
 				reg = <0x10006000 0x1000>;
 				interrupts = <23>;
-				clocks = <&clks 34>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_PWM_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 			};
 
@@ -141,14 +148,14 @@
 				compatible = "fsl,imx27-kpp", "fsl,imx21-kpp";
 				reg = <0x10008000 0x1000>;
 				interrupts = <21>;
-				clocks = <&clks 37>;
+				clocks = <&clks IMX27_CLK_KPP_IPG_GATE>;
 				status = "disabled";
 			};
 
 			owire: owire at 10009000 {
 				compatible = "fsl,imx27-owire", "fsl,imx21-owire";
 				reg = <0x10009000 0x1000>;
-				clocks = <&clks 35>;
+				clocks = <&clks IMX27_CLK_OWIRE_IPG_GATE>;
 				status = "disabled";
 			};
 
@@ -156,7 +163,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000a000 0x1000>;
 				interrupts = <20>;
-				clocks = <&clks 81>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_UART1_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -165,7 +173,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000b000 0x1000>;
 				interrupts = <19>;
-				clocks = <&clks 80>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_UART2_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -174,7 +183,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000c000 0x1000>;
 				interrupts = <18>;
-				clocks = <&clks 79>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_UART3_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -183,7 +193,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000d000 0x1000>;
 				interrupts = <17>;
-				clocks = <&clks 78>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_UART4_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -194,7 +205,8 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x1000e000 0x1000>;
 				interrupts = <16>;
-				clocks = <&clks 53>, <&clks 60>;
+				clocks = <&clks IMX27_CLK_CSPI1_IPG_GATE>,
+					 <&clks IMX27_CLK_PER2_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -205,7 +217,8 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x1000f000 0x1000>;
 				interrupts = <15>;
-				clocks = <&clks 52>, <&clks 60>;
+				clocks = <&clks IMX27_CLK_CSPI2_IPG_GATE>,
+					 <&clks IMX27_CLK_PER2_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -215,7 +228,7 @@
 				compatible = "fsl,imx27-ssi", "fsl,imx21-ssi";
 				reg = <0x10010000 0x1000>;
 				interrupts = <14>;
-				clocks = <&clks 26>;
+				clocks = <&clks IMX27_CLK_SSI1_IPG_GATE>;
 				dmas = <&dma 12>, <&dma 13>, <&dma 14>, <&dma 15>;
 				dma-names = "rx0", "tx0", "rx1", "tx1";
 				fsl,fifo-depth = <8>;
@@ -227,7 +240,7 @@
 				compatible = "fsl,imx27-ssi", "fsl,imx21-ssi";
 				reg = <0x10011000 0x1000>;
 				interrupts = <13>;
-				clocks = <&clks 25>;
+				clocks = <&clks IMX27_CLK_SSI2_IPG_GATE>;
 				dmas = <&dma 8>, <&dma 9>, <&dma 10>, <&dma 11>;
 				dma-names = "rx0", "tx0", "rx1", "tx1";
 				fsl,fifo-depth = <8>;
@@ -240,7 +253,7 @@
 				compatible = "fsl,imx27-i2c", "fsl,imx21-i2c";
 				reg = <0x10012000 0x1000>;
 				interrupts = <12>;
-				clocks = <&clks 40>;
+				clocks = <&clks IMX27_CLK_I2C1_IPG_GATE>;
 				status = "disabled";
 			};
 
@@ -248,7 +261,8 @@
 				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
 				reg = <0x10013000 0x1000>;
 				interrupts = <11>;
-				clocks = <&clks 30>, <&clks 60>;
+				clocks = <&clks IMX27_CLK_SDHC1_IPG_GATE>,
+					 <&clks IMX27_CLK_PER2_GATE>;
 				clock-names = "ipg", "per";
 				dmas = <&dma 7>;
 				dma-names = "rx-tx";
@@ -259,7 +273,8 @@
 				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
 				reg = <0x10014000 0x1000>;
 				interrupts = <10>;
-				clocks = <&clks 29>, <&clks 60>;
+				clocks = <&clks IMX27_CLK_SDHC2_IPG_GATE>,
+					 <&clks IMX27_CLK_PER2_GATE>;
 				clock-names = "ipg", "per";
 				dmas = <&dma 6>;
 				dma-names = "rx-tx";
@@ -276,6 +291,7 @@
 				gpio1: gpio at 10015000 {
 					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
 					reg = <0x10015000 0x100>;
+					clocks = <&clks IMX27_CLK_GPIO_IPG_GATE>;
 					interrupts = <8>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -286,6 +302,7 @@
 				gpio2: gpio at 10015100 {
 					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
 					reg = <0x10015100 0x100>;
+					clocks = <&clks IMX27_CLK_GPIO_IPG_GATE>;
 					interrupts = <8>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -296,6 +313,7 @@
 				gpio3: gpio at 10015200 {
 					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
 					reg = <0x10015200 0x100>;
+					clocks = <&clks IMX27_CLK_GPIO_IPG_GATE>;
 					interrupts = <8>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -306,6 +324,7 @@
 				gpio4: gpio at 10015300 {
 					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
 					reg = <0x10015300 0x100>;
+					clocks = <&clks IMX27_CLK_GPIO_IPG_GATE>;
 					interrupts = <8>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -316,6 +335,7 @@
 				gpio5: gpio at 10015400 {
 					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
 					reg = <0x10015400 0x100>;
+					clocks = <&clks IMX27_CLK_GPIO_IPG_GATE>;
 					interrupts = <8>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -326,6 +346,7 @@
 				gpio6: gpio at 10015500 {
 					compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
 					reg = <0x10015500 0x100>;
+					clocks = <&clks IMX27_CLK_GPIO_IPG_GATE>;
 					interrupts = <8>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -337,7 +358,7 @@
 			audmux: audmux at 10016000 {
 				compatible = "fsl,imx27-audmux", "fsl,imx21-audmux";
 				reg = <0x10016000 0x1000>;
-				clocks = <&clks 0>;
+				clocks = <&clks IMX27_CLK_DUMMY>;
 				clock-names = "audmux";
 				status = "disabled";
 			};
@@ -348,7 +369,8 @@
 				compatible = "fsl,imx27-cspi";
 				reg = <0x10017000 0x1000>;
 				interrupts = <6>;
-				clocks = <&clks 51>, <&clks 60>;
+				clocks = <&clks IMX27_CLK_CSPI3_IPG_GATE>,
+					 <&clks IMX27_CLK_PER2_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -357,7 +379,8 @@
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x10019000 0x1000>;
 				interrupts = <4>;
-				clocks = <&clks 43>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_GPT4_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 			};
 
@@ -365,7 +388,8 @@
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x1001a000 0x1000>;
 				interrupts = <3>;
-				clocks = <&clks 42>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_GPT5_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 			};
 
@@ -373,7 +397,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1001b000 0x1000>;
 				interrupts = <49>;
-				clocks = <&clks 77>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_UART5_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -382,7 +407,8 @@
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1001c000 0x1000>;
 				interrupts = <48>;
-				clocks = <&clks 78>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_UART6_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -393,7 +419,7 @@
 				compatible = "fsl,imx27-i2c", "fsl,imx21-i2c";
 				reg = <0x1001d000 0x1000>;
 				interrupts = <1>;
-				clocks = <&clks 39>;
+				clocks = <&clks IMX27_CLK_I2C2_IPG_GATE>;
 				status = "disabled";
 			};
 
@@ -401,7 +427,8 @@
 				compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
 				reg = <0x1001e000 0x1000>;
 				interrupts = <9>;
-				clocks = <&clks 28>, <&clks 60>;
+				clocks = <&clks IMX27_CLK_SDHC3_IPG_GATE>,
+					 <&clks IMX27_CLK_PER2_GATE>;
 				clock-names = "ipg", "per";
 				dmas = <&dma 36>;
 				dma-names = "rx-tx";
@@ -412,7 +439,8 @@
 				compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
 				reg = <0x1001f000 0x1000>;
 				interrupts = <2>;
-				clocks = <&clks 41>, <&clks 61>;
+				clocks = <&clks IMX27_CLK_GPT6_IPG_GATE>,
+					 <&clks IMX27_CLK_PER1_GATE>;
 				clock-names = "ipg", "per";
 			};
 		};
@@ -428,7 +456,9 @@
 				compatible = "fsl,imx27-fb", "fsl,imx21-fb";
 				interrupts = <61>;
 				reg = <0x10021000 0x1000>;
-				clocks = <&clks 36>, <&clks 65>, <&clks 59>;
+				clocks = <&clks IMX27_CLK_LCDC_IPG_GATE>,
+					 <&clks IMX27_CLK_LCDC_AHB_GATE>,
+					 <&clks IMX27_CLK_PER3_GATE>;
 				clock-names = "ipg", "ahb", "per";
 				status = "disabled";
 			};
@@ -437,7 +467,8 @@
 				compatible = "fsl,imx27-vpu";
 				reg = <0x10023000 0x0200>;
 				interrupts = <53>;
-				clocks = <&clks 57>, <&clks 66>;
+				clocks = <&clks IMX27_CLK_VPU_BAUD_GATE>,
+					 <&clks IMX27_CLK_VPU_AHB_GATE>;
 				clock-names = "per", "ahb";
 				iram = <&iram>;
 			};
@@ -446,7 +477,7 @@
 				compatible = "fsl,imx27-usb";
 				reg = <0x10024000 0x200>;
 				interrupts = <56>;
-				clocks = <&clks 75>;
+				clocks = <&clks IMX27_CLK_USB_IPG_GATE>;
 				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
@@ -455,7 +486,7 @@
 				compatible = "fsl,imx27-usb";
 				reg = <0x10024200 0x200>;
 				interrupts = <54>;
-				clocks = <&clks 75>;
+				clocks = <&clks IMX27_CLK_USB_IPG_GATE>;
 				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
@@ -464,7 +495,7 @@
 				compatible = "fsl,imx27-usb";
 				reg = <0x10024400 0x200>;
 				interrupts = <55>;
-				clocks = <&clks 75>;
+				clocks = <&clks IMX27_CLK_USB_IPG_GATE>;
 				fsl,usbmisc = <&usbmisc 2>;
 				status = "disabled";
 			};
@@ -473,14 +504,15 @@
 				#index-cells = <1>;
 				compatible = "fsl,imx27-usbmisc";
 				reg = <0x10024600 0x200>;
-				clocks = <&clks 62>;
+				clocks = <&clks IMX27_CLK_USB_AHB_GATE>;
 			};
 
 			sahara2: sahara at 10025000 {
 				compatible = "fsl,imx27-sahara";
 				reg = <0x10025000 0x1000>;
 				interrupts = <59>;
-				clocks = <&clks 32>, <&clks 64>;
+				clocks = <&clks IMX27_CLK_SAHARA_IPG_GATE>,
+					 <&clks IMX27_CLK_SAHARA_AHB_GATE>;
 				clock-names = "ipg", "ahb";
 			};
 
@@ -494,14 +526,15 @@
 				compatible = "fsl,imx27-iim";
 				reg = <0x10028000 0x1000>;
 				interrupts = <62>;
-				clocks = <&clks 38>;
+				clocks = <&clks IMX27_CLK_IIM_IPG_GATE>;
 			};
 
 			fec: ethernet at 1002b000 {
 				compatible = "fsl,imx27-fec";
 				reg = <0x1002b000 0x4000>;
 				interrupts = <50>;
-				clocks = <&clks 48>, <&clks 67>;
+				clocks = <&clks IMX27_CLK_FEC_IPG_GATE>,
+					 <&clks IMX27_CLK_FEC_AHB_GATE>;
 				clock-names = "ipg", "ahb";
 				status = "disabled";
 			};
@@ -513,7 +546,7 @@
 			compatible = "fsl,imx27-nand";
 			reg = <0xd8000000 0x1000>;
 			interrupts = <29>;
-			clocks = <&clks 54>;
+			clocks = <&clks IMX27_CLK_NFC_BAUD_GATE>;
 			status = "disabled";
 		};
 
@@ -522,7 +555,7 @@
 			#size-cells = <1>;
 			compatible = "fsl,imx27-weim";
 			reg = <0xd8002000 0x1000>;
-			clocks = <&clks 0>;
+			clocks = <&clks IMX27_CLK_EMI_AHB_GATE>;
 			ranges = <
 				0 0 0xc0000000 0x08000000
 				1 0 0xc8000000 0x08000000
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index d76aa5f..ef7001c 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <dt-bindings/clock/imx27-clock.h>
 
 #include "clk.h"
 #include "common.h"
@@ -63,147 +64,123 @@ static const char *clko_sel_clks[] = {
 
 static const char *ssi_sel_clks[] = { "spll_gate", "mpll", };
 
-enum mx27_clks {
-	dummy, ckih, ckil, mpll, spll, mpll_main2, ahb, ipg, nfc_div, per1_div,
-	per2_div, per3_div, per4_div, vpu_sel, vpu_div, usb_div, cpu_sel,
-	clko_sel, cpu_div, clko_div, ssi1_sel, ssi2_sel, ssi1_div, ssi2_div,
-	clko_en, ssi2_ipg_gate, ssi1_ipg_gate, slcdc_ipg_gate, sdhc3_ipg_gate,
-	sdhc2_ipg_gate, sdhc1_ipg_gate, scc_ipg_gate, sahara_ipg_gate,
-	rtc_ipg_gate, pwm_ipg_gate, owire_ipg_gate, lcdc_ipg_gate,
-	kpp_ipg_gate, iim_ipg_gate, i2c2_ipg_gate, i2c1_ipg_gate,
-	gpt6_ipg_gate, gpt5_ipg_gate, gpt4_ipg_gate, gpt3_ipg_gate,
-	gpt2_ipg_gate, gpt1_ipg_gate, gpio_ipg_gate, fec_ipg_gate,
-	emma_ipg_gate, dma_ipg_gate, cspi3_ipg_gate, cspi2_ipg_gate,
-	cspi1_ipg_gate, nfc_baud_gate, ssi2_baud_gate, ssi1_baud_gate,
-	vpu_baud_gate, per4_gate, per3_gate, per2_gate, per1_gate,
-	usb_ahb_gate, slcdc_ahb_gate, sahara_ahb_gate, lcdc_ahb_gate,
-	vpu_ahb_gate, fec_ahb_gate, emma_ahb_gate, emi_ahb_gate, dma_ahb_gate,
-	csi_ahb_gate, brom_ahb_gate, ata_ahb_gate, wdog_ipg_gate, usb_ipg_gate,
-	uart6_ipg_gate, uart5_ipg_gate, uart4_ipg_gate, uart3_ipg_gate,
-	uart2_ipg_gate, uart1_ipg_gate, ckih_div1p5, fpm, mpll_osc_sel,
-	mpll_sel, spll_gate, mshc_div, rtic_ipg_gate, mshc_ipg_gate,
-	rtic_ahb_gate, mshc_baud_gate, clk_max
-};
-
-static struct clk *clk[clk_max];
+static struct clk *clk[IMX27_CLK_MAX];
 static struct clk_onecell_data clk_data;
 
 static void __init _mx27_clocks_init(unsigned long fref)
 {
 	BUG_ON(!ccm);
 
-	clk[dummy] = imx_clk_fixed("dummy", 0);
-	clk[ckih] = imx_clk_fixed("ckih", fref);
-	clk[ckil] = imx_clk_fixed("ckil", 32768);
-	clk[fpm] = imx_clk_fixed_factor("fpm", "ckil", 1024, 1);
-	clk[ckih_div1p5] = imx_clk_fixed_factor("ckih_div1p5", "ckih", 2, 3);
-
-	clk[mpll_osc_sel] = imx_clk_mux("mpll_osc_sel", CCM_CSCR, 4, 1,
-			mpll_osc_sel_clks,
-			ARRAY_SIZE(mpll_osc_sel_clks));
-	clk[mpll_sel] = imx_clk_mux("mpll_sel", CCM_CSCR, 16, 1, mpll_sel_clks,
-			ARRAY_SIZE(mpll_sel_clks));
-	clk[mpll] = imx_clk_pllv1("mpll", "mpll_sel", CCM_MPCTL0);
-	clk[spll] = imx_clk_pllv1("spll", "ckih", CCM_SPCTL0);
-	clk[spll_gate] = imx_clk_gate("spll_gate", "spll", CCM_CSCR, 1);
-	clk[mpll_main2] = imx_clk_fixed_factor("mpll_main2", "mpll", 2, 3);
+	clk[IMX27_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
+	clk[IMX27_CLK_CKIH] = imx_clk_fixed("ckih", fref);
+	clk[IMX27_CLK_CKIL] = imx_clk_fixed("ckil", 32768);
+	clk[IMX27_CLK_FPM] = imx_clk_fixed_factor("fpm", "ckil", 1024, 1);
+	clk[IMX27_CLK_CKIH_DIV1P5] = imx_clk_fixed_factor("ckih_div1p5", "ckih", 2, 3);
+	clk[IMX27_CLK_MPLL_OSC_SEL] = imx_clk_mux("mpll_osc_sel", CCM_CSCR, 4, 1, mpll_osc_sel_clks, ARRAY_SIZE(mpll_osc_sel_clks));
+	clk[IMX27_CLK_MPLL_SEL] = imx_clk_mux("mpll_sel", CCM_CSCR, 16, 1, mpll_sel_clks, ARRAY_SIZE(mpll_sel_clks));
+	clk[IMX27_CLK_MPLL] = imx_clk_pllv1("mpll", "mpll_sel", CCM_MPCTL0);
+	clk[IMX27_CLK_SPLL] = imx_clk_pllv1("spll", "ckih", CCM_SPCTL0);
+	clk[IMX27_CLK_SPLL_GATE] = imx_clk_gate("spll_gate", "spll", CCM_CSCR, 1);
+	clk[IMX27_CLK_MPLL_MAIN2] = imx_clk_fixed_factor("mpll_main2", "mpll", 2, 3);
 
 	if (mx27_revision() >= IMX_CHIP_REVISION_2_0) {
-		clk[ahb] = imx_clk_divider("ahb", "mpll_main2", CCM_CSCR, 8, 2);
-		clk[ipg] = imx_clk_fixed_factor("ipg", "ahb", 1, 2);
+		clk[IMX27_CLK_AHB] = imx_clk_divider("ahb", "mpll_main2", CCM_CSCR, 8, 2);
+		clk[IMX27_CLK_IPG] = imx_clk_fixed_factor("ipg", "ahb", 1, 2);
 	} else {
-		clk[ahb] = imx_clk_divider("ahb", "mpll_main2", CCM_CSCR, 9, 4);
-		clk[ipg] = imx_clk_divider("ipg", "ahb", CCM_CSCR, 8, 1);
+		clk[IMX27_CLK_AHB] = imx_clk_divider("ahb", "mpll_main2", CCM_CSCR, 9, 4);
+		clk[IMX27_CLK_IPG] = imx_clk_divider("ipg", "ahb", CCM_CSCR, 8, 1);
 	}
 
-	clk[mshc_div] = imx_clk_divider("mshc_div", "ahb", CCM_PCDR0, 0, 6);
-	clk[nfc_div] = imx_clk_divider("nfc_div", "ahb", CCM_PCDR0, 6, 4);
-	clk[per1_div] = imx_clk_divider("per1_div", "mpll_main2", CCM_PCDR1, 0, 6);
-	clk[per2_div] = imx_clk_divider("per2_div", "mpll_main2", CCM_PCDR1, 8, 6);
-	clk[per3_div] = imx_clk_divider("per3_div", "mpll_main2", CCM_PCDR1, 16, 6);
-	clk[per4_div] = imx_clk_divider("per4_div", "mpll_main2", CCM_PCDR1, 24, 6);
-	clk[vpu_sel] = imx_clk_mux("vpu_sel", CCM_CSCR, 21, 1, vpu_sel_clks, ARRAY_SIZE(vpu_sel_clks));
-	clk[vpu_div] = imx_clk_divider("vpu_div", "vpu_sel", CCM_PCDR0, 10, 6);
-	clk[usb_div] = imx_clk_divider("usb_div", "spll_gate", CCM_CSCR, 28, 3);
-	clk[cpu_sel] = imx_clk_mux("cpu_sel", CCM_CSCR, 15, 1, cpu_sel_clks, ARRAY_SIZE(cpu_sel_clks));
-	clk[clko_sel] = imx_clk_mux("clko_sel", CCM_CCSR, 0, 5, clko_sel_clks, ARRAY_SIZE(clko_sel_clks));
+	clk[IMX27_CLK_MSHC_DIV] = imx_clk_divider("mshc_div", "ahb", CCM_PCDR0, 0, 6);
+	clk[IMX27_CLK_NFC_DIV] = imx_clk_divider("nfc_div", "ahb", CCM_PCDR0, 6, 4);
+	clk[IMX27_CLK_PER1_DIV] = imx_clk_divider("per1_div", "mpll_main2", CCM_PCDR1, 0, 6);
+	clk[IMX27_CLK_PER2_DIV] = imx_clk_divider("per2_div", "mpll_main2", CCM_PCDR1, 8, 6);
+	clk[IMX27_CLK_PER3_DIV] = imx_clk_divider("per3_div", "mpll_main2", CCM_PCDR1, 16, 6);
+	clk[IMX27_CLK_PER4_DIV] = imx_clk_divider("per4_div", "mpll_main2", CCM_PCDR1, 24, 6);
+	clk[IMX27_CLK_VPU_SEL] = imx_clk_mux("vpu_sel", CCM_CSCR, 21, 1, vpu_sel_clks, ARRAY_SIZE(vpu_sel_clks));
+	clk[IMX27_CLK_VPU_DIV] = imx_clk_divider("vpu_div", "vpu_sel", CCM_PCDR0, 10, 6);
+	clk[IMX27_CLK_USB_DIV] = imx_clk_divider("usb_div", "spll_gate", CCM_CSCR, 28, 3);
+	clk[IMX27_CLK_CPU_SEL] = imx_clk_mux("cpu_sel", CCM_CSCR, 15, 1, cpu_sel_clks, ARRAY_SIZE(cpu_sel_clks));
+	clk[IMX27_CLK_CLKO_SEL] = imx_clk_mux("clko_sel", CCM_CCSR, 0, 5, clko_sel_clks, ARRAY_SIZE(clko_sel_clks));
+
 	if (mx27_revision() >= IMX_CHIP_REVISION_2_0)
-		clk[cpu_div] = imx_clk_divider("cpu_div", "cpu_sel", CCM_CSCR, 12, 2);
+		clk[IMX27_CLK_CPU_DIV] = imx_clk_divider("cpu_div", "cpu_sel", CCM_CSCR, 12, 2);
 	else
-		clk[cpu_div] = imx_clk_divider("cpu_div", "cpu_sel", CCM_CSCR, 13, 3);
-	clk[clko_div] = imx_clk_divider("clko_div", "clko_sel", CCM_PCDR0, 22, 3);
-	clk[ssi1_sel] = imx_clk_mux("ssi1_sel", CCM_CSCR, 22, 1, ssi_sel_clks, ARRAY_SIZE(ssi_sel_clks));
-	clk[ssi2_sel] = imx_clk_mux("ssi2_sel", CCM_CSCR, 23, 1, ssi_sel_clks, ARRAY_SIZE(ssi_sel_clks));
-	clk[ssi1_div] = imx_clk_divider("ssi1_div", "ssi1_sel", CCM_PCDR0, 16, 6);
-	clk[ssi2_div] = imx_clk_divider("ssi2_div", "ssi2_sel", CCM_PCDR0, 26, 6);
-	clk[clko_en] = imx_clk_gate("clko_en", "clko_div", CCM_PCCR0, 0);
-	clk[ssi2_ipg_gate] = imx_clk_gate("ssi2_ipg_gate", "ipg", CCM_PCCR0, 0);
-	clk[ssi1_ipg_gate] = imx_clk_gate("ssi1_ipg_gate", "ipg", CCM_PCCR0, 1);
-	clk[slcdc_ipg_gate] = imx_clk_gate("slcdc_ipg_gate", "ipg", CCM_PCCR0, 2);
-	clk[sdhc3_ipg_gate] = imx_clk_gate("sdhc3_ipg_gate", "ipg", CCM_PCCR0, 3);
-	clk[sdhc2_ipg_gate] = imx_clk_gate("sdhc2_ipg_gate", "ipg", CCM_PCCR0, 4);
-	clk[sdhc1_ipg_gate] = imx_clk_gate("sdhc1_ipg_gate", "ipg", CCM_PCCR0, 5);
-	clk[scc_ipg_gate] = imx_clk_gate("scc_ipg_gate", "ipg", CCM_PCCR0, 6);
-	clk[sahara_ipg_gate] = imx_clk_gate("sahara_ipg_gate", "ipg", CCM_PCCR0, 7);
-	clk[rtic_ipg_gate] = imx_clk_gate("rtic_ipg_gate", "ipg", CCM_PCCR0, 8);
-	clk[rtc_ipg_gate] = imx_clk_gate("rtc_ipg_gate", "ipg", CCM_PCCR0, 9);
-	clk[pwm_ipg_gate] = imx_clk_gate("pwm_ipg_gate", "ipg", CCM_PCCR0, 11);
-	clk[owire_ipg_gate] = imx_clk_gate("owire_ipg_gate", "ipg", CCM_PCCR0, 12);
-	clk[mshc_ipg_gate] = imx_clk_gate("mshc_ipg_gate", "ipg", CCM_PCCR0, 13);
-	clk[lcdc_ipg_gate] = imx_clk_gate("lcdc_ipg_gate", "ipg", CCM_PCCR0, 14);
-	clk[kpp_ipg_gate] = imx_clk_gate("kpp_ipg_gate", "ipg", CCM_PCCR0, 15);
-	clk[iim_ipg_gate] = imx_clk_gate("iim_ipg_gate", "ipg", CCM_PCCR0, 16);
-	clk[i2c2_ipg_gate] = imx_clk_gate("i2c2_ipg_gate", "ipg", CCM_PCCR0, 17);
-	clk[i2c1_ipg_gate] = imx_clk_gate("i2c1_ipg_gate", "ipg", CCM_PCCR0, 18);
-	clk[gpt6_ipg_gate] = imx_clk_gate("gpt6_ipg_gate", "ipg", CCM_PCCR0, 19);
-	clk[gpt5_ipg_gate] = imx_clk_gate("gpt5_ipg_gate", "ipg", CCM_PCCR0, 20);
-	clk[gpt4_ipg_gate] = imx_clk_gate("gpt4_ipg_gate", "ipg", CCM_PCCR0, 21);
-	clk[gpt3_ipg_gate] = imx_clk_gate("gpt3_ipg_gate", "ipg", CCM_PCCR0, 22);
-	clk[gpt2_ipg_gate] = imx_clk_gate("gpt2_ipg_gate", "ipg", CCM_PCCR0, 23);
-	clk[gpt1_ipg_gate] = imx_clk_gate("gpt1_ipg_gate", "ipg", CCM_PCCR0, 24);
-	clk[gpio_ipg_gate] = imx_clk_gate("gpio_ipg_gate", "ipg", CCM_PCCR0, 25);
-	clk[fec_ipg_gate] = imx_clk_gate("fec_ipg_gate", "ipg", CCM_PCCR0, 26);
-	clk[emma_ipg_gate] = imx_clk_gate("emma_ipg_gate", "ipg", CCM_PCCR0, 27);
-	clk[dma_ipg_gate] = imx_clk_gate("dma_ipg_gate", "ipg", CCM_PCCR0, 28);
-	clk[cspi3_ipg_gate] = imx_clk_gate("cspi3_ipg_gate", "ipg", CCM_PCCR0, 29);
-	clk[cspi2_ipg_gate] = imx_clk_gate("cspi2_ipg_gate", "ipg", CCM_PCCR0, 30);
-	clk[cspi1_ipg_gate] = imx_clk_gate("cspi1_ipg_gate", "ipg", CCM_PCCR0, 31);
-	clk[mshc_baud_gate] = imx_clk_gate("mshc_baud_gate", "mshc_div", CCM_PCCR1, 2);
-	clk[nfc_baud_gate] = imx_clk_gate("nfc_baud_gate", "nfc_div", CCM_PCCR1,  3);
-	clk[ssi2_baud_gate] = imx_clk_gate("ssi2_baud_gate", "ssi2_div", CCM_PCCR1,  4);
-	clk[ssi1_baud_gate] = imx_clk_gate("ssi1_baud_gate", "ssi1_div", CCM_PCCR1,  5);
-	clk[vpu_baud_gate] = imx_clk_gate("vpu_baud_gate", "vpu_div", CCM_PCCR1,  6);
-	clk[per4_gate] = imx_clk_gate("per4_gate", "per4_div", CCM_PCCR1,  7);
-	clk[per3_gate] = imx_clk_gate("per3_gate", "per3_div", CCM_PCCR1,  8);
-	clk[per2_gate] = imx_clk_gate("per2_gate", "per2_div", CCM_PCCR1,  9);
-	clk[per1_gate] = imx_clk_gate("per1_gate", "per1_div", CCM_PCCR1, 10);
-	clk[usb_ahb_gate] = imx_clk_gate("usb_ahb_gate", "ahb", CCM_PCCR1, 11);
-	clk[slcdc_ahb_gate] = imx_clk_gate("slcdc_ahb_gate", "ahb", CCM_PCCR1, 12);
-	clk[sahara_ahb_gate] = imx_clk_gate("sahara_ahb_gate", "ahb", CCM_PCCR1, 13);
-	clk[rtic_ahb_gate] = imx_clk_gate("rtic_ahb_gate", "ahb", CCM_PCCR1, 14);
-	clk[lcdc_ahb_gate] = imx_clk_gate("lcdc_ahb_gate", "ahb", CCM_PCCR1, 15);
-	clk[vpu_ahb_gate] = imx_clk_gate("vpu_ahb_gate", "ahb", CCM_PCCR1, 16);
-	clk[fec_ahb_gate] = imx_clk_gate("fec_ahb_gate", "ahb", CCM_PCCR1, 17);
-	clk[emma_ahb_gate] = imx_clk_gate("emma_ahb_gate", "ahb", CCM_PCCR1, 18);
-	clk[emi_ahb_gate] = imx_clk_gate("emi_ahb_gate", "ahb", CCM_PCCR1, 19);
-	clk[dma_ahb_gate] = imx_clk_gate("dma_ahb_gate", "ahb", CCM_PCCR1, 20);
-	clk[csi_ahb_gate] = imx_clk_gate("csi_ahb_gate", "ahb", CCM_PCCR1, 21);
-	clk[brom_ahb_gate] = imx_clk_gate("brom_ahb_gate", "ahb", CCM_PCCR1, 22);
-	clk[ata_ahb_gate] = imx_clk_gate("ata_ahb_gate", "ahb", CCM_PCCR1, 23);
-	clk[wdog_ipg_gate] = imx_clk_gate("wdog_ipg_gate", "ipg", CCM_PCCR1, 24);
-	clk[usb_ipg_gate] = imx_clk_gate("usb_ipg_gate", "ipg", CCM_PCCR1, 25);
-	clk[uart6_ipg_gate] = imx_clk_gate("uart6_ipg_gate", "ipg", CCM_PCCR1, 26);
-	clk[uart5_ipg_gate] = imx_clk_gate("uart5_ipg_gate", "ipg", CCM_PCCR1, 27);
-	clk[uart4_ipg_gate] = imx_clk_gate("uart4_ipg_gate", "ipg", CCM_PCCR1, 28);
-	clk[uart3_ipg_gate] = imx_clk_gate("uart3_ipg_gate", "ipg", CCM_PCCR1, 29);
-	clk[uart2_ipg_gate] = imx_clk_gate("uart2_ipg_gate", "ipg", CCM_PCCR1, 30);
-	clk[uart1_ipg_gate] = imx_clk_gate("uart1_ipg_gate", "ipg", CCM_PCCR1, 31);
+		clk[IMX27_CLK_CPU_DIV] = imx_clk_divider("cpu_div", "cpu_sel", CCM_CSCR, 13, 3);
+
+	clk[IMX27_CLK_CLKO_DIV] = imx_clk_divider("clko_div", "clko_sel", CCM_PCDR0, 22, 3);
+	clk[IMX27_CLK_SSI1_SEL] = imx_clk_mux("ssi1_sel", CCM_CSCR, 22, 1, ssi_sel_clks, ARRAY_SIZE(ssi_sel_clks));
+	clk[IMX27_CLK_SSI2_SEL] = imx_clk_mux("ssi2_sel", CCM_CSCR, 23, 1, ssi_sel_clks, ARRAY_SIZE(ssi_sel_clks));
+	clk[IMX27_CLK_SSI1_DIV] = imx_clk_divider("ssi1_div", "ssi1_sel", CCM_PCDR0, 16, 6);
+	clk[IMX27_CLK_SSI2_DIV] = imx_clk_divider("ssi2_div", "ssi2_sel", CCM_PCDR0, 26, 6);
+	clk[IMX27_CLK_CLKO_EN] = imx_clk_gate("clko_en", "clko_div", CCM_PCCR0, 0);
+	clk[IMX27_CLK_SSI2_IPG_GATE] = imx_clk_gate("ssi2_ipg_gate", "ipg", CCM_PCCR0, 0);
+	clk[IMX27_CLK_SSI1_IPG_GATE] = imx_clk_gate("ssi1_ipg_gate", "ipg", CCM_PCCR0, 1);
+	clk[IMX27_CLK_SLCDC_IPG_GATE] = imx_clk_gate("slcdc_ipg_gate", "ipg", CCM_PCCR0, 2);
+	clk[IMX27_CLK_SDHC3_IPG_GATE] = imx_clk_gate("sdhc3_ipg_gate", "ipg", CCM_PCCR0, 3);
+	clk[IMX27_CLK_SDHC2_IPG_GATE] = imx_clk_gate("sdhc2_ipg_gate", "ipg", CCM_PCCR0, 4);
+	clk[IMX27_CLK_SDHC1_IPG_GATE] = imx_clk_gate("sdhc1_ipg_gate", "ipg", CCM_PCCR0, 5);
+	clk[IMX27_CLK_SCC_IPG_GATE] = imx_clk_gate("scc_ipg_gate", "ipg", CCM_PCCR0, 6);
+	clk[IMX27_CLK_SAHARA_IPG_GATE] = imx_clk_gate("sahara_ipg_gate", "ipg", CCM_PCCR0, 7);
+	clk[IMX27_CLK_RTIC_IPG_GATE] = imx_clk_gate("rtic_ipg_gate", "ipg", CCM_PCCR0, 8);
+	clk[IMX27_CLK_RTC_IPG_GATE] = imx_clk_gate("rtc_ipg_gate", "ipg", CCM_PCCR0, 9);
+	clk[IMX27_CLK_PWM_IPG_GATE] = imx_clk_gate("pwm_ipg_gate", "ipg", CCM_PCCR0, 11);
+	clk[IMX27_CLK_OWIRE_IPG_GATE] = imx_clk_gate("owire_ipg_gate", "ipg", CCM_PCCR0, 12);
+	clk[IMX27_CLK_MSHC_IPG_GATE] = imx_clk_gate("mshc_ipg_gate", "ipg", CCM_PCCR0, 13);
+	clk[IMX27_CLK_LCDC_IPG_GATE] = imx_clk_gate("lcdc_ipg_gate", "ipg", CCM_PCCR0, 14);
+	clk[IMX27_CLK_KPP_IPG_GATE] = imx_clk_gate("kpp_ipg_gate", "ipg", CCM_PCCR0, 15);
+	clk[IMX27_CLK_IIM_IPG_GATE] = imx_clk_gate("iim_ipg_gate", "ipg", CCM_PCCR0, 16);
+	clk[IMX27_CLK_I2C2_IPG_GATE] = imx_clk_gate("i2c2_ipg_gate", "ipg", CCM_PCCR0, 17);
+	clk[IMX27_CLK_I2C1_IPG_GATE] = imx_clk_gate("i2c1_ipg_gate", "ipg", CCM_PCCR0, 18);
+	clk[IMX27_CLK_GPT6_IPG_GATE] = imx_clk_gate("gpt6_ipg_gate", "ipg", CCM_PCCR0, 19);
+	clk[IMX27_CLK_GPT5_IPG_GATE] = imx_clk_gate("gpt5_ipg_gate", "ipg", CCM_PCCR0, 20);
+	clk[IMX27_CLK_GPT4_IPG_GATE] = imx_clk_gate("gpt4_ipg_gate", "ipg", CCM_PCCR0, 21);
+	clk[IMX27_CLK_GPT3_IPG_GATE] = imx_clk_gate("gpt3_ipg_gate", "ipg", CCM_PCCR0, 22);
+	clk[IMX27_CLK_GPT2_IPG_GATE] = imx_clk_gate("gpt2_ipg_gate", "ipg", CCM_PCCR0, 23);
+	clk[IMX27_CLK_GPT1_IPG_GATE] = imx_clk_gate("gpt1_ipg_gate", "ipg", CCM_PCCR0, 24);
+	clk[IMX27_CLK_GPIO_IPG_GATE] = imx_clk_gate("gpio_ipg_gate", "ipg", CCM_PCCR0, 25);
+	clk[IMX27_CLK_FEC_IPG_GATE] = imx_clk_gate("fec_ipg_gate", "ipg", CCM_PCCR0, 26);
+	clk[IMX27_CLK_EMMA_IPG_GATE] = imx_clk_gate("emma_ipg_gate", "ipg", CCM_PCCR0, 27);
+	clk[IMX27_CLK_DMA_IPG_GATE] = imx_clk_gate("dma_ipg_gate", "ipg", CCM_PCCR0, 28);
+	clk[IMX27_CLK_CSPI3_IPG_GATE] = imx_clk_gate("cspi3_ipg_gate", "ipg", CCM_PCCR0, 29);
+	clk[IMX27_CLK_CSPI2_IPG_GATE] = imx_clk_gate("cspi2_ipg_gate", "ipg", CCM_PCCR0, 30);
+	clk[IMX27_CLK_CSPI1_IPG_GATE] = imx_clk_gate("cspi1_ipg_gate", "ipg", CCM_PCCR0, 31);
+	clk[IMX27_CLK_MSHC_BAUD_GATE] = imx_clk_gate("mshc_baud_gate", "mshc_div", CCM_PCCR1, 2);
+	clk[IMX27_CLK_NFC_BAUD_GATE] = imx_clk_gate("nfc_baud_gate", "nfc_div", CCM_PCCR1,  3);
+	clk[IMX27_CLK_SSI2_BAUD_GATE] = imx_clk_gate("ssi2_baud_gate", "ssi2_div", CCM_PCCR1,  4);
+	clk[IMX27_CLK_SSI1_BAUD_GATE] = imx_clk_gate("ssi1_baud_gate", "ssi1_div", CCM_PCCR1,  5);
+	clk[IMX27_CLK_VPU_BAUD_GATE] = imx_clk_gate("vpu_baud_gate", "vpu_div", CCM_PCCR1,  6);
+	clk[IMX27_CLK_PER4_GATE] = imx_clk_gate("per4_gate", "per4_div", CCM_PCCR1,  7);
+	clk[IMX27_CLK_PER3_GATE] = imx_clk_gate("per3_gate", "per3_div", CCM_PCCR1,  8);
+	clk[IMX27_CLK_PER2_GATE] = imx_clk_gate("per2_gate", "per2_div", CCM_PCCR1,  9);
+	clk[IMX27_CLK_PER1_GATE] = imx_clk_gate("per1_gate", "per1_div", CCM_PCCR1, 10);
+	clk[IMX27_CLK_USB_AHB_GATE] = imx_clk_gate("usb_ahb_gate", "ahb", CCM_PCCR1, 11);
+	clk[IMX27_CLK_SLCDC_AHB_GATE] = imx_clk_gate("slcdc_ahb_gate", "ahb", CCM_PCCR1, 12);
+	clk[IMX27_CLK_SAHARA_AHB_GATE] = imx_clk_gate("sahara_ahb_gate", "ahb", CCM_PCCR1, 13);
+	clk[IMX27_CLK_RTIC_AHB_GATE] = imx_clk_gate("rtic_ahb_gate", "ahb", CCM_PCCR1, 14);
+	clk[IMX27_CLK_LCDC_AHB_GATE] = imx_clk_gate("lcdc_ahb_gate", "ahb", CCM_PCCR1, 15);
+	clk[IMX27_CLK_VPU_AHB_GATE] = imx_clk_gate("vpu_ahb_gate", "ahb", CCM_PCCR1, 16);
+	clk[IMX27_CLK_FEC_AHB_GATE] = imx_clk_gate("fec_ahb_gate", "ahb", CCM_PCCR1, 17);
+	clk[IMX27_CLK_EMMA_AHB_GATE] = imx_clk_gate("emma_ahb_gate", "ahb", CCM_PCCR1, 18);
+	clk[IMX27_CLK_EMI_AHB_GATE] = imx_clk_gate("emi_ahb_gate", "ahb", CCM_PCCR1, 19);
+	clk[IMX27_CLK_DMA_AHB_GATE] = imx_clk_gate("dma_ahb_gate", "ahb", CCM_PCCR1, 20);
+	clk[IMX27_CLK_CSI_AHB_GATE] = imx_clk_gate("csi_ahb_gate", "ahb", CCM_PCCR1, 21);
+	clk[IMX27_CLK_BROM_AHB_GATE] = imx_clk_gate("brom_ahb_gate", "ahb", CCM_PCCR1, 22);
+	clk[IMX27_CLK_ATA_AHB_GATE] = imx_clk_gate("ata_ahb_gate", "ahb", CCM_PCCR1, 23);
+	clk[IMX27_CLK_WDOG_IPG_GATE] = imx_clk_gate("wdog_ipg_gate", "ipg", CCM_PCCR1, 24);
+	clk[IMX27_CLK_USB_IPG_GATE] = imx_clk_gate("usb_ipg_gate", "ipg", CCM_PCCR1, 25);
+	clk[IMX27_CLK_UART6_IPG_GATE] = imx_clk_gate("uart6_ipg_gate", "ipg", CCM_PCCR1, 26);
+	clk[IMX27_CLK_UART5_IPG_GATE] = imx_clk_gate("uart5_ipg_gate", "ipg", CCM_PCCR1, 27);
+	clk[IMX27_CLK_UART4_IPG_GATE] = imx_clk_gate("uart4_ipg_gate", "ipg", CCM_PCCR1, 28);
+	clk[IMX27_CLK_UART3_IPG_GATE] = imx_clk_gate("uart3_ipg_gate", "ipg", CCM_PCCR1, 29);
+	clk[IMX27_CLK_UART2_IPG_GATE] = imx_clk_gate("uart2_ipg_gate", "ipg", CCM_PCCR1, 30);
+	clk[IMX27_CLK_UART1_IPG_GATE] = imx_clk_gate("uart1_ipg_gate", "ipg", CCM_PCCR1, 31);
 
 	imx_check_clocks(clk, ARRAY_SIZE(clk));
 
-	clk_register_clkdev(clk[cpu_div], NULL, "cpu0");
+	clk_register_clkdev(clk[IMX27_CLK_CPU_DIV], NULL, "cpu0");
 
-	clk_prepare_enable(clk[emi_ahb_gate]);
+	clk_prepare_enable(clk[IMX27_CLK_EMI_AHB_GATE]);
 
 	imx_print_silicon_rev("i.MX27", mx27_revision());
 }
@@ -214,67 +191,67 @@ int __init mx27_clocks_init(unsigned long fref)
 
 	_mx27_clocks_init(fref);
 
-	clk_register_clkdev(clk[uart1_ipg_gate], "ipg", "imx21-uart.0");
-	clk_register_clkdev(clk[per1_gate], "per", "imx21-uart.0");
-	clk_register_clkdev(clk[uart2_ipg_gate], "ipg", "imx21-uart.1");
-	clk_register_clkdev(clk[per1_gate], "per", "imx21-uart.1");
-	clk_register_clkdev(clk[uart3_ipg_gate], "ipg", "imx21-uart.2");
-	clk_register_clkdev(clk[per1_gate], "per", "imx21-uart.2");
-	clk_register_clkdev(clk[uart4_ipg_gate], "ipg", "imx21-uart.3");
-	clk_register_clkdev(clk[per1_gate], "per", "imx21-uart.3");
-	clk_register_clkdev(clk[uart5_ipg_gate], "ipg", "imx21-uart.4");
-	clk_register_clkdev(clk[per1_gate], "per", "imx21-uart.4");
-	clk_register_clkdev(clk[uart6_ipg_gate], "ipg", "imx21-uart.5");
-	clk_register_clkdev(clk[per1_gate], "per", "imx21-uart.5");
-	clk_register_clkdev(clk[gpt1_ipg_gate], "ipg", "imx-gpt.0");
-	clk_register_clkdev(clk[per1_gate], "per", "imx-gpt.0");
-	clk_register_clkdev(clk[per2_gate], "per", "imx21-mmc.0");
-	clk_register_clkdev(clk[sdhc1_ipg_gate], "ipg", "imx21-mmc.0");
-	clk_register_clkdev(clk[per2_gate], "per", "imx21-mmc.1");
-	clk_register_clkdev(clk[sdhc2_ipg_gate], "ipg", "imx21-mmc.1");
-	clk_register_clkdev(clk[per2_gate], "per", "imx21-mmc.2");
-	clk_register_clkdev(clk[sdhc2_ipg_gate], "ipg", "imx21-mmc.2");
-	clk_register_clkdev(clk[per2_gate], "per", "imx27-cspi.0");
-	clk_register_clkdev(clk[cspi1_ipg_gate], "ipg", "imx27-cspi.0");
-	clk_register_clkdev(clk[per2_gate], "per", "imx27-cspi.1");
-	clk_register_clkdev(clk[cspi2_ipg_gate], "ipg", "imx27-cspi.1");
-	clk_register_clkdev(clk[per2_gate], "per", "imx27-cspi.2");
-	clk_register_clkdev(clk[cspi3_ipg_gate], "ipg", "imx27-cspi.2");
-	clk_register_clkdev(clk[per3_gate], "per", "imx21-fb.0");
-	clk_register_clkdev(clk[lcdc_ipg_gate], "ipg", "imx21-fb.0");
-	clk_register_clkdev(clk[lcdc_ahb_gate], "ahb", "imx21-fb.0");
-	clk_register_clkdev(clk[csi_ahb_gate], "ahb", "imx27-camera.0");
-	clk_register_clkdev(clk[per4_gate], "per", "imx27-camera.0");
-	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx27");
-	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "imx-udc-mx27");
-	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "imx-udc-mx27");
-	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.0");
-	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "mxc-ehci.0");
-	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.0");
-	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.1");
-	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "mxc-ehci.1");
-	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.1");
-	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
-	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "mxc-ehci.2");
-	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
-	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
-	clk_register_clkdev(clk[nfc_baud_gate], NULL, "imx27-nand.0");
-	clk_register_clkdev(clk[vpu_baud_gate], "per", "coda-imx27.0");
-	clk_register_clkdev(clk[vpu_ahb_gate], "ahb", "coda-imx27.0");
-	clk_register_clkdev(clk[dma_ahb_gate], "ahb", "imx27-dma");
-	clk_register_clkdev(clk[dma_ipg_gate], "ipg", "imx27-dma");
-	clk_register_clkdev(clk[fec_ipg_gate], "ipg", "imx27-fec.0");
-	clk_register_clkdev(clk[fec_ahb_gate], "ahb", "imx27-fec.0");
-	clk_register_clkdev(clk[wdog_ipg_gate], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[i2c1_ipg_gate], NULL, "imx21-i2c.0");
-	clk_register_clkdev(clk[i2c2_ipg_gate], NULL, "imx21-i2c.1");
-	clk_register_clkdev(clk[owire_ipg_gate], NULL, "mxc_w1.0");
-	clk_register_clkdev(clk[kpp_ipg_gate], NULL, "imx-keypad");
-	clk_register_clkdev(clk[emma_ahb_gate], "emma-ahb", "imx27-camera.0");
-	clk_register_clkdev(clk[emma_ipg_gate], "emma-ipg", "imx27-camera.0");
-	clk_register_clkdev(clk[emma_ahb_gate], "ahb", "m2m-emmaprp.0");
-	clk_register_clkdev(clk[emma_ipg_gate], "ipg", "m2m-emmaprp.0");
+	clk_register_clkdev(clk[IMX27_CLK_UART1_IPG_GATE], "ipg", "imx21-uart.0");
+	clk_register_clkdev(clk[IMX27_CLK_PER1_GATE], "per", "imx21-uart.0");
+	clk_register_clkdev(clk[IMX27_CLK_UART2_IPG_GATE], "ipg", "imx21-uart.1");
+	clk_register_clkdev(clk[IMX27_CLK_PER1_GATE], "per", "imx21-uart.1");
+	clk_register_clkdev(clk[IMX27_CLK_UART3_IPG_GATE], "ipg", "imx21-uart.2");
+	clk_register_clkdev(clk[IMX27_CLK_PER1_GATE], "per", "imx21-uart.2");
+	clk_register_clkdev(clk[IMX27_CLK_UART4_IPG_GATE], "ipg", "imx21-uart.3");
+	clk_register_clkdev(clk[IMX27_CLK_PER1_GATE], "per", "imx21-uart.3");
+	clk_register_clkdev(clk[IMX27_CLK_UART5_IPG_GATE], "ipg", "imx21-uart.4");
+	clk_register_clkdev(clk[IMX27_CLK_PER1_GATE], "per", "imx21-uart.4");
+	clk_register_clkdev(clk[IMX27_CLK_UART6_IPG_GATE], "ipg", "imx21-uart.5");
+	clk_register_clkdev(clk[IMX27_CLK_PER1_GATE], "per", "imx21-uart.5");
+	clk_register_clkdev(clk[IMX27_CLK_GPT1_IPG_GATE], "ipg", "imx-gpt.0");
+	clk_register_clkdev(clk[IMX27_CLK_PER1_GATE], "per", "imx-gpt.0");
+	clk_register_clkdev(clk[IMX27_CLK_PER2_GATE], "per", "imx21-mmc.0");
+	clk_register_clkdev(clk[IMX27_CLK_SDHC1_IPG_GATE], "ipg", "imx21-mmc.0");
+	clk_register_clkdev(clk[IMX27_CLK_PER2_GATE], "per", "imx21-mmc.1");
+	clk_register_clkdev(clk[IMX27_CLK_SDHC2_IPG_GATE], "ipg", "imx21-mmc.1");
+	clk_register_clkdev(clk[IMX27_CLK_PER2_GATE], "per", "imx21-mmc.2");
+	clk_register_clkdev(clk[IMX27_CLK_SDHC2_IPG_GATE], "ipg", "imx21-mmc.2");
+	clk_register_clkdev(clk[IMX27_CLK_PER2_GATE], "per", "imx27-cspi.0");
+	clk_register_clkdev(clk[IMX27_CLK_CSPI1_IPG_GATE], "ipg", "imx27-cspi.0");
+	clk_register_clkdev(clk[IMX27_CLK_PER2_GATE], "per", "imx27-cspi.1");
+	clk_register_clkdev(clk[IMX27_CLK_CSPI2_IPG_GATE], "ipg", "imx27-cspi.1");
+	clk_register_clkdev(clk[IMX27_CLK_PER2_GATE], "per", "imx27-cspi.2");
+	clk_register_clkdev(clk[IMX27_CLK_CSPI3_IPG_GATE], "ipg", "imx27-cspi.2");
+	clk_register_clkdev(clk[IMX27_CLK_PER3_GATE], "per", "imx21-fb.0");
+	clk_register_clkdev(clk[IMX27_CLK_LCDC_IPG_GATE], "ipg", "imx21-fb.0");
+	clk_register_clkdev(clk[IMX27_CLK_LCDC_AHB_GATE], "ahb", "imx21-fb.0");
+	clk_register_clkdev(clk[IMX27_CLK_CSI_AHB_GATE], "ahb", "imx27-camera.0");
+	clk_register_clkdev(clk[IMX27_CLK_PER4_GATE], "per", "imx27-camera.0");
+	clk_register_clkdev(clk[IMX27_CLK_USB_DIV], "per", "imx-udc-mx27");
+	clk_register_clkdev(clk[IMX27_CLK_USB_IPG_GATE], "ipg", "imx-udc-mx27");
+	clk_register_clkdev(clk[IMX27_CLK_USB_AHB_GATE], "ahb", "imx-udc-mx27");
+	clk_register_clkdev(clk[IMX27_CLK_USB_DIV], "per", "mxc-ehci.0");
+	clk_register_clkdev(clk[IMX27_CLK_USB_IPG_GATE], "ipg", "mxc-ehci.0");
+	clk_register_clkdev(clk[IMX27_CLK_USB_AHB_GATE], "ahb", "mxc-ehci.0");
+	clk_register_clkdev(clk[IMX27_CLK_USB_DIV], "per", "mxc-ehci.1");
+	clk_register_clkdev(clk[IMX27_CLK_USB_IPG_GATE], "ipg", "mxc-ehci.1");
+	clk_register_clkdev(clk[IMX27_CLK_USB_AHB_GATE], "ahb", "mxc-ehci.1");
+	clk_register_clkdev(clk[IMX27_CLK_USB_DIV], "per", "mxc-ehci.2");
+	clk_register_clkdev(clk[IMX27_CLK_USB_IPG_GATE], "ipg", "mxc-ehci.2");
+	clk_register_clkdev(clk[IMX27_CLK_USB_AHB_GATE], "ahb", "mxc-ehci.2");
+	clk_register_clkdev(clk[IMX27_CLK_SSI1_IPG_GATE], NULL, "imx-ssi.0");
+	clk_register_clkdev(clk[IMX27_CLK_SSI2_IPG_GATE], NULL, "imx-ssi.1");
+	clk_register_clkdev(clk[IMX27_CLK_NFC_BAUD_GATE], NULL, "imx27-nand.0");
+	clk_register_clkdev(clk[IMX27_CLK_VPU_BAUD_GATE], "per", "coda-imx27.0");
+	clk_register_clkdev(clk[IMX27_CLK_VPU_AHB_GATE], "ahb", "coda-imx27.0");
+	clk_register_clkdev(clk[IMX27_CLK_DMA_AHB_GATE], "ahb", "imx27-dma");
+	clk_register_clkdev(clk[IMX27_CLK_DMA_IPG_GATE], "ipg", "imx27-dma");
+	clk_register_clkdev(clk[IMX27_CLK_FEC_IPG_GATE], "ipg", "imx27-fec.0");
+	clk_register_clkdev(clk[IMX27_CLK_FEC_AHB_GATE], "ahb", "imx27-fec.0");
+	clk_register_clkdev(clk[IMX27_CLK_WDOG_IPG_GATE], NULL, "imx2-wdt.0");
+	clk_register_clkdev(clk[IMX27_CLK_I2C1_IPG_GATE], NULL, "imx21-i2c.0");
+	clk_register_clkdev(clk[IMX27_CLK_I2C2_IPG_GATE], NULL, "imx21-i2c.1");
+	clk_register_clkdev(clk[IMX27_CLK_OWIRE_IPG_GATE], NULL, "mxc_w1.0");
+	clk_register_clkdev(clk[IMX27_CLK_KPP_IPG_GATE], NULL, "imx-keypad");
+	clk_register_clkdev(clk[IMX27_CLK_EMMA_AHB_GATE], "emma-ahb", "imx27-camera.0");
+	clk_register_clkdev(clk[IMX27_CLK_EMMA_IPG_GATE], "emma-ipg", "imx27-camera.0");
+	clk_register_clkdev(clk[IMX27_CLK_EMMA_AHB_GATE], "ahb", "m2m-emmaprp.0");
+	clk_register_clkdev(clk[IMX27_CLK_EMMA_IPG_GATE], "ipg", "m2m-emmaprp.0");
 
 	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
 
diff --git a/include/dt-bindings/clock/imx27-clock.h b/include/dt-bindings/clock/imx27-clock.h
new file mode 100644
index 0000000..6b642d4
--- /dev/null
+++ b/include/dt-bindings/clock/imx27-clock.h
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX27_H
+#define __DT_BINDINGS_CLOCK_IMX27_H
+
+#define IMX27_CLK_DUMMY			0
+#define IMX27_CLK_CKIH			1
+#define IMX27_CLK_CKIL			2
+#define IMX27_CLK_MPLL			3
+#define IMX27_CLK_SPLL			4
+#define IMX27_CLK_MPLL_MAIN2		5
+#define IMX27_CLK_AHB			6
+#define IMX27_CLK_IPG			7
+#define IMX27_CLK_NFC_DIV		8
+#define IMX27_CLK_PER1_DIV		9
+#define IMX27_CLK_PER2_DIV		10
+#define IMX27_CLK_PER3_DIV		11
+#define IMX27_CLK_PER4_DIV		12
+#define IMX27_CLK_VPU_SEL		13
+#define IMX27_CLK_VPU_DIV		14
+#define IMX27_CLK_USB_DIV		15
+#define IMX27_CLK_CPU_SEL		16
+#define IMX27_CLK_CLKO_SEL		17
+#define IMX27_CLK_CPU_DIV		18
+#define IMX27_CLK_CLKO_DIV		19
+#define IMX27_CLK_SSI1_SEL		20
+#define IMX27_CLK_SSI2_SEL		21
+#define IMX27_CLK_SSI1_DIV		22
+#define IMX27_CLK_SSI2_DIV		23
+#define IMX27_CLK_CLKO_EN		24
+#define IMX27_CLK_SSI2_IPG_GATE		25
+#define IMX27_CLK_SSI1_IPG_GATE		26
+#define IMX27_CLK_SLCDC_IPG_GATE	27
+#define IMX27_CLK_SDHC3_IPG_GATE	28
+#define IMX27_CLK_SDHC2_IPG_GATE	29
+#define IMX27_CLK_SDHC1_IPG_GATE	30
+#define IMX27_CLK_SCC_IPG_GATE		31
+#define IMX27_CLK_SAHARA_IPG_GATE	32
+#define IMX27_CLK_RTC_IPG_GATE		33
+#define IMX27_CLK_PWM_IPG_GATE		34
+#define IMX27_CLK_OWIRE_IPG_GATE	35
+#define IMX27_CLK_LCDC_IPG_GATE		36
+#define IMX27_CLK_KPP_IPG_GATE		37
+#define IMX27_CLK_IIM_IPG_GATE		38
+#define IMX27_CLK_I2C2_IPG_GATE		39
+#define IMX27_CLK_I2C1_IPG_GATE		40
+#define IMX27_CLK_GPT6_IPG_GATE		41
+#define IMX27_CLK_GPT5_IPG_GATE		42
+#define IMX27_CLK_GPT4_IPG_GATE		43
+#define IMX27_CLK_GPT3_IPG_GATE		44
+#define IMX27_CLK_GPT2_IPG_GATE		45
+#define IMX27_CLK_GPT1_IPG_GATE		46
+#define IMX27_CLK_GPIO_IPG_GATE		47
+#define IMX27_CLK_FEC_IPG_GATE		48
+#define IMX27_CLK_EMMA_IPG_GATE		49
+#define IMX27_CLK_DMA_IPG_GATE		50
+#define IMX27_CLK_CSPI3_IPG_GATE	51
+#define IMX27_CLK_CSPI2_IPG_GATE	52
+#define IMX27_CLK_CSPI1_IPG_GATE	53
+#define IMX27_CLK_NFC_BAUD_GATE		54
+#define IMX27_CLK_SSI2_BAUD_GATE	55
+#define IMX27_CLK_SSI1_BAUD_GATE	56
+#define IMX27_CLK_VPU_BAUD_GATE		57
+#define IMX27_CLK_PER4_GATE		58
+#define IMX27_CLK_PER3_GATE		59
+#define IMX27_CLK_PER2_GATE		60
+#define IMX27_CLK_PER1_GATE		61
+#define IMX27_CLK_USB_AHB_GATE		62
+#define IMX27_CLK_SLCDC_AHB_GATE	63
+#define IMX27_CLK_SAHARA_AHB_GATE	64
+#define IMX27_CLK_LCDC_AHB_GATE		65
+#define IMX27_CLK_VPU_AHB_GATE		66
+#define IMX27_CLK_FEC_AHB_GATE		67
+#define IMX27_CLK_EMMA_AHB_GATE		68
+#define IMX27_CLK_EMI_AHB_GATE		69
+#define IMX27_CLK_DMA_AHB_GATE		70
+#define IMX27_CLK_CSI_AHB_GATE		71
+#define IMX27_CLK_BROM_AHB_GATE		72
+#define IMX27_CLK_ATA_AHB_GATE		73
+#define IMX27_CLK_WDOG_IPG_GATE		74
+#define IMX27_CLK_USB_IPG_GATE		75
+#define IMX27_CLK_UART6_IPG_GATE	76
+#define IMX27_CLK_UART5_IPG_GATE	77
+#define IMX27_CLK_UART4_IPG_GATE	78
+#define IMX27_CLK_UART3_IPG_GATE	79
+#define IMX27_CLK_UART2_IPG_GATE	80
+#define IMX27_CLK_UART1_IPG_GATE	81
+#define IMX27_CLK_CKIH_DIV1P5		82
+#define IMX27_CLK_FPM			83
+#define IMX27_CLK_MPLL_OSC_SEL		84
+#define IMX27_CLK_MPLL_SEL		85
+#define IMX27_CLK_SPLL_GATE		86
+#define IMX27_CLK_MSHC_DIV		87
+#define IMX27_CLK_RTIC_IPG_GATE		88
+#define IMX27_CLK_MSHC_IPG_GATE		89
+#define IMX27_CLK_RTIC_AHB_GATE		90
+#define IMX27_CLK_MSHC_BAUD_GATE	91
+#define IMX27_CLK_MAX			92
+
+#endif
-- 
1.8.5.5
