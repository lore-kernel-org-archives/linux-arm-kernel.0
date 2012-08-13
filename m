From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:31 +0800
Subject: [PATCH 11/17] ARM: dts: imx53-smd: add pinctrl settings
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-12-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl settings for the exsiting devices in imx53-smd.dts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-smd.dts |   38 ++++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx53.dtsi    |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 8cdf0a2..dd7e792 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -25,22 +25,30 @@
 		aips at 50000000 { /* AIPS1 */
 			spba at 50000000 {
 				esdhc at 50004000 { /* ESDHC1 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc1_1>;
 					cd-gpios = <&gpio3 13 0>;
 					wp-gpios = <&gpio4 11 0>;
 					status = "okay";
 				};
 
 				esdhc at 50008000 { /* ESDHC2 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc2_1>;
 					non-removable;
 					status = "okay";
 				};
 
 				uart3: serial at 5000c000 {
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_uart3_1>;
 					fsl,uart-has-rtscts;
 					status = "okay";
 				};
 
 				ecspi at 50010000 { /* ECSPI1 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_ecspi1_1>;
 					fsl,spi-num-chipselects = <2>;
 					cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
 					status = "okay";
@@ -72,27 +80,49 @@
 				};
 
 				esdhc at 50020000 { /* ESDHC3 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc3_1>;
 					non-removable;
 					status = "okay";
 				};
 			};
 
 			iomuxc at 53fa8000 {
-				compatible = "fsl,imx53-iomuxc-smd";
-				reg = <0x53fa8000 0x4000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_hog>;
+
+				hog {
+					pinctrl_hog: hoggrp {
+						fsl,pins = <
+							982 0x80000000	/* MX53_PAD_PATA_DATA14__GPIO2_14 */
+							989 0x80000000	/* MX53_PAD_PATA_DATA15__GPIO2_15 */
+							424 0x80000000	/* MX53_PAD_EIM_EB2__GPIO2_30 */
+							701 0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
+							449 0x80000000	/* MX53_PAD_EIM_D19__GPIO3_19 */
+							43  0x80000000	/* MX53_PAD_KEY_ROW2__GPIO4_11 */
+							868 0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
+						>;
+					};
+				};
 			};
 
 			uart1: serial at 53fbc000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1_1>;
 				status = "okay";
 			};
 
 			uart2: serial at 53fc0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart2_1>;
 				status = "okay";
 			};
 		};
 
 		aips at 60000000 {	/* AIPS2 */
 			i2c at 63fc4000 { /* I2C2 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c2_1>;
 				status = "okay";
 
 				codec: sgtl5000 at 0a {
@@ -112,6 +142,8 @@
 			};
 
 			i2c at 63fc8000 { /* I2C1 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1_1>;
 				status = "okay";
 
 				accelerometer: mma8450 at 1c {
@@ -131,6 +163,8 @@
 			};
 
 			ethernet at 63fec000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_fec_1>;
 				phy-mode = "rmii";
 				phy-reset-gpios = <&gpio7 6 0>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index e91cbc0..a8df8a4 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -251,6 +251,19 @@
 					};
 				};
 
+				esdhc2 {
+					pinctrl_esdhc2_1: esdhc2grp-1 {
+						fsl,pins = <
+							1038 0x1d5	/* MX53_PAD_SD2_CMD__ESDHC2_CMD */
+							1032 0x1d5	/* MX53_PAD_SD2_CLK__ESDHC2_CLK */
+							1062 0x1d5	/* MX53_PAD_SD2_DATA0__ESDHC2_DAT0 */
+							1056 0x1d5	/* MX53_PAD_SD2_DATA1__ESDHC2_DAT1 */
+							1050 0x1d5	/* MX53_PAD_SD2_DATA2__ESDHC2_DAT2 */
+							1044 0x1d5	/* MX53_PAD_SD2_DATA3__ESDHC2_DAT3 */
+						>;
+					};
+				};
+
 				esdhc3 {
 					pinctrl_esdhc3_1: esdhc3grp-1 {
 						fsl,pins = <
@@ -301,6 +314,26 @@
 						>;
 					};
 				};
+
+				uart2 {
+					pinctrl_uart2_1: uart2grp-1 {
+						fsl,pins = <
+							841 0x1c5	/* MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX */
+							836 0x1c5	/* MX53_PAD_PATA_DMARQ__UART2_TXD_MUX */
+						>;
+					};
+				};
+
+				uart3 {
+					pinctrl_uart3_1: uart3grp-1 {
+						fsl,pins = <
+							884 0x1c5	/* MX53_PAD_PATA_CS_0__UART3_TXD_MUX */
+							888 0x1c5	/* MX53_PAD_PATA_CS_1__UART3_RXD_MUX */
+							875 0x1c5	/* MX53_PAD_PATA_DA_1__UART3_CTS */
+							880 0x1c5	/* MX53_PAD_PATA_DA_2__UART3_RTS */
+						>;
+					};
+				};
 			};
 
 			uart1: serial at 53fbc000 {
-- 
1.7.5.4
