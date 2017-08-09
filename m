From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Wed,  9 Aug 2017 10:19:49 +0200
Subject: [PATCH] ARM64: dts: a7040: add regulator nodes to enable USB host VBUS
Message-ID: <20170809081949.24343-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanna Hawa <hannah@marvell.com>

Add I2C expander and USB host PHY (host 0 and host 1) to enable
USB VBUS on USB ports of type A on Armada-7040-DB.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 92c761c380d3..b14df53dda9d 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -44,6 +44,7 @@
  * Device Tree file for Marvell Armada 7040 Development board platform
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-7040.dtsi"
 
 / {
@@ -59,6 +60,36 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	exp_usb3h0_vbus: usb3-0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&expander0 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	exp_usb3h1_vbus: usb3-1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&expander0 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	cpm_usb3_0_phy: cpm-usb3-0-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&exp_usb3h0_vbus>;
+	};
+
+	cpm_usb3_1_phy: cpm-usb3-1-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&exp_usb3h1_vbus>;
+	};
 };
 
 &i2c0 {
@@ -105,6 +136,14 @@
 &cpm_i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
+
+	expander0: pca9555 at 21 {
+		compatible = "nxp,pca9555";
+		pinctrl-names = "default";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x21>;
+	};
 };
 
 &cpm_spi1 {
@@ -140,10 +179,12 @@
 };
 
 &cpm_usb3_0 {
+	usb-phy = <&cpm_usb3_0_phy>;
 	status = "okay";
 };
 
 &cpm_usb3_1 {
+	usb-phy = <&cpm_usb3_1_phy>;
 	status = "okay";
 };
 
-- 
2.11.0
