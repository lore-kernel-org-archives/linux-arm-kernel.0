From: denis@eukrea.com (Denis Carikli)
Date: Thu, 17 Oct 2013 17:02:24 +0200
Subject: [Patch v2][ 26/37] arm/dts: Add support for the cpuimx51 board from
 Eukrea and its baseboard.
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <1382022155-21954-27-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following devices/functionalities were added:
 * Main and secondary UARTs.
 * i2c and the pcf8563 device.
 * Sound.
 * CMO-QVGA(With backlight), DVI-VGA and DVI-SVGA displays
 * Ethernet.
 * NAND.
 * The BP1 button.
 * The LED.
 * Watchdog
 * SD.
 * Touchscreen.

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
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |   74 ++++++++++
 .../imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts  |   73 ++++++++++
 .../imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts  |   52 +++++++
 .../imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts   |   52 +++++++
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |  151 ++++++++++++++++++++
 5 files changed, 402 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts

diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
new file mode 100644
index 0000000..01bd40d
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
@@ -0,0 +1,74 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include "imx51.dtsi"
+
+/ {
+	model = "Eukrea CPUIMX51";
+	compatible = "eukrea,cpuimx51", "fsl,imx51";
+
+	memory {
+		reg = <0x90000000 0x10000000>; /* 256M */
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_2>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+	status = "okay";
+
+	pcf8563 at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+
+	tsc2007 at 49 {
+		compatible = "ti,tsc2007";
+		reg = <0x49>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc2007_1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <0x0 0x8>;
+		gpios = <&gpio4 0 0>;
+		x-plate-ohms = <180>;
+	};
+};
+
+&iomuxc {
+	tsc2007 {
+		pinctrl_tsc2007_1: tsc2007grp-1 {
+			fsl,pins = <
+				MX51_PAD_GPIO_NAND__GPIO_NAND 0x1f5
+				MX51_PAD_NANDF_D8__GPIO4_0 0x1f5
+			>;
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
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
new file mode 100644
index 0000000..d206c22
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
@@ -0,0 +1,73 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include "imx51-eukrea-mbimxsd51-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD51 with the CMO-QVGA Display";
+	compatible = "eukrea,mbimxsd51-baseboard-cmo-qvga", "eukrea,mbimxsd51-baseboard", "eukrea,cpuimx51", "fsl,imx51";
+
+	backlight {
+		compatible = "gpio-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight_1>;
+		gpios = <&gpio3 4 0>;
+		default-brightness-level = <1>;
+	};
+
+	reg_lcd_3v3: lcd-en {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 13 0>;
+		enable-active-high;
+	};
+
+};
+
+&display {
+	display = <&cmo_qvga>;
+	lcd-supply = <&reg_lcd_3v3>;
+	status = "okay";
+
+	cmo_qvga: display {
+		model = "CMO-QVGA";
+		bits-per-pixel = <16>;
+		native-mode = <&qvga_timings>;
+		display-timings {
+		qvga_timings: 320x240 {
+				clock-frequency = <6500000>;
+				hactive = <320>;
+				vactive = <240>;
+				hfront-porch = <20>;
+				hback-porch = <38>;
+				vfront-porch = <4>;
+				vback-porch = <15>;
+				hsync-len = <30>;
+				vsync-len = <3>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <0>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts
new file mode 100644
index 0000000..f7229e9
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-svga.dts
@@ -0,0 +1,52 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include "imx51-eukrea-mbimxsd51-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD51 with the DVI-SVGA Display";
+	compatible = "eukrea,mbimxsd51-baseboard-dvi-svga", "eukrea,mbimxsd51-baseboard", "eukrea,cpuimx51", "fsl,imx51";
+};
+
+&display {
+	display = <&dvi_svga>;
+	status = "okay";
+
+	dvi_svga: display {
+		model = "DVI-SVGA";
+		bits-per-pixel = <16>;
+		native-mode = <&svga_timings>;
+		display-timings {
+			svga_timings: 800x600 {
+				clock-frequency = <38251000>;
+				hactive = <800>;
+				vactive = <600>;
+				hback-porch = <112>;
+				hfront-porch = <32>;
+				vback-porch = <3>;
+				vfront-porch = <17>;
+				hsync-len = <80>;
+				vsync-len = <4>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts
new file mode 100644
index 0000000..ae09850
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-dvi-vga.dts
@@ -0,0 +1,52 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include "imx51-eukrea-mbimxsd51-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD51 with the DVI-VGA Display";
+	compatible = "eukrea,mbimxsd51-baseboard-dvi-vga", "eukrea,mbimxsd51-baseboard", "eukrea,cpuimx51", "fsl,imx51";
+};
+
+&display {
+	display = <&dvi_vga>;
+	status = "okay";
+
+	dvi_vga: display {
+		model = "DVI-VGA";
+		bits-per-pixel = <16>;
+		native-mode = <&vga_timings>;
+		display-timings {
+			vga_timings: 640x480 {
+				clock-frequency = <23750000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <80>;
+				hfront-porch = <16>;
+				vback-porch = <3>;
+				vfront-porch = <13>;
+				hsync-len = <64>;
+				vsync-len = <4>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
new file mode 100644
index 0000000..d47fa9a
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -0,0 +1,151 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+/dts-v1/;
+#include "imx51-eukrea-cpuimx51.dtsi"
+
+/ {
+	model = "Eukrea CPUIMX51";
+	compatible = "eukrea,mbimxsd51","eukrea,cpuimx51", "fsl,imx51";
+
+	soc {
+		display: display at di0 {
+			compatible = "fsl,imx-parallel-display";
+			crtcs = <&ipu 0>;
+			interface-pix-fmt = "rgb666";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ipu_disp1_1>;
+			status = "disabled";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys_1>;
+
+		button-1 {
+			label = "BP1";
+			gpios = <&gpio3 31 1>;
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
+			gpios = <&gpio3 30 1>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	sound {
+		compatible = "eukrea,eukrea-tlv320";
+		model = "imx51-eukrea-tlv320aic23";
+		ssi-controller = <&ssi2>;
+		fsl,audio-codec = <&tlv320aic23>;
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux_1>;
+	status = "okay";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_1 &pinctrl_esdhc1_cd>;
+	fsl,cd-controller;
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
+	backlight {
+		pinctrl_backlight_1: backlightgrp-1 {
+			fsl,pins = <
+				MX51_PAD_DI1_D1_CS__GPIO3_4 0x1f5
+			>;
+		};
+	};
+
+	esdhc1 {
+		pinctrl_esdhc1_cd: esdhc1_cd {
+			fsl,pins = <
+				MX51_PAD_GPIO1_0__SD1_CD 0x20d5
+			>;
+		};
+	};
+
+	gpio-keys {
+		pinctrl_gpiokeys_1: gpiokeysgrp-1 {
+			fsl,pins = <
+				MX51_PAD_NANDF_D9__GPIO3_31 0x1f5
+			>;
+		};
+	};
+
+	leds {
+		pinctrl_gpioled: gpioledgrp-1 {
+			fsl,pins = <
+				MX51_PAD_NANDF_D10__GPIO3_30 0x80000000
+			>;
+		};
+	};
+
+	reg_lcd_3v3 {
+		pinctrl_reg_lcd_3v3: reg_lcd_3v3 {
+			fsl,pins = <
+				MX51_PAD_CSI1_D9__GPIO3_13 0x1f5
+			>;
+		};
+	};
+};
+
+&ssi2 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_2 &pinctrl_uart3_rtscts_2>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
-- 
1.7.9.5
