From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu,  5 Nov 2015 13:13:44 -0500
Subject: [PATCH v2 10/10] ARM: dts: imx6q-ba16: Cleanup pinctrl and LDO
In-Reply-To: <1446747224-32514-1-git-send-email-akshay.bhat@timesys.com>
References: <1446747224-32514-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1446747224-32514-11-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Incorporate feedback from Lucas Stash
- Move entries from pinctrl_hog to relevant groups
- Remove unused PCIe power-on-gpio entry
- Remove always-on from regulators that do not need to be always-on

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/imx6q-ba16.dtsi | 85 +++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 3d47039..d0c4568 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -2,7 +2,7 @@
  * Support for imx6 based Advantech DMS-BA16 Qseven module
  *
  * Copyright 2015 Timesys Corporation.
- * Copyright 2015 GE Healthcare.
+ * Copyright 2015 General Electric Company
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
@@ -73,6 +73,8 @@
 	};
 
 	backlight {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_display>;
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <  0   1   2   3   4   5   6   7   8   9
@@ -176,6 +178,8 @@
 	pmic@58 {
 		compatible = "dlg,da9063";
 		reg = <0x58>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio7>;
 		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
 
@@ -245,43 +249,31 @@
 			vdd_ldo5: ldo5 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <3600000>;
-				regulator-always-on;
-				regulator-boot-on;
 			};
 
 			vdd_ldo6: ldo6 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <3600000>;
-				regulator-always-on;
-				regulator-boot-on;
 			};
 
 			vdd_ldo7: ldo7 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <3600000>;
-				regulator-always-on;
-				regulator-boot-on;
 			};
 
 			vdd_ldo8: ldo8 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <3600000>;
-				regulator-always-on;
-				regulator-boot-on;
 			};
 
 			vdd_ldo9: ldo9 {
 				regulator-min-microvolt = <950000>;
 				regulator-max-microvolt = <3600000>;
-				regulator-always-on;
-				regulator-boot-on;
 			};
 
 			vdd_ldo10: ldo10 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <3600000>;
-				regulator-always-on;
-				regulator-boot-on;
 			};
 
 			vdd_ldo11: ldo11 {
@@ -301,16 +293,6 @@
 	imx6q-ba16 {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x80000000	/* uSDHC2 CD */
-				MX6QDL_PAD_NANDF_CS0__GPIO6_IO11 0x80000000	/* uSDHC4 CD */
-				MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x80000000	/* uSDHC4 SDIO PWR */
-				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000	/* uSDHC4 SDIO WP */
-				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16 0x80000000	/* uSDHC4 SDIO LED */
-				MX6QDL_PAD_EIM_EB2__GPIO2_IO30   0x80000000	/* SPI1 CS */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12   0x80000000	/* PCIe Reset */
-				MX6QDL_PAD_GPIO_5__GPIO1_IO05    0x80000000	/* PCIe Wake */
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1     0x130b0	/* FEC CLK */
-				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x80000000	/* FEC Reset */
 				MX6QDL_PAD_NANDF_D0__GPIO2_IO00  0x80000000	/* GPIO0 */
 				MX6QDL_PAD_NANDF_D1__GPIO2_IO01  0x80000000	/* GPIO1 */
 				MX6QDL_PAD_NANDF_D2__GPIO2_IO02  0x80000000	/* GPIO2 */
@@ -321,17 +303,44 @@
 				MX6QDL_PAD_NANDF_D7__GPIO2_IO07  0x80000000	/* GPIO7 */
 				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07 0x80000000	/* CAM_PWDN */
 				MX6QDL_PAD_GPIO_2__GPIO1_IO02    0x80000000	/* CAM_RST */
-				MX6QDL_PAD_GPIO_9__WDOG1_B       0x80000000	/* Watchdog out */
-				MX6QDL_PAD_GPIO_16__GPIO7_IO11   0x80000000	/* HUB_RESET */
-				MX6QDL_PAD_GPIO_18__GPIO7_IO13   0x80000000	/* PMIC Interrupt */
-				MX6QDL_PAD_GPIO_19__GPIO4_IO05   0x80000000	/* AR8033 Interrupt */
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1     0x130b0	/* CAM CLK */
 				MX6QDL_PAD_KEY_ROW2__GPIO4_IO11  0x80000000	/* SUS_S3_OUT */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15  0x80000000	/* BLEN_OUT */
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x80000000	/* LVDS_PPEN_OUT */
 				MX6QDL_PAD_KEY_COL2__GPIO4_IO10  0x80000000	/* RTC_INT */
 			>;
 		};
 
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_9__WDOG1_B       0x80000000	/* Watchdog out */
+			>;
+		};
+
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_18__GPIO7_IO13   0x80000000	/* PMIC Interrupt */
+			>;
+		};
+
+		pinctrl_usbhub: usbhubgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_16__GPIO7_IO11   0x80000000	/* HUB_RESET */
+			>;
+		};
+
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12   0x80000000	/* PCIe Reset */
+				MX6QDL_PAD_GPIO_5__GPIO1_IO05    0x80000000	/* PCIe Wake */
+			>;
+		};
+
+		pinctrl_display: dispgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15  0x80000000 /* BLEN_OUT */
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x80000000 /* LVDS_PPEN_OUT */
+			>;
+		};
+
 		pinctrl_usdhc4: usdhc4grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD4_CMD__SD4_CMD    0x17059
@@ -344,6 +353,10 @@
 				MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17059
 				MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17059
 				MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17059
+				MX6QDL_PAD_NANDF_CS0__GPIO6_IO11 0x80000000 /* uSDHC4 CD */
+				MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x80000000 /* uSDHC4 SDIO PWR */
+				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000 /* uSDHC4 SDIO WP */
+				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16 0x80000000 /* uSDHC4 SDIO LED */
 			>;
 		};
 
@@ -352,6 +365,7 @@
 				MX6QDL_PAD_EIM_D17__ECSPI1_MISO 0x100b1
 				MX6QDL_PAD_EIM_D18__ECSPI1_MOSI 0x100b1
 				MX6QDL_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
+				MX6QDL_PAD_EIM_EB2__GPIO2_IO30	0x80000000 /* SPI1 CS */
 			>;
 		};
 
@@ -427,6 +441,7 @@
 				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
 				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
 				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x80000000 /* uSDHC2 CD */
 			>;
 		};
 
@@ -477,13 +492,16 @@
 				MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
 				MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
 				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28     0x80000000 /* FEC Reset */
+				MX6QDL_PAD_GPIO_19__GPIO4_IO05        0x80000000 /* AR8033 Interrupt */
 			>;
 		};
 	};
 };
 
 &pcie {
-	power-on-gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
@@ -524,6 +542,8 @@
 };
 
 &usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbhub>;
 	vbus-supply = <&reg_usb_h1_vbus>;
 	reset-gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 	status = "okay";
@@ -557,3 +577,8 @@
 	keep-power-in-suspend;
 	status = "okay";
 };
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+};
-- 
2.6.2
