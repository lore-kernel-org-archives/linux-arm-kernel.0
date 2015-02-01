From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:05 +0100
Subject: [PATCH 21/30] ARM: sun7i: cubieboard2: Convert to DT label based
 syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-22-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 198 ++++++++++++++--------------
 1 file changed, 98 insertions(+), 100 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index c4ab6edb6f15..8c847eb70cad 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -59,96 +59,6 @@
 	model = "Cubietech Cubieboard2";
 	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
 
-	soc at 01c00000 {
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-			cd-inverted;
-			status = "okay";
-		};
-
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			usb2_vbus-supply = <&reg_usb2_vbus>;
-			status = "okay";
-		};
-
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
-
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
-
-		ahci: sata at 01c18000 {
-			target-supply = <&reg_ahci_5v>;
-			status = "okay";
-		};
-
-		ehci1: usb at 01c1c000 {
-			status = "okay";
-		};
-
-		ohci1: usb at 01c1c400 {
-			status = "okay";
-		};
-
-		pinctrl at 01c20800 {
-			led_pins_cubieboard2: led_pins at 0 {
-				allwinner,pins = "PH20", "PH21";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
-
-		ir0: ir at 01c21800 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&ir0_pins_a>;
-			status = "okay";
-		};
-
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
-
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "okay";
-
-			axp209: pmic at 34 {
-				reg = <0x34>;
-				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-			};
-		};
-
-		i2c1: i2c at 01c2b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c1_pins_a>;
-			status = "okay";
-		};
-
-		gmac: ethernet at 01c50000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gmac_pins_mii_a>;
-			phy = <&phy1>;
-			phy-mode = "mii";
-			status = "okay";
-
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -164,26 +74,94 @@
 			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
 		};
 	};
+};
 
-	reg_ahci_5v: ahci-5v {
-		status = "okay";
-	};
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
 
-	reg_usb1_vbus: usb1-vbus {
-		status = "okay";
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_mii_a>;
+	phy = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
 	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
 
-	reg_usb2_vbus: usb2-vbus {
-		status = "okay";
+	axp209: pmic at 34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-#include "axp209.dtsi"
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
 
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
+&ir0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir0_pins_a>;
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
 };
 
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	led_pins_cubieboard2: led_pins at 0 {
+		allwinner,pins = "PH20", "PH21";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&reg_ahci_5v {
+	status = "okay";
+};
+
+#include "axp209.dtsi"
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
@@ -208,3 +186,23 @@
 	regulator-max-microvolt = <3000000>;
 	regulator-name = "avcc";
 };
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.2.2
