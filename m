From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 1 Nov 2016 11:02:21 +0800
Subject: [PATCH 1/3] ARM: imx6u: add imx6ull support
In-Reply-To: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
References: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1477969343-19887-2-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is the 10th processor in the well-known imx6 series, and derived
from imx6ul but cost optimized. The more information about imx6ull
can be found at:

http://www.nxp.com/products/microcontrollers-and-processors/
arm-processors/i.mx-applications-processors/i.mx-6-processors
/i.mx6qp/i.mx-6ull-single-core-processor-with-arm-cortex-a7-core
:i.MX6ULL

In this patch, it moves common dts between imx6ul* and imx6ull* as
new files named imx6u*, and the specific part for imx6ul and imx6ull
are individual file.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/Makefile              |   3 +-
 arch/arm/boot/dts/imx6u-14x14-evk.dts   | 475 ++++++++++++++++
 arch/arm/boot/dts/imx6u-14x14-evk.dtsi  | 487 +++++++++++++++++
 arch/arm/boot/dts/imx6u.dtsi            | 942 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-14x14-evk.dts  | 479 +---------------
 arch/arm/boot/dts/imx6ul.dtsi           | 936 +------------------------------
 arch/arm/boot/dts/imx6ull-14x14-evk.dts |  17 +
 arch/arm/boot/dts/imx6ull-pinfunc.h     |  57 ++
 arch/arm/boot/dts/imx6ull.dtsi          |  10 +
 9 files changed, 1993 insertions(+), 1413 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6u-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6u-14x14-evk.dtsi
 create mode 100644 arch/arm/boot/dts/imx6u.dtsi
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
diff --git a/arch/arm/boot/dts/imx6u-14x14-evk.dts b/arch/arm/boot/dts/imx6u-14x14-evk.dts
new file mode 100644
index 0000000..ba8614c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6u-14x14-evk.dts
@@ -0,0 +1,475 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
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
diff --git a/arch/arm/boot/dts/imx6u.dtsi b/arch/arm/boot/dts/imx6u.dtsi
new file mode 100644
index 0000000..c5c05fd
--- /dev/null
+++ b/arch/arm/boot/dts/imx6u.dtsi
@@ -0,0 +1,942 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/clock/imx6ul-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "imx6ul-pinfunc.h"
+#include "skeleton.dtsi"
+
+/ {
+	aliases {
+		ethernet0 = &fec1;
+		ethernet1 = &fec2;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &i2c1;
+		i2c1 = &i2c2;
+		i2c2 = &i2c3;
+		i2c3 = &i2c4;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		serial5 = &uart6;
+		serial6 = &uart7;
+		serial7 = &uart8;
+		sai1 = &sai1;
+		sai2 = &sai2;
+		sai3 = &sai3;
+		spi0 = &ecspi1;
+		spi1 = &ecspi2;
+		spi2 = &ecspi3;
+		spi3 = &ecspi4;
+		usbphy0 = &usbphy1;
+		usbphy1 = &usbphy2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <0>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			operating-points = <
+				/* kHz	uV */
+				528000	1175000
+				396000	1025000
+				198000	950000
+			>;
+			fsl,soc-operating-points = <
+				/* KHz	uV */
+				528000	1175000
+				396000	1175000
+				198000	1175000
+			>;
+			clocks = <&clks IMX6UL_CLK_ARM>,
+				 <&clks IMX6UL_CLK_PLL2_BUS>,
+				 <&clks IMX6UL_CLK_PLL2_PFD2>,
+				 <&clks IMX6UL_CA7_SECONDARY_SEL>,
+				 <&clks IMX6UL_CLK_STEP>,
+				 <&clks IMX6UL_CLK_PLL1_SW>,
+				 <&clks IMX6UL_CLK_PLL1_SYS>,
+				 <&clks IMX6UL_PLL1_BYPASS>,
+				 <&clks IMX6UL_CLK_PLL1>,
+				 <&clks IMX6UL_PLL1_BYPASS_SRC>,
+				 <&clks IMX6UL_CLK_OSC>;
+			clock-names = "arm", "pll2_bus",  "pll2_pfd2_396m",
+				      "secondary_sel", "step", "pll1_sw",
+				      "pll1_sys", "pll1_bypass", "pll1",
+				      "pll1_bypass_src", "osc";
+			arm-supply = <&reg_arm>;
+			soc-supply = <&reg_soc>;
+		};
+	};
+
+	intc: interrupt-controller at 00a01000 {
+		compatible = "arm,cortex-a7-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x00a01000 0x1000>,
+		      <0x00a02000 0x1000>,
+		      <0x00a04000 0x2000>,
+		      <0x00a06000 0x2000>;
+	};
+
+	ckil: clock-cli {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ckil";
+	};
+
+	osc: clock-osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc";
+	};
+
+	ipp_di0: clock-di0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "ipp_di0";
+	};
+
+	ipp_di1: clock-di1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "ipp_di1";
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gpc>;
+		ranges;
+
+		pmu {
+			compatible = "arm,cortex-a7-pmu";
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		ocram: sram at 00900000 {
+			compatible = "mmio-sram";
+			reg = <0x00900000 0x20000>;
+		};
+
+		dma_apbh: dma-apbh at 01804000 {
+			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
+			reg = <0x01804000 0x2000>;
+			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
+			#dma-cells = <1>;
+			dma-channels = <4>;
+			clocks = <&clks IMX6UL_CLK_APBHDMA>;
+		};
+
+		gpmi: gpmi-nand at 01806000         {
+			compatible = "fsl,imx6q-gpmi-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x01806000 0x2000>, <0x01808000 0x2000>;
+			reg-names = "gpmi-nand", "bch";
+			interrupts = <0 15 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "bch";
+			clocks = <&clks IMX6UL_CLK_GPMI_IO>,
+				 <&clks IMX6UL_CLK_GPMI_APB>,
+				 <&clks IMX6UL_CLK_GPMI_BCH>,
+				 <&clks IMX6UL_CLK_GPMI_BCH_APB>,
+				 <&clks IMX6UL_CLK_PER_BCH>;
+			clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
+				      "gpmi_bch_apb", "per1_bch";
+			dmas = <&dma_apbh 0>;
+			dma-names = "rx-tx";
+			status = "disabled";
+		};
+
+		aips1: aips-bus at 02000000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x02000000 0x100000>;
+			ranges;
+
+			spba-bus at 02000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x02000000 0x40000>;
+				ranges;
+
+				ecspi1: ecspi at 02008000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
+					reg = <0x02008000 0x4000>;
+					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_ECSPI1>,
+						 <&clks IMX6UL_CLK_ECSPI1>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+
+				ecspi2: ecspi at 0200c000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
+					reg = <0x0200c000 0x4000>;
+					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_ECSPI2>,
+						 <&clks IMX6UL_CLK_ECSPI2>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+
+				ecspi3: ecspi at 02010000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
+					reg = <0x02010000 0x4000>;
+					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_ECSPI3>,
+						 <&clks IMX6UL_CLK_ECSPI3>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+
+				ecspi4: ecspi at 02014000 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
+					reg = <0x02014000 0x4000>;
+					interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_ECSPI4>,
+						 <&clks IMX6UL_CLK_ECSPI4>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+
+				uart7: serial at 02018000 {
+					compatible = "fsl,imx6ul-uart",
+						     "fsl,imx6q-uart";
+					reg = <0x02018000 0x4000>;
+					interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_UART7_IPG>,
+						 <&clks IMX6UL_CLK_UART7_SERIAL>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+
+				uart1: serial at 02020000 {
+					compatible = "fsl,imx6ul-uart",
+						     "fsl,imx6q-uart";
+					reg = <0x02020000 0x4000>;
+					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_UART1_IPG>,
+						 <&clks IMX6UL_CLK_UART1_SERIAL>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+
+				uart8: serial at 02024000 {
+					compatible = "fsl,imx6ul-uart",
+						     "fsl,imx6q-uart";
+					reg = <0x02024000 0x4000>;
+					interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_UART8_IPG>,
+						 <&clks IMX6UL_CLK_UART8_SERIAL>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
+
+				sai1: sai at 02028000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
+					reg = <0x02028000 0x4000>;
+					interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_SAI1_IPG>,
+						 <&clks IMX6UL_CLK_SAI1>,
+						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma 35 24 0>,
+					       <&sdma 36 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai2: sai at 0202c000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
+					reg = <0x0202c000 0x4000>;
+					interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_SAI2_IPG>,
+						 <&clks IMX6UL_CLK_SAI2>,
+						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma 37 24 0>,
+					       <&sdma 38 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai3: sai at 02030000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
+					reg = <0x02030000 0x4000>;
+					interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_SAI3_IPG>,
+						 <&clks IMX6UL_CLK_SAI3>,
+						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma 39 24 0>,
+					       <&sdma 40 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+			};
+
+			tsc: tsc at 02040000 {
+				compatible = "fsl,imx6ul-tsc";
+				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_IPG>,
+					 <&clks IMX6UL_CLK_ADC2>;
+				clock-names = "tsc", "adc";
+				status = "disabled";
+			};
+
+			pwm1: pwm at 02080000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x02080000 0x4000>;
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM1>,
+					 <&clks IMX6UL_CLK_PWM1>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm2: pwm at 02084000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x02084000 0x4000>;
+				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM2>,
+					 <&clks IMX6UL_CLK_PWM2>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm3: pwm at 02088000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x02088000 0x4000>;
+				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM3>,
+					 <&clks IMX6UL_CLK_PWM3>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm4: pwm at 0208c000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x0208c000 0x4000>;
+				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM4>,
+					 <&clks IMX6UL_CLK_PWM4>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			can1: flexcan at 02090000 {
+				compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
+				reg = <0x02090000 0x4000>;
+				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_CAN1_IPG>,
+					 <&clks IMX6UL_CLK_CAN1_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			can2: flexcan at 02094000 {
+				compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
+				reg = <0x02094000 0x4000>;
+				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_CAN2_IPG>,
+					 <&clks IMX6UL_CLK_CAN2_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			gpt1: gpt at 02098000 {
+				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
+				reg = <0x02098000 0x4000>;
+				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPT1_BUS>,
+					 <&clks IMX6UL_CLK_GPT1_SERIAL>;
+				clock-names = "ipg", "per";
+			};
+
+			gpio1: gpio at 0209c000 {
+				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
+				reg = <0x0209c000 0x4000>;
+				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc  0 23 10>, <&iomuxc 10 17 6>,
+					      <&iomuxc 16 33 16>;
+			};
+
+			gpio2: gpio at 020a0000 {
+				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
+				reg = <0x020a0000 0x4000>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 49 16>, <&iomuxc 16 111 6>;
+			};
+
+			gpio3: gpio at 020a4000 {
+				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
+				reg = <0x020a4000 0x4000>;
+				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 65 29>;
+			};
+
+			gpio4: gpio at 020a8000 {
+				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
+				reg = <0x020a8000 0x4000>;
+				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 94 17>, <&iomuxc 17 117 12>;
+			};
+
+			gpio5: gpio at 020ac000 {
+				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
+				reg = <0x020ac000 0x4000>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 7 10>, <&iomuxc 10 5 2>;
+			};
+
+			fec2: ethernet at 020b4000 {
+				compatible = "fsl,imx6ul-fec", "fsl,imx6q-fec";
+				reg = <0x020b4000 0x4000>;
+				interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_ENET>,
+					 <&clks IMX6UL_CLK_ENET_AHB>,
+					 <&clks IMX6UL_CLK_ENET_PTP>,
+					 <&clks IMX6UL_CLK_ENET2_REF_125M>,
+					 <&clks IMX6UL_CLK_ENET2_REF_125M>;
+				clock-names = "ipg", "ahb", "ptp",
+					      "enet_clk_ref", "enet_out";
+				fsl,num-tx-queues=<1>;
+				fsl,num-rx-queues=<1>;
+				status = "disabled";
+			};
+
+			kpp: kpp at 020b8000 {
+				compatible = "fsl,imx6ul-kpp", "fsl,imx6q-kpp", "fsl,imx21-kpp";
+				reg = <0x020b8000 0x4000>;
+				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_KPP>;
+				status = "disabled";
+			};
+
+			wdog1: wdog at 020bc000 {
+				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
+				reg = <0x020bc000 0x4000>;
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_WDOG1>;
+			};
+
+			wdog2: wdog at 020c0000 {
+				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
+				reg = <0x020c0000 0x4000>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_WDOG2>;
+				status = "disabled";
+			};
+
+			clks: ccm at 020c4000 {
+				compatible = "fsl,imx6ul-ccm";
+				reg = <0x020c4000 0x4000>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				#clock-cells = <1>;
+				clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>;
+				clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
+			};
+
+			anatop: anatop at 020c8000 {
+				compatible = "fsl,imx6ul-anatop", "fsl,imx6q-anatop",
+					     "syscon", "simple-bus";
+				reg = <0x020c8000 0x1000>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+
+				reg_3p0: regulator-3p0 {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vdd3p0";
+					regulator-min-microvolt = <2625000>;
+					regulator-max-microvolt = <3400000>;
+					anatop-reg-offset = <0x120>;
+					anatop-vol-bit-shift = <8>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <0>;
+					anatop-min-voltage = <2625000>;
+					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
+				};
+
+				reg_arm: regulator-vddcore {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "cpu";
+					regulator-min-microvolt = <725000>;
+					regulator-max-microvolt = <1450000>;
+					regulator-always-on;
+					anatop-reg-offset = <0x140>;
+					anatop-vol-bit-shift = <0>;
+					anatop-vol-bit-width = <5>;
+					anatop-delay-reg-offset = <0x170>;
+					anatop-delay-bit-shift = <24>;
+					anatop-delay-bit-width = <2>;
+					anatop-min-bit-val = <1>;
+					anatop-min-voltage = <725000>;
+					anatop-max-voltage = <1450000>;
+				};
+
+				reg_soc: regulator-vddsoc {
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vddsoc";
+					regulator-min-microvolt = <725000>;
+					regulator-max-microvolt = <1450000>;
+					regulator-always-on;
+					anatop-reg-offset = <0x140>;
+					anatop-vol-bit-shift = <18>;
+					anatop-vol-bit-width = <5>;
+					anatop-delay-reg-offset = <0x170>;
+					anatop-delay-bit-shift = <28>;
+					anatop-delay-bit-width = <2>;
+					anatop-min-bit-val = <1>;
+					anatop-min-voltage = <725000>;
+					anatop-max-voltage = <1450000>;
+				};
+			};
+
+			usbphy1: usbphy at 020c9000 {
+				compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
+				reg = <0x020c9000 0x1000>;
+				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_USBPHY1>;
+				phy-3p0-supply = <&reg_3p0>;
+				fsl,anatop = <&anatop>;
+			};
+
+			usbphy2: usbphy at 020ca000 {
+				compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
+				reg = <0x020ca000 0x1000>;
+				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_USBPHY2>;
+				phy-3p0-supply = <&reg_3p0>;
+				fsl,anatop = <&anatop>;
+			};
+
+			snvs: snvs at 020cc000 {
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x020cc000 0x4000>;
+
+				snvs_rtc: snvs-rtc-lp {
+					compatible = "fsl,sec-v4.0-mon-rtc-lp";
+					regmap = <&snvs>;
+					offset = <0x34>;
+					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				snvs_poweroff: snvs-poweroff {
+					compatible = "syscon-poweroff";
+					regmap = <&snvs>;
+					offset = <0x38>;
+					mask = <0x60>;
+					status = "disabled";
+				};
+
+				snvs_pwrkey: snvs-powerkey {
+					compatible = "fsl,sec-v4.0-pwrkey";
+					regmap = <&snvs>;
+					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+					linux,keycode = <KEY_POWER>;
+					wakeup-source;
+				};
+			};
+
+			epit1: epit at 020d0000 {
+				reg = <0x020d0000 0x4000>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			epit2: epit at 020d4000 {
+				reg = <0x020d4000 0x4000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			src: src at 020d8000 {
+				compatible = "fsl,imx6ul-src", "fsl,imx51-src";
+				reg = <0x020d8000 0x4000>;
+				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				#reset-cells = <1>;
+			};
+
+			gpc: gpc at 020dc000 {
+				compatible = "fsl,imx6ul-gpc", "fsl,imx6q-gpc";
+				reg = <0x020dc000 0x4000>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
+				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&intc>;
+			};
+
+			iomuxc: iomuxc at 020e0000 {
+				compatible = "fsl,imx6ul-iomuxc";
+				reg = <0x020e0000 0x4000>;
+			};
+
+			gpr: iomuxc-gpr at 020e4000 {
+				compatible = "fsl,imx6ul-iomuxc-gpr",
+					     "fsl,imx6q-iomuxc-gpr", "syscon";
+				reg = <0x020e4000 0x4000>;
+			};
+
+			gpt2: gpt at 020e8000 {
+				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
+				reg = <0x020e8000 0x4000>;
+				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_GPT2_BUS>,
+					 <&clks IMX6UL_CLK_GPT2_SERIAL>;
+				clock-names = "ipg", "per";
+			};
+
+			sdma: sdma at 020ec000 {
+				compatible = "fsl,imx6ul-sdma", "fsl,imx6q-sdma",
+					     "fsl,imx35-sdma";
+				reg = <0x020ec000 0x4000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_SDMA>,
+					 <&clks IMX6UL_CLK_SDMA>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
+			};
+
+			pwm5: pwm at 020f0000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x020f0000 0x4000>;
+				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM5>,
+					 <&clks IMX6UL_CLK_PWM5>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm6: pwm at 020f4000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x020f4000 0x4000>;
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM6>,
+					 <&clks IMX6UL_CLK_PWM6>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm7: pwm at 020f8000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x020f8000 0x4000>;
+				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM7>,
+					 <&clks IMX6UL_CLK_PWM7>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+
+			pwm8: pwm at 020fc000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x020fc000 0x4000>;
+				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_PWM8>,
+					 <&clks IMX6UL_CLK_PWM8>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+				status = "disabled";
+			};
+		};
+
+		aips2: aips-bus at 02100000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x02100000 0x100000>;
+			ranges;
+
+			usbotg1: usb at 02184000 {
+				compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
+				reg = <0x02184000 0x200>;
+				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_USBOH3>;
+				fsl,usbphy = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc 0>;
+				fsl,anatop = <&anatop>;
+				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
+				status = "disabled";
+			};
+
+			usbotg2: usb at 02184200 {
+				compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
+				reg = <0x02184200 0x200>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_USBOH3>;
+				fsl,usbphy = <&usbphy2>;
+				fsl,usbmisc = <&usbmisc 1>;
+				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x10>;
+				rx-burst-size-dword = <0x10>;
+				status = "disabled";
+			};
+
+			usbmisc: usbmisc at 02184800 {
+				#index-cells = <1>;
+				compatible = "fsl,imx6ul-usbmisc", "fsl,imx6q-usbmisc";
+				reg = <0x02184800 0x200>;
+			};
+
+			fec1: ethernet at 02188000 {
+				compatible = "fsl,imx6ul-fec", "fsl,imx6q-fec";
+				reg = <0x02188000 0x4000>;
+				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_ENET>,
+					 <&clks IMX6UL_CLK_ENET_AHB>,
+					 <&clks IMX6UL_CLK_ENET_PTP>,
+					 <&clks IMX6UL_CLK_ENET_REF>,
+					 <&clks IMX6UL_CLK_ENET_REF>;
+				clock-names = "ipg", "ahb", "ptp",
+					      "enet_clk_ref", "enet_out";
+				fsl,num-tx-queues=<1>;
+				fsl,num-rx-queues=<1>;
+				status = "disabled";
+			};
+
+			usdhc1: usdhc at 02190000 {
+				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
+				reg = <0x02190000 0x4000>;
+				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_USDHC1>,
+					 <&clks IMX6UL_CLK_USDHC1>,
+					 <&clks IMX6UL_CLK_USDHC1>;
+				clock-names = "ipg", "ahb", "per";
+				bus-width = <4>;
+				status = "disabled";
+			};
+
+			usdhc2: usdhc at 02194000 {
+				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
+				reg = <0x02194000 0x4000>;
+				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_USDHC2>,
+					 <&clks IMX6UL_CLK_USDHC2>,
+					 <&clks IMX6UL_CLK_USDHC2>;
+				clock-names = "ipg", "ahb", "per";
+				bus-width = <4>;
+				status = "disabled";
+			};
+
+			adc1: adc at 02198000 {
+				compatible = "fsl,imx6ul-adc", "fsl,vf610-adc";
+				reg = <0x02198000 0x4000>;
+				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_ADC1>;
+				num-channels = <2>;
+				clock-names = "adc";
+				fsl,adck-max-frequency = <30000000>, <40000000>,
+							 <20000000>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at 021a0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
+				reg = <0x021a0000 0x4000>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_I2C1>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at 021a4000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
+				reg = <0x021a4000 0x4000>;
+				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_I2C2>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 021a8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
+				reg = <0x021a8000 0x4000>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_I2C3>;
+				status = "disabled";
+			};
+
+			mmdc: mmdc at 021b0000 {
+				compatible = "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
+				reg = <0x021b0000 0x4000>;
+			};
+
+			lcdif: lcdif at 021c8000 {
+				compatible = "fsl,imx6ul-lcdif", "fsl,imx28-lcdif";
+				reg = <0x021c8000 0x4000>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
+					 <&clks IMX6UL_CLK_LCDIF_APB>,
+					 <&clks IMX6UL_CLK_DUMMY>;
+				clock-names = "pix", "axi", "disp_axi";
+				status = "disabled";
+			};
+
+			qspi: qspi at 021e0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6ul-qspi", "fsl,imx6sx-qspi";
+				reg = <0x021e0000 0x4000>, <0x60000000 0x10000000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_QSPI>,
+					 <&clks IMX6UL_CLK_QSPI>;
+				clock-names = "qspi_en", "qspi";
+				status = "disabled";
+			};
+
+			uart2: serial at 021e8000 {
+				compatible = "fsl,imx6ul-uart",
+					     "fsl,imx6q-uart";
+				reg = <0x021e8000 0x4000>;
+				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_UART2_IPG>,
+					 <&clks IMX6UL_CLK_UART2_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			uart3: serial at 021ec000 {
+				compatible = "fsl,imx6ul-uart",
+					     "fsl,imx6q-uart";
+				reg = <0x021ec000 0x4000>;
+				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_UART3_IPG>,
+					 <&clks IMX6UL_CLK_UART3_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			uart4: serial at 021f0000 {
+				compatible = "fsl,imx6ul-uart",
+					     "fsl,imx6q-uart";
+				reg = <0x021f0000 0x4000>;
+				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_UART4_IPG>,
+					 <&clks IMX6UL_CLK_UART4_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			uart5: serial at 021f4000 {
+				compatible = "fsl,imx6ul-uart",
+					     "fsl,imx6q-uart";
+				reg = <0x021f4000 0x4000>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_UART5_IPG>,
+					 <&clks IMX6UL_CLK_UART5_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+
+			i2c4: i2c at 021f8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
+				reg = <0x021f8000 0x4000>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_I2C4>;
+				status = "disabled";
+			};
+
+			uart6: serial at 021fc000 {
+				compatible = "fsl,imx6ul-uart",
+					     "fsl,imx6q-uart";
+				reg = <0x021fc000 0x4000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_UART6_IPG>,
+					 <&clks IMX6UL_CLK_UART6_SERIAL>;
+				clock-names = "ipg", "per";
+				status = "disabled";
+			};
+		};
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
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index c5c05fd..e3952c5 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -1,942 +1,10 @@
 /*
- * Copyright 2015 Freescale Semiconductor, Inc.
+ * Copyright 2016 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 
-#include <dt-bindings/clock/imx6ul-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "imx6u.dtsi"
 #include "imx6ul-pinfunc.h"
-#include "skeleton.dtsi"
-
-/ {
-	aliases {
-		ethernet0 = &fec1;
-		ethernet1 = &fec2;
-		gpio0 = &gpio1;
-		gpio1 = &gpio2;
-		gpio2 = &gpio3;
-		gpio3 = &gpio4;
-		gpio4 = &gpio5;
-		i2c0 = &i2c1;
-		i2c1 = &i2c2;
-		i2c2 = &i2c3;
-		i2c3 = &i2c4;
-		mmc0 = &usdhc1;
-		mmc1 = &usdhc2;
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
-		serial4 = &uart5;
-		serial5 = &uart6;
-		serial6 = &uart7;
-		serial7 = &uart8;
-		sai1 = &sai1;
-		sai2 = &sai2;
-		sai3 = &sai3;
-		spi0 = &ecspi1;
-		spi1 = &ecspi2;
-		spi2 = &ecspi3;
-		spi3 = &ecspi4;
-		usbphy0 = &usbphy1;
-		usbphy1 = &usbphy2;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu at 0 {
-			compatible = "arm,cortex-a7";
-			device_type = "cpu";
-			reg = <0>;
-			clock-latency = <61036>; /* two CLK32 periods */
-			operating-points = <
-				/* kHz	uV */
-				528000	1175000
-				396000	1025000
-				198000	950000
-			>;
-			fsl,soc-operating-points = <
-				/* KHz	uV */
-				528000	1175000
-				396000	1175000
-				198000	1175000
-			>;
-			clocks = <&clks IMX6UL_CLK_ARM>,
-				 <&clks IMX6UL_CLK_PLL2_BUS>,
-				 <&clks IMX6UL_CLK_PLL2_PFD2>,
-				 <&clks IMX6UL_CA7_SECONDARY_SEL>,
-				 <&clks IMX6UL_CLK_STEP>,
-				 <&clks IMX6UL_CLK_PLL1_SW>,
-				 <&clks IMX6UL_CLK_PLL1_SYS>,
-				 <&clks IMX6UL_PLL1_BYPASS>,
-				 <&clks IMX6UL_CLK_PLL1>,
-				 <&clks IMX6UL_PLL1_BYPASS_SRC>,
-				 <&clks IMX6UL_CLK_OSC>;
-			clock-names = "arm", "pll2_bus",  "pll2_pfd2_396m",
-				      "secondary_sel", "step", "pll1_sw",
-				      "pll1_sys", "pll1_bypass", "pll1",
-				      "pll1_bypass_src", "osc";
-			arm-supply = <&reg_arm>;
-			soc-supply = <&reg_soc>;
-		};
-	};
-
-	intc: interrupt-controller at 00a01000 {
-		compatible = "arm,cortex-a7-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x00a01000 0x1000>,
-		      <0x00a02000 0x1000>,
-		      <0x00a04000 0x2000>,
-		      <0x00a06000 0x2000>;
-	};
-
-	ckil: clock-cli {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "ckil";
-	};
-
-	osc: clock-osc {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24000000>;
-		clock-output-names = "osc";
-	};
-
-	ipp_di0: clock-di0 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-		clock-output-names = "ipp_di0";
-	};
-
-	ipp_di1: clock-di1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-		clock-output-names = "ipp_di1";
-	};
-
-	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		interrupt-parent = <&gpc>;
-		ranges;
-
-		pmu {
-			compatible = "arm,cortex-a7-pmu";
-			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		ocram: sram at 00900000 {
-			compatible = "mmio-sram";
-			reg = <0x00900000 0x20000>;
-		};
-
-		dma_apbh: dma-apbh at 01804000 {
-			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
-			reg = <0x01804000 0x2000>;
-			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 13 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 13 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 13 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
-			#dma-cells = <1>;
-			dma-channels = <4>;
-			clocks = <&clks IMX6UL_CLK_APBHDMA>;
-		};
-
-		gpmi: gpmi-nand at 01806000         {
-			compatible = "fsl,imx6q-gpmi-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x01806000 0x2000>, <0x01808000 0x2000>;
-			reg-names = "gpmi-nand", "bch";
-			interrupts = <0 15 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "bch";
-			clocks = <&clks IMX6UL_CLK_GPMI_IO>,
-				 <&clks IMX6UL_CLK_GPMI_APB>,
-				 <&clks IMX6UL_CLK_GPMI_BCH>,
-				 <&clks IMX6UL_CLK_GPMI_BCH_APB>,
-				 <&clks IMX6UL_CLK_PER_BCH>;
-			clock-names = "gpmi_io", "gpmi_apb", "gpmi_bch",
-				      "gpmi_bch_apb", "per1_bch";
-			dmas = <&dma_apbh 0>;
-			dma-names = "rx-tx";
-			status = "disabled";
-		};
-
-		aips1: aips-bus at 02000000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x02000000 0x100000>;
-			ranges;
-
-			spba-bus at 02000000 {
-				compatible = "fsl,spba-bus", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0x02000000 0x40000>;
-				ranges;
-
-				ecspi1: ecspi at 02008000 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
-					reg = <0x02008000 0x4000>;
-					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_ECSPI1>,
-						 <&clks IMX6UL_CLK_ECSPI1>;
-					clock-names = "ipg", "per";
-					status = "disabled";
-				};
-
-				ecspi2: ecspi at 0200c000 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
-					reg = <0x0200c000 0x4000>;
-					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_ECSPI2>,
-						 <&clks IMX6UL_CLK_ECSPI2>;
-					clock-names = "ipg", "per";
-					status = "disabled";
-				};
-
-				ecspi3: ecspi at 02010000 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
-					reg = <0x02010000 0x4000>;
-					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_ECSPI3>,
-						 <&clks IMX6UL_CLK_ECSPI3>;
-					clock-names = "ipg", "per";
-					status = "disabled";
-				};
-
-				ecspi4: ecspi at 02014000 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					compatible = "fsl,imx6ul-ecspi", "fsl,imx51-ecspi";
-					reg = <0x02014000 0x4000>;
-					interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_ECSPI4>,
-						 <&clks IMX6UL_CLK_ECSPI4>;
-					clock-names = "ipg", "per";
-					status = "disabled";
-				};
-
-				uart7: serial at 02018000 {
-					compatible = "fsl,imx6ul-uart",
-						     "fsl,imx6q-uart";
-					reg = <0x02018000 0x4000>;
-					interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_UART7_IPG>,
-						 <&clks IMX6UL_CLK_UART7_SERIAL>;
-					clock-names = "ipg", "per";
-					status = "disabled";
-				};
-
-				uart1: serial at 02020000 {
-					compatible = "fsl,imx6ul-uart",
-						     "fsl,imx6q-uart";
-					reg = <0x02020000 0x4000>;
-					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_UART1_IPG>,
-						 <&clks IMX6UL_CLK_UART1_SERIAL>;
-					clock-names = "ipg", "per";
-					status = "disabled";
-				};
-
-				uart8: serial at 02024000 {
-					compatible = "fsl,imx6ul-uart",
-						     "fsl,imx6q-uart";
-					reg = <0x02024000 0x4000>;
-					interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_UART8_IPG>,
-						 <&clks IMX6UL_CLK_UART8_SERIAL>;
-					clock-names = "ipg", "per";
-					status = "disabled";
-				};
-
-				sai1: sai at 02028000 {
-					#sound-dai-cells = <0>;
-					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
-					reg = <0x02028000 0x4000>;
-					interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_SAI1_IPG>,
-						 <&clks IMX6UL_CLK_SAI1>,
-						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
-					clock-names = "bus", "mclk1", "mclk2", "mclk3";
-					dmas = <&sdma 35 24 0>,
-					       <&sdma 36 24 0>;
-					dma-names = "rx", "tx";
-					status = "disabled";
-				};
-
-				sai2: sai at 0202c000 {
-					#sound-dai-cells = <0>;
-					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
-					reg = <0x0202c000 0x4000>;
-					interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_SAI2_IPG>,
-						 <&clks IMX6UL_CLK_SAI2>,
-						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
-					clock-names = "bus", "mclk1", "mclk2", "mclk3";
-					dmas = <&sdma 37 24 0>,
-					       <&sdma 38 24 0>;
-					dma-names = "rx", "tx";
-					status = "disabled";
-				};
-
-				sai3: sai at 02030000 {
-					#sound-dai-cells = <0>;
-					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
-					reg = <0x02030000 0x4000>;
-					interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6UL_CLK_SAI3_IPG>,
-						 <&clks IMX6UL_CLK_SAI3>,
-						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
-					clock-names = "bus", "mclk1", "mclk2", "mclk3";
-					dmas = <&sdma 39 24 0>,
-					       <&sdma 40 24 0>;
-					dma-names = "rx", "tx";
-					status = "disabled";
-				};
-			};
-
-			tsc: tsc at 02040000 {
-				compatible = "fsl,imx6ul-tsc";
-				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
-				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_IPG>,
-					 <&clks IMX6UL_CLK_ADC2>;
-				clock-names = "tsc", "adc";
-				status = "disabled";
-			};
-
-			pwm1: pwm at 02080000 {
-				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
-				reg = <0x02080000 0x4000>;
-				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_PWM1>,
-					 <&clks IMX6UL_CLK_PWM1>;
-				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
-				status = "disabled";
-			};
-
-			pwm2: pwm at 02084000 {
-				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
-				reg = <0x02084000 0x4000>;
-				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_PWM2>,
-					 <&clks IMX6UL_CLK_PWM2>;
-				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
-				status = "disabled";
-			};
-
-			pwm3: pwm at 02088000 {
-				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
-				reg = <0x02088000 0x4000>;
-				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_PWM3>,
-					 <&clks IMX6UL_CLK_PWM3>;
-				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
-				status = "disabled";
-			};
-
-			pwm4: pwm at 0208c000 {
-				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
-				reg = <0x0208c000 0x4000>;
-				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_PWM4>,
-					 <&clks IMX6UL_CLK_PWM4>;
-				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
-				status = "disabled";
-			};
-
-			can1: flexcan at 02090000 {
-				compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
-				reg = <0x02090000 0x4000>;
-				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_CAN1_IPG>,
-					 <&clks IMX6UL_CLK_CAN1_SERIAL>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			can2: flexcan at 02094000 {
-				compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
-				reg = <0x02094000 0x4000>;
-				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_CAN2_IPG>,
-					 <&clks IMX6UL_CLK_CAN2_SERIAL>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			gpt1: gpt at 02098000 {
-				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
-				reg = <0x02098000 0x4000>;
-				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_GPT1_BUS>,
-					 <&clks IMX6UL_CLK_GPT1_SERIAL>;
-				clock-names = "ipg", "per";
-			};
-
-			gpio1: gpio at 0209c000 {
-				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
-				reg = <0x0209c000 0x4000>;
-				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc  0 23 10>, <&iomuxc 10 17 6>,
-					      <&iomuxc 16 33 16>;
-			};
-
-			gpio2: gpio at 020a0000 {
-				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
-				reg = <0x020a0000 0x4000>;
-				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc 0 49 16>, <&iomuxc 16 111 6>;
-			};
-
-			gpio3: gpio at 020a4000 {
-				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
-				reg = <0x020a4000 0x4000>;
-				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc 0 65 29>;
-			};
-
-			gpio4: gpio at 020a8000 {
-				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
-				reg = <0x020a8000 0x4000>;
-				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc 0 94 17>, <&iomuxc 17 117 12>;
-			};
-
-			gpio5: gpio at 020ac000 {
-				compatible = "fsl,imx6ul-gpio", "fsl,imx35-gpio";
-				reg = <0x020ac000 0x4000>;
-				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				gpio-ranges = <&iomuxc 0 7 10>, <&iomuxc 10 5 2>;
-			};
-
-			fec2: ethernet at 020b4000 {
-				compatible = "fsl,imx6ul-fec", "fsl,imx6q-fec";
-				reg = <0x020b4000 0x4000>;
-				interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_ENET>,
-					 <&clks IMX6UL_CLK_ENET_AHB>,
-					 <&clks IMX6UL_CLK_ENET_PTP>,
-					 <&clks IMX6UL_CLK_ENET2_REF_125M>,
-					 <&clks IMX6UL_CLK_ENET2_REF_125M>;
-				clock-names = "ipg", "ahb", "ptp",
-					      "enet_clk_ref", "enet_out";
-				fsl,num-tx-queues=<1>;
-				fsl,num-rx-queues=<1>;
-				status = "disabled";
-			};
-
-			kpp: kpp at 020b8000 {
-				compatible = "fsl,imx6ul-kpp", "fsl,imx6q-kpp", "fsl,imx21-kpp";
-				reg = <0x020b8000 0x4000>;
-				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_KPP>;
-				status = "disabled";
-			};
-
-			wdog1: wdog at 020bc000 {
-				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
-				reg = <0x020bc000 0x4000>;
-				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_WDOG1>;
-			};
-
-			wdog2: wdog at 020c0000 {
-				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
-				reg = <0x020c0000 0x4000>;
-				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_WDOG2>;
-				status = "disabled";
-			};
-
-			clks: ccm at 020c4000 {
-				compatible = "fsl,imx6ul-ccm";
-				reg = <0x020c4000 0x4000>;
-				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
-				#clock-cells = <1>;
-				clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>;
-				clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
-			};
-
-			anatop: anatop at 020c8000 {
-				compatible = "fsl,imx6ul-anatop", "fsl,imx6q-anatop",
-					     "syscon", "simple-bus";
-				reg = <0x020c8000 0x1000>;
-				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-
-				reg_3p0: regulator-3p0 {
-					compatible = "fsl,anatop-regulator";
-					regulator-name = "vdd3p0";
-					regulator-min-microvolt = <2625000>;
-					regulator-max-microvolt = <3400000>;
-					anatop-reg-offset = <0x120>;
-					anatop-vol-bit-shift = <8>;
-					anatop-vol-bit-width = <5>;
-					anatop-min-bit-val = <0>;
-					anatop-min-voltage = <2625000>;
-					anatop-max-voltage = <3400000>;
-					anatop-enable-bit = <0>;
-				};
-
-				reg_arm: regulator-vddcore {
-					compatible = "fsl,anatop-regulator";
-					regulator-name = "cpu";
-					regulator-min-microvolt = <725000>;
-					regulator-max-microvolt = <1450000>;
-					regulator-always-on;
-					anatop-reg-offset = <0x140>;
-					anatop-vol-bit-shift = <0>;
-					anatop-vol-bit-width = <5>;
-					anatop-delay-reg-offset = <0x170>;
-					anatop-delay-bit-shift = <24>;
-					anatop-delay-bit-width = <2>;
-					anatop-min-bit-val = <1>;
-					anatop-min-voltage = <725000>;
-					anatop-max-voltage = <1450000>;
-				};
-
-				reg_soc: regulator-vddsoc {
-					compatible = "fsl,anatop-regulator";
-					regulator-name = "vddsoc";
-					regulator-min-microvolt = <725000>;
-					regulator-max-microvolt = <1450000>;
-					regulator-always-on;
-					anatop-reg-offset = <0x140>;
-					anatop-vol-bit-shift = <18>;
-					anatop-vol-bit-width = <5>;
-					anatop-delay-reg-offset = <0x170>;
-					anatop-delay-bit-shift = <28>;
-					anatop-delay-bit-width = <2>;
-					anatop-min-bit-val = <1>;
-					anatop-min-voltage = <725000>;
-					anatop-max-voltage = <1450000>;
-				};
-			};
-
-			usbphy1: usbphy at 020c9000 {
-				compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
-				reg = <0x020c9000 0x1000>;
-				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_USBPHY1>;
-				phy-3p0-supply = <&reg_3p0>;
-				fsl,anatop = <&anatop>;
-			};
-
-			usbphy2: usbphy at 020ca000 {
-				compatible = "fsl,imx6ul-usbphy", "fsl,imx23-usbphy";
-				reg = <0x020ca000 0x1000>;
-				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_USBPHY2>;
-				phy-3p0-supply = <&reg_3p0>;
-				fsl,anatop = <&anatop>;
-			};
-
-			snvs: snvs at 020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
-				reg = <0x020cc000 0x4000>;
-
-				snvs_rtc: snvs-rtc-lp {
-					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					regmap = <&snvs>;
-					offset = <0x34>;
-					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
-						     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-				};
-
-				snvs_poweroff: snvs-poweroff {
-					compatible = "syscon-poweroff";
-					regmap = <&snvs>;
-					offset = <0x38>;
-					mask = <0x60>;
-					status = "disabled";
-				};
-
-				snvs_pwrkey: snvs-powerkey {
-					compatible = "fsl,sec-v4.0-pwrkey";
-					regmap = <&snvs>;
-					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-					linux,keycode = <KEY_POWER>;
-					wakeup-source;
-				};
-			};
-
-			epit1: epit at 020d0000 {
-				reg = <0x020d0000 0x4000>;
-				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-			};
-
-			epit2: epit at 020d4000 {
-				reg = <0x020d4000 0x4000>;
-				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-			};
-
-			src: src at 020d8000 {
-				compatible = "fsl,imx6ul-src", "fsl,imx51-src";
-				reg = <0x020d8000 0x4000>;
-				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-				#reset-cells = <1>;
-			};
-
-			gpc: gpc at 020dc000 {
-				compatible = "fsl,imx6ul-gpc", "fsl,imx6q-gpc";
-				reg = <0x020dc000 0x4000>;
-				interrupt-controller;
-				#interrupt-cells = <3>;
-				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-parent = <&intc>;
-			};
-
-			iomuxc: iomuxc at 020e0000 {
-				compatible = "fsl,imx6ul-iomuxc";
-				reg = <0x020e0000 0x4000>;
-			};
-
-			gpr: iomuxc-gpr at 020e4000 {
-				compatible = "fsl,imx6ul-iomuxc-gpr",
-					     "fsl,imx6q-iomuxc-gpr", "syscon";
-				reg = <0x020e4000 0x4000>;
-			};
-
-			gpt2: gpt at 020e8000 {
-				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
-				reg = <0x020e8000 0x4000>;
-				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_GPT2_BUS>,
-					 <&clks IMX6UL_CLK_GPT2_SERIAL>;
-				clock-names = "ipg", "per";
-			};
-
-			sdma: sdma at 020ec000 {
-				compatible = "fsl,imx6ul-sdma", "fsl,imx6q-sdma",
-					     "fsl,imx35-sdma";
-				reg = <0x020ec000 0x4000>;
-				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_SDMA>,
-					 <&clks IMX6UL_CLK_SDMA>;
-				clock-names = "ipg", "ahb";
-				#dma-cells = <3>;
-				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
-			};
-
-			pwm5: pwm at 020f0000 {
-				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
-				reg = <0x020f0000 0x4000>;
-				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_PWM5>,
-					 <&clks IMX6UL_CLK_PWM5>;
-				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
-				status = "disabled";
-			};
-
-			pwm6: pwm at 020f4000 {
-				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
-				reg = <0x020f4000 0x4000>;
-				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_PWM6>,
-					 <&clks IMX6UL_CLK_PWM6>;
-				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
-				status = "disabled";
-			};
-
-			pwm7: pwm at 020f8000 {
-				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
-				reg = <0x020f8000 0x4000>;
-				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_PWM7>,
-					 <&clks IMX6UL_CLK_PWM7>;
-				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
-				status = "disabled";
-			};
-
-			pwm8: pwm at 020fc000 {
-				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
-				reg = <0x020fc000 0x4000>;
-				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_PWM8>,
-					 <&clks IMX6UL_CLK_PWM8>;
-				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
-				status = "disabled";
-			};
-		};
-
-		aips2: aips-bus at 02100000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x02100000 0x100000>;
-			ranges;
-
-			usbotg1: usb at 02184000 {
-				compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
-				reg = <0x02184000 0x200>;
-				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_USBOH3>;
-				fsl,usbphy = <&usbphy1>;
-				fsl,usbmisc = <&usbmisc 0>;
-				fsl,anatop = <&anatop>;
-				ahb-burst-config = <0x0>;
-				tx-burst-size-dword = <0x10>;
-				rx-burst-size-dword = <0x10>;
-				status = "disabled";
-			};
-
-			usbotg2: usb at 02184200 {
-				compatible = "fsl,imx6ul-usb", "fsl,imx27-usb";
-				reg = <0x02184200 0x200>;
-				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_USBOH3>;
-				fsl,usbphy = <&usbphy2>;
-				fsl,usbmisc = <&usbmisc 1>;
-				ahb-burst-config = <0x0>;
-				tx-burst-size-dword = <0x10>;
-				rx-burst-size-dword = <0x10>;
-				status = "disabled";
-			};
-
-			usbmisc: usbmisc at 02184800 {
-				#index-cells = <1>;
-				compatible = "fsl,imx6ul-usbmisc", "fsl,imx6q-usbmisc";
-				reg = <0x02184800 0x200>;
-			};
-
-			fec1: ethernet at 02188000 {
-				compatible = "fsl,imx6ul-fec", "fsl,imx6q-fec";
-				reg = <0x02188000 0x4000>;
-				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_ENET>,
-					 <&clks IMX6UL_CLK_ENET_AHB>,
-					 <&clks IMX6UL_CLK_ENET_PTP>,
-					 <&clks IMX6UL_CLK_ENET_REF>,
-					 <&clks IMX6UL_CLK_ENET_REF>;
-				clock-names = "ipg", "ahb", "ptp",
-					      "enet_clk_ref", "enet_out";
-				fsl,num-tx-queues=<1>;
-				fsl,num-rx-queues=<1>;
-				status = "disabled";
-			};
-
-			usdhc1: usdhc at 02190000 {
-				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
-				reg = <0x02190000 0x4000>;
-				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_USDHC1>,
-					 <&clks IMX6UL_CLK_USDHC1>,
-					 <&clks IMX6UL_CLK_USDHC1>;
-				clock-names = "ipg", "ahb", "per";
-				bus-width = <4>;
-				status = "disabled";
-			};
-
-			usdhc2: usdhc at 02194000 {
-				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
-				reg = <0x02194000 0x4000>;
-				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_USDHC2>,
-					 <&clks IMX6UL_CLK_USDHC2>,
-					 <&clks IMX6UL_CLK_USDHC2>;
-				clock-names = "ipg", "ahb", "per";
-				bus-width = <4>;
-				status = "disabled";
-			};
-
-			adc1: adc at 02198000 {
-				compatible = "fsl,imx6ul-adc", "fsl,vf610-adc";
-				reg = <0x02198000 0x4000>;
-				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_ADC1>;
-				num-channels = <2>;
-				clock-names = "adc";
-				fsl,adck-max-frequency = <30000000>, <40000000>,
-							 <20000000>;
-				status = "disabled";
-			};
-
-			i2c1: i2c at 021a0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
-				reg = <0x021a0000 0x4000>;
-				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_I2C1>;
-				status = "disabled";
-			};
-
-			i2c2: i2c at 021a4000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
-				reg = <0x021a4000 0x4000>;
-				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_I2C2>;
-				status = "disabled";
-			};
-
-			i2c3: i2c at 021a8000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
-				reg = <0x021a8000 0x4000>;
-				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_I2C3>;
-				status = "disabled";
-			};
-
-			mmdc: mmdc at 021b0000 {
-				compatible = "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
-				reg = <0x021b0000 0x4000>;
-			};
-
-			lcdif: lcdif at 021c8000 {
-				compatible = "fsl,imx6ul-lcdif", "fsl,imx28-lcdif";
-				reg = <0x021c8000 0x4000>;
-				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
-					 <&clks IMX6UL_CLK_LCDIF_APB>,
-					 <&clks IMX6UL_CLK_DUMMY>;
-				clock-names = "pix", "axi", "disp_axi";
-				status = "disabled";
-			};
-
-			qspi: qspi at 021e0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx6ul-qspi", "fsl,imx6sx-qspi";
-				reg = <0x021e0000 0x4000>, <0x60000000 0x10000000>;
-				reg-names = "QuadSPI", "QuadSPI-memory";
-				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_QSPI>,
-					 <&clks IMX6UL_CLK_QSPI>;
-				clock-names = "qspi_en", "qspi";
-				status = "disabled";
-			};
-
-			uart2: serial at 021e8000 {
-				compatible = "fsl,imx6ul-uart",
-					     "fsl,imx6q-uart";
-				reg = <0x021e8000 0x4000>;
-				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_UART2_IPG>,
-					 <&clks IMX6UL_CLK_UART2_SERIAL>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			uart3: serial at 021ec000 {
-				compatible = "fsl,imx6ul-uart",
-					     "fsl,imx6q-uart";
-				reg = <0x021ec000 0x4000>;
-				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_UART3_IPG>,
-					 <&clks IMX6UL_CLK_UART3_SERIAL>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			uart4: serial at 021f0000 {
-				compatible = "fsl,imx6ul-uart",
-					     "fsl,imx6q-uart";
-				reg = <0x021f0000 0x4000>;
-				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_UART4_IPG>,
-					 <&clks IMX6UL_CLK_UART4_SERIAL>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			uart5: serial at 021f4000 {
-				compatible = "fsl,imx6ul-uart",
-					     "fsl,imx6q-uart";
-				reg = <0x021f4000 0x4000>;
-				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_UART5_IPG>,
-					 <&clks IMX6UL_CLK_UART5_SERIAL>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			i2c4: i2c at 021f8000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx6ul-i2c", "fsl,imx21-i2c";
-				reg = <0x021f8000 0x4000>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_I2C4>;
-				status = "disabled";
-			};
-
-			uart6: serial at 021fc000 {
-				compatible = "fsl,imx6ul-uart",
-					     "fsl,imx6q-uart";
-				reg = <0x021fc000 0x4000>;
-				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_UART6_IPG>,
-					 <&clks IMX6UL_CLK_UART6_SERIAL>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
new file mode 100644
index 0000000..64c38bc
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
new file mode 100644
index 0000000..fca0036
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
@@ -0,0 +1,57 @@
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
+#define MX6UL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
+#define MX6UL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
+#define MX6UL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
+#define MX6UL_PAD_ENET2_TX_DATA0__EPDC_SDDO11                    0x00F0 0x037C 0x0000 0x9 0x0
+#define MX6UL_PAD_ENET2_TX_DATA1__EPDC_SDDO12                    0x00F4 0x0380 0x0000 0x9 0x0
+#define MX6UL_PAD_ENET2_TX_EN__EPDC_SDDO13                       0x00F8 0x0384 0x0000 0x9 0x0
+#define MX6UL_PAD_ENET2_TX_CLK__EPDC_SDDO14                      0x00FC 0x0388 0x0000 0x9 0x0
+#define MX6UL_PAD_ENET2_RX_ER__EPDC_SDDO15                       0x0100 0x038C 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_CLK__EPDC_SDCLK                            0x0104 0x0390 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_ENABLE__EPDC_SDLE                          0x0108 0x0394 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_HSYNC__EPDC_SDOE                           0x010C 0x0398 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_VSYNC__EPDC_SDCE0                          0x0110 0x039C 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_RESET__EPDC_GDOE                           0x0114 0x03A0 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA00__EPDC_SDDO00                        0x0118 0x03A4 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA01__EPDC_SDDO01                        0x011C 0x03A8 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA02__EPDC_SDDO02                        0x0120 0x03AC 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA03__EPDC_SDDO03                        0x0124 0x03B0 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA04__EPDC_SDDO04                        0x0128 0x03B4 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA05__EPDC_SDDO05                        0x012C 0x03B8 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA06__EPDC_SDDO06                        0x0130 0x03BC 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA07__EPDC_SDDO07                        0x0134 0x03C0 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA14__EPDC_SDSHR                         0x0150 0x03DC 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA15__EPDC_GDRL                          0x0154 0x03E0 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA16__EPDC_GDCLK                         0x0158 0x03E4 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA17__EPDC_GDSP                          0x015C 0x03E8 0x0000 0x9 0x0
+#define MX6UL_PAD_LCD_DATA21__EPDC_SDCE1                         0x016C 0x03F8 0x0000 0x9 0x0
+
+#define MX6UL_PAD_CSI_MCLK__ESAI_TX3_RX2                          0x01D4 0x0460 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_PIXCLK__ESAI_TX2_RX3                        0x01D8 0x0464 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_VSYNC__ESAI_TX4_RX1                         0x01DC 0x0468 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_HSYNC__ESAI_TX1                             0x01E0 0x046C 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_DATA00__ESAI_TX_HF_CLK                      0x01E4 0x0470 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_DATA01__ESAI_RX_HF_CLK                      0x01E8 0x0474 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_DATA02__ESAI_RX_FS                          0x01EC 0x0478 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_DATA03__ESAI_RX_CLK                         0x01F0 0x047C 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_DATA04__ESAI_TX_FS                          0x01F4 0x0480 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_DATA05__ESAI_TX_CLK                         0x01F8 0x0484 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_DATA06__ESAI_TX5_RX0                        0x01FC 0x0488 0x0000 0x9 0x0
+#define MX6UL_PAD_CSI_DATA07__ESAI_T0                             0x0200 0x048C 0x0000 0x9 0x0
+
+#endif /* __DTS_IMX6ULL_PINFUNC_H */
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
new file mode 100644
index 0000000..afd9796
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -0,0 +1,10 @@
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6u.dtsi"
+#include "imx6ull-pinfunc.h"
-- 
2.7.4
