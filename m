From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Sep 2012 09:02:06 +0200
Subject: [PATCH 2/2] ARM i.MX25: Add devicetree
In-Reply-To: <1348556526-9174-1-git-send-email-s.hauer@pengutronix.de>
References: <1348556526-9174-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1348556526-9174-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a i.MX25 dtsi file along with the i.MX25 clock tree
documentation. The devicetree should be fairly complete for:

- uart
- fec
- i2c
- spi
- pwm
- nand
- gpio
- wdog
- esdhc
- flexcan

The more exotic devices currently miss clock bindings.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/clock/imx25-clock.txt      |  121 +++++
 arch/arm/boot/dts/imx25.dtsi                       |  477 ++++++++++++++++++++
 2 files changed, 598 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.txt
 create mode 100644 arch/arm/boot/dts/imx25.dtsi

diff --git a/Documentation/devicetree/bindings/clock/imx25-clock.txt b/Documentation/devicetree/bindings/clock/imx25-clock.txt
new file mode 100644
index 0000000..22c1725
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx25-clock.txt
@@ -0,0 +1,121 @@
+* Clock bindings for Freescale i.MX25
+
+Required properties:
+- compatible: Should be "fsl,imx25-ccm"
+- reg: Address and length of the register set
+- interrupts: Should contain CCM interrupt
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  The following is a full list of i.MX25
+clocks and IDs.
+
+	Clock			ID
+	---------------------------
+	dummy			0
+	osc			1
+	mpll			2
+	upll			3
+	mpll_cpu_3_4		4
+	cpu_sel			5
+	cpu			6
+	ahb			7
+	usb_div			8
+	ipg			9
+	per0_sel		10
+	per1_sel		11
+	per2_sel		12
+	per3_sel		13
+	per4_sel		14
+	per5_sel		15
+	per6_sel		16
+	per7_sel		17
+	per8_sel		18
+	per9_sel		19
+	per10_sel		20
+	per11_sel		21
+	per12_sel		22
+	per13_sel		23
+	per14_sel		24
+	per15_sel		25
+	per0			26
+	per1			27
+	per2			28
+	per3			29
+	per4			30
+	per5			31
+	per6			32
+	per7			33
+	per8			34
+	per9			35
+	per10			36
+	per11			37
+	per12			38
+	per13			39
+	per14			40
+	per15			41
+	csi_ipg_per		42
+	esdhc1_ipg_per		43
+	esdhc2_ipg_per		44
+	gpt_ipg_per		45
+	i2c_ipg_per		46
+	lcdc_ipg_per		47
+	nfc_ipg_per		48
+	ssi1_ipg_per		49
+	ssi2_ipg_per		50
+	uart_ipg_per		51
+	csi_ahb			52
+	esdhc1_ahb		53
+	esdhc2_ahb		54
+	fec_ahb			55
+	lcdc_ahb		56
+	sdma_ahb		57
+	usbotg_ahb		58
+	can1_ipg		59
+	can2_ipg		60
+	csi_ipg			61
+	cspi1_ipg		62
+	cspi2_ipg		63
+	cspi3_ipg		64
+	dryice_ipg		65
+	esdhc1_ipg		66
+	esdhc2_ipg		67
+	fec_ipg			68
+	iim_ipg			69
+	kpp_ipg			70
+	lcdc_ipg		71
+	pwm1_ipg		72
+	pwm2_ipg		73
+	pwm3_ipg		74
+	pwm4_ipg		75
+	sdma_ipg		76
+	ssi1_ipg		77
+	ssi2_ipg		78
+	tsc_ipg			79
+	uart1_ipg		80
+	uart2_ipg		81
+	uart3_ipg		82
+	uart4_ipg		83
+	uart5_ipg		84
+	wdt_ipg			85
+
+Examples:
+
+clks: ccm at 53f80000 {
+	compatible = "fsl,imx25-ccm";
+	reg = <0x53f80000 0x4000>;
+	interrupts = <31>;
+	clock-output-names = ...
+			"uart_ipg",
+			"uart_serial",
+			...;
+};
+
+uart1: serial at 43f90000 {
+	compatible = "fsl,imx25-uart", "fsl,imx21-uart";
+	reg = <0x43f90000 0x4000>;
+	interrupts = <45>;
+	clocks = <&clks 79>, <&clks 50>;
+	clock-names = "ipg", "per";
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
new file mode 100644
index 0000000..5cce7b4
--- /dev/null
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -0,0 +1,477 @@
+/*
+ * Copyright 2012 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+	};
+
+	asic: asic-interrupt-controller at 68000000 {
+		compatible = "fsl,imx25-asic", "fsl,avic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x68000000 0x8000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		osc {
+			compatible = "fsl,imx-osc", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&asic>;
+		ranges;
+
+		aips at 43f00000 { /* AIPS1 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x43f00000 0x100000>;
+			ranges;
+
+			i2c1: i2c at 43f80000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx25-i2c", "fsl,imx21-i2c";
+				reg = <0x43f80000 0x4000>;
+				clocks = <&clks 46>;
+				clock-names = "";
+				interrupts = <3>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 43f84000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx25-i2c", "fsl,imx21-i2c";
+				reg = <0x43f84000 0x4000>;
+				clocks = <&clks 46>;
+				clock-names = "";
+				interrupts = <10>;
+				status = "disabled";
+			};
+
+			can1: can at 43f88000 {
+				compatible = "fsl,imx25-flexcan", "fsl,p1010-flexcan";
+				reg = <0x43f88000 0x4000>;
+				interrupts = <43>;
+				clocks = <&clks 59>, <&clks 59>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			can2: can at 43f8c000 {
+				compatible = "fsl,imx25-flexcan", "fsl,p1010-flexcan";
+				reg = <0x43f8c000 0x4000>;
+				interrupts = <44>;
+				clocks = <&clks 60>, <&clks 60>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			uart1: serial at 43f90000 {
+				compatible = "fsl,imx25-uart", "fsl,imx21-uart";
+				reg = <0x43f90000 0x4000>;
+				interrupts = <45>;
+				clocks = <&clks 80>, <&clks 51>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			uart2: serial at 43f94000 {
+				compatible = "fsl,imx25-uart", "fsl,imx21-uart";
+				reg = <0x43f94000 0x4000>;
+				interrupts = <32>;
+				clocks = <&clks 81>, <&clks 51>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			i2c2: i2c at 43f98000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx25-i2c", "fsl,imx21-i2c";
+				reg = <0x43f98000 0x4000>;
+				clocks = <&clks 46>;
+				clock-names = "";
+				interrupts = <4>;
+				status = "disabled";
+			};
+
+			owire at 43f9c000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x43f9c000 0x4000>;
+				interrupts = <2>;
+				status = "disabled";
+			};
+
+			spi1: cspi at 43fa4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
+				reg = <0x43fa4000 0x4000>;
+				clocks = <&clks 47>;
+				clock-names = "ipg";
+				interrupts = <14>;
+				status = "disabled";
+			};
+
+			kpp at 43fa8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x43fa8000 0x4000>;
+				interrupts = <24>;
+				status = "disabled";
+			};
+
+			iomuxc at 43fac000{
+				compatible = "fsl,imx25-iomuxc";
+				reg = <0x43fac000 0x4000>;
+			};
+
+			audmux at 43fb0000 {
+				compatible = "fsl,imx25-audmux", "fsl,imx31-audmux";
+				reg = <0x43fb0000 0x4000>;
+				status = "disabled";
+			};
+		};
+
+		spba at 50000000 {
+			compatible = "fsl,spba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x50000000 0x40000>;
+			ranges;
+
+			spi3: cspi at 50004000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
+				reg = <0x50004000 0x4000>;
+				interrupts = <0>;
+				clocks = <&clks 64>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			uart4: serial at 50008000 {
+				compatible = "fsl,imx25-uart", "fsl,imx21-uart";
+				reg = <0x50008000 0x4000>;
+				interrupts = <5>;
+				clocks = <&clks 83>, <&clks 51>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			uart3: serial at 5000c000 {
+				compatible = "fsl,imx25-uart", "fsl,imx21-uart";
+				reg = <0x5000c000 0x4000>;
+				interrupts = <18>;
+				clocks = <&clks 82>, <&clks 51>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			spi2: cspi at 50010000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
+				reg = <0x50010000 0x4000>;
+				clocks = <&clks 63>;
+				clock-names = "ipg";
+				interrupts = <13>;
+				status = "disabled";
+			};
+
+			ssi2: ssi at 50014000 {
+				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
+				reg = <0x50014000 0x4000>;
+				interrupts = <11>;
+				status = "disabled";
+			};
+
+			esai at 50018000 {
+				reg = <0x50018000 0x4000>;
+				interrupts = <7>;
+			};
+
+			uart5: serial at 5002c000 {
+				compatible = "fsl,imx25-uart", "fsl,imx21-uart";
+				reg = <0x5002c000 0x4000>;
+				interrupts = <40>;
+				clocks = <&clks 84>, <&clks 51>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			tsc: tsc at 50030000 {
+				compatible = "fsl,imx25-adc", "fsl,imx21-tsc";
+				reg = <0x50030000 0x4000>;
+				interrupts = <46>;
+				clocks = <&clks 79>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
+			ssi1: ssi at 50034000 {
+				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
+				reg = <0x50034000 0x4000>;
+				interrupts = <12>;
+				status = "disabled";
+			};
+
+			fec: ethernet at 50038000 {
+				compatible = "fsl,imx25-fec";
+				reg = <0x50038000 0x4000>;
+				interrupts = <57>;
+				clocks = <&clks 68>, <&clks 55>;
+				clock-names = "ipg", "ahb";
+				status = "disabled";
+			};
+		};
+
+		aips at 53f00000 { /* AIPS2 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x53f00000 0x100000>;
+			ranges;
+
+			clks: ccm at 53f80000 {
+				compatible = "fsl,imx25-ccm";
+				reg = <0x53f80000 0x4000>;
+				interrupts = <31>;
+				#clock-cells = <1>;
+			};
+
+			gpt4: timer at 53f84000 {
+				compatible = "fsl,imx25-gpt", "fsl,imx31-gpt";
+				reg = <0x53f84000 0x4000>;
+				clocks = <&clks 9>, <&clks 45>;
+				clock-names = "ipg", "per";
+				interrupts = <1>;
+			};
+
+			gpt3: timer at 53f88000 {
+				compatible = "fsl,imx25-gpt", "fsl,imx31-gpt";
+				reg = <0x53f88000 0x4000>;
+				clocks = <&clks 9>, <&clks 45>;
+				clock-names = "ipg", "per";
+				interrupts = <29>;
+			};
+
+			gpt2: timer at 53f8c000 {
+				compatible = "fsl,imx25-gpt", "fsl,imx31-gpt";
+				reg = <0x53f8c000 0x4000>;
+				clocks = <&clks 9>, <&clks 45>;
+				clock-names = "ipg", "per";
+				interrupts = <53>;
+			};
+
+			gpt1: timer at 53f90000 {
+				compatible = "fsl,imx25-gpt", "fsl,imx31-gpt";
+				reg = <0x53f90000 0x4000>;
+				clocks = <&clks 9>, <&clks 45>;
+				clock-names = "ipg", "per";
+				interrupts = <54>;
+			};
+
+			epit1: timer at 53f94000 {
+				compatible = "fsl,imx25-epit";
+				reg = <0x53f94000 0x4000>;
+				interrupts = <28>;
+			};
+
+			epit2: timer at 53f98000 {
+				compatible = "fsl,imx25-epit";
+				reg = <0x53f98000 0x4000>;
+				interrupts = <27>;
+			};
+
+			gpio4: gpio at 53f9c000 {
+				compatible = "fsl,imx25-gpio", "fsl,imx35-gpio";
+				reg = <0x53f9c000 0x4000>;
+				interrupts = <23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pwm2: pwm at 53fa0000 {
+				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
+				#pwm-cells = <2>;
+				reg = <0x53fa0000 0x4000>;
+				clocks = <&clks 73>, <&clks 36>;
+				clock-names = "ipg", "per";
+				interrupts = <36>;
+			};
+
+			gpio3: gpio at 53fa4000 {
+				compatible = "fsl,imx25-gpio", "fsl,imx35-gpio";
+				reg = <0x53fa4000 0x4000>;
+				interrupts = <16>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pwm3: pwm at 53fa8000 {
+				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
+				#pwm-cells = <2>;
+				reg = <0x53fa8000 0x4000>;
+				clocks = <&clks 74>, <&clks 36>;
+				clock-names = "ipg", "per";
+				interrupts = <41>;
+			};
+
+			esdhc1: esdhc at 53fb4000 {
+				compatible = "fsl,imx25-esdhc";
+				reg = <0x53fb4000 0x4000>;
+				interrupts = <9>;
+				clocks = <&clks 66>, <&clks 53>, <&clks 43>;
+				clock-names = "ipg", "ahb", "per";
+				status = "disabled";
+			};
+
+			esdhc2: esdhc at 53fb8000 {
+				compatible = "fsl,imx25-esdhc";
+				reg = <0x53fb8000 0x4000>;
+				interrupts = <8>;
+				clocks = <&clks 67>, <&clks 54>, <&clks 44>;
+				clock-names = "ipg", "ahb", "per";
+				status = "disabled";
+			};
+
+			lcdc at 53fbc000 {
+				reg = <0x53fbc000 0x4000>;
+				interrupts = <39>;
+				clocks = <&clks 71>, <&clks 56>, <&clks 47>;
+				clock-names = "ipg", "ahb", "per";
+				status = "disabled";
+			};
+
+			slcdc at 53fc0000 {
+				reg = <0x53fc0000 0x4000>;
+				interrupts = <38>;
+				status = "disabled";
+			};
+
+			pwm4: pwm at 53fc8000 {
+				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
+				reg = <0x53fc8000 0x4000>;
+				clocks = <&clks 75>, <&clks 36>;
+				clock-names = "ipg", "per";
+				interrupts = <42>;
+			};
+
+			gpio1: gpio at 53fcc000 {
+				compatible = "fsl,imx25-gpio", "fsl,imx35-gpio";
+				reg = <0x53fcc000 0x4000>;
+				interrupts = <52>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio2: gpio at 53fd0000 {
+				compatible = "fsl,imx25-gpio", "fsl,imx35-gpio";
+				reg = <0x53fd0000 0x4000>;
+				interrupts = <51>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			sdma at 53fd4000 {
+				compatible = "fsl,imx25-sdma", "fsl,imx35-sdma";
+				reg = <0x53fd4000 0x4000>;
+				clocks = <&clks 76>, <&clks 57>;
+				clock-names = "ipg", "ahb";
+				interrupts = <34>;
+			};
+
+			wdog at 53fdc000 {
+				compatible = "fsl,imx25-wdt", "fsl,imx21-wdt";
+				reg = <0x53fdc000 0x4000>;
+				clocks = <&clks 85>;
+				clock-names = "";
+				interrupts = <55>;
+			};
+
+			pwm1: pwm at 53fe0000 {
+				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
+				#pwm-cells = <2>;
+				reg = <0x53fe0000 0x4000>;
+				clocks = <&clks 72>, <&clks 36>;
+				clock-names = "ipg", "per";
+				interrupts = <26>;
+			};
+
+			usb at 53ff4000 {
+				reg = <0x53ff4000 0x4000>;
+			};
+
+			csi at 53ff8000 {
+				reg = <0x53ff8000 0x4000>;
+				interrupts = <17>;
+			};
+
+			dryice at 53ffc000 {
+				compatible = "fsl,imx25-dryice", "fsl,imx25-rtc";
+				reg = <0x53ffc000 0x4000>;
+				clocks = <&clks 65>;
+				clock-names = "ipg";
+				interrupts = <25>;
+			};
+		};
+
+		emi at 80000000 {
+			compatible = "fsl,emi-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x80000000 0x3b002000>;
+			ranges;
+
+			nand at bb000000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				compatible = "fsl,imx25-nand";
+				reg = <0xbb000000 0x2000>;
+				interrupts = <33>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
1.7.10.4
