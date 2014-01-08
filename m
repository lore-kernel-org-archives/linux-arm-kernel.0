From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  8 Jan 2014 19:31:54 +0400
Subject: [PATCH] ARM: dts: imx53-evk: Remove board support
Message-ID: <1389195114-6209-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx53-evk board is discontinued by Freescale. The replacement is
imx53-qsb. Additionally this board is not supported by anyone and
in their current state is non-functional, for example PMIC not have
an IRQ line defined, so it is not works. This patch removes this DTS.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile      |   1 -
 arch/arm/boot/dts/imx53-evk.dts | 150 ----------------------------------------
 2 files changed, 151 deletions(-)
 delete mode 100644 arch/arm/boot/dts/imx53-evk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 529b6e6..2f9eab6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -148,7 +148,6 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx51-babbage.dtb \
 	imx51-eukrea-mbimxsd51-baseboard.dtb \
 	imx53-ard.dtb \
-	imx53-evk.dtb \
 	imx53-m53evk.dtb \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
deleted file mode 100644
index 214ac2e..0000000
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ /dev/null
@@ -1,150 +0,0 @@
-/*
- * Copyright 2011 Freescale Semiconductor, Inc.
- * Copyright 2011 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-/dts-v1/;
-#include "imx53.dtsi"
-
-/ {
-	model = "Freescale i.MX53 Evaluation Kit";
-	compatible = "fsl,imx53-evk", "fsl,imx53";
-
-	memory {
-		reg = <0x70000000 0x80000000>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		green {
-			label = "Heartbeat";
-			gpios = <&gpio7 7 0>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-};
-
-&esdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio3 13 0>;
-	wp-gpios = <&gpio3 14 0>;
-	status = "okay";
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <2>;
-	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
-	status = "okay";
-
-	flash: at45db321d at 1 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
-		spi-max-frequency = <25000000>;
-		reg = <1>;
-
-		partition at 0 {
-			label = "U-Boot";
-			reg = <0x0 0x40000>;
-			read-only;
-		};
-
-		partition at 40000 {
-			label = "Kernel";
-			reg = <0x40000 0x3c0000>;
-		};
-	};
-};
-
-&esdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc3>;
-	cd-gpios = <&gpio3 11 0>;
-	wp-gpios = <&gpio3 12 0>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
-
-	imx53-evk {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX53_PAD_EIM_EB2__GPIO2_30  0x80000000
-				MX53_PAD_EIM_D19__GPIO3_19  0x80000000
-				MX53_PAD_EIM_DA11__GPIO3_11 0x80000000
-				MX53_PAD_EIM_DA12__GPIO3_12 0x80000000
-				MX53_PAD_EIM_DA13__GPIO3_13 0x80000000
-				MX53_PAD_EIM_DA14__GPIO3_14 0x80000000
-				MX53_PAD_PATA_DA_0__GPIO7_6 0x80000000
-				MX53_PAD_PATA_DA_1__GPIO7_7 0x80000000
-			>;
-		};
-
-		pinctrl_ecspi1: ecspi1grp {
-			fsl,pins = <MX53_ECSPI1_PINGRP1>;
-		};
-
-		pinctrl_esdhc1: esdhc1grp {
-			fsl,pins = <MX53_ESDHC1_PINGRP1>;
-		};
-
-		pinctrl_esdhc3: esdhc3grp {
-			fsl,pins = <MX53_ESDHC3_PINGRP1>;
-		};
-
-		pinctrl_fec: fecgrp {
-			fsl,pins = <MX53_FEC_PINGRP1>;
-		};
-
-		pinctrl_i2c2: i2c2grp {
-			fsl,pins = <MX53_I2C2_PINGRP1>;
-		};
-
-		pinctrl_uart1: uart1grp {
-			fsl,pins = <MX53_UART1_PINGRP1>;
-		};
-	};
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	pmic: mc13892 at 08 {
-		compatible = "fsl,mc13892", "fsl,mc13xxx";
-		reg = <0x08>;
-	};
-
-	codec: sgtl5000 at 0a {
-		compatible = "fsl,sgtl5000";
-		reg = <0x0a>;
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
-	status = "okay";
-};
-- 
1.8.3.2
