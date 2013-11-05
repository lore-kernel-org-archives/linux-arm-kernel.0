From: mhei@heimpold.de (Michael Heimpold)
Date: Tue,  5 Nov 2013 22:07:50 +0100
Subject: [PATCH] ARM: mxs: add support for I2SE's duckbill series
Message-ID: <1383685670-10046-1-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/Makefile           |    1 +
 arch/arm/boot/dts/imx28-duckbill.dts |  118 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c         |   13 ++++
 3 files changed, 132 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-duckbill.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 802720e..f0fbc09 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -158,6 +158,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx28-cfa10056.dtb \
 	imx28-cfa10057.dtb \
 	imx28-cfa10058.dtb \
+	imx28-duckbill.dtb \
 	imx28-evk.dtb \
 	imx28-m28evk.dtb \
 	imx28-sps1.dtb \
diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
new file mode 100644
index 0000000..bd231e7
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -0,0 +1,118 @@
+/*
+ * Copyright (C) 2013 Michael Heimpold <mhei@heimpold.de>
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
+/include/ "imx28.dtsi"
+
+/ {
+	model = "I2SE Duckbill";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_8bit_pins_a
+					&mmc0_cd_cfg &mmc0_sck_cfg>;
+				bus-width = <8>;
+				vmmc-supply = <&reg_3p3v>;
+				status = "okay";
+			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x40d3 /* MX28_PAD_ENET0_RX_CLK__GPIO_4_13, PHY Reset */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				led_pins_a: led_gpio at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3043 /* MX28_PAD_AUART1_RX__GPIO_3_4 */
+						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+
+			usbphy0: usbphy at 8007c000 {
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			status = "okay";
+		};
+
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a>;
+			phy-supply = <&reg_3p3v>;
+			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-duration = <100>;
+			status = "okay";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_a>;
+
+		status {
+			label = "duckbill:green:status";
+			gpios = <&gpio3 5 0>;
+		};
+
+		failure {
+			label = "duckbill:red:status";
+			gpios = <&gpio3 4 0>;
+		};
+	};
+};
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 98f6e2a..60073c7 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -159,6 +159,7 @@ enum mac_oui {
 	OUI_FSL,
 	OUI_DENX,
 	OUI_CRYSTALFONTZ,
+	OUI_I2SE,
 };
 
 static void __init update_fec_mac_prop(enum mac_oui oui)
@@ -213,6 +214,11 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
 			macaddr[1] = 0xb9;
 			macaddr[2] = 0xe1;
 			break;
+		case OUI_I2SE:
+			macaddr[0] = 0x00;
+			macaddr[1] = 0x01;
+			macaddr[2] = 0x87;
+			break;
 		}
 		val = ocotp[i];
 		macaddr[3] = (val >> 16) & 0xff;
@@ -332,6 +338,11 @@ static void __init crystalfontz_init(void)
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
 }
 
+static void __init duckbill_init(void)
+{
+	update_fec_mac_prop(OUI_I2SE);
+}
+
 static const char __init *mxs_get_soc_id(void)
 {
 	struct device_node *np;
@@ -459,6 +470,8 @@ static void __init mxs_machine_init(void)
 		apx4devkit_init();
 	else if (of_machine_is_compatible("crystalfontz,cfa10036"))
 		crystalfontz_init();
+	else if (of_machine_is_compatible("i2se,duckbill"))
+		duckbill_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     NULL, parent);
-- 
1.7.10.4
