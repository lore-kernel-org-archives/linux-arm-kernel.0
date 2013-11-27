From: denis@eukrea.com (Denis Carikli)
Date: Wed, 27 Nov 2013 16:27:44 +0100
Subject: [PATCH] ARM: dts: Add support for the cpuimx53 board from Eukrea and
 its baseboard.
Message-ID: <1385566064-30761-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following devices/functionalities were added:
 * Main and secondary UARTs.
 * i2c and the pcf8563 device.
 * Ethernet.
 * NAND.
 * The BP1 button.
 * The LED.
 * Watchdog.
 * SD.
 * USB host.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi       |   81 +++++++++++++++
 .../boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts  |  106 ++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi
 create mode 100644 arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts

diff --git a/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi b/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi
new file mode 100644
index 0000000..cb40cf3
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi
@@ -0,0 +1,81 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "imx53.dtsi"
+
+/ {
+	model = "Eukrea CPUIMX53";
+	compatible = "eukrea,cpuimx53", "fsl,imx53";
+
+	memory {
+		reg = <0x70000000 0x20000000>; /* 512M */
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-reset-gpios = <&gpio2 30 1>;
+	phy-mode = "rmii";
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pcf8563 at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx53-eukrea {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX53_PAD_EIM_EB2__GPIO2_30 0x1e4
+			>;
+		};
+
+		pinctrl_fec: fecgrp {
+			fsl,pins = <MX53_FEC_PINGRP1>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <MX53_I2C1_PINGRP1>;
+		};
+
+		pinctrl_nand: nandgrp {
+			fsl,pins = <MX53_NAND_PINGRP1>;
+
+		};
+	};
+};
+
+&nfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nand>;
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	status = "okay";
+};
+
+&usbh1 {
+	phy_type = "utmi";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts
new file mode 100644
index 0000000..95929aa
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts
@@ -0,0 +1,106 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+#include "imx53-eukrea-cpuimx53.dtsi"
+
+/ {
+	model = "Eukrea MBIMX53SD";
+	compatible = "eukrea,mbimxsd53","eukrea,cpuimx53", "fsl,imx53";
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+
+		button-1 {
+			label = "BP1";
+			gpios = <&gpio4 14 1>;
+			linux,code = <256>;
+			gpio-key,wakeup;
+			linux,input-type = <1>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpioled>;
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio4 15 1>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_3p3v: 3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1 &pinctrl_esdhc1_cd>;
+	cd-gpios = <&gpio5 17 1>;
+	vqmmc-supply = <&reg_3p3v>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&iomuxc {
+	imx53-eukrea {
+		pinctrl_esdhc1: esdhc1 {
+			fsl,pins = <MX53_ESDHC1_PINGRP1>;
+		};
+
+		pinctrl_esdhc1_cd: esdhc1_cd {
+			fsl,pins = <MX53_PAD_DISP0_DAT23__GPIO5_17 0x80000000>;
+		};
+
+		pinctrl_gpiokeys: gpiokeysgrp {
+			fsl,pins = <MX53_PAD_KEY_COL4__GPIO4_14 0x80000000>;
+		};
+
+		pinctrl_gpioled: gpioledgrp {
+			fsl,pins = <MX53_PAD_KEY_ROW4__GPIO4_15 0x80000000>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <MX53_UART1_PINGRP2>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <MX53_UART2_PINGRP2>;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
-- 
1.7.9.5
