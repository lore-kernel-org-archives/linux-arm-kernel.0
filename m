From: denis@eukrea.com (Denis Carikli)
Date: Thu, 17 Oct 2013 17:02:25 +0200
Subject: [Patch v2][ 27/37] arm/dts: Add support for the cpuimx35 board from
 Eukrea and its baseboard.
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <1382022155-21954-28-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following devices/functionalities were added:
 * Main and secondary UARTs.
 * i2c and the pcf8563 device.
 * Sound.
 * CMO-QVGA, DVI-VGA and DVI-SVGA displays
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
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |   63 ++++++++
 .../imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts  |   59 ++++++++
 .../imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts  |   51 +++++++
 .../imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts   |   51 +++++++
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |  152 ++++++++++++++++++++
 5 files changed, 376 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts

diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
new file mode 100644
index 0000000..f6570d4
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
@@ -0,0 +1,63 @@
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
+#include "imx35.dtsi"
+
+/ {
+	model = "Eukrea CPUIMX35";
+	compatible = "eukrea,cpuimx35", "fsl,imx35";
+
+	memory {
+		reg = <0x80000000 0x8000000>; /* 128M */
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+	status = "okay";
+	pcf8563 at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+
+	tsc2007: tsc2007 at 48 {
+		compatible = "ti,tsc2007";
+		reg = <0x48>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc2007_1>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <0x2 0x8>;
+		gpios = <&gpio3 2 0>;
+		x-plate-ohms = <180>;
+	};
+};
+
+&nfc {
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts
new file mode 100644
index 0000000..8ba8659
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts
@@ -0,0 +1,59 @@
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
+#include "imx35-eukrea-mbimxsd35-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD35 with the CMO-QVGA Display";
+	compatible = "eukrea,mbimxsd35-baseboard-cmo-qvga", "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
+	cmo_qvga: display {
+		model = "CMO-QVGA";
+		bits-per-pixel = <16>;
+		native-mode = <&qvga_timings>;
+		display-timings {
+			qvga_timings: 320x240 {
+				clock-frequency = <6500000>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <68>;
+				hfront-porch = <20>;
+				vback-porch = <15>;
+				vfront-porch = <4>;
+				hsync-len = <30>;
+				vsync-len = <3>;
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
+		gpio = <&gpio1 4 0>;
+		enable-active-high;
+	};
+};
+
+&lcdc {
+	display = <&cmo_qvga>;
+	lcd-supply = <&reg_lcd_3v3>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts
new file mode 100644
index 0000000..35e5c04
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts
@@ -0,0 +1,51 @@
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
+#include "imx35-eukrea-mbimxsd35-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD35 with the DVI-SVGA Display";
+	compatible = "eukrea,mbimxsd35-baseboard-dvi-svga", "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
+	dvi_svga: display {
+		model = "DVI-SVGA";
+		bits-per-pixel = <16>;
+		native-mode = <&svga_timings>;
+		display-timings {
+			svga_timings: 800x600 {
+				clock-frequency = <40000000>;
+				hactive = <800>;
+				vactive = <600>;
+				hback-porch = <75>;
+				hfront-porch = <75>;
+				vback-porch = <7>;
+				vfront-porch = <75>;
+				hsync-len = <7>;
+				vsync-len = <7>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&lcdc {
+	display = <&dvi_svga>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts
new file mode 100644
index 0000000..b64118c
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts
@@ -0,0 +1,51 @@
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
+#include "imx35-eukrea-mbimxsd35-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD35 with the DVI-VGA Display";
+	compatible = "eukrea,mbimxsd35-baseboard-dvi-vga", "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
+	dvi_vga: display {
+		model = "DVI-VGA";
+		bits-per-pixel = <16>;
+		native-mode = <&vga_timings>;
+		display-timings {
+			vga_timings: 640x480 {
+				clock-frequency = <31250000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <100>;
+				hfront-porch = <100>;
+				vback-porch = <7>;
+				vfront-porch = <100>;
+				hsync-len = <7>;
+				vsync-len = <7>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&lcdc {
+	display = <&dvi_vga>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
new file mode 100644
index 0000000..ff22ca7
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
@@ -0,0 +1,152 @@
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
+#include "imx35-eukrea-cpuimx35.dtsi"
+
+/ {
+	model = "Eukrea CPUIMX35";
+	compatible = "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys_1>;
+
+		bp1 {
+			label = "BP1";
+			gpios = <&gpio3 25 1>;
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
+			gpios = <&gpio3 29 1>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	sound {
+		compatible = "eukrea,eukrea-tlv320";
+		model = "imx35-eukrea-tlv320aic23";
+		ssi-controller = <&ssi1>;
+		fsl,audio-codec = <&tlv320aic23>;
+		mux-int-port = <1>;
+		mux-ext-port = <4>;
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
+	cd-gpios = <&gpio3 24 0>;
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
+	esdhc1 {
+		pinctrl_esdhc1_cd: esdhc1_cd_grp-1 {
+			fsl,pins = <
+				MX35_PAD_LD18__GPIO3_24 0x80000000
+			>;
+		};
+	};
+
+	gpio_keys {
+		pinctrl_gpiokeys_1: gpiokeysgrp-1 {
+			fsl,pins = <
+				MX35_PAD_LD19__GPIO3_25 0x80000000
+			>;
+		};
+	};
+
+	leds {
+		pinctrl_gpioled: gpioledgrp-1 {
+			fsl,pins = <
+				MX35_PAD_LD23__GPIO3_29 0x80000000
+			>;
+		};
+	};
+
+	reg_lcd_3v3 {
+		pinctrl_reg_lcd_3v3: reg_lcd_3v3 {
+			fsl,pins = <
+				MX35_PAD_D3_CLS__GPIO1_4 0x80000000
+			>;
+		};
+	};
+
+	tsc2007 {
+		pinctrl_tsc2007_1: tsc2007grp-1 {
+			fsl,pins = <
+				MX35_PAD_ATA_DA2__GPIO3_2 0x80000000
+			>;
+		};
+	};
+
+};
+
+&ipu {
+	status = "okay";
+};
+
+&lcdc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdc_1>;
+	ipu-disp-format = "rgb666";
+};
+
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
-- 
1.7.9.5
