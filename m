From: mhei@heimpold.de (Michael Heimpold)
Date: Sat,  9 Nov 2013 12:14:16 +0100
Subject: [PATCH v2] ARM: mxs: add support for I2SE's duckbill series
Message-ID: <1383995657-5388-1-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---

Changelog v1->v2:
- rebased on git://git.linaro.org/people/shawnguo/linux-2.6.git for-next
- used macros for pinctrl constants
- used generic name for fixed regulator node

 arch/arm/boot/dts/Makefile           |    1 +
 arch/arm/boot/dts/imx28-duckbill.dts |  121 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c         |   13 ++++
 3 files changed, 135 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-duckbill.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3159ab6..5801ed0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -172,6 +172,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx28-cfa10056.dtb \
 	imx28-cfa10057.dtb \
 	imx28-cfa10058.dtb \
+	imx28-duckbill.dtb \
 	imx28-evk.dtb \
 	imx28-m28cu3.dtb \
 	imx28-m28evk.dtb \
diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
new file mode 100644
index 0000000..88733c1
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -0,0 +1,121 @@
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
+						MX28_PAD_ENET0_RX_CLK__GPIO_4_13 /* PHY Reset */
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				led_pins_a: led_gpio at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART1_RX__GPIO_3_4
+						MX28_PAD_AUART1_TX__GPIO_3_5
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
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
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_3p3v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
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
index 1dc5acd..3982e12 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -157,6 +157,7 @@ enum mac_oui {
 	OUI_FSL,
 	OUI_DENX,
 	OUI_CRYSTALFONTZ,
+	OUI_I2SE,
 };
 
 static void __init update_fec_mac_prop(enum mac_oui oui)
@@ -211,6 +212,11 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
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
@@ -330,6 +336,11 @@ static void __init crystalfontz_init(void)
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
 }
 
+static void __init duckbill_init(void)
+{
+	update_fec_mac_prop(OUI_I2SE);
+}
+
 static void __init m28cu3_init(void)
 {
 	update_fec_mac_prop(OUI_DENX);
@@ -462,6 +473,8 @@ static void __init mxs_machine_init(void)
 		apx4devkit_init();
 	else if (of_machine_is_compatible("crystalfontz,cfa10036"))
 		crystalfontz_init();
+	else if (of_machine_is_compatible("i2se,duckbill"))
+		duckbill_init();
 	else if (of_machine_is_compatible("msr,m28cu3"))
 		m28cu3_init();
 
-- 
1.7.10.4
