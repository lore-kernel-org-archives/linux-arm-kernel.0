From: hs@denx.de (Heiko Schocher)
Date: Wed, 11 Jun 2014 08:35:48 +0200
Subject: [PATCH] arm, imx6, dts: add aristainetos board support
Message-ID: <1402468548-17539-1-git-send-email-hs@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the imx6dl based aristainetos board
with following configuration:

CPU:   Freescale i.MX6DL rev1.1 at 792 MHz
DRAM:  1 GiB
NAND:  512 MiB
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
SF: Detected N25Q128 with page size 256 Bytes, erase size 64 KiB, total 16 MiB

As this board can used with 2 different display types, the
differences between them are extracted into 2 DTS files, and
the common settings are collected in a common file.

Signed-off-by: Heiko Schocher <hs@denx.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: devicetree at vger.kernel.org <devicetree@vger.kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/Makefile                  |   2 +
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts |  82 ++++++
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts |  71 +++++
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi | 436 ++++++++++++++++++++++++++++
 4 files changed, 591 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos_4.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos_7.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5986ff6..3b9a275 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -182,6 +182,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-tx53-x03x.dtb \
 	imx53-tx53-x13x.dtb \
 	imx53-voipac-bsb.dtb \
+	imx6dl-aristainetos_4.dtb \
+	imx6dl-aristainetos_7.dtb \
 	imx6dl-cubox-i.dtb \
 	imx6dl-dfi-fs700-m60.dtb \
 	imx6dl-gw51xx.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
new file mode 100644
index 0000000..60625a3
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -0,0 +1,82 @@
+/*
+ * support fot the imx6 based aristainetos board
+ *
+ * Copyright (C) 2014 Heiko Schocher <hs@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-aristainetos.dtsi"
+
+/ {
+	model = "aristainetos i.MX6 Dual Lite Board 4";
+	compatible = "fsl,imx6dl";
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		status = "okay";
+		enable-gpios = <&gpio1 2 0>;
+	};
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	soc {
+		display0: display at di0 {
+			compatible = "fsl,imx-parallel-display";
+			interface-pix-fmt = "rgb24";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ipu_disp>;
+			status = "okay";
+
+			display-timings {
+				480x800p60 {
+					native-mode;
+					clock-frequency = <30000000>;
+					hactive = <480>;
+					vactive = <800>;
+					hfront-porch = <59>;
+					hback-porch = <10>;
+					hsync-len = <10>;
+					vback-porch = <15>;
+					vfront-porch = <15>;
+					vsync-len = <15>;
+					hsync-active = <1>;
+					vsync-active = <1>;
+				};
+			};
+			port {
+				display0_in: endpoint {
+					remote-endpoint = <&ipu1_di0_disp0>;
+				};
+			};
+		};
+	};
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&ecspi2 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio3 24 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
new file mode 100644
index 0000000..e8c7c2c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
@@ -0,0 +1,71 @@
+/*
+ * support fot the imx6 based aristainetos board
+ *
+ * Copyright (C) 2014 Heiko Schocher <hs@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-aristainetos.dtsi"
+
+/ {
+	model = "aristainetos i.MX6 Dual Lite Board 7";
+	compatible = "fsl,imx6dl";
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+	soc {
+		display0: display at di0 {
+			compatible = "fsl,imx-parallel-display";
+			interface-pix-fmt = "rgb24";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ipu_disp>;
+			status = "okay";
+
+			display-timings {
+				800x480p60 {
+					native-mode;
+					clock-frequency = <33246000>;
+					hactive = <800>;
+					vactive = <480>;
+					hfront-porch = <88>;
+					hback-porch = <88>;
+					hsync-len = <80>;
+					vback-porch = <10>;
+					vfront-porch = <10>;
+					vsync-len = <25>;
+					vsync-active = <1>;
+				};
+			};
+
+			port {
+				display0_in: endpoint {
+					remote-endpoint = <&ipu1_di0_disp0>;
+				};
+			};
+		};
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm3 0 3000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
new file mode 100644
index 0000000..4281813
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -0,0 +1,436 @@
+/*
+ * support fot the imx6 based aristainetos board
+ *
+ * Copyright (C) 2014 Heiko Schocher <hs@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+/ {
+	regulators {
+		compatible = "simple-bus";
+
+		reg_2p5v: 2p5v {
+			compatible = "regulator-fixed";
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_usbh1_vbus: usb-h1-vbus {
+			compatible = "regulator-fixed";
+			enable-active-high;
+			gpio = <&gpio3 31 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_aristainetos_usbh1_vbus>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
+
+		reg_usbotg_vbus: usb-otg-vbus {
+			compatible = "regulator-fixed";
+			enable-active-high;
+			gpio = <&gpio4 15 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_aristainetos_usbotg_vbus>;
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
+
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+};
+
+&ecspi4 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio3 20 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi4>;
+	status = "okay";
+
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q128a11";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x0 0xc0000>;
+			read-only;
+		};
+		partition at 1 {
+			label = "u-boot-env";
+			reg = <0xd0000 0x10000>;
+		};
+		partition at 2 {
+			label = "u-boot-env-red";
+			reg = <0xe0000 0x10000>;
+		};
+		partition at 3 {
+			label = "kernel";
+			reg = <0xf0000 0x520000>;
+		};
+		partition at 4 {
+			label = "rootfs";
+			reg = <0x610000 0x9f0000>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	tmp103: tmp103 at 71 {
+		compatible = "ti,tmp103";
+		reg = <0x71>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	rtc at 68 {
+		compatible = "dallas,m41t00";
+		reg = <0x68>;
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog &pinctrl_backlight &pinctrl_gpio>;
+
+	imx6qdl-aristainetos {
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29   0x80000000
+		>;
+	};
+
+	pinctrl_backlight: backlightgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__PWM1_OUT	0x1b0b0
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b0
+		>;
+	};
+
+	pinctrl_gpio: gpiogrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10	0x1b0b0
+			MX6QDL_PAD_SD4_DAT3__GPIO2_IO11	0x1b0b0
+			MX6QDL_PAD_SD4_DAT4__GPIO2_IO12 0x1b0b0
+			MX6QDL_PAD_SD4_DAT5__GPIO2_IO13	0x1b0b0
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b0b0
+			MX6QDL_PAD_GPIO_3__GPIO1_IO03	0x1b0b0
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04	0x1b0b0
+			MX6QDL_PAD_GPIO_5__GPIO1_IO05	0x1b0b0
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06	0x1b0b0
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07	0x1b0b0
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08	0x1b0b0
+			MX6QDL_PAD_KEY_COL0__GPIO4_IO06	0x1b0b0
+			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07 0x1b0b0
+			MX6QDL_PAD_KEY_COL1__GPIO4_IO08 0x1b0b0
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK 0x4001b0a8
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO  0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC    0x1b0b0
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0 0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1 0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN   0x1b0b0
+			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER   0x1b0b0
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0 0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1 0x1b0b0
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN  0x1b0b0
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_OE__ECSPI2_MISO 0x100b1
+			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK 0x100b1
+			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI 0x100b1
+			MX6QDL_PAD_EIM_D24__GPIO3_IO24  0x100b1
+		>;
+	};
+
+	pinctrl_ecspi4: ecspi4grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D21__ECSPI4_SCLK 0x100b1
+			MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
+			MX6QDL_PAD_EIM_D28__ECSPI4_MOSI 0x100b1
+			MX6QDL_PAD_EIM_D20__GPIO3_IO20  0x100b1
+			MX6QDL_PAD_SD4_DAT7__GPIO2_IO15 0x1b0b0 /* WP pin */
+		>;
+	};
+
+	pinctrl_aristainetos_usbh1_vbus: aristainetos-usbh1-vbus {
+		fsl,pins = <MX6QDL_PAD_EIM_D31__GPIO3_IO31 0x130b0>;
+	};
+
+	pinctrl_aristainetos_usbotg_vbus: aristainetos-usbotg-vbus {
+		fsl,pins = <MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x130b0>;
+	};
+
+	pinctrl_ipu_disp: ipudisp1grp {
+		fsl,pins = <
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
+			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20			0x20000
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
+			>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x80000000
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x80000000
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX 0x80000000
+			MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX 0x80000000
+			>;
+	};
+
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
+			MX6QDL_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
+			MX6QDL_PAD_SD4_DAT0__NAND_DQS      0x00b1
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
+			MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
+			MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+		>;
+	};
+
+	pinctrl_audmux: audmuxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x80000000
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x80000000
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x80000000
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x80000000
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D26__UART2_TX_DATA 0x1b0b1
+			MX6QDL_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B 0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT14__UART5_TX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA 0x1b0b1
+		>;
+	};
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio3 29 0>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&pcie {
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usbh1_vbus>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usbotg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	vmmc-supply = <&reg_3p3v>;
+	cd-gpios = <&gpio4 7 0>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	vmmc-supply = <&reg_3p3v>;
+	cd-gpios = <&gpio4 8 0>;
+	status = "okay";
+};
-- 
1.8.3.1
