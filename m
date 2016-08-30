From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 31 Aug 2016 01:24:41 +0300
Subject: [PATCH] ARM: dts: wheat: add SDHI0 support
In-Reply-To: <34968644.DhifNderY8@wasted.cogentembedded.com>
References: <34968644.DhifNderY8@wasted.cogentembedded.com>
Message-ID: <1659137.gEKJxNrmrk@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Wheat board dependent  part of  the SDHI0 (connected to the
micro-SD slot)  device node along with the necessary voltage regulator.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20160830-v4.8-rc4' of Simon Horman's
'renesas.git' repo plus the CAN patch posted yesterday.
Starting with this patch, SMSC LAN89218 Ethernet chip starts to misbehave on my
board...

 arch/arm/boot/dts/r8a7792-wheat.dts |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-wheat.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-wheat.dts
+++ renesas/arch/arm/boot/dts/r8a7792-wheat.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "r8a7792.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Wheat";
@@ -54,6 +55,17 @@
 		pinctrl-0 = <&lan89218_pins>;
 		pinctrl-names = "default";
 	};
+
+	vcc_sdhi0: regulator-vcc-sdhi0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio11 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &extal_clk {
@@ -86,6 +98,11 @@
 		groups = "can1_data";
 		function = "can1";
 	};
+
+	sdhi0_pins: sdhi0 {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+	};
 };
 
 &scif0 {
@@ -108,3 +125,12 @@
 
 	status = "okay";
 };
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	cd-gpios = <&gpio11 11 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
