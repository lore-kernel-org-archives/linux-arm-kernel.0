From: denis@eukrea.com (Denis Carikli)
Date: Wed,  6 Nov 2013 09:52:19 +0100
Subject: [PATCHv12][ 8/8] ARM: dts: Add support for the cpuimx25 board from
 Eukrea and its baseboard.
In-Reply-To: <1383727939-4190-1-git-send-email-denis@eukrea.com>
References: <1383727939-4190-1-git-send-email-denis@eukrea.com>
Message-ID: <1383727939-4190-8-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following devices/functionalities were added:
 * Main and secondary UARTs.
 * i2c and the pcf8563 device.
 * CMO-QVGA(With backlight), DVI-VGA and DVI-SVGA displays
 * Ethernet.
 * NAND.
 * The BP1 button.
 * The LED.
 * Watchdog
 * SD.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v9->v10:
- Adapted to the new pingrp patches.

ChangeLog v8->v9:
- Licenses were shortened.
---
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   60 ++++++++++
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   66 +++++++++++
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts  |   45 ++++++++
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts   |   45 ++++++++
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |  117 ++++++++++++++++++++
 5 files changed, 333 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts

diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
new file mode 100644
index 0000000..8abd45a
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -0,0 +1,60 @@
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
+#include "imx25.dtsi"
+
+/ {
+	model = "Eukrea CPUIMX25";
+	compatible = "eukrea,cpuimx25", "fsl,imx25";
+
+	memory {
+		reg = <0x80000000 0x4000000>; /* 64M */
+	};
+};
+
+&fec {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
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
+	imx25-eukrea-cpuimx25 {
+		pinctrl_fec: fecgrp {
+			fsl,pins = <MX25_FEC_PINGRP1>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <MX25_I2C1_PINGRP1>;
+		};
+	};
+};
+
+&nfc {
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
new file mode 100644
index 0000000..622de82
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -0,0 +1,66 @@
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
+#include "imx25-eukrea-mbimxsd25-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD25 with the CMO-QVGA Display";
+	compatible = "eukrea,mbimxsd25-baseboard-cmo-qvga", "eukrea,mbimxsd25-baseboard", "eukrea,cpuimx25", "fsl,imx25";
+
+	cmo_qvga: display {
+		model = "CMO-QVGA";
+		bits-per-pixel = <16>;
+		fsl,pcr = <0xcad08b80>;
+		bus-width = <18>;
+		native-mode = <&qvga_timings>;
+		display-timings {
+			qvga_timings: 320x240 {
+				clock-frequency = <6500000>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <30>;
+				hfront-porch = <38>;
+				vback-porch = <20>;
+				vfront-porch = <3>;
+				hsync-len = <15>;
+				vsync-len = <4>;
+			};
+		};
+	};
+
+	reg_lcd_3v3: lcd-en {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 26 0>;
+		enable-active-high;
+	};
+};
+
+&iomuxc {
+	imx25-eukrea-mbimxsd25-baseboard-cmo-qvga {
+		pinctrl_reg_lcd_3v3: reg_lcd_3v3 {
+			fsl,pins = <MX25_PAD_PWM__GPIO_1_26  0x80000000>;
+		};
+	};
+};
+
+&lcdc {
+	display = <&cmo_qvga>;
+	fsl,pwmr = <0x00a903ff>;
+	lcd-supply = <&reg_lcd_3v3>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
new file mode 100644
index 0000000..8eee2f6
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
@@ -0,0 +1,45 @@
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
+#include "imx25-eukrea-mbimxsd25-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD25 with the DVI-SVGA Display";
+	compatible = "eukrea,mbimxsd25-baseboard-dvi-svga", "eukrea,mbimxsd25-baseboard", "eukrea,cpuimx25", "fsl,imx25";
+
+	dvi_svga: display {
+		model = "DVI-SVGA";
+		bits-per-pixel = <16>;
+		fsl,pcr = <0xfa208b80>;
+		bus-width = <18>;
+		native-mode = <&dvi_svga_timings>;
+		display-timings {
+			dvi_svga_timings: 800x600 {
+				clock-frequency = <40000000>;
+				hactive = <800>;
+				vactive = <600>;
+				hback-porch = <75>;
+				hfront-porch = <75>;
+				vback-porch = <7>;
+				vfront-porch = <75>;
+				hsync-len = <7>;
+				vsync-len = <7>;
+			};
+		};
+	};
+};
+
+&lcdc {
+	display = <&dvi_svga>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
new file mode 100644
index 0000000..447da62
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
@@ -0,0 +1,45 @@
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
+#include "imx25-eukrea-mbimxsd25-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD25 with the DVI-VGA Display";
+	compatible = "eukrea,mbimxsd25-baseboard-dvi-vga", "eukrea,mbimxsd25-baseboard", "eukrea,cpuimx25", "fsl,imx25";
+
+	dvi_vga: display {
+		model = "DVI-VGA";
+		bits-per-pixel = <16>;
+		fsl,pcr = <0xfa208b80>;
+		bus-width = <18>;
+		native-mode = <&dvi_vga_timings>;
+		display-timings {
+			dvi_vga_timings: 640x480 {
+				clock-frequency = <31250000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <100>;
+				hfront-porch = <100>;
+				vback-porch = <7>;
+				vfront-porch = <100>;
+				hsync-len = <7>;
+				vsync-len = <7>;
+			};
+		};
+	};
+};
+
+&lcdc {
+	display = <&dvi_vga>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
new file mode 100644
index 0000000..fad6847
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -0,0 +1,117 @@
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
+#include "imx25-eukrea-cpuimx25.dtsi"
+
+/ {
+	model = "Eukrea MBIMXSD25";
+	compatible = "eukrea,mbimxsd25-baseboard", "eukrea,cpuimx25", "fsl,imx25";
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+
+		bp1 {
+			label = "BP1";
+			gpios = <&gpio3 18 1>;
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
+			gpios = <&gpio3 19 1>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	cd-gpios = <&gpio1 20>;
+	status = "okay";
+};
+
+&i2c1 {
+	tlv320aic23: codec at 1a {
+		compatible = "ti,tlv320aic23";
+		reg = <0x1a>;
+	};
+};
+
+&iomuxc {
+	imx25-eukrea-mbimxsd25-baseboard {
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <MX25_AUDMUX_PINGRP1>;
+		};
+
+		pinctrl_esdhc1: esdhc1grp {
+			fsl,pins = <MX25_ESDHC1_PINGRP1>;
+		};
+
+		pinctrl_gpiokeys: gpiokeysgrp {
+			fsl,pins = <MX25_PAD_VSTBY_ACK__GPIO_3_18 0x80000000>;
+		};
+
+		pinctrl_gpioled: gpioledgrp {
+			fsl,pins = <MX25_PAD_POWER_FAIL__GPIO_3_19 0x80000000>;
+		};
+
+		pinctrl_lcdc: lcdcgrp {
+			fsl,pins = <MX25_LCDC_PINGRP1>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <MX25_UART1_PINGRP1>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <MX25_UART2_PINGRP1>;
+		};
+	};
+};
+
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
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
