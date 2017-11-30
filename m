From: tyler@opensourcefoundries.com (tyler at opensourcefoundries.com)
Date: Thu, 30 Nov 2017 12:14:27 -0800
Subject: [PATCH 1/8] ARM: dts: imx7d-sbc-iot: add initial iot gateway dts
In-Reply-To: <20171130201434.14122-1-tyler@opensourcefoundries.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
Message-ID: <20171130201434.14122-2-tyler@opensourcefoundries.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tyler Baker <tyler@opensourcefoundries.com>

The Compulab IoT Gateway is based on an NXP i.MX7D, dual core
Cortex-A7 clocking at 1GHz. It supports up to 2GB of DDR3,
and 32GB of eMMC flash. Onboard, there are two gigabit
ethernet controllers, 4 x USB2, RS485, and CAN.

This platform is based on the imx7d-cl-som-imx7 module but
includes a baseboard with additional peripherals
which is what this device tree is meant to describe.

This work has been derrived from the Compulab Linux sources
based on v4.1.

Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
---
 arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts | 238 +++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts

diff --git a/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
new file mode 100644
index 0000000..50dfdd3
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
@@ -0,0 +1,238 @@
+/*
+ * Support for CompuLab SBC-IOT-iMX7 Single Board Computer
+ *
+ * Copyright (C) 2017 CompuLab Ltd. - http://www.compulab.co.il/
+ * Author: Ilya Ledvich <ilya@compulab.co.il>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx7d-cl-som-imx7.dts"
+
+/ {
+	model = "CompuLab SBC-IOT-iMX7";
+	compatible = "compulab,sbc-iot-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
+
+	aliases {
+		lcdif = &lcdif;
+	};
+};
+
+&ecspi3 {
+	fsl,spi-num-chipselects = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3 &pinctrl_ecspi3_cs>;
+	cs-gpios = <&gpio4 11 0>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	eeprom_iot at 54 {
+		compatible = "atmel,24c08";
+		reg = <0x54>;
+		pagesize = <16>;
+	};
+
+	dvicape at 39 {
+		compatible = "sil164_simple";
+		reg = <0x39>;
+	};
+};
+
+&iomuxc {
+	pinctrl_xpen: xpengrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA13__GPIO3_IO18		0x34 /* P7-4 - gpio82 */
+			MX7D_PAD_LCD_DATA12__GPIO3_IO17		0x34 /* P7-5 - gpio81 */
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0xf /* P7-8 */
+			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0xf /* P7-7 */
+			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0xf /* P7-6 */
+		>;
+	};
+
+	pinctrl_ecspi3_cs: ecspi3_cs_grp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x34 /* P7-9 */
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO09__I2C3_SDA		0x4000000f /* P7-3 */
+			MX7D_PAD_GPIO1_IO08__I2C3_SCL		0x4000000f /* P7-2 */
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO11__I2C4_SDA		0x4000000f
+			MX7D_PAD_GPIO1_IO10__I2C4_SCL		0x4000000f
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdifdatgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+			MX7D_PAD_EPDC_DATA04__LCD_DATA4		0x79
+			MX7D_PAD_EPDC_DATA05__LCD_DATA5		0x79
+			MX7D_PAD_EPDC_DATA06__LCD_DATA6		0x79
+			MX7D_PAD_EPDC_DATA07__LCD_DATA7		0x79
+			MX7D_PAD_EPDC_DATA08__LCD_DATA8		0x79
+			MX7D_PAD_EPDC_DATA09__LCD_DATA9		0x79
+			MX7D_PAD_EPDC_DATA10__LCD_DATA10	0x79
+			MX7D_PAD_EPDC_DATA11__LCD_DATA11	0x79
+			MX7D_PAD_EPDC_DATA12__LCD_DATA12	0x79
+			MX7D_PAD_EPDC_DATA13__LCD_DATA13	0x79
+			MX7D_PAD_EPDC_DATA14__LCD_DATA14	0x79
+			MX7D_PAD_EPDC_DATA15__LCD_DATA15	0x79
+			MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+			MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+		>;
+	};
+
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA00__LCD_CLK		0x79
+			MX7D_PAD_EPDC_DATA01__LCD_ENABLE	0x79
+			MX7D_PAD_EPDC_DATA02__LCD_VSYNC		0x79
+			MX7D_PAD_EPDC_DATA03__LCD_HSYNC		0x79
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX7D_PAD_LCD_ENABLE__UART2_DCE_TX	0x79 /* P7-12 */
+			MX7D_PAD_LCD_CLK__UART2_DCE_RX		0x79 /* P7-13 */
+			MX7D_PAD_LCD_VSYNC__UART2_DCE_CTS	0x79 /* P7-11 */
+			MX7D_PAD_LCD_HSYNC__UART2_DCE_RTS	0x79 /* P7-10 */
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79 /* RS232-TX */
+			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79 /* RS232-RX */
+			MX7D_PAD_I2C3_SDA__UART5_DCE_RTS	0x79 /* RS232-RTS */
+			MX7D_PAD_I2C3_SCL__UART5_DCE_CTS	0x79 /* RS232-CTS */
+		>;
+	};
+
+	pinctrl_uart7: uart7grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI2_MOSI__UART7_DCE_TX	0x79 /* R485-TX */
+			MX7D_PAD_ECSPI2_SCLK__UART7_DCE_RX	0x79 /* R485-RX */
+			MX7D_PAD_ECSPI2_SS0__UART7_DCE_CTS	0x79 /* R485-CTS */
+			MX7D_PAD_ECSPI2_MISO__UART7_DCE_RTS	0x79 /* R485-TTS */
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
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
+		>;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display {
+		bits-per-pixel = <24>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: dvi {
+				/* 1024x768p60 */
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				hfront-porch = <40>;
+				hback-porch = <220>;
+				hsync-len = <60>;
+				vactive = <768>;
+				vfront-porch = <7>;
+				vback-porch = <21>;
+				vsync-len = <10>;
+
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	enable-sdio-wakeup;
+	status = "okay";
+};
-- 
2.9.3
