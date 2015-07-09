From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 10 Jul 2015 01:16:42 +0800
Subject: [PATCH v3 5/7] ARM: dts: imx: add imx6ul and imx6ul evk board support
In-Reply-To: <1436462204-32654-1-git-send-email-Frank.Li@freescale.com>
References: <1436462204-32654-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1436462204-32654-6-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Add new SOC i.MX6UL dtb file support, including evk board
support

i.MX6 Ultralite processor include one ARM cortext-A7 core.
Offer high perfomance and lowest power consumption.

Main included:
- 4 MMC/SD/SDIO
- 2 USB 2.0 OTG
- 3 I2S/SAI/AC97
- 4 eCSPI
- 4 I2C
- 2 ENET
- 2 CAN
- 3 wdog
- ASRC
- 8 uart
- LCDIF
- PXP

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Fancy Fang <chen.fang@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/Makefile             |   2 +
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 278 +++++++++++++++
 arch/arm/boot/dts/imx6ul.dtsi          | 607 +++++++++++++++++++++++++++++++++
 3 files changed, 887 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ul.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a..7c2fd63 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -331,6 +331,8 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-sabreauto.dtb \
 	imx6sx-sdb-reva.dtb \
 	imx6sx-sdb.dtb
+dtb-$(CONFIG_SOC_IMX6UL) += \
+	imx6ul-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-sdb.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
new file mode 100644
index 0000000..61b41ee
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -0,0 +1,278 @@
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
+#include <dt-bindings/input/input.h>
+#include "imx6ul.dtsi"
+
+/ {
+	model = "Freescale i.MX6 UltraLite 14x14 EVK Board";
+	compatible = "fsl,imx6ul-14x14-evk", "fsl,imx6ul";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory {
+		reg = <0x80000000 0x20000000>;
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
+};
+
+&cpu0 {
+	arm-supply = <&reg_arm>;
+	soc-supply = <&reg_soc>;
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
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	status = "okay";
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
+};
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
new file mode 100644
index 0000000..dc0f5b4
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -0,0 +1,607 @@
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
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "imx6ul-pinfunc.h"
+#include "skeleton.dtsi"
+
+/ {
+	aliases {
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
+				528000	1250000
+				396000	1150000
+				198000	1150000
+			>;
+			fsl,soc-operating-points = <
+				/* KHz	uV */
+				528000	1250000
+				396000	1150000
+				198000	1150000
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
+		interrupt-parent = <&intc>;
+		ranges;
+
+		pmu {
+			compatible = "arm,cortex-a7-pmu";
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
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
+				reg_3p0: regulator-3p0 at 120 {
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
+				reg_arm: regulator-vddcore at 140 {
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
+				reg_soc: regulator-vddsoc at 140 {
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
+				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			iomuxc: iomuxc at 020e0000 {
+				compatible = "fsl,imx6ul-iomuxc";
+				reg = <0x020e0000 0x4000>;
+			};
+
+			gpr: iomuxc-gpr at 020e4000 {
+				compatible = "fsl,imx6ul-iomuxc-gpr", "syscon";
+				reg = <0x020e4000 0x4000>;
+			};
+
+			gpt2: gpt at 020e8000 {
+				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
+				reg = <0x020e8000 0x4000>;
+				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_DUMMY>,
+					 <&clks IMX6UL_CLK_DUMMY>;
+				clock-names = "ipg", "per";
+			};
+
+			pwm5: pwm at 020f0000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x020f0000 0x4000>;
+				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_DUMMY>,
+					 <&clks IMX6UL_CLK_DUMMY>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+			};
+
+			pwm6: pwm at 020f4000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x020f4000 0x4000>;
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_DUMMY>,
+					 <&clks IMX6UL_CLK_DUMMY>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+			};
+
+			pwm7: pwm at 020f8000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x020f8000 0x4000>;
+				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_DUMMY>,
+					 <&clks IMX6UL_CLK_DUMMY>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
+			};
+
+			pwm8: pwm at 020fc000 {
+				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
+				reg = <0x020fc000 0x4000>;
+				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_DUMMY>,
+					 <&clks IMX6UL_CLK_DUMMY>;
+				clock-names = "ipg", "per";
+				#pwm-cells = <2>;
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
-- 
1.9.1
