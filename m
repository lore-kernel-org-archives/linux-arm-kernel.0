From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  8 Mar 2017 03:50:12 +0100
Subject: [PATCH 1/2] ARM: dts: vf610-zii-dev: Wire up devel C switch interrupts
In-Reply-To: <1488941413-8112-1-git-send-email-andrew@lunn.ch>
References: <1488941413-8112-1-git-send-email-andrew@lunn.ch>
Message-ID: <1488941413-8112-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The devel B and devel C board use the same GPIO lines for interrupts
from the two switches. Move the pinmux nodes from devel B into the
shared .dtsi file, and wire up the interrupts on devel C.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 12 ------------
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 12 ++++++++++++
 arch/arm/boot/dts/vf610-zii-dev.dtsi      | 12 ++++++++++++
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 7940408838df..dd2f2b9907ff 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -459,18 +459,6 @@
 		>;
 	};
 
-	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
-		fsl,pins = <
-			VF610_PAD_PTB5__GPIO_27		0x219d
-		>;
-	};
-
-	pinctrl_gpio_switch1: pinctrl-gpio-switch1 {
-		fsl,pins = <
-			VF610_PAD_PTB4__GPIO_26		0x219d
-		>;
-	};
-
 	pinctrl_mdio_mux: pinctrl-mdio-mux {
 		fsl,pins = <
 			VF610_PAD_PTA18__GPIO_8		0x31c2
diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index 6a45bd24ffe6..352ecec64bb7 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -67,11 +67,17 @@
 
 			switch0: switch@0 {
 				compatible = "marvell,mv88e6190";
+				pinctrl-0 = <&pinctrl_gpio_switch0>;
+				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 0>;
 				eeprom-length = <512>;
+				interrupt-parent = <&gpio0>;
+				interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 
 				ports {
 					#address-cells = <1>;
@@ -125,11 +131,17 @@
 
 			switch1: switch at 0 {
 				compatible = "marvell,mv88e6190";
+				pinctrl-0 = <&pinctrl_gpio_switch1>;
+				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 1>;
 				eeprom-length = <512>;
+				interrupt-parent = <&gpio0>;
+				interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 
 				ports {
 					#address-cells = <1>;
diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index ca9e1bc35e45..6b58d3a97992 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -296,6 +296,18 @@
 		>;
 	};
 
+	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
+		fsl,pins = <
+			VF610_PAD_PTB5__GPIO_27		0x219d
+		>;
+	};
+
+	pinctrl_gpio_switch1: pinctrl-gpio-switch1 {
+		fsl,pins = <
+			VF610_PAD_PTB4__GPIO_26		0x219d
+		>;
+	};
+
 	pinctrl_i2c_mux_reset: pinctrl-i2c-mux-reset {
 		fsl,pins = <
 			 VF610_PAD_PTE14__GPIO_119	0x31c2
-- 
2.11.0
