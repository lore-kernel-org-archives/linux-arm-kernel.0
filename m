From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Fri, 21 Jul 2017 06:06:40 +0200
Subject: [PATCH v4 2/2] ARM: dts: imx: add CX9020 Embedded PC device tree
In-Reply-To: <20170721040640.31424-1-linux-kernel-dev@beckhoff.com>
References: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
 <20170721040640.31424-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20170721040640.31424-3-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

The CX9020 differs from i.MX53 Quick Start Board by:
- use uart2 instead of uart1
- DVI-D connector instead of VGA
- no audio
- no SATA connector
- CCAT FPGA connected to emi
- enable rtc

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

---

v4:
- move alternative UART2 pinmux settings to imx53-pinfunc.h
- fix copyright notice and model name to clearify cx9020 is a
  Beckhoff board and not from Freescale/NXP/Qualcomm
- add "bhf,cx9020" compatible
- remove ccat node and pin configuration as long as the ccat
  driver is not mainlined
- use dvi-connector + ti,tfp410 instead of panel-simple
- add newlines between property list and child nodes
- replace underscores in node names with hypens
- replace magic number 0 with polarity defines from
  include/dt-bindings/gpio/gpio.h
- move rtc node into imx53.dtsi, change it's name into 'srtc',
  to avoid a conflict with 'rtc' node in imx53-m53.dtsi
- rename regulator-3p2v
- drop imx53-qsb container node
- make iomux configuration explicit
- remove unused audmux
- remove unused led_pin_gpio3_23 configuration
- use blue gpio-leds as disk-activity indicators for mmc0 and mmc1
- add mmc indicator leds to sdhc pingroups
- keep node names in alphabetical order
- remove unused sata and ssi2
- remove unused pin configs from hoggrp
- add entry for imx53-cx9020.dts to MAINTAINERS

v3: add missig changelog
v2:
- keep alphabetic order of dts/Makefile
- configure uart2 with 'fsl,dte-mode'
- use display-0 and panel-0 as node names
- remove unnecessary "simple-bus" for fixed regulators

Cc: Andrew Lunn <andrew@lunn.ch>
---
 MAINTAINERS                        |   1 +
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/imx53-cx9020.dts | 295 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx53-pinfunc.h  |   4 +
 arch/arm/boot/dts/imx53.dtsi       |   9 ++
 5 files changed, 310 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-cx9020.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bf282843dc2..1bd06328f79b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1176,6 +1176,7 @@ ARM/BECKHOFF SUPPORT
 M:	Patrick Bruenn <p.bruenn@beckhoff.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/bhf.txt
+F:	arch/arm/boot/dts/imx53-cx9020.dts
 
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <robh@kernel.org>
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35dc9a7..f0ba9be523e0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -340,6 +340,7 @@ dtb-$(CONFIG_SOC_IMX51) += \
 	imx51-ts4800.dtb
 dtb-$(CONFIG_SOC_IMX53) += \
 	imx53-ard.dtb \
+	imx53-cx9020.dtb \
 	imx53-m53evk.dtb \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
diff --git a/arch/arm/boot/dts/imx53-cx9020.dts b/arch/arm/boot/dts/imx53-cx9020.dts
new file mode 100644
index 000000000000..c4f9c89668c2
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-cx9020.dts
@@ -0,0 +1,295 @@
+/*
+ * Copyright 2017 Beckhoff Automation GmbH & Co. KG
+ * based on imx53-qsb.dts
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
+	model = "Beckhoff CX9020 Embedded PC";
+	compatible = "bhf,cx9020", "fsl,imx53";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	memory {
+		reg = <0x70000000 0x20000000>,
+		      <0xb0000000 0x20000000>;
+	};
+
+	display-0 {
+		#address-cells =<1>;
+		#size-cells = <0>;
+		compatible = "fsl,imx-parallel-display";
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu_disp0>;
+		status = "okay";
+
+		port at 0 {
+			reg = <0>;
+
+			display0_in: endpoint {
+				remote-endpoint = <&ipu_di0_disp0>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			display0_out: endpoint {
+				remote-endpoint = <&tfp410_in>;
+			};
+		};
+	};
+
+	dvi-connector {
+		compatible = "dvi-connector";
+		ddc-i2c-bus = <&i2c2>;
+		digital;
+
+		port {
+			dvi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
+
+	dvi-converter {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,tfp410";
+
+		port at 0 {
+			reg = <0>;
+
+			tfp410_in: endpoint {
+				remote-endpoint = <&display0_out>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			tfp410_out: endpoint {
+				remote-endpoint = <&dvi_connector_in>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pwr-r {
+			gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		pwr-g {
+			gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		pwr-b {
+			gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		sd1-b {
+			linux,default-trigger = "mmc0";
+			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		sd2-b {
+			linux,default-trigger = "mmc1";
+			gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	regulator-3p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P2V";
+		regulator-min-microvolt = <3200000>;
+		regulator-max-microvolt = <3200000>;
+		regulator-always-on;
+	};
+
+	reg_usb_vbus: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio7 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&esdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc2>;
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&ipu_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	fsl,dte-mode;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_vbus>;
+	phy_type = "utmi";
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&vpu {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX53_PAD_GPIO_0__CCM_CLKO               0x1a4
+			MX53_PAD_GPIO_16__I2C3_SDA              0x1a4
+		>;
+	};
+
+	pinctrl_esdhc1: esdhc1grp {
+		fsl,pins = <
+			MX53_PAD_SD1_DATA0__ESDHC1_DAT0		0x1d5
+			MX53_PAD_SD1_DATA1__ESDHC1_DAT1		0x1d5
+			MX53_PAD_SD1_DATA2__ESDHC1_DAT2		0x1d5
+			MX53_PAD_SD1_DATA3__ESDHC1_DAT3		0x1d5
+			MX53_PAD_SD1_CMD__ESDHC1_CMD		0x1d5
+			MX53_PAD_SD1_CLK__ESDHC1_CLK		0x1d5
+			MX53_PAD_GPIO_1__ESDHC1_CD              0x1a4
+			MX53_PAD_EIM_D17__GPIO3_17              0x1e4
+			MX53_PAD_GPIO_3__GPIO1_3                0x1e4
+		>;
+	};
+
+	pinctrl_esdhc2: esdhc2grp {
+		fsl,pins = <
+			MX53_PAD_SD2_DATA0__ESDHC2_DAT0		0x1d5
+			MX53_PAD_SD2_DATA1__ESDHC2_DAT1		0x1d5
+			MX53_PAD_SD2_DATA2__ESDHC2_DAT2		0x1d5
+			MX53_PAD_SD2_DATA3__ESDHC2_DAT3		0x1d5
+			MX53_PAD_SD2_CMD__ESDHC2_CMD		0x1d5
+			MX53_PAD_SD2_CLK__ESDHC2_CLK		0x1d5
+			MX53_PAD_GPIO_4__ESDHC2_CD              0x1e4
+			MX53_PAD_EIM_D20__GPIO3_20              0x1e4
+			MX53_PAD_GPIO_8__GPIO1_8                0x1a4
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX53_PAD_FEC_MDC__FEC_MDC		0x4
+			MX53_PAD_FEC_MDIO__FEC_MDIO		0x1fc
+			MX53_PAD_FEC_REF_CLK__FEC_TX_CLK	0x180
+			MX53_PAD_FEC_RX_ER__FEC_RX_ER		0x180
+			MX53_PAD_FEC_CRS_DV__FEC_RX_DV		0x180
+			MX53_PAD_FEC_RXD1__FEC_RDATA_1		0x180
+			MX53_PAD_FEC_RXD0__FEC_RDATA_0		0x180
+			MX53_PAD_FEC_TX_EN__FEC_TX_EN		0x4
+			MX53_PAD_FEC_TXD1__FEC_TDATA_1		0x4
+			MX53_PAD_FEC_TXD0__FEC_TDATA_0		0x4
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX53_PAD_KEY_ROW3__I2C2_SDA             0xc0000000
+			MX53_PAD_KEY_COL3__I2C2_SCL             0xc0000000
+		>;
+	};
+
+	pinctrl_ipu_disp0: ipudisp0grp {
+		fsl,pins = <
+			MX53_PAD_DI0_DISP_CLK__IPU_DI0_DISP_CLK	0x5
+			MX53_PAD_DI0_PIN15__IPU_DI0_PIN15	0x5
+			MX53_PAD_DI0_PIN2__IPU_DI0_PIN2		0x5
+			MX53_PAD_DI0_PIN3__IPU_DI0_PIN3		0x5
+			MX53_PAD_DI0_PIN4__IPU_DI0_PIN4		0x5
+			MX53_PAD_DISP0_DAT0__IPU_DISP0_DAT_0	0x5
+			MX53_PAD_DISP0_DAT1__IPU_DISP0_DAT_1	0x5
+			MX53_PAD_DISP0_DAT2__IPU_DISP0_DAT_2	0x5
+			MX53_PAD_DISP0_DAT3__IPU_DISP0_DAT_3	0x5
+			MX53_PAD_DISP0_DAT4__IPU_DISP0_DAT_4	0x5
+			MX53_PAD_DISP0_DAT5__IPU_DISP0_DAT_5	0x5
+			MX53_PAD_DISP0_DAT6__IPU_DISP0_DAT_6	0x5
+			MX53_PAD_DISP0_DAT7__IPU_DISP0_DAT_7	0x5
+			MX53_PAD_DISP0_DAT8__IPU_DISP0_DAT_8	0x5
+			MX53_PAD_DISP0_DAT9__IPU_DISP0_DAT_9	0x5
+			MX53_PAD_DISP0_DAT10__IPU_DISP0_DAT_10	0x5
+			MX53_PAD_DISP0_DAT11__IPU_DISP0_DAT_11	0x5
+			MX53_PAD_DISP0_DAT12__IPU_DISP0_DAT_12	0x5
+			MX53_PAD_DISP0_DAT13__IPU_DISP0_DAT_13	0x5
+			MX53_PAD_DISP0_DAT14__IPU_DISP0_DAT_14	0x5
+			MX53_PAD_DISP0_DAT15__IPU_DISP0_DAT_15	0x5
+			MX53_PAD_DISP0_DAT16__IPU_DISP0_DAT_16	0x5
+			MX53_PAD_DISP0_DAT17__IPU_DISP0_DAT_17	0x5
+			MX53_PAD_DISP0_DAT18__IPU_DISP0_DAT_18	0x5
+			MX53_PAD_DISP0_DAT19__IPU_DISP0_DAT_19	0x5
+			MX53_PAD_DISP0_DAT20__IPU_DISP0_DAT_20	0x5
+			MX53_PAD_DISP0_DAT21__IPU_DISP0_DAT_21	0x5
+			MX53_PAD_DISP0_DAT22__IPU_DISP0_DAT_22	0x5
+			MX53_PAD_DISP0_DAT23__IPU_DISP0_DAT_23	0x5
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX53_PAD_EIM_D26__UART2_RXD_MUX	0x1e4
+			MX53_PAD_EIM_D27__UART2_TXD_MUX 0x1e4
+			MX53_PAD_EIM_D28__UART2_RTS 0x1e4
+			MX53_PAD_EIM_D29__UART2_CTS 0x1e4
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx53-pinfunc.h b/arch/arm/boot/dts/imx53-pinfunc.h
index aec406bc65eb..59f9c29e3fe2 100644
--- a/arch/arm/boot/dts/imx53-pinfunc.h
+++ b/arch/arm/boot/dts/imx53-pinfunc.h
@@ -524,6 +524,7 @@
 #define MX53_PAD_EIM_D25__UART1_DSR				0x140 0x488 0x000 0x7 0x0
 #define MX53_PAD_EIM_D26__EMI_WEIM_D_26				0x144 0x48c 0x000 0x0 0x0
 #define MX53_PAD_EIM_D26__GPIO3_26				0x144 0x48c 0x000 0x1 0x0
+#define MX53_PAD_EIM_D26__UART2_RXD_MUX				0x144 0x48c 0x880 0x2 0x0
 #define MX53_PAD_EIM_D26__UART2_TXD_MUX				0x144 0x48c 0x000 0x2 0x0
 #define MX53_PAD_EIM_D26__FIRI_RXD				0x144 0x48c 0x80c 0x3 0x0
 #define MX53_PAD_EIM_D26__IPU_CSI0_D_1				0x144 0x48c 0x000 0x4 0x0
@@ -533,6 +534,7 @@
 #define MX53_PAD_EIM_D27__EMI_WEIM_D_27				0x148 0x490 0x000 0x0 0x0
 #define MX53_PAD_EIM_D27__GPIO3_27				0x148 0x490 0x000 0x1 0x0
 #define MX53_PAD_EIM_D27__UART2_RXD_MUX				0x148 0x490 0x880 0x2 0x1
+#define MX53_PAD_EIM_D27__UART2_TXD_MUX				0x148 0x490 0x000 0x2 0x0
 #define MX53_PAD_EIM_D27__FIRI_TXD				0x148 0x490 0x000 0x3 0x0
 #define MX53_PAD_EIM_D27__IPU_CSI0_D_0				0x148 0x490 0x000 0x4 0x0
 #define MX53_PAD_EIM_D27__IPU_DI1_PIN13				0x148 0x490 0x000 0x5 0x0
@@ -541,6 +543,7 @@
 #define MX53_PAD_EIM_D28__EMI_WEIM_D_28				0x14c 0x494 0x000 0x0 0x0
 #define MX53_PAD_EIM_D28__GPIO3_28				0x14c 0x494 0x000 0x1 0x0
 #define MX53_PAD_EIM_D28__UART2_CTS				0x14c 0x494 0x000 0x2 0x0
+#define MX53_PAD_EIM_D28__UART2_RTS				0x14c 0x494 0x87c 0x2 0x0
 #define MX53_PAD_EIM_D28__IPU_DISPB0_SER_DIO			0x14c 0x494 0x82c 0x3 0x1
 #define MX53_PAD_EIM_D28__CSPI_MOSI				0x14c 0x494 0x788 0x4 0x1
 #define MX53_PAD_EIM_D28__I2C1_SDA				0x14c 0x494 0x818 0x5 0x1
@@ -548,6 +551,7 @@
 #define MX53_PAD_EIM_D28__IPU_DI0_PIN13				0x14c 0x494 0x000 0x7 0x0
 #define MX53_PAD_EIM_D29__EMI_WEIM_D_29				0x150 0x498 0x000 0x0 0x0
 #define MX53_PAD_EIM_D29__GPIO3_29				0x150 0x498 0x000 0x1 0x0
+#define MX53_PAD_EIM_D29__UART2_CTS				0x150 0x498 0x000 0x2 0x0
 #define MX53_PAD_EIM_D29__UART2_RTS				0x150 0x498 0x87c 0x2 0x1
 #define MX53_PAD_EIM_D29__IPU_DISPB0_SER_RS			0x150 0x498 0x000 0x3 0x0
 #define MX53_PAD_EIM_D29__CSPI_SS0				0x150 0x498 0x78c 0x4 0x2
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 2e516f4985e4..8bf0d89cdd35 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -433,6 +433,15 @@
 				clock-names = "ipg", "per";
 			};
 
+			srtc: srtc at 53fa4000 {
+				compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
+				reg = <0x53fa4000 0x4000>;
+				interrupts = <24>;
+				interrupt-parent = <&tzic>;
+				clocks = <&clks IMX5_CLK_SRTC_GATE>;
+				clock-names = "ipg";
+			};
+
 			iomuxc: iomuxc at 53fa8000 {
 				compatible = "fsl,imx53-iomuxc";
 				reg = <0x53fa8000 0x4000>;
-- 
2.11.0
