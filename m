From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 8 Nov 2016 13:56:52 +0800
Subject: [PATCH v2 1/3] ARM: imx6ull: add imx6ull support
In-Reply-To: <1478584614-12054-1-git-send-email-peter.chen@nxp.com>
References: <1478584614-12054-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1478584614-12054-2-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is the 10th processor in the well-known imx6 series, and derived
from imx6ul but cost optimized. The more information about imx6ull
can be found at:

http://www.nxp.com/products/microcontrollers-and-processors/
arm-processors/i.mx-applications-processors/i.mx-6-processors
/i.mx6qp/i.mx-6ull-single-core-processor-with-arm-cortex-a7-core
:i.MX6ULL

In this patch, for SoC part, the imx6ull.dtsi includes imx6ul.dtsi;
for board part (imx6ul/imx6ull 14x14 evk), it has a common board
file imx6u-14x14-evk.dtsi, and this file is included by both
imx6ul-14x14-evk.dts and imx6ull-14x14-evk.dts.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/Makefile              |   3 +-
 arch/arm/boot/dts/imx6u-14x14-evk.dtsi  | 487 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-14x14-evk.dts  | 479 +------------------------------
 arch/arm/boot/dts/imx6ull-14x14-evk.dts |  55 ++++
 arch/arm/boot/dts/imx6ull-pinfunc.h     |  56 ++++
 arch/arm/boot/dts/imx6ull.dtsi          |  43 +++
 6 files changed, 644 insertions(+), 479 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6u-14x14-evk.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6ull.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..3d6e199 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -423,7 +423,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-pico-hobbit.dtb \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
-	imx6ul-tx6ul-mainboard.dtb
+	imx6ul-tx6ul-mainboard.dtb \
+	imx6ull-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6u-14x14-evk.dtsi b/arch/arm/boot/dts/imx6u-14x14-evk.dtsi
new file mode 100644
index 0000000..c80a214
--- /dev/null
+++ b/arch/arm/boot/dts/imx6u-14x14-evk.dtsi
@@ -0,0 +1,487 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_sd1_vmmc: sd1_regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "VSD_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "mx6ul-wm8960";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Line", "Line In",
+			"Line", "Line Out",
+			"Speaker", "Speaker",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Speaker", "SPK_LP",
+			"Speaker", "SPK_LN",
+			"Speaker", "SPK_RP",
+			"Speaker", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"LINPUT3", "Mic Jack",
+			"RINPUT1", "Mic Jack",
+			"RINPUT2", "Mic Jack";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&codec>;
+			clocks = <&clks IMX6UL_CLK_SAI2>;
+		};
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <786432000>;
+};
+
+&cpu0 {
+	arm-supply = <&reg_arm>;
+	soc-supply = <&reg_soc>;
+};
+
+&i2c2 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	codec: wm8960 at 1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		wlf,shared-lrclk;
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy at 2 {
+			reg = <2>;
+		};
+
+		ethphy1: ethernet-phy at 1 {
+			reg = <1>;
+		};
+	};
+};
+
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display {
+		bits-per-pixel = <16>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+
+			timing0: timing0 {
+				clock-frequency = <9200000>;
+				hactive = <480>;
+				vactive = <272>;
+				hfront-porch = <8>;
+				hback-porch = <4>;
+				hsync-len = <41>;
+				vback-porch = <2>;
+				vfront-porch = <4>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi>;
+	status = "okay";
+
+	flash0: n25q256a at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a";
+		spi-max-frequency = <29000000>;
+		reg = <0>;
+	};
+};
+
+&sai2 {
+	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
+			  <&clks IMX6UL_CLK_SAI2>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <0>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "disabled";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&tsc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tsc>;
+	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	measure-delay-time = <0xffff>;
+	pre-charge-time = <0xfff>;
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
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <106>;
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <106>;
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+	keep-power-in-suspend;
+	wakeup-source;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+
+	pinctrl_csi1: csi1grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_MCLK__CSI_MCLK		0x1b088
+			MX6UL_PAD_CSI_PIXCLK__CSI_PIXCLK	0x1b088
+			MX6UL_PAD_CSI_VSYNC__CSI_VSYNC		0x1b088
+			MX6UL_PAD_CSI_HSYNC__CSI_HSYNC		0x1b088
+			MX6UL_PAD_CSI_DATA00__CSI_DATA02	0x1b088
+			MX6UL_PAD_CSI_DATA01__CSI_DATA03	0x1b088
+			MX6UL_PAD_CSI_DATA02__CSI_DATA04	0x1b088
+			MX6UL_PAD_CSI_DATA03__CSI_DATA05	0x1b088
+			MX6UL_PAD_CSI_DATA04__CSI_DATA06	0x1b088
+			MX6UL_PAD_CSI_DATA05__CSI_DATA07	0x1b088
+			MX6UL_PAD_CSI_DATA06__CSI_DATA08	0x1b088
+			MX6UL_PAD_CSI_DATA07__CSI_DATA09	0x1b088
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+		>;
+	};
+
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
+			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x17059
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp{
+		fsl,pins = <
+			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
+			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp{
+		fsl,pins = <
+			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
+			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL 0x4001b8b0
+			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA 0x4001b8b0
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdifdatgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00  0x79
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01  0x79
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02  0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03  0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04  0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05  0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06  0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07  0x79
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08  0x79
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09  0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10  0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11  0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12  0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13  0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14  0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15  0x79
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16  0x79
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17  0x79
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18  0x79
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19  0x79
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20  0x79
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21  0x79
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22  0x79
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23  0x79
+		>;
+	};
+
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK	    0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE  0x79
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC    0x79
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC    0x79
+			/* used for lcd reset */
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09  0x79
+		>;
+	};
+
+	pinctrl_qspi: qspigrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_WP_B__QSPI_A_SCLK	0x70a1
+			MX6UL_PAD_NAND_READY_B__QSPI_A_DATA00	0x70a1
+			MX6UL_PAD_NAND_CE0_B__QSPI_A_DATA01	0x70a1
+			MX6UL_PAD_NAND_CE1_B__QSPI_A_DATA02	0x70a1
+			MX6UL_PAD_NAND_CLE__QSPI_A_DATA03	0x70a1
+			MX6UL_PAD_NAND_DQS__QSPI_A_SS0_B	0x70a1
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO08__PWM1_OUT   0x110b0
+		>;
+	};
+
+	pinctrl_sim2: sim2grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA03__SIM2_PORT1_PD		0xb808
+			MX6UL_PAD_CSI_DATA04__SIM2_PORT1_CLK		0x31
+			MX6UL_PAD_CSI_DATA05__SIM2_PORT1_RST_B		0xb808
+			MX6UL_PAD_CSI_DATA06__SIM2_PORT1_SVEN		0xb808
+			MX6UL_PAD_CSI_DATA07__SIM2_PORT1_TRXD		0xb809
+			MX6UL_PAD_CSI_DATA02__GPIO4_IO23		0x3008
+		>;
+	};
+
+	pinctrl_tsc: tscgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01		0xb0
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02		0xb0
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0xb0
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04		0xb0
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX 0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX 0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART3_RX_DATA__UART2_DCE_RTS	0x1b0b1
+			MX6UL_PAD_UART3_TX_DATA__UART2_DCE_CTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD     	0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK     	0x10059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0 	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1 	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2 	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 	0x17059
+			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19       0x17059 /* SD1 CD */
+			MX6UL_PAD_GPIO1_IO05__USDHC1_VSELECT    0x17059 /* SD1 VSELECT */
+			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09        0x17059 /* SD1 RESET */
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0 0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1 0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2 0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x170b9
+
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0 0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1 0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2 0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x170f9
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK     0x17059
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD     0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0 0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1 0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2 0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3 0x17059
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 1867c69..f423f0c 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -9,486 +9,9 @@
 /dts-v1/;
 
 #include "imx6ul.dtsi"
+#include "imx6u-14x14-evk.dtsi"
 
 / {
 	model = "Freescale i.MX6 UltraLite 14x14 EVK Board";
 	compatible = "fsl,imx6ul-14x14-evk", "fsl,imx6ul";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	memory {
-		reg = <0x80000000 0x20000000>;
-	};
-
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-		status = "okay";
-	};
-
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_sd1_vmmc: sd1_regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "VSD_3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "mx6ul-wm8960";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&dailink_master>;
-		simple-audio-card,frame-master = <&dailink_master>;
-		simple-audio-card,widgets =
-			"Microphone", "Mic Jack",
-			"Line", "Line In",
-			"Line", "Line Out",
-			"Speaker", "Speaker",
-			"Headphone", "Headphone Jack";
-		simple-audio-card,routing =
-			"Headphone Jack", "HP_L",
-			"Headphone Jack", "HP_R",
-			"Speaker", "SPK_LP",
-			"Speaker", "SPK_LN",
-			"Speaker", "SPK_RP",
-			"Speaker", "SPK_RN",
-			"LINPUT1", "Mic Jack",
-			"LINPUT3", "Mic Jack",
-			"RINPUT1", "Mic Jack",
-			"RINPUT2", "Mic Jack";
-
-		simple-audio-card,cpu {
-			sound-dai = <&sai2>;
-		};
-
-		dailink_master: simple-audio-card,codec {
-			sound-dai = <&codec>;
-			clocks = <&clks IMX6UL_CLK_SAI2>;
-		};
-	};
-};
-
-&clks {
-	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
-	assigned-clock-rates = <786432000>;
-};
-
-&cpu0 {
-	arm-supply = <&reg_arm>;
-	soc-supply = <&reg_soc>;
-};
-
-&i2c2 {
-	clock_frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	codec: wm8960 at 1a {
-		#sound-dai-cells = <0>;
-		compatible = "wlf,wm8960";
-		reg = <0x1a>;
-		wlf,shared-lrclk;
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy0>;
-	status = "okay";
-};
-
-&fec2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet2>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy at 2 {
-			reg = <2>;
-		};
-
-		ethphy1: ethernet-phy at 1 {
-			reg = <1>;
-		};
-	};
-};
-
-
-&lcdif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lcdif_dat
-		     &pinctrl_lcdif_ctrl>;
-	display = <&display0>;
-	status = "okay";
-
-	display0: display {
-		bits-per-pixel = <16>;
-		bus-width = <24>;
-
-		display-timings {
-			native-mode = <&timing0>;
-
-			timing0: timing0 {
-				clock-frequency = <9200000>;
-				hactive = <480>;
-				vactive = <272>;
-				hfront-porch = <8>;
-				hback-porch = <4>;
-				hsync-len = <41>;
-				vback-porch = <2>;
-				vfront-porch = <4>;
-				vsync-len = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
-		};
-	};
-};
-
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1>;
-	status = "okay";
-};
-
-&qspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi>;
-	status = "okay";
-
-	flash0: n25q256a at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "micron,n25q256a";
-		spi-max-frequency = <29000000>;
-		reg = <0>;
-	};
-};
-
-&sai2 {
-	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
-			  <&clks IMX6UL_CLK_SAI2>;
-	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
-	assigned-clock-rates = <0>, <12288000>;
-	fsl,sai-mclk-direction-output;
-	status = "disabled";
-};
-
-&snvs_poweroff {
-	status = "okay";
-};
-
-&tsc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_tsc>;
-	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
-	measure-delay-time = <0xffff>;
-	pre-charge-time = <0xfff>;
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbotg2 {
-	dr_mode = "host";
-	disable-over-current;
-	status = "okay";
-};
-
-&usbphy1 {
-	fsl,tx-d-cal = <106>;
-};
-
-&usbphy2 {
-	fsl,tx-d-cal = <106>;
-};
-
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
-	keep-power-in-suspend;
-	wakeup-source;
-	vmmc-supply = <&reg_sd1_vmmc>;
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	no-1-8-v;
-	keep-power-in-suspend;
-	wakeup-source;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-
-	pinctrl_csi1: csi1grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_MCLK__CSI_MCLK		0x1b088
-			MX6UL_PAD_CSI_PIXCLK__CSI_PIXCLK	0x1b088
-			MX6UL_PAD_CSI_VSYNC__CSI_VSYNC		0x1b088
-			MX6UL_PAD_CSI_HSYNC__CSI_HSYNC		0x1b088
-			MX6UL_PAD_CSI_DATA00__CSI_DATA02	0x1b088
-			MX6UL_PAD_CSI_DATA01__CSI_DATA03	0x1b088
-			MX6UL_PAD_CSI_DATA02__CSI_DATA04	0x1b088
-			MX6UL_PAD_CSI_DATA03__CSI_DATA05	0x1b088
-			MX6UL_PAD_CSI_DATA04__CSI_DATA06	0x1b088
-			MX6UL_PAD_CSI_DATA05__CSI_DATA07	0x1b088
-			MX6UL_PAD_CSI_DATA06__CSI_DATA08	0x1b088
-			MX6UL_PAD_CSI_DATA07__CSI_DATA09	0x1b088
-		>;
-	};
-
-	pinctrl_enet1: enet1grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
-			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
-			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
-			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
-			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
-			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
-		>;
-	};
-
-	pinctrl_enet2: enet2grp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
-			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
-			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
-			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
-			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
-			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
-			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
-			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
-			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x17059
-		>;
-	};
-
-	pinctrl_flexcan1: flexcan1grp{
-		fsl,pins = <
-			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
-			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
-		>;
-	};
-
-	pinctrl_flexcan2: flexcan2grp{
-		fsl,pins = <
-			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
-			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
-			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL 0x4001b8b0
-			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA 0x4001b8b0
-		>;
-	};
-
-	pinctrl_lcdif_dat: lcdifdatgrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00  0x79
-			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01  0x79
-			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02  0x79
-			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03  0x79
-			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04  0x79
-			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05  0x79
-			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06  0x79
-			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07  0x79
-			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08  0x79
-			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09  0x79
-			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10  0x79
-			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11  0x79
-			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12  0x79
-			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13  0x79
-			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14  0x79
-			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15  0x79
-			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16  0x79
-			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17  0x79
-			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18  0x79
-			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19  0x79
-			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20  0x79
-			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21  0x79
-			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22  0x79
-			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23  0x79
-		>;
-	};
-
-	pinctrl_lcdif_ctrl: lcdifctrlgrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_CLK__LCDIF_CLK	    0x79
-			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE  0x79
-			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC    0x79
-			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC    0x79
-			/* used for lcd reset */
-			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09  0x79
-		>;
-	};
-
-	pinctrl_qspi: qspigrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_WP_B__QSPI_A_SCLK	0x70a1
-			MX6UL_PAD_NAND_READY_B__QSPI_A_DATA00	0x70a1
-			MX6UL_PAD_NAND_CE0_B__QSPI_A_DATA01	0x70a1
-			MX6UL_PAD_NAND_CE1_B__QSPI_A_DATA02	0x70a1
-			MX6UL_PAD_NAND_CLE__QSPI_A_DATA03	0x70a1
-			MX6UL_PAD_NAND_DQS__QSPI_A_SS0_B	0x70a1
-		>;
-	};
-
-	pinctrl_pwm1: pwm1grp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO08__PWM1_OUT   0x110b0
-		>;
-	};
-
-	pinctrl_sim2: sim2grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_DATA03__SIM2_PORT1_PD		0xb808
-			MX6UL_PAD_CSI_DATA04__SIM2_PORT1_CLK		0x31
-			MX6UL_PAD_CSI_DATA05__SIM2_PORT1_RST_B		0xb808
-			MX6UL_PAD_CSI_DATA06__SIM2_PORT1_SVEN		0xb808
-			MX6UL_PAD_CSI_DATA07__SIM2_PORT1_TRXD		0xb809
-			MX6UL_PAD_CSI_DATA02__GPIO4_IO23		0x3008
-		>;
-	};
-
-	pinctrl_tsc: tscgrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01		0xb0
-			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02		0xb0
-			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0xb0
-			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04		0xb0
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX 0x1b0b1
-			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX 0x1b0b1
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
-			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
-			MX6UL_PAD_UART3_RX_DATA__UART2_DCE_RTS	0x1b0b1
-			MX6UL_PAD_UART3_TX_DATA__UART2_DCE_CTS	0x1b0b1
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD     	0x17059
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK     	0x10059
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0 	0x17059
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1 	0x17059
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2 	0x17059
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 	0x17059
-			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19       0x17059 /* SD1 CD */
-			MX6UL_PAD_GPIO1_IO05__USDHC1_VSELECT    0x17059 /* SD1 VSELECT */
-			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09        0x17059 /* SD1 RESET */
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170b9
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100b9
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0 0x170b9
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1 0x170b9
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2 0x170b9
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x170b9
-
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD     0x170f9
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK     0x100f9
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0 0x170f9
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1 0x170f9
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2 0x170f9
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3 0x170f9
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK     0x17059
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD     0x17059
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0 0x17059
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1 0x17059
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2 0x17059
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3 0x17059
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
-		>;
-	};
 };
diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
new file mode 100644
index 0000000..992adde
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "imx6ull.dtsi"
+#include "imx6u-14x14-evk.dtsi"
+
+/ {
+	model = "Freescale i.MX6 UlltraLite 14x14 EVK Board";
+	compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6UL_CLK_PLL3_PFD2>;
+	assigned-clock-rates = <320000000>;
+};
diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
new file mode 100644
index 0000000..580b5c3
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __DTS_IMX6ULL_PINFUNC_H
+#define __DTS_IMX6ULL_PINFUNC_H
+
+#include "imx6ul-pinfunc.h"
+/*
+ * The pin function ID is a tuple of
+ * <mux_reg conf_reg input_reg mux_mode input_val>
+ */
+#define MX6ULL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET2_TX_DATA0__EPDC_SDDO11                    0x00F0 0x037C 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET2_TX_DATA1__EPDC_SDDO12                    0x00F4 0x0380 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET2_TX_EN__EPDC_SDDO13                       0x00F8 0x0384 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET2_TX_CLK__EPDC_SDDO14                      0x00FC 0x0388 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET2_RX_ER__EPDC_SDDO15                       0x0100 0x038C 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_CLK__EPDC_SDCLK                            0x0104 0x0390 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_ENABLE__EPDC_SDLE                          0x0108 0x0394 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_HSYNC__EPDC_SDOE                           0x010C 0x0398 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_VSYNC__EPDC_SDCE0                          0x0110 0x039C 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_RESET__EPDC_GDOE                           0x0114 0x03A0 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA00__EPDC_SDDO00                        0x0118 0x03A4 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA01__EPDC_SDDO01                        0x011C 0x03A8 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA02__EPDC_SDDO02                        0x0120 0x03AC 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA03__EPDC_SDDO03                        0x0124 0x03B0 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA04__EPDC_SDDO04                        0x0128 0x03B4 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA05__EPDC_SDDO05                        0x012C 0x03B8 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA06__EPDC_SDDO06                        0x0130 0x03BC 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA07__EPDC_SDDO07                        0x0134 0x03C0 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA14__EPDC_SDSHR                         0x0150 0x03DC 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA15__EPDC_GDRL                          0x0154 0x03E0 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA16__EPDC_GDCLK                         0x0158 0x03E4 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA17__EPDC_GDSP                          0x015C 0x03E8 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA21__EPDC_SDCE1                         0x016C 0x03F8 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_MCLK__ESAI_TX3_RX2                          0x01D4 0x0460 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_PIXCLK__ESAI_TX2_RX3                        0x01D8 0x0464 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_VSYNC__ESAI_TX4_RX1                         0x01DC 0x0468 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_HSYNC__ESAI_TX1                             0x01E0 0x046C 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_DATA00__ESAI_TX_HF_CLK                      0x01E4 0x0470 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_DATA01__ESAI_RX_HF_CLK                      0x01E8 0x0474 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_DATA02__ESAI_RX_FS                          0x01EC 0x0478 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_DATA03__ESAI_RX_CLK                         0x01F0 0x047C 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_DATA04__ESAI_TX_FS                          0x01F4 0x0480 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_DATA05__ESAI_TX_CLK                         0x01F8 0x0484 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_DATA06__ESAI_TX5_RX0                        0x01FC 0x0488 0x0000 0x9 0x0
+#define MX6ULL_PAD_CSI_DATA07__ESAI_T0                             0x0200 0x048C 0x0000 0x9 0x0
+
+#endif /* __DTS_IMX6ULL_PINFUNC_H */
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
new file mode 100644
index 0000000..dee8ab8
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "imx6ul.dtsi"
+#include "imx6ull-pinfunc.h"
-- 
2.7.4
