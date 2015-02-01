From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:49:51 +0100
Subject: [PATCH 07/30] ARM: sun4i: hackberry: Convert to DT label based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-hackberry.dts | 187 ++++++++++++++----------------
 1 file changed, 85 insertions(+), 102 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index d3f73ea25567..3cb067ed8715 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -58,102 +58,6 @@
 	model = "Miniand Hackberry";
 	compatible = "miniand,hackberry", "allwinner,sun4i-a10";
 
-	soc at 01c00000 {
-		emac: ethernet at 01c0b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&emac_pins_a>;
-			phy = <&phy0>;
-			status = "okay";
-		};
-
-		mdio at 01c0b080 {
-			phy-supply = <&reg_emac_3v3>;
-			status = "okay";
-
-			phy0: ethernet-phy at 0 {
-				reg = <0>;
-			};
-		};
-
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
-		ehci1: usb at 01c1c000 {
-			status = "okay";
-		};
-
-		ohci1: usb at 01c1c400 {
-			status = "okay";
-		};
-
-		pio: pinctrl at 01c20800 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&hackberry_hogs>;
-
-			hackberry_hogs: hogs at 0 {
-				allwinner,pins = "PH19";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			usb2_vbus_pin_hackberry: usb2_vbus_pin at 0 {
-					allwinner,pins = "PH12";
-					allwinner,function = "gpio_out";
-					allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-					allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
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
-				compatible = "x-powers,axp209";
-				reg = <0x34>;
-				interrupts = <0>;
-
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-	};
-
 	reg_emac_3v3: emac-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "emac-3v3";
@@ -162,14 +66,93 @@
 		enable-active-high;
 		gpio = <&pio 7 19 GPIO_ACTIVE_HIGH>;
 	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_pins_a>;
+	phy = <&phy0>;
+	status = "okay";
+};
+
+&ir0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir0_pins_a>;
+	status = "okay";
+};
+
+&mdio {
+	phy-supply = <&reg_emac_3v3>;
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
 
-	reg_usb1_vbus: usb1-vbus {
-		status = "okay";
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
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hackberry_hogs>;
+
+	hackberry_hogs: hogs at 0 {
+		allwinner,pins = "PH19";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	reg_usb2_vbus: usb2-vbus {
-		pinctrl-0 = <&usb2_vbus_pin_hackberry>;
-		gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
-		status = "okay";
+	usb2_vbus_pin_hackberry: usb2_vbus_pin at 0 {
+		allwinner,pins = "PH12";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	pinctrl-0 = <&usb2_vbus_pin_hackberry>;
+	gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
-- 
2.2.2
