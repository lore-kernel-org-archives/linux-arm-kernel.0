From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Wed,  9 Aug 2017 16:44:37 +0200
Subject: [PATCH 2/2] ARM64: dts: marvell: enable USB host on Armada-8040-DB
In-Reply-To: <20170809140538.692b3e6d@windsurf>
References: <20170809140538.692b3e6d@windsurf>
Message-ID: <20170809144437.26858-2-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grzegorz Jaszczyk <jaz@semihalf.com>

Enable USB host on Armada-8040-DB by adding USB PHY nodes for the
following ports:
  - host 0 and 1 of CPM
  - host 0 of CPS

These PHY are enabled by lanes coming from regulators based on two
I2C expanders.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 1e8f7242ed6f..0d7b2ae46610 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -44,6 +44,7 @@
  * Device Tree file for Marvell Armada 8040 Development board platform
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-8040.dtsi"
 
 / {
@@ -59,6 +60,48 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	cpm_reg_usb3_0_vbus: cpm-usb3-0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "cpm-usb3h0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&expander0 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	cpm_reg_usb3_1_vbus: cpm-usb3-1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "cpm-usb3h1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&expander0 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	cpm_usb3_0_phy: cpm-usb3-0-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&cpm_reg_usb3_0_vbus>;
+	};
+
+	cpm_usb3_1_phy: cpm-usb3-1-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&cpm_reg_usb3_1_vbus>;
+	};
+
+	cps_reg_usb3_0_vbus: cps-usb3-0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "cps-usb3h0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&expander1 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	cps_usb3_0_phy: cps-usb3-0-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&cps_reg_usb3_0_vbus>;
+	};
 };
 
 &i2c0 {
@@ -107,6 +150,25 @@
 &cpm_i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
+
+	/* U31 */
+	expander0: pca9555 at 21 {
+		compatible = "nxp,pca9555";
+		pinctrl-names = "default";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x21>;
+	};
+
+	/* U25 */
+	expander1: pca9555 at 25 {
+		compatible = "nxp,pca9555";
+		pinctrl-names = "default";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x25>;
+	};
+
 };
 
 /* CON4 on CP0 expansion */
@@ -116,11 +178,13 @@
 
 /* CON9 on CP0 expansion */
 &cpm_usb3_0 {
+	usb-phy = <&cpm_usb3_0_phy>;
 	status = "okay";
 };
 
 /* CON10 on CP0 expansion */
 &cpm_usb3_1 {
+	usb-phy = <&cpm_usb3_1_phy>;
 	status = "okay";
 };
 
@@ -159,6 +223,7 @@
 
 /* CON9 on CP1 expansion */
 &cps_usb3_0 {
+	usb-phy = <&cps_usb3_0_phy>;
 	status = "okay";
 };
 
-- 
2.11.0
