From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:13 +0100
Subject: [PATCH 29/30] ARM: sun7i: pcduino3: Convert to DT label based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-30-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts | 210 +++++++++++++++----------------
 1 file changed, 104 insertions(+), 106 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 0a2c2aeb4687..09ec96b2b7d7 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -59,105 +59,6 @@
 	model = "LinkSprite pcDuino3";
 	compatible = "linksprite,pcduino3", "allwinner,sun7i-a20";
 
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
-			ahci_pwr_pin_a: ahci_pwr_pin at 0 {
-				allwinner,pins = "PH2";
-			};
-
-			led_pins_pcduino3: led_pins at 0 {
-				allwinner,pins = "PH15", "PH16";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			key_pins_pcduino3: key_pins at 0 {
-				allwinner,pins = "PH17", "PH18", "PH19";
-				allwinner,function = "gpio_in";
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
-				compatible = "x-powers,axp209";
-				reg = <0x34>;
-				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
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
@@ -196,17 +97,114 @@
 			gpios = <&pio 7 19 GPIO_ACTIVE_LOW>;
 		};
 	};
+};
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&ahci_pwr_pin_a {
+	allwinner,pins = "PH2";
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
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_mii_a>;
+	phy = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp209: pmic at 34 {
+		compatible = "x-powers,axp209";
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
-	reg_usb1_vbus: usb1-vbus {
-		status = "okay";
+		interrupt-controller;
+		#interrupt-cells = <1>;
 	};
+};
+
+&ir0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir0_pins_a>;
+	status = "okay";
+};
 
-	reg_usb2_vbus: usb2-vbus {
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
+	led_pins_pcduino3: led_pins at 0 {
+		allwinner,pins = "PH15", "PH16";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	reg_ahci_5v: ahci-5v {
-		gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>;
-		status = "okay";
+	key_pins_pcduino3: key_pins at 0 {
+		allwinner,pins = "PH17", "PH18", "PH19";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&reg_ahci_5v {
+	gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
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
