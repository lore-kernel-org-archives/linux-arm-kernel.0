From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 16 Nov 2016 11:40:45 -0800
Subject: [PATCH] ARM: dts: imx: ventana: add LTC3676 PMIC support
Message-ID: <1479325245-1169-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of the Gateworks Ventana boards based on the IMX6 SoC except for the
GW54xx use the LTC3676 PMIC. Add a device-tree node with interrupt support
for this PMIC. Additionally remove the simple-bus notation in the regulator
nodes and any fixed regulators that are provided by the PMIC.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 132 ++++++++++++++++++++-------
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 165 ++++++++++++++++++++++++----------
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 163 +++++++++++++++++++++++----------
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 132 +++++++++++++++++++++------
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 130 +++++++++++++++++++++------
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi |  98 ++++++++++++++++++--
 6 files changed, 630 insertions(+), 190 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index afec2c7..341fef1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -56,38 +56,29 @@
 		status = "okay";
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_3p3v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		reg_5p0v: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "5P0V";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	reg_5p0v: regulator-5p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "5P0V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 
-		reg_usb_otg_vbus: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 };
 
@@ -158,6 +149,81 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	pmic: ltc3676 at 3c {
+		compatible = "lltc,ltc3676";
+		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			/* VDD_SOC (1+R1/R2 = 1.635) */
+			reg_vdd_soc: sw1 {
+				regulator-name = "vddsoc";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_1P8 (1+R1/R2 = 2.505): GPS/VideoIn/ENET-PHY */
+			reg_1p8v: sw2 {
+				regulator-name = "vdd1p8";
+				regulator-min-microvolt = <1033310>;
+				regulator-max-microvolt = <2004000>;
+				lltc,fb-voltage-divider = <301000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_ARM (1+R1/R2 = 1.635) */
+			reg_vdd_arm: sw3 {
+				regulator-name = "vddarm";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_DDR (1+R1/R2 = 2.105) */
+			reg_vdd_ddr: sw4 {
+				regulator-name = "vddddr";
+				regulator-min-microvolt = <868310>;
+				regulator-max-microvolt = <1684000>;
+				lltc,fb-voltage-divider = <221000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_2P5 (1+R1/R2 = 3.435): PCIe/ENET-PHY */
+			reg_2p5v: ldo2 {
+				regulator-name = "vdd2p5";
+				regulator-min-microvolt = <2490375>;
+				regulator-max-microvolt = <2490375>;
+				lltc,fb-voltage-divider = <487000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_HIGH (1+R1/R2 = 4.17) */
+			reg_3p0v: ldo4 {
+				regulator-name = "vdd3p0";
+				regulator-min-microvolt = <3023250>;
+				regulator-max-microvolt = <3023250>;
+				lltc,fb-voltage-divider = <634000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -312,6 +378,12 @@
 			>;
 		};
 
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x0001b0b0 /* PMIC_IRQ# */
+			>;
+		};
+
 		pinctrl_pps: ppsgrp {
 			fsl,pins = <
 				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 54aca3a..5c76317 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -71,57 +71,37 @@
 		status = "okay";
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_1p0v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "1P0V";
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1000000>;
-			regulator-always-on;
-		};
-
-		/* remove this fixed regulator once ltc3676__sw2 driver available */
-		reg_1p8v: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "1P8V";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
+	reg_1p0v: regulator-1p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P0V";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-always-on;
+	};
 
-		reg_3p3v: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		reg_5p0v: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "5P0V";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	reg_5p0v: regulator-5p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "5P0V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 
-		reg_usb_otg_vbus: regulator at 4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	sound {
@@ -233,6 +213,89 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	pmic: ltc3676 at 3c {
+		compatible = "lltc,ltc3676";
+		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			/* VDD_SOC (1+R1/R2 = 1.635) */
+			reg_vdd_soc: sw1 {
+				regulator-name = "vddsoc";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_1P8 (1+R1/R2 = 2.505): GPS/VideoIn/ENET-PHY */
+			reg_1p8v: sw2 {
+                                regulator-name = "vdd1p8";
+				regulator-min-microvolt = <1033310>;
+				regulator-max-microvolt = <2004000>;
+				lltc,fb-voltage-divider = <301000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_ARM (1+R1/R2 = 1.635) */
+			reg_vdd_arm: sw3 {
+				regulator-name = "vddarm";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_DDR (1+R1/R2 = 2.105) */
+			reg_vdd_ddr: sw4 {
+				regulator-name = "vddddr";
+				regulator-min-microvolt = <868310>;
+				regulator-max-microvolt = <1684000>;
+				lltc,fb-voltage-divider = <221000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_2P5 (1+R1/R2 = 3.435): PCIe/ENET-PHY */
+			reg_2p5v: ldo2 {
+				regulator-name = "vdd2p5";
+				regulator-min-microvolt = <2490375>;
+				regulator-max-microvolt = <2490375>;
+				lltc,fb-voltage-divider = <487000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_AUD_1P8: Audio codec */
+			reg_aud_1p8v: ldo3 {
+				regulator-name = "vdd1p8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
+
+			/* VDD_HIGH (1+R1/R2 = 4.17) */
+			reg_3p0v: ldo4 {
+				regulator-name = "vdd3p0";
+				regulator-min-microvolt = <3023250>;
+				regulator-max-microvolt = <3023250>;
+				lltc,fb-voltage-divider = <634000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -467,6 +530,12 @@
 			>;
 		};
 
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x0001b0b0 /* PMIC_IRQ# */
+			>;
+		};
+
 		pinctrl_pps: ppsgrp {
 			fsl,pins = <
 				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 88e5cb3..8797e7b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -72,57 +72,37 @@
 		status = "okay";
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_1p0v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "1P0V";
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1000000>;
-			regulator-always-on;
-		};
-
-		/* remove when pmic 1p8 regulator available */
-		reg_1p8v: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "1P8V";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
+	reg_1p0v: regulator-1p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P0V";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-always-on;
+	};
 
-		reg_3p3v: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		reg_usb_h1_vbus: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	reg_usb_h1_vbus: regulator-usb-h1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 
-		reg_usb_otg_vbus: regulator at 4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	sound {
@@ -226,6 +206,87 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	pmic: ltc3676 at 3c {
+		compatible = "lltc,ltc3676";
+		reg = <0x3c>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			/* VDD_SOC (1+R1/R2 = 1.635) */
+			reg_vdd_soc: sw1 {
+				regulator-name = "vddsoc";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_1P8 (1+R1/R2 = 2.505): GPS/VideoIn/ENET-PHY */
+			reg_1p8v: sw2 {
+                                regulator-name = "vdd1p8";
+				regulator-min-microvolt = <1033310>;
+				regulator-max-microvolt = <2004000>;
+				lltc,fb-voltage-divider = <301000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_ARM (1+R1/R2 = 1.635) */
+			reg_vdd_arm: sw3 {
+				regulator-name = "vddarm";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_DDR (1+R1/R2 = 2.105) */
+			reg_vdd_ddr: sw4 {
+				regulator-name = "vddddr";
+				regulator-min-microvolt = <868310>;
+				regulator-max-microvolt = <1684000>;
+				lltc,fb-voltage-divider = <221000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_2P5 (1+R1/R2 = 3.435): PCIe/ENET-PHY */
+			reg_2p5v: ldo2 {
+				regulator-name = "vdd2p5";
+				regulator-min-microvolt = <2490375>;
+				regulator-max-microvolt = <2490375>;
+				lltc,fb-voltage-divider = <487000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_AUD_1P8: Audio codec */
+			reg_aud_1p8v: ldo3 {
+				regulator-name = "vdd1p8a";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
+
+			/* VDD_HIGH (1+R1/R2 = 4.17) */
+			reg_3p0v: ldo4 {
+				regulator-name = "vdd3p0";
+				regulator-min-microvolt = <3023250>;
+				regulator-max-microvolt = <3023250>;
+				lltc,fb-voltage-divider = <634000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -456,6 +517,12 @@
 			>;
 		};
 
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x0001b0b0 /* PMIC_IRQ# */
+			>;
+		};
+
 		pinctrl_pps: ppsgrp {
 			fsl,pins = <
 				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 4b9fef8..1d44a7a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -78,34 +78,25 @@
 		reg = <0x10000000 0x20000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_5p0v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "5P0V";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
+	reg_5p0v: regulator-5p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "5P0V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
 
-		reg_usb_h1_vbus: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
+	reg_usb_h1_vbus: regulator-usb-h1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
 
-		reg_usb_otg_vbus: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 	};
 };
 
@@ -174,6 +165,89 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	pmic: ltc3676 at 3c {
+		compatible = "lltc,ltc3676";
+		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			/* VDD_SOC (1+R1/R2 = 1.635) */
+			reg_vdd_soc: sw1 {
+				regulator-name = "vddsoc";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_DDR (1+R1/R2 = 2.105) */
+			reg_vdd_ddr: sw2 {
+				regulator-name = "vddddr";
+				regulator-min-microvolt = <868310>;
+				regulator-max-microvolt = <1684000>;
+				lltc,fb-voltage-divider = <221000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_ARM (1+R1/R2 = 1.635) */
+			reg_vdd_arm: sw3 {
+				regulator-name = "vddarm";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_3P3 (1+R1/R2 = 1.281) */
+			reg_3p3: sw4 {
+				regulator-name = "vdd3p3";
+				regulator-min-microvolt = <1880000>;
+				regulator-max-microvolt = <3647000>;
+				lltc,fb-voltage-divider = <200000 56200>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_1P8a (1+R1/R2 = 2.505): HDMI In core */
+			reg_1p8a: ldo2 {
+				regulator-name = "vdd1p8a";
+				regulator-min-microvolt = <1816125>;
+				regulator-max-microvolt = <1816125>;
+				lltc,fb-voltage-divider = <301000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_1P8b: HDMI In analog */
+			reg_1p8b: ldo3 {
+				regulator-name = "vdd1p8b";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
+
+			/* VDD_HIGH (1+R1/R2 = 4.17) */
+			reg_3p0: ldo4 {
+				regulator-name = "vdd3p0";
+				regulator-min-microvolt = <3023250>;
+				regulator-max-microvolt = <3023250>;
+				lltc,fb-voltage-divider = <634000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -308,6 +382,12 @@
 			>;
 		};
 
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x0001b0b0 /* PMIC_IRQ# */
+			>;
+		};
+
 		pinctrl_pwm2: pwm2grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index ee83161..e22da6f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -55,37 +55,28 @@
 		reg = <0x10000000 0x20000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_1p0v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "1P0V";
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1000000>;
-			regulator-always-on;
-		};
+	reg_1p0v: regulator-1p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P0V";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-always-on;
+	};
 
-		reg_3p3v: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		reg_5p0v: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "5P0V";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	reg_5p0v: regulator-5p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "5P0V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
 	};
 };
 
@@ -148,6 +139,81 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	pmic: ltc3676 at 3c {
+		compatible = "lltc,ltc3676";
+		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			/* VDD_SOC (1+R1/R2 = 1.635) */
+			reg_vdd_soc: sw1 {
+				regulator-name = "vddsoc";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_1P8 (1+R1/R2 = 2.505): ENET-PHY */
+			reg_1p8v: sw2 {
+                                regulator-name = "vdd1p8";
+				regulator-min-microvolt = <1033310>;
+				regulator-max-microvolt = <2004000>;
+				lltc,fb-voltage-divider = <301000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_ARM (1+R1/R2 = 1.635) */
+			reg_vdd_arm: sw3 {
+				regulator-name = "vddarm";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_DDR (1+R1/R2 = 2.105) */
+			reg_vdd_ddr: sw4 {
+				regulator-name = "vddddr";
+				regulator-min-microvolt = <868310>;
+				regulator-max-microvolt = <1684000>;
+				lltc,fb-voltage-divider = <221000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_2P5 (1+R1/R2 = 3.435): PCIe/ENET-PHY */
+			reg_2p5v: ldo2 {
+				regulator-name = "vdd2p5";
+				regulator-min-microvolt = <2490375>;
+				regulator-max-microvolt = <2490375>;
+				lltc,fb-voltage-divider = <487000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_HIGH (1+R1/R2 = 4.17) */
+			reg_3p0v: ldo4 {
+				regulator-name = "vdd3p0";
+				regulator-min-microvolt = <3023250>;
+				regulator-max-microvolt = <3023250>;
+				lltc,fb-voltage-divider = <634000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -260,6 +326,12 @@
 			>;
 		};
 
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x0001b0b0 /* PMIC_IRQ# */
+			>;
+		};
+
 		pinctrl_pwm2: pwm2grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index 86cec05..1528f98 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -92,14 +92,6 @@
 		status = "okay";
 	};
 
-	reg_3p3v: regulator-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "3P0V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
 	reg_5p0v: regulator-5p0v {
 		compatible = "regulator-fixed";
 		regulator-name = "5P0V";
@@ -179,6 +171,89 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	pmic: ltc3676 at 3c {
+		compatible = "lltc,ltc3676";
+		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			/* VDD_SOC (1+R1/R2 = 1.635) */
+			reg_vdd_soc: sw1 {
+				regulator-name = "vddsoc";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_DDR (1+R1/R2 = 2.105) */
+			reg_vdd_ddr: sw2 {
+				regulator-name = "vddddr";
+				regulator-min-microvolt = <868310>;
+				regulator-max-microvolt = <1684000>;
+				lltc,fb-voltage-divider = <221000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_ARM (1+R1/R2 = 1.635) */
+			reg_vdd_arm: sw3 {
+				regulator-name = "vddarm";
+				regulator-min-microvolt = <674400>;
+				regulator-max-microvolt = <1308000>;
+				lltc,fb-voltage-divider = <127000 200000>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_3P3 (1+R1/R2 = 1.281) */
+			reg_3p3v: sw4 {
+				regulator-name = "vdd3p3";
+				regulator-min-microvolt = <1880000>;
+				regulator-max-microvolt = <3647000>;
+				lltc,fb-voltage-divider = <200000 56200>;
+				regulator-ramp-delay = <7000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_1P8a (1+R1/R2 = 2.505): Analog Video Decoder */
+			reg_1p8a: ldo2 {
+				regulator-name = "vdd1p8a";
+				regulator-min-microvolt = <1816125>;
+				regulator-max-microvolt = <1816125>;
+				lltc,fb-voltage-divider = <301000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VDD_1P8b: microSD VDD_1P8 */
+			reg_1p8b: ldo3 {
+				regulator-name = "vdd1p8b";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
+
+			/* VDD_HIGH (1+R1/R2 = 4.17) */
+			reg_3p0v: ldo4 {
+				regulator-name = "vdd3p0";
+				regulator-min-microvolt = <3023250>;
+				regulator-max-microvolt = <3023250>;
+				lltc,fb-voltage-divider = <634000 200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -255,7 +330,6 @@
 	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	cd-gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
 
@@ -327,6 +401,12 @@
 		>;
 	};
 
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x0001b0b0 /* PMIC_IRQ# */
+		>;
+	};
+
 	pinctrl_pps: ppsgrp {
 		fsl,pins = <
 			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
-- 
1.9.1
