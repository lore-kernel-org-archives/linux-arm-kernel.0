From: denis@eukrea.com (Denis Carikli)
Date: Wed, 30 Oct 2013 17:51:14 +0100
Subject: [PATCHv6][ 2/3] arm/dts: Add support for the cpuimx35 board from
 Eukrea and its baseboard.
In-Reply-To: <1383151875-7708-1-git-send-email-denis@eukrea.com>
References: <1383151875-7708-1-git-send-email-denis@eukrea.com>
Message-ID: <1383151875-7708-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following devices/functionalities were added:
 * Main and secondary UARTs.
 * i2c and the pcf8563 device.
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
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
ChangeLog v5->v6:
- Shawn Guo was added in the Cc.
---
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |   61 ++++++++++
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |  124 ++++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts

diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
new file mode 100644
index 0000000..2c2d4cd
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
@@ -0,0 +1,61 @@
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
+};
+
+&iomuxc {
+	tsc2007 {
+		pinctrl_tsc2007_1: tsc2007grp-1 {
+			fsl,pins = <
+				MX35_PAD_ATA_DA2__GPIO3_2 0x80000000
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
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
new file mode 100644
index 0000000..5aafde3
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
@@ -0,0 +1,124 @@
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
