From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Mon,  9 Jan 2017 17:00:18 +0100
Subject: [PATCH 1/1] ARM: dts: add Armadeus Systems OPOS6UL AND OPOS6ULDEV
 support
Message-ID: <1483977618-18298-1-git-send-email-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OPOS6UL is an i.MX6UL based SoM.
OPOS6ULDev is a carrier board for the OPOS6UL SoM.

For more details see:
http://www.opossom.com/english/products-processor_boards-opos6ul.html
http://www.opossom.com/english/products-development_boards-opos6ul_dev.html

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi   | 192 +++++++++++++++
 arch/arm/boot/dts/imx6ul-opos6uldev.dts | 414 ++++++++++++++++++++++++++++++++
 3 files changed, 607 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-opos6ul.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-opos6uldev.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7327250..f839c75 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -435,6 +435,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-14x14-evk.dtb \
 	imx6ul-geam-kit.dtb \
 	imx6ul-liteboard.dtb \
+	imx6ul-opos6uldev.dtb \
 	imx6ul-pico-hobbit.dtb \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-opos6ul.dtsi b/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
new file mode 100644
index 0000000..4673dde
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
@@ -0,0 +1,192 @@
+/*
+ * Copyright 2016 Armadeus Systems <support@armadeus.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "imx6ul.dtsi"
+
+/ {
+	memory {
+		reg = <0x80000000 0>; /* will be filled by U-Boot */
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	usdhc3_pwrseq: usdhc3_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio2 9 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-reset-duration = <1>;
+	phy-reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
+	phy-handle = <&ethphy1>;
+	phy-supply = <&reg_3v3>;
+	status = "okay";
+
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy at 1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+			status = "okay";
+		};
+	};
+};
+
+/* Bluetooth */
+&uart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart8>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	status = "okay";
+};
+
+/* WiFi */
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	brcmf: bcrmf at 1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "host-wake";
+	};
+};
+
+&iomuxc {
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x130b0
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x130b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x130b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x130b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			/* INT# */
+			MX6UL_PAD_NAND_DQS__GPIO4_IO16		0x1b0b0
+			/* RST# */
+			MX6UL_PAD_NAND_DATA00__GPIO4_IO02	0x130b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+		>;
+	};
+
+	pinctrl_uart8: uart8grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_TX_EN__UART8_DCE_RX	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__UART8_DCE_TX	0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__UART8_DCE_RTS	0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__UART8_DCE_CTS	0x1b0b0
+			/* BT_REG_ON */
+			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10	0x130b0
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+			MX6UL_PAD_NAND_READY_B__USDHC1_DATA4	0x17059
+			MX6UL_PAD_NAND_CE0_B__USDHC1_DATA5	0x17059
+			MX6UL_PAD_NAND_CE1_B__USDHC1_DATA6	0x17059
+			MX6UL_PAD_NAND_CLE__USDHC1_DATA7	0x17059
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA18__USDHC2_CMD	0x1b0b0
+			MX6UL_PAD_LCD_DATA19__USDHC2_CLK	0x100b0
+			MX6UL_PAD_LCD_DATA20__USDHC2_DATA0	0x1b0b0
+			MX6UL_PAD_LCD_DATA21__USDHC2_DATA1	0x1b0b0
+			MX6UL_PAD_LCD_DATA22__USDHC2_DATA2	0x1b0b0
+			MX6UL_PAD_LCD_DATA23__USDHC2_DATA3	0x1b0b0
+			/* WL_REG_ON */
+			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09	0x130b0
+			/* WL_IRQ */
+			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08	0x1b0b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ul-opos6uldev.dts b/arch/arm/boot/dts/imx6ul-opos6uldev.dts
new file mode 100644
index 0000000..a373562
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-opos6uldev.dts
@@ -0,0 +1,414 @@
+/*
+ * Copyright 2016 Armadeus Systems <support@armadeus.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6ul-opos6ul.dtsi"
+
+/ {
+	model = "Armadeus Systems OPOS6UL SoM on OPOS6ULDev board";
+	compatible = "armadeus,opos6uldev", "armadeus,opos6ul", "fsl,imx6ul";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	lcd_backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm3 0 191000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		power-supply = <&reg_5v>;
+		status = "okay";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		user-button {
+			label = "User button";
+			gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_MISC>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user_led {
+			label = "User";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_led>;
+			gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	onewire {
+		compatible = "w1-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_w1>;
+		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usbotg1_vbus: regulator-usbotg1vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbotg1vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg1_vbus>;
+		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usbotg2_vbus: regulator-usbotg2vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbotg2vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg2_vbus>;
+		gpio = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&adc1 {
+	vref-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_5v>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_5v>;
+	status = "okay";
+};
+
+&ecspi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi4>;
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>, <&gpio4 3 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	spidev0: spi at 0 {
+		compatible = "spidev";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+	};
+
+	spidev1: spi at 1 {
+		compatible = "spidev";
+		reg = <1>;
+		spi-max-frequency = <5000000>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	clock_frequency = <400000>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock_frequency = <400000>;
+	status = "okay";
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif>;
+	display = <&display0>;
+	lcd-supply = <&reg_3v3>;
+	status = "okay";
+
+	display0: display0 {
+		bits-per-pixel = <32>;
+		bus-width = <18>;
+
+		display-timings {
+			timing0: timing0 {
+				clock-frequency = <33000033>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <96>;
+				hfront-porch = <96>;
+				vback-porch = <20>;
+				vfront-porch = <21>;
+				hsync-len = <64>;
+				vsync-len = <4>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&snvs_pwrkey {
+	status = "disabled";
+};
+
+&tsc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tsc>;
+	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	measure-delay-time = <0xffff>;
+	pre-charge-time = <0xffff>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1_id>;
+	vbus-supply = <&reg_usbotg1_vbus>;
+	dr_mode = "otg";
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usbotg2_vbus>;
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpios>;
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_ALE__PWM3_OUT		0x1b0b0
+		>;
+	};
+
+	pinctrl_ecspi4: ecspi4grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_DATA04__ECSPI4_SCLK	0x1b0b0
+			MX6UL_PAD_NAND_DATA05__ECSPI4_MOSI	0x1b0b0
+			MX6UL_PAD_NAND_DATA06__ECSPI4_MISO	0x1b0b0
+			MX6UL_PAD_NAND_DATA01__GPIO4_IO03	0x1b0b0
+			MX6UL_PAD_NAND_DATA07__GPIO4_IO09	0x1b0b0
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x0b0b0
+			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x0b0b0
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x0b0b0
+			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x0b0b0
+		>;
+	};
+
+	pinctrl_gpios: gpiosgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09	0x0b0b0
+			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x0b0b0
+			MX6UL_PAD_UART3_TX_DATA__GPIO1_IO24	0x0b0b0
+			MX6UL_PAD_NAND_RE_B__GPIO4_IO00		0x0b0b0
+			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0x0b0b0
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x0b0b0
+			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x0b0b0
+			MX6UL_PAD_NAND_WE_B__GPIO4_IO01		0x0b0b0
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x0b0b0
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x0b0b0
+			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x0b0b0
+			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x0b0b0
+			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x0b0b0
+			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x0b0b0
+			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x0b0b0
+			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x0b0b0
+		>;
+	};
+
+	pinctrl_w1: w1grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x0b0b0
+		>;
+	};
+
+	pinctrl_gpio_keys: gpio_keysgrp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_TX_DATA0__GPIO2_IO11	0x0b0b0
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA	0x4001b8b0
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL	0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA	0x4001b8b0
+			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL	0x4001b8b0
+		>;
+	};
+
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK	    0x100b1
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE  0x100b1
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC    0x100b1
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC    0x100b1
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00  0x100b1
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01  0x100b1
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02  0x100b1
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03  0x100b1
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04  0x100b1
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05  0x100b1
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06  0x100b1
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07  0x100b1
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08  0x100b1
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09  0x100b1
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10  0x100b1
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11  0x100b1
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12  0x100b1
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13  0x100b1
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14  0x100b1
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15  0x100b1
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16  0x100b1
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17  0x100b1
+		>;
+	};
+
+	pinctrl_led: ledgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_RESET__GPIO3_IO04		0x0b0b0
+		>;
+	};
+
+	pinctrl_tsc: tscgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01       0xb0
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02       0xb0
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03       0xb0
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04       0xb0
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg1_id: usbotg1_idgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x1b0b0
+		>;
+	};
+
+	pinctrl_usbotg1_vbus: usbotg1_vbusgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO05__GPIO1_IO05	0x1b0b0
+		>;
+	};
+
+	pinctrl_usbotg2_vbus: usbotg2_vbusgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x1b0b0
+		>;
+	};
+};
-- 
2.7.3
