From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 14 Jun 2017 22:48:53 +0200
Subject: [RFC PATCH 1/3] ARM: dts: imx7d: add imx7d-phyboard-zeta
In-Reply-To: <20170614204855.18347-1-o.rempel@pengutronix.de>
References: <20170614204855.18347-1-o.rempel@pengutronix.de>
Message-ID: <20170614204855.18347-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleksij Rempel <linux@rempel-privat.de>

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/imx7d-pba-c-09.dtsi     | 272 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-peb-av-02.dtsi    | 104 ++++++++++++
 arch/arm/boot/dts/imx7d-peb-eval-02.dtsi  | 130 ++++++++++++++
 arch/arm/boot/dts/imx7d-phyboard-zeta.dts | 144 ++++++++++++++++
 arch/arm/boot/dts/imx7d-phycore-som.dtsi  | 272 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-pinfunc-lpsr.h    |  76 +++++++++
 arch/arm/boot/dts/imx7s.dtsi              |   1 +
 8 files changed, 1000 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-pba-c-09.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-peb-av-02.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-peb-eval-02.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-phyboard-zeta.dts
 create mode 100644 arch/arm/boot/dts/imx7d-phycore-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-pinfunc-lpsr.h

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c5e1d944d1c..cdd4bdb3a7c2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -476,6 +476,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-eval-v3.dtb \
 	imx7d-nitrogen7.dtb \
+	imx7d-phyboard-zeta.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
 	imx7d-sdb-sht11.dtb \
diff --git a/arch/arm/boot/dts/imx7d-pba-c-09.dtsi b/arch/arm/boot/dts/imx7d-pba-c-09.dtsi
new file mode 100644
index 000000000000..4150c16684b7
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-pba-c-09.dtsi
@@ -0,0 +1,272 @@
+/*
+ * Copyright (C) 2015 PHYTEC America, LLC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	model = "Phytec i.MX7 phyBOARD-Zeta";
+	compatible = "phytec,imx7d-pba-c-09", "phytec,imx7d-phycore-som", "fsl,imx7d";
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usb_otg1_vbus: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_otg1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		reg_usb_otg2_vbus: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "usb_otg2_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		/* Enable if R9 is populated. Conflicts with userbtn2 on PEB-EVAL-02 */
+		/*
+		reg_can1_3v3: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "can1-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+		*/
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog_1 &pinctrl_hog_2 &pinctrl_hog_lcd>;
+
+	pinctrl_hog_2: hoggrp-2 {
+		fsl,pins = <
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* SD1 CD */
+			MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* PCIe Disable */
+			MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17	0x59 /* PCIe Reset */
+			MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14 /* USB2 pwr */
+			MX7D_PAD_GPIO1_IO09__GPIO1_IO9 		0x59 /* ETH2 Int_N */
+			MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30	0x59 /* ETH2 Reset_n */
+			MX7D_PAD_EPDC_DATA10__GPIO2_IO10	0x59 /* User Button */
+			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x39 /* Boot Circuit Buffer Enable
+									5K pull-up  */
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x59
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x19
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO12__FLEXCAN1_RX	0x59
+			MX7D_PAD_GPIO1_IO13__FLEXCAN1_TX	0x59
+		>;
+	};
+
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_SDCE0__ENET2_RGMII_RX_CTL	0x5
+			MX7D_PAD_EPDC_SDCE1__ENET2_RGMII_RXC 	0x5
+			MX7D_PAD_EPDC_SDCLK__ENET2_RGMII_RD0	0x5
+			MX7D_PAD_EPDC_SDLE__ENET2_RGMII_RD1	0x5
+			MX7D_PAD_EPDC_SDOE__ENET2_RGMII_RD2	0x5
+			MX7D_PAD_EPDC_SDSHR__ENET2_RGMII_RD3	0x5
+			MX7D_PAD_EPDC_SDCE2__ENET2_RGMII_TD0	0x5
+			MX7D_PAD_EPDC_SDCE3__ENET2_RGMII_TD1	0x5
+			MX7D_PAD_EPDC_GDCLK__ENET2_RGMII_TD2	0x5
+			MX7D_PAD_EPDC_GDOE__ENET2_RGMII_TD3	0x5
+			MX7D_PAD_EPDC_GDRL__ENET2_RGMII_TX_CTL	0x5
+			MX7D_PAD_EPDC_GDSP__ENET2_RGMII_TXC	0x5
+		>;
+	};
+};
+
+&iomuxc_lpsr {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog_lpsr_1 &pinctrl_hog_lpsr_lcd>;
+
+	pinctrl_hog_lpsr_1: hoggrp-lpsr_1 {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO05__GPIO1_IO5		0x14 /* USB1 pwr */
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO06__UART5_DCE_RX	0x79
+			MX7D_PAD_GPIO1_IO07__UART5_DCE_TX	0x79
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B	0x74
+		>;
+	};
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	status = "disabled";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	no-1-8-v; /* Fixed voltage supply, doesn't support vsel */
+	enable-sdio-wakeup;
+	keep-power-in-suspend;
+	status = "disabled";
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	/* Enable the following if SD1_RESET_B is used to enable/disable CAN xceiver
+	 *  xceiver-supply = <&reg_can1_3v3>;
+	 */
+	status = "disabled";
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	assigned-clocks = <&clks IMX7D_ENET2_TIME_ROOT_SRC>,
+			<&clks IMX7D_ENET2_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+	fsl,magic-packet;
+	phy-reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
+	status = "disabled";
+};
+
+/* same MDIO bus as PHY on phyCORE SOM */
+&mdio {
+	ethphy1: ethernet-phy at 2 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 0>;
+		reg = <2>;
+		rxdv-skew-ps = <0>;
+		txen-skew-ps = <0>;
+		rxd0-skew-ps = <0>;
+		rxd1-skew-ps = <0>;
+		rxd2-skew-ps = <0>;
+		rxd3-skew-ps = <0>;
+		rxc-skew-ps = <1860>;
+		txc-skew-ps = <1860>;
+	};
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	dr_mode = "host";
+	status = "disabled";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	status = "disabled";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,wdog_b;
+};
+
+/* DTS pinmuxing and bindings for LCD adapter PEB-AV-02 */
+
+&iomuxc {
+	pinctrl_hog_lcd: hog_lcdgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_RESET__GPIO3_IO4		0x79
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
+			MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
+		>;
+	};
+
+	pinctrl_edt_ts_irq: tsirqgrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA14__GPIO2_IO14	0x59
+		>;
+	};
+};
+
+&iomuxc_lpsr {
+	pinctrl_pwm3: pwmgrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO03__PWM3_OUT		0x30
+		>;
+	};
+
+	pinctrl_hog_lpsr_lcd: hoggrp_lpsr_lcd {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO01__GPIO1_IO1		0x59
+		>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "disabled";
+
+	ft5406: ft5406 at 38 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_edt_ts_irq>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <14 0>;
+		reset-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+		status = "disabled";
+	};
+};
+
+#include "imx7d-peb-av-02.dtsi"
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "disabled";
+};
+
+&backlight {
+	pwms = <&pwm3 0 5000000>;
+	enable-gpios = <&gpio1 1 0>;
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx7d-peb-av-02.dtsi b/arch/arm/boot/dts/imx7d-peb-av-02.dtsi
new file mode 100644
index 000000000000..dcf117c71a92
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-peb-av-02.dtsi
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) 2015 PHYTEC America, LLC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		power-supply = <&lcd_3v3>;
+		status = "disabled";
+	};
+
+	lcd_3v3: fixedregulator-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+};
+
+&iomuxc {
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_CLK__LCD_CLK	0x7e
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE	0x7e
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC	0x7e
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC	0x7e
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdifdatgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0	0x7e
+			MX7D_PAD_LCD_DATA01__LCD_DATA1	0x7e
+			MX7D_PAD_LCD_DATA02__LCD_DATA2	0x7e
+			MX7D_PAD_LCD_DATA03__LCD_DATA3	0x7e
+			MX7D_PAD_LCD_DATA04__LCD_DATA4	0x7e
+			MX7D_PAD_LCD_DATA05__LCD_DATA5	0x7e
+			MX7D_PAD_LCD_DATA06__LCD_DATA6	0x7e
+			MX7D_PAD_LCD_DATA07__LCD_DATA7	0x7e
+			MX7D_PAD_LCD_DATA08__LCD_DATA8	0x7e
+			MX7D_PAD_LCD_DATA09__LCD_DATA9	0x7e
+			MX7D_PAD_LCD_DATA10__LCD_DATA10	0x7e
+			MX7D_PAD_LCD_DATA11__LCD_DATA11	0x7e
+			MX7D_PAD_LCD_DATA12__LCD_DATA12	0x7e
+			MX7D_PAD_LCD_DATA13__LCD_DATA13	0x7e
+			MX7D_PAD_LCD_DATA14__LCD_DATA14	0x7e
+			MX7D_PAD_LCD_DATA15__LCD_DATA15	0x7e
+			MX7D_PAD_LCD_DATA16__LCD_DATA16	0x7e
+			MX7D_PAD_LCD_DATA17__LCD_DATA17	0x7e
+			MX7D_PAD_LCD_DATA18__LCD_DATA18	0x7e
+			MX7D_PAD_LCD_DATA19__LCD_DATA19	0x7e
+			MX7D_PAD_LCD_DATA20__LCD_DATA20	0x7e
+			MX7D_PAD_LCD_DATA21__LCD_DATA21	0x7e
+			MX7D_PAD_LCD_DATA22__LCD_DATA22	0x7e
+			MX7D_PAD_LCD_DATA23__LCD_DATA23	0x7e
+		>;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		&pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	lcd-supply = <&lcd_3v3>;
+	status = "disabled";
+
+	display0: display {
+		bits-per-pixel = <32>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: ETM0700G0DH6 {
+				clock-frequency = <33000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <40>;
+				hback-porch = <216>;
+				hsync-len = <128>;
+				vback-porch = <35>;
+				vfront-porch = <10>;
+				vsync-len = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+};
+
+&ft5406 {
+	compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
+	reg = <0x38>;
+	status = "disabled";
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/imx7d-peb-eval-02.dtsi b/arch/arm/boot/dts/imx7d-peb-eval-02.dtsi
new file mode 100644
index 000000000000..8bde5b13e702
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-peb-eval-02.dtsi
@@ -0,0 +1,130 @@
+/*
+ * Copyright (C) 2015 PHYTEC America, LLC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	phytec_leds: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds_eval>;
+		status = "disabled";
+
+		led at 0 {
+			label = "eval_led_1";
+			gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "gpio";
+			default-state = "on";
+		};
+
+		led at 1 {
+			label = "eval_led_2";
+			gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "gpio";
+			default-state = "on";
+		};
+
+		led at 2 {
+			label = "eval_led_3";
+			gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "gpio";
+			default-state = "on";
+		};
+	};
+
+	phytec_buttons: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_btns_eval>;
+		status = "disabled";
+
+		userbtn at 0 {
+			label = "eval_button_1";
+			gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
+			linux,code = <0x100>;	/* BTN_MISC */
+		};
+		userbtn at 1 {
+			label = "eval_button_2";
+			gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
+			linux,code = <0x100>;   /* BTN_MISC */
+		};
+
+		userbtn at 2 {
+			label = "eval_button_3";
+			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+			linux,code = <0x100>;	/* BTN_MISC */
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
+			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
+		>;
+	};
+
+	pinctrl_leds_eval: leds_evalgrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA08__GPIO2_IO8		0x79	/* Labeled UART6_RX on schematic */
+			MX7D_PAD_UART3_RX_DATA__GPIO4_IO4	0x79
+			MX7D_PAD_EPDC_DATA15__GPIO2_IO15	0x79	/* Labeled EXP_CONN_MUX5 on schematic */
+		>;
+	};
+
+	pinctrl_btns_eval: btns_evalgrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA09__GPIO2_IO9		0x79	/* Labeled UART6_TX on schematic */
+			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x79
+			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x79	/* Labeled EXP_CONN_MUX3 on schematic */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
+			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX7D_PAD_UART2_RX_DATA__UART2_DCE_RX	0x79
+			MX7D_PAD_UART2_TX_DATA__UART2_DCE_TX	0x79
+		>;
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "disabled";
+
+	i2c4_eeprom: eeprom at 56 {
+		compatible = "onnn,24c32";
+		reg = <0x56>;
+		pagesize = <32>;
+		status = "disabled";
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "disabled";
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/imx7d-phyboard-zeta.dts b/arch/arm/boot/dts/imx7d-phyboard-zeta.dts
new file mode 100644
index 000000000000..16cf12244f16
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-phyboard-zeta.dts
@@ -0,0 +1,144 @@
+/*
+ * Copyright (C) 2015 PHYTEC America, LLC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "imx7d-phycore-som.dtsi"
+#include "imx7d-pba-c-09.dtsi"
+#include "imx7d-peb-eval-02.dtsi"
+
+#include "imx7s.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart5;
+
+		environment at 0 {
+			compatible = "barebox,environment";
+			device-path = &bareboxenv;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+/**** SOM - PCM-061 ****/
+
+&fec1 {
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc3 {
+	status = "okay";
+
+	boot0-partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		barebox at 0 {
+			label = "barebox";
+			reg = <0x0 0x300000>;
+		};
+
+		bareboxenv: bareboxenv at 300000 {
+			label = "bareboxenv";
+			reg = <0x300000 0x0>;
+		};
+	};
+};
+
+&i2c_eeprom {
+	status = "okay";
+};
+
+&i2c_rtc {
+	status = "okay";
+};
+
+/**** Carrier Board - PBA-C-09 ****/
+
+&uart5 {
+	status = "okay";
+};
+
+&usdhc1 {
+	status = "okay";
+};
+
+&fec2 {
+	status = "okay";
+};
+
+/* Host mode */
+&usbotg1 {
+	status = "okay";
+};
+
+/* OTG mode */
+&usbotg2 {
+	status = "okay";
+};
+
+&flexcan1 {
+	status = "okay";
+};
+
+&wdog1 {
+	status = "okay";
+};
+
+/**** PEB-AV-02: touch controller ft5406, LCD and PWM backlight control ****/
+&i2c2 {
+	status = "okay";
+};
+
+&ft5406 {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&backlight {
+	status = "okay";
+};
+
+/**** Interfaces on PEB-EVAL-02 ****/
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c4_eeprom {
+	status = "okay";
+};
+
+&phytec_leds {
+	status = "okay";
+};
+
+&phytec_buttons {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/imx7d-phycore-som.dtsi b/arch/arm/boot/dts/imx7d-phycore-som.dtsi
new file mode 100644
index 000000000000..ea8c801f3852
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-phycore-som.dtsi
@@ -0,0 +1,272 @@
+/*
+ * Copyright (C) 2015 PHYTEC America, LLC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/input/input.h>
+#include <arm/imx7d.dtsi>
+
+/ {
+	model = "Phytec i.MX7D phyCORE";
+	compatible = "phytec,imx7d-phycore-som", "fsl,imx7d";
+
+	memory {
+		reg = <0x80000000 0x80000000>;
+	};
+};
+
+&cpu0 {
+	arm-supply = <&sw1a_reg>;
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pfuze3000 at 08 {
+		compatible = "fsl,pfuze3000";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1a {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			/* use sw1c_reg to align with pfuze100/pfuze200 */
+			sw1c_reg: sw1b {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1475000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vldo2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vccsd {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: v33 {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vldo3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vldo4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+	i2c_eeprom: eeprom at 50 {
+		compatible = "atmel,24c32";
+		pagesize = <32>;
+		reg = <0x50>;
+		status = "disabled";
+	};
+
+	i2c_rtc: rtc at 68 {
+		compatible = "mc,rv4162";
+		reg=<0x68>;
+		status = "disabled";
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog_1>;
+
+	pinctrl_hog_1: hoggrp-1 {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO08__SD1_VSELECT	0x59 /* PMIC VSELECT */
+			MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x59 /* ENET1_RESET_B */
+			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x59 /* ENET1_INT_B */
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO10__ENET1_MDIO			0x7
+			MX7D_PAD_GPIO1_IO11__ENET1_MDC			0x7
+			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x5
+			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x5
+			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x5
+			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x5
+			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x5
+			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x5
+			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x5
+			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x5
+			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x5
+			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x5
+			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x5
+			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x5
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SDA__I2C1_SDA	0x4000007f
+			MX7D_PAD_I2C1_SCL__I2C1_SCL	0x4000007f
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD	0x5d
+			MX7D_PAD_SD3_CLK__SD3_CLK	0x1d
+			MX7D_PAD_SD3_DATA0__SD3_DATA0	0x5d
+			MX7D_PAD_SD3_DATA1__SD3_DATA1	0x5d
+			MX7D_PAD_SD3_DATA2__SD3_DATA2	0x5d
+			MX7D_PAD_SD3_DATA3__SD3_DATA3	0x5d
+			MX7D_PAD_SD3_DATA4__SD3_DATA4	0x5d
+			MX7D_PAD_SD3_DATA5__SD3_DATA5	0x5d
+			MX7D_PAD_SD3_DATA6__SD3_DATA6	0x5d
+			MX7D_PAD_SD3_DATA7__SD3_DATA7	0x5d
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD	0x5e
+			MX7D_PAD_SD3_CLK__SD3_CLK	0x1e
+			MX7D_PAD_SD3_DATA0__SD3_DATA0	0x5e
+			MX7D_PAD_SD3_DATA1__SD3_DATA1	0x5e
+			MX7D_PAD_SD3_DATA2__SD3_DATA2	0x5e
+			MX7D_PAD_SD3_DATA3__SD3_DATA3	0x5e
+			MX7D_PAD_SD3_DATA4__SD3_DATA4	0x5e
+			MX7D_PAD_SD3_DATA5__SD3_DATA5	0x5e
+			MX7D_PAD_SD3_DATA6__SD3_DATA6	0x5e
+			MX7D_PAD_SD3_DATA7__SD3_DATA7	0x5e
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD	0x5f
+			MX7D_PAD_SD3_CLK__SD3_CLK	0x1f
+			MX7D_PAD_SD3_DATA0__SD3_DATA0	0x5f
+			MX7D_PAD_SD3_DATA1__SD3_DATA1	0x5f
+			MX7D_PAD_SD3_DATA2__SD3_DATA2	0x5f
+			MX7D_PAD_SD3_DATA3__SD3_DATA3	0x5f
+			MX7D_PAD_SD3_DATA4__SD3_DATA4	0x5f
+			MX7D_PAD_SD3_DATA5__SD3_DATA5	0x5f
+			MX7D_PAD_SD3_DATA6__SD3_DATA6	0x5f
+			MX7D_PAD_SD3_DATA7__SD3_DATA7	0x5f
+		>;
+	};
+
+	pinctrl_qspi1_1: qspi1grp_1 {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA00__QSPI_A_DATA0	0x51
+			MX7D_PAD_EPDC_DATA01__QSPI_A_DATA1	0x51
+			MX7D_PAD_EPDC_DATA02__QSPI_A_DATA2	0x51
+			MX7D_PAD_EPDC_DATA03__QSPI_A_DATA3	0x51
+			MX7D_PAD_EPDC_DATA05__QSPI_A_SCLK	0x51
+			MX7D_PAD_EPDC_DATA06__QSPI_A_SS0_B	0x51
+		>;
+	};
+};
+
+&sdma {
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
+			<&clks IMX7D_ENET1_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	phy-reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
+	status = "disabled";
+
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/*ETH1 PHY on SOM, 25MHz crystal */
+		ethphy0: ethernet-phy at 1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			interrupt-parent = <&gpio2>;
+			interrupts = <29 0>;
+			reg = <1>;
+		};
+	};
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	tuning-step = <2>;
+	non-removable;
+	status = "disabled";
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/imx7d-pinfunc-lpsr.h b/arch/arm/boot/dts/imx7d-pinfunc-lpsr.h
new file mode 100644
index 000000000000..378694ee05c2
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-pinfunc-lpsr.h
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DTS_IMX7D_PINFUNC_LPSR_H
+#define __DTS_IMX7D_PINFUNC_LPSR_H
+
+/*
+ * The pin function ID is a tuple of
+ * <mux_reg conf_reg input_reg mux_mode input_val>
+ *
+ * NOTE: imx7d-lpsr pin groups should be put under &iomuxc_lpsr node when used
+ */
+
+#define MX7D_PAD_GPIO1_IO00__GPIO1_IO0				  0x0000 0x0030 0x0000 0x0 0x0
+#define MX7D_PAD_GPIO1_IO00__PWM4_OUT				  0x0000 0x0030 0x0000 0x1 0x0
+#define MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_ANY			  0x0000 0x0030 0x0000 0x2 0x0
+#define MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B			  0x0000 0x0030 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO00__WDOD1_WDOG__RST_B_DEB		  0x0000 0x0030 0x0000 0x4 0x0
+#define MX7D_PAD_GPIO1_IO01__GPIO1_IO1				  0x0004 0x0034 0x0000 0x0 0x0
+#define MX7D_PAD_GPIO1_IO01__PWM1_OUT				  0x0004 0x0034 0x0000 0x1 0x0
+#define MX7D_PAD_GPIO1_IO01__CCM_ENET_REF_CLK3			  0x0004 0x0034 0x0000 0x2 0x0
+#define MX7D_PAD_GPIO1_IO01__SAI1_MCLK				  0x0004 0x0034 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO01__ANATOP_24M_OUT			  0x0004 0x0034 0x0000 0x4 0x0
+#define MX7D_PAD_GPIO1_IO01__OBSERVE0_OUT			  0x0004 0x0034 0x0000 0x6 0x0
+#define MX7D_PAD_GPIO1_IO02__GPIO1_IO2				  0x0008 0x0038 0x0000 0x0 0x0
+#define MX7D_PAD_GPIO1_IO02__PWM2_OUT				  0x0008 0x0038 0x0000 0x1 0x0
+#define MX7D_PAD_GPIO1_IO02__CCM_ENET_REF_CLK1			  0x0008 0x0038 0x0564 0x2 0x3
+#define MX7D_PAD_GPIO1_IO02__SAI2_MCLK				  0x0008 0x0038 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO02__CCM_CLKO1				  0x0008 0x0038 0x0000 0x5 0x0
+#define MX7D_PAD_GPIO1_IO02__OBSERVE1_OUT			  0x0008 0x0038 0x0000 0x6 0x0
+#define MX7D_PAD_GPIO1_IO02__USB_OTG1_ID			  0x0008 0x0038 0x0734 0x7 0x3
+#define MX7D_PAD_GPIO1_IO03__GPIO1_IO3				  0x000C 0x003C 0x0000 0x0 0x0
+#define MX7D_PAD_GPIO1_IO03__PWM3_OUT				  0x000C 0x003C 0x0000 0x1 0x0
+#define MX7D_PAD_GPIO1_IO03__CCM_ENET_REF_CLK2			  0x000C 0x003C 0x0570 0x2 0x3
+#define MX7D_PAD_GPIO1_IO03__SAI3_MCLK				  0x000C 0x003C 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO03__CCM_CLKO2				  0x000C 0x003C 0x0000 0x5 0x0
+#define MX7D_PAD_GPIO1_IO03__OBSERVE2_OUT			  0x000C 0x003C 0x0000 0x6 0x0
+#define MX7D_PAD_GPIO1_IO03__USB_OTG2_ID			  0x000C 0x003C 0x0730 0x7 0x3
+#define MX7D_PAD_GPIO1_IO04__GPIO1_IO4				  0x0010 0x0040 0x0000 0x0 0x0
+#define MX7D_PAD_GPIO1_IO04__USB_OTG1_OC			  0x0010 0x0040 0x072C 0x1 0x1
+#define MX7D_PAD_GPIO1_IO04__FLEXTIMER1_CH4			  0x0010 0x0040 0x0594 0x2 0x1
+#define MX7D_PAD_GPIO1_IO04__UART5_DCE_CTS			  0x0010 0x0040 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO04__UART5_DTE_RTS			  0x0010 0x0040 0x0710 0x3 0x4
+#define MX7D_PAD_GPIO1_IO04__I2C1_SCL				  0x0010 0x0040 0x05D4 0x4 0x2
+#define MX7D_PAD_GPIO1_IO04__OBSERVE3_OUT			  0x0010 0x0040 0x0000 0x6 0x0
+#define MX7D_PAD_GPIO1_IO05__GPIO1_IO5				  0x0014 0x0044 0x0000 0x0 0x0
+#define MX7D_PAD_GPIO1_IO05__USB_OTG1_PWR			  0x0014 0x0044 0x0000 0x1 0x0
+#define MX7D_PAD_GPIO1_IO05__FLEXTIMER1_CH5			  0x0014 0x0044 0x0598 0x2 0x1
+#define MX7D_PAD_GPIO1_IO05__UART5_DCE_RTS			  0x0014 0x0044 0x0710 0x3 0x5
+#define MX7D_PAD_GPIO1_IO05__UART5_DTE_CTS			  0x0014 0x0044 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO05__I2C1_SDA				  0x0014 0x0044 0x05D8 0x4 0x2
+#define MX7D_PAD_GPIO1_IO05__OBSERVE4_OUT			  0x0014 0x0044 0x0000 0x6 0x0
+#define MX7D_PAD_GPIO1_IO06__GPIO1_IO6				  0x0018 0x0048 0x0000 0x0 0x0
+#define MX7D_PAD_GPIO1_IO06__USB_OTG2_OC			  0x0018 0x0048 0x0728 0x1 0x1
+#define MX7D_PAD_GPIO1_IO06__FLEXTIMER1_CH6			  0x0018 0x0048 0x059C 0x2 0x1
+#define MX7D_PAD_GPIO1_IO06__UART5_DCE_RX			  0x0018 0x0048 0x0714 0x3 0x4
+#define MX7D_PAD_GPIO1_IO06__UART5_DTE_TX			  0x0018 0x0048 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO06__I2C2_SCL				  0x0018 0x0048 0x05DC 0x4 0x2
+#define MX7D_PAD_GPIO1_IO06__CCM_WAIT				  0x0018 0x0048 0x0000 0x5 0x0
+#define MX7D_PAD_GPIO1_IO06__KPP_ROW4				  0x0018 0x0048 0x0624 0x6 0x1
+#define MX7D_PAD_GPIO1_IO07__GPIO1_IO7				  0x001C 0x004C 0x0000 0x0 0x0
+#define MX7D_PAD_GPIO1_IO07__USB_OTG2_PWR			  0x001C 0x004C 0x0000 0x1 0x0
+#define MX7D_PAD_GPIO1_IO07__FLEXTIMER1_CH7			  0x001C 0x004C 0x05A0 0x2 0x1
+#define MX7D_PAD_GPIO1_IO07__UART5_DCE_TX			  0x001C 0x004C 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO07__UART5_DTE_RX			  0x001C 0x004C 0x0714 0x3 0x5
+#define MX7D_PAD_GPIO1_IO07__I2C2_SDA				  0x001C 0x004C 0x05E0 0x4 0x2
+#define MX7D_PAD_GPIO1_IO07__CCM_STOP				  0x001C 0x004C 0x0000 0x5 0x0
+#define MX7D_PAD_GPIO1_IO07__KPP_COL4				  0x001C 0x004C 0x0604 0x6 0x1
+
+#endif /* __DTS_IMX7D_PINFUNC_LPSR_H */
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index c4f12fd2e044..c138b0fb410a 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -46,6 +46,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "imx7d-pinfunc.h"
+#include "imx7d-pinfunc-lpsr.h"
 
 / {
 	#address-cells = <1>;
-- 
2.11.0
