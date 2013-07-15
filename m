From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:57:05 +0200
Subject: =?UTF-8?q?=5BPATCH=2020/22=5D=20arm/dts=3A=20Add=20support=20for=20the=20cpuimx51=20board=20from=20Eukrea=20and=20its=20baseboard=2E?=
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-21-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the following devices/functionalities were added:
 * Main UART and the memory node information.
 * NAND.
 * Ethernet.
 * i2c and its pcf8563 device.
 * The GPIO button (its label is BP1 on the baseboard).
 * The GPIO backlight.
 * The GPIO LCD enabling/disabling.
 * Display/IPU controller.
 * Touchscreen.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt     |    4 +
 arch/arm/boot/dts/eukrea_cpuimx51.dts             |   69 ++++++++++++++
 arch/arm/boot/dts/eukrea_mbimxsd51-baseboard.dtsi |  105 +++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 arch/arm/boot/dts/eukrea_cpuimx51.dts
 create mode 100644 arch/arm/boot/dts/eukrea_mbimxsd51-baseboard.dtsi

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 2c19348..4001d91 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -25,6 +25,10 @@ i.MX51 Babbage Board
 Required root node properties:
     - compatible = "fsl,imx51-babbage", "fsl,imx51";
 
+i.MX51 Eukrea CPUIMX51 Board
+Required root node properties:
+    - compatible = "fsl,eukrea_cpuimx51", "fsl,imx51";
+
 i.MX53 Automotive Reference Design Board
 Required root node properties:
     - compatible = "fsl,imx53-ard", "fsl,imx53";
diff --git a/arch/arm/boot/dts/eukrea_cpuimx51.dts b/arch/arm/boot/dts/eukrea_cpuimx51.dts
new file mode 100644
index 0000000..4e944cd
--- /dev/null
+++ b/arch/arm/boot/dts/eukrea_cpuimx51.dts
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
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
+#include "imx51.dtsi"
+#include "eukrea_mbimxsd51-baseboard.dtsi"
+
+/ {
+	model = "Eukrea CPUIMX51";
+	compatible = "fsl,eukrea_cpuimx51", "fsl,imx51";
+
+	memory {
+		reg = <0x90000000 0x10000000>; /* 256M */
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
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+	status = "okay";
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
+
+	pcf8563 at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_2>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/eukrea_mbimxsd51-baseboard.dtsi b/arch/arm/boot/dts/eukrea_mbimxsd51-baseboard.dtsi
new file mode 100644
index 0000000..6d74659
--- /dev/null
+++ b/arch/arm/boot/dts/eukrea_mbimxsd51-baseboard.dtsi
@@ -0,0 +1,105 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "skeleton.dtsi"
+
+/ {
+	soc {
+		display at di0 {
+			compatible = "fsl,imx-parallel-display";
+			crtcs = <&ipu 0>;
+			interface-pix-fmt = "rgb666";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ipu_disp1_1>;
+
+			display-timings {
+			native-mode = <&cmoqvga>;
+				cmoqvga: 320x240 {
+					clock-frequency = <6500000>;
+					hactive = <320>;
+					vactive = <240>;
+					hfront-porch = <20>;
+					hback-porch = <38>;
+					vfront-porch = <4>;
+					vback-porch = <15>;
+					hsync-len = <30>;
+					vsync-len = <3>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					de-active = <0>;
+					pixelclk-active = <1>;
+				};
+			};
+		};
+	};
+
+	gpio-keys {
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
+	backlight {
+		compatible = "gpio-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight_1>;
+		gpios = <&gpio3 4 0>;
+		default-brightness-level = <1>;
+	};
+
+	lcd {
+		compatible = "gpio-lcd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd_1>;
+		gpios = <&gpio3 13 0>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&iomuxc {
+	gpio-keys {
+		pinctrl_gpiokeys_1: gpiokeysgrp-1 {
+			fsl,pins = <
+				MX51_PAD_NANDF_D9__GPIO3_31 0x1f5
+			>;
+		};
+	};
+
+	backlight {
+		pinctrl_backlight_1: backlightgrp-1 {
+			fsl,pins = <
+				MX51_PAD_DI1_D1_CS__GPIO3_4 0x1f5
+			>;
+		};
+	};
+
+	lcd {
+		pinctrl_lcd_1: lcdgrp-1 {
+			fsl,pins = <
+				MX51_PAD_CSI1_D9__GPIO3_13 0x1f5
+			>;
+		};
+	};
+};
-- 
1.7.9.5
