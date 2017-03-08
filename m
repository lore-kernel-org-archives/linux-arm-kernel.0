From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  8 Mar 2017 18:33:15 +0100
Subject: [PATCH 3/3] ARM64: dts: marvell: armada-3720-db: Add phy for USB3
In-Reply-To: <20170308173315.28512-1-gregory.clement@free-electrons.com>
References: <20170308173315.28512-1-gregory.clement@free-electrons.com>
Message-ID: <20170308173315.28512-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the gpio expander is present in the dts, use it to add an USB3
PHY using one of these gpio as a regulator.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index aa39339b6582..10207f96f090 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -46,6 +46,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-372x.dtsi"
 
 / {
@@ -60,6 +61,21 @@
 		device_type = "memory";
 		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
 	};
+
+	exp_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	usb3_phy: usb3-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&exp_usb3_vbus>;
+	};
 };
 
 &i2c0 {
@@ -127,6 +143,7 @@
 /* CON31 */
 &usb3 {
 	status = "okay";
+	usb-phy = <&usb3_phy>;
 };
 
 /* CON17 (PCIe) / CON12 (mini-PCIe) */
-- 
2.11.0
