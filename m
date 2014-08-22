From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 21 Aug 2014 20:55:06 -0700
Subject: [PATCH v2] ARM: dts: Gateworks GW5520 support (i.MX6)
In-Reply-To: <1407572602-14017-1-git-send-email-tharvey@gateworks.com>
References: <1407572602-14017-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1408679706-18200-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Gateworks GW5520 board.

Cc: Tony Prisk <linux@prisktech.co.nz>
Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
Changes in v2:
 - use GPIO constants
 - move gpio pins from hoggrp to gpiogrp
 - use proper pad conf instead of 0x80000000
 - moved iomuxc to bottom for readability
 - pulled gpioledsgrp into iomuxc
 - fix whitespace errors
 - Note that a patch was sent for adding the vendor prefix of 'gw' for
   Gateworks and is queued for inclusion

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/Makefile            |   2 +
 arch/arm/boot/dts/imx6dl-gw552x.dts   |  20 +++
 arch/arm/boot/dts/imx6q-gw552x.dts    |  24 +++
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 278 ++++++++++++++++++++++++++++++++++
 4 files changed, 324 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-gw552x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw552x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw552x.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index adb5ed9..99697b4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -188,6 +188,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6dl-gw52xx.dtb \
 	imx6dl-gw53xx.dtb \
 	imx6dl-gw54xx.dtb \
+	imx6dl-gw552x.dtb \
 	imx6dl-hummingboard.dtb \
 	imx6dl-nitrogen6x.dtb \
 	imx6dl-phytec-pbab01.dtb \
@@ -207,6 +208,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-gw53xx.dtb \
 	imx6q-gw5400-a.dtb \
 	imx6q-gw54xx.dtb \
+	imx6q-gw552x.dtb \
 	imx6q-nitrogen6x.dtb \
 	imx6q-phytec-pbab01.dtb \
 	imx6q-sabreauto.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-gw552x.dts b/arch/arm/boot/dts/imx6dl-gw552x.dts
new file mode 100644
index 0000000..a4b700c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-gw552x.dts
@@ -0,0 +1,20 @@
+/*
+ * Copyright 2014 Gateworks Corporation
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
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-gw552x.dtsi"
+
+/ {
+	model = "Gateworks Ventana i.MX6 DualLite/Solo GW552X";
+	compatible = "gw,imx6dl-gw552x", "gw,ventana", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/imx6q-gw552x.dts b/arch/arm/boot/dts/imx6q-gw552x.dts
new file mode 100644
index 0000000..f87a8fa
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-gw552x.dts
@@ -0,0 +1,24 @@
+/*
+ * Copyright 2014 Gateworks Corporation
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
+
+#include "imx6q.dtsi"
+#include "imx6qdl-gw552x.dtsi"
+
+/ {
+	model = "Gateworks Ventana i.MX6 Dual/Quad GW552X";
+	compatible = "gw,imx6q-gw552x", "gw,ventana", "fsl,imx6q";
+};
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
new file mode 100644
index 0000000..d75e22a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -0,0 +1,278 @@
+/*
+ * Copyright 2014 Gateworks Corporation
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	/* these are used by bootloader for disabling nodes */
+	aliases {
+		led0 = &led0;
+		led1 = &led1;
+		led2 = &led2;
+		nand = &gpmi;
+		usb0 = &usbh1;
+		usb1 = &usbotg;
+	};
+
+	chosen {
+		bootargs = "console=ttymxc1,115200";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led0: user1 {
+			label = "user1";
+			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led1: user2 {
+			label = "user2";
+			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
+			default-state = "off";
+		};
+
+		led2: user3 {
+			label = "user3";
+			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
+			default-state = "off";
+		};
+	};
+
+	memory {
+		reg = <0x10000000 0x20000000>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_1p0v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "1P0V";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-always-on;
+		};
+
+		reg_3p3v: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_5p0v: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "5P0V";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "okay";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c3>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	eeprom1: eeprom at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+
+	eeprom2: eeprom at 51 {
+		compatible = "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+	};
+
+	eeprom3: eeprom at 52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <16>;
+	};
+
+	eeprom4: eeprom at 53 {
+		compatible = "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <16>;
+	};
+
+	gpio: pca9555 at 23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	rtc: ds1672 at 68 {
+		compatible = "dallas,ds1672";
+		reg = <0x68>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
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
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay"; };
+
+&usbh1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx6qdl-gw552x {
+		pinctrl_gpio: gpiogrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x4001b0b0 /* USBHUB_RST# */
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x4001b0b0 /* PCIESKT_WDIS# */
+			>;
+		};
+
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x1b0b0
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
+			>;
+		};
+
+		pinctrl_gpmi_nand: gpminandgrp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+				MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
+				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+				MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+				MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+				MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+				MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+				MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+				MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+				MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
+				MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+			>;
+		};
+
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
+				MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+			>;
+		};
+
+		pinctrl_uart5: uart5grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x1b0b1
+				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
+			>;
+                };
+	};
+};
-- 
1.8.3.2
