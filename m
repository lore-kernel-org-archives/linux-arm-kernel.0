From: marex@denx.de (Marek Vasut)
Date: Mon, 22 Apr 2013 23:23:47 +0200
Subject: [PATCH V2] ARM: mx5: Add support for DENX M53EVK
Message-ID: <1366665827-8949-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the DENX M53EVK board. The board currently supports
NAND, Ethernet, UART, CAN, I2C.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/Makefile         |    1 +
 arch/arm/boot/dts/imx53-m53evk.dts |  259 ++++++++++++++++++++++++++++++++++++
 2 files changed, 260 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-m53evk.dts

V2: - Rebase on top of Shawn's patch:
      "[PATCH] ARM: imx: move imx53-qsb audio codec clk lookup into DT"
    - Use BGR666 format on LCD, this makes it depend on:
      "[PATCH V2] video: imx: Add BGR666 support for parallel display"
    - Remove the first LCD as it's not populated
    - Reorder the DT nodes in alphabetical order
    - Configure PWM pinmux properly
    - Pass IRQ GPIO to STMPE-TS driver using "interrupt" and
      "interrupt-parent" DT properties

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4fd1f62..1fbec6b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -107,6 +107,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx51-babbage.dtb \
 	imx53-ard.dtb \
 	imx53-evk.dtb \
+	imx53-m53evk.dtb \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
 	imx53-smd.dtb \
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
new file mode 100644
index 0000000..7d304d0
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -0,0 +1,259 @@
+/*
+ * Copyright (C) 2013 Marek Vasut <marex@denx.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx53.dtsi"
+
+/ {
+	model = "DENX M53EVK";
+	compatible = "denx,imx53-m53evk", "fsl,imx53";
+
+	memory {
+		reg = <0x70000000 0x20000000>;
+	};
+
+	soc {
+		display at di1 {
+			compatible = "fsl,imx-parallel-display";
+			crtcs = <&ipu 1>;
+			interface-pix-fmt = "bgr666";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ipu_disp2_1>;
+
+			display-timings {
+				800x480p60 {
+					native-mode;
+					clock-frequency = <31500000>;
+					hactive = <800>;
+					vactive = <480>;
+					hfront-porch = <40>;
+					hback-porch = <88>;
+					hsync-len = <128>;
+					vback-porch = <33>;
+					vfront-porch = <9>;
+					vsync-len = <3>;
+					vsync-active = <1>;
+				};
+			};
+		};
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 3000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pin_gpio>;
+
+		user1 {
+			label = "user1";
+			gpios = <&gpio2 8 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user2 {
+			label = "user2";
+			gpios = <&gpio2 9 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p2v: 3p2v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P2V";
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx53-m53evk-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx53-m53evk-sgtl5000";
+		ssi-controller = <&ssi2>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Ext Spk", "LINE_OUT";
+		mux-int-port = <2>;
+		mux-ext-port = <4>;
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux_2>;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_3>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2_1>;
+	status = "okay";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	cd-gpios = <&gpio1 1 0>;
+	wp-gpios = <&gpio1 9 0>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
+	phy-mode = "rmii";
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_2>;
+	status = "okay";
+
+	sgtl5000: codec at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&reg_3p2v>;
+		VDDIO-supply = <&reg_3p2v>;
+		clocks = <&clks 150>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_2>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	stmpe610 at 41 {
+		compatible = "st,stmpe610";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x41>;
+		id = <0>;
+		blocks = <0x5>;
+		interrupts = <6 0x0>;
+		interrupt-parent = <&gpio7>;
+		irq-trigger = <0x1>;
+
+		stmpe_touchscreen {
+			compatible = "stmpe,ts";
+			reg = <0>;
+			ts,sample-time = <4>;
+			ts,mod-12b = <1>;
+			ts,ref-sel = <0>;
+			ts,adc-freq = <1>;
+			ts,ave-ctrl = <3>;
+			ts,touch-det-delay = <3>;
+			ts,settling = <4>;
+			ts,fraction-z = <7>;
+			ts,i-drive = <1>;
+		};
+	};
+
+	eeprom: eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+
+	rtc: rtc at 68 {
+		compatible = "stm,m41t62";
+		reg = <0x68>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_1>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK	0x80000000
+				MX53_PAD_EIM_EB3__GPIO2_31		0x80000000
+				MX53_PAD_PATA_DA_0__GPIO7_6		0x80000000
+				MX53_PAD_DISP0_DAT8__PWM1_PWMO		0x5
+
+			>;
+		};
+
+		led_pin_gpio: led_gpio at 0 {
+			fsl,pins = <
+				MX53_PAD_PATA_DATA8__GPIO2_8		0x80000000
+				MX53_PAD_PATA_DATA9__GPIO2_9		0x80000000
+			>;
+		};
+	};
+};
+
+&nfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nand_1>;
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1_1>;
+	status = "okay";
+};
+
+&ssi2 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_2>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_1>;
+	status = "okay";
+};
-- 
1.7.10.4
