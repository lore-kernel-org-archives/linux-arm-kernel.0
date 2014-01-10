From: denis@eukrea.com (Denis Carikli)
Date: Fri, 10 Jan 2014 16:40:40 +0100
Subject: [PATCHv10][ 2/3] ARM: dts: Add support for the cpuimx35 board from
 Eukrea and its baseboard.
In-Reply-To: <1389368441-26310-1-git-send-email-denis@eukrea.com>
References: <1389368441-26310-1-git-send-email-denis@eukrea.com>
Message-ID: <1389368441-26310-2-git-send-email-denis@eukrea.com>
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
Cc: Grant Likely <grant.likely@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
ChangeLog v9->v10:
- Added Fabio Estevam To the Cc list

ChangeLog v8->v9:
- Added the dtb target into arch/arm/boot/dts/Makefile.
- Added a blank line before the pcf8563 node in the i2c1 node.
- Whitespace cleanups as requested by Shawn Guo.
- _' was used in label, it's now fixed (it has been replaced with '-').
- The recently introduced defines for input and gpios are now used.
- The uarts had the fsl,uart-has-rtscts property set, but they didn't use 
  any rts and cts pins in the uart pinctrl nodes.

ChangeLog v7->v8:
- The commit message was improved.
- The board specific iomuxc pins group configuration that were in imx35.dtsi were moved here.
- The rest of the patch was updated accordingly.

ChangeLog v6->v7:
- Added Grant Likely in the Cc list.
- Shortened the license.
- The tsc2007 pads were moved in another patch.

ChangeLog v5->v6:
- Shawn Guo was added in the Cc.
---
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |   59 +++++++++
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |  127 ++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 059d280..d41edc7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -143,6 +143,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-phytec-phycard-s-som.dtb \
 	imx27-phytec-phycard-s-rdk.dtb \
 	imx31-bug.dtb \
+	imx35-eukrea-mbimxsd35-baseboard.dtb \
 	imx50-evk.dtb \
 	imx51-apf51.dtb \
 	imx51-apf51dev.dtb \
diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
new file mode 100644
index 0000000..303f789
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
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
+	imx35-eukrea {
+		pinctrl_fec: fecgrp {
+			fsl,pins = <MX35_FEC_PINGRP1>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <MX35_I2C1_PINGRP1>;
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
index 0000000..8c46596
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
@@ -0,0 +1,127 @@
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
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "imx35-eukrea-cpuimx35.dtsi"
+
+/ {
+	model = "Eukrea CPUIMX35";
+	compatible = "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		bp1 {
+			label = "BP1";
+			gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_MISC>;
+			gpio-key,wakeup;
+			linux,input-type = <1>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
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
+	cd-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx35-eukrea {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX35_PAD_LD18__GPIO3_24  0x80000000
+				MX35_PAD_LD19__GPIO3_25  0x80000000
+				MX35_PAD_LD23__GPIO3_29  0x80000000
+			>;
+		};
+
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <MX35_AUDMUX_PINGRP1>;
+		};
+
+		pinctrl_esdhc1: esdhc1grp {
+			fsl,pins = <MX35_ESDHC1_PINGRP1>;
+		};
+
+		pinctrl_fec: fecgrp {
+			fsl,pins = <MX35_FEC_PINGRP1>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <MX35_I2C1_PINGRP1>;
+		};
+
+		pinctrl_reg_lcd_3v3: reg-lcd-3v3 {
+			fsl,pins = <MX35_PAD_D3_CLS__GPIO1_4 0x80000000>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <MX35_UART1_PINGRP1 MX35_UART1_RTSCTS_PINGRP1>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <MX35_UART2_PINGRP1 MX35_UART2_RTSCTS_PINGRP1>;
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
