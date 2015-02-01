From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:49:54 +0100
Subject: [PATCH 10/30] ARM: sun4i: olinuxino lime: Convert to DT label based
 syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-11-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 188 ++++++++++++-------------
 1 file changed, 93 insertions(+), 95 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index ab7891c43231..31dc2f1c3870 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -56,120 +56,118 @@
 	model = "Olimex A10-OLinuXino-LIME";
 	compatible = "olimex,a10-olinuxino-lime", "allwinner,sun4i-a10";
 
-	soc at 01c00000 {
-		emac: ethernet at 01c0b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&emac_pins_a>;
-			phy = <&phy1>;
-			status = "okay";
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxinolime>;
+
+		green {
+			label = "a10-olinuxino-lime:green:usr";
+			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
 		};
+	};
+};
 
-		mdio at 01c0b080 {
-			status = "okay";
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
 
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
+&ehci0 {
+	status = "okay";
+};
 
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-			cd-inverted;
-			status = "okay";
-		};
+&ehci1 {
+	status = "okay";
+};
 
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			usb2_vbus-supply = <&reg_usb2_vbus>;
-			status = "okay";
-		};
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_pins_a>;
+	phy = <&phy1>;
+	status = "okay";
+};
 
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
 
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
+	axp209: pmic at 34 {
+		compatible = "x-powers,axp209";
+		reg = <0x34>;
+		interrupts = <0>;
 
-		ahci: sata at 01c18000 {
-			target-supply = <&reg_ahci_5v>;
-			status = "okay";
-		};
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
 
-		ehci1: usb at 01c1c000 {
-			status = "okay";
-		};
+&mdio {
+	status = "okay";
 
-		ohci1: usb at 01c1c400 {
-			status = "okay";
-		};
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
 
-		pinctrl at 01c20800 {
-			ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
-				allwinner,pins = "PC3";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			led_pins_olinuxinolime: led_pins at 0 {
-				allwinner,pins = "PH2";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
 
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
+&ohci0 {
+	status = "okay";
+};
 
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "okay";
+&ohci1 {
+	status = "okay";
+};
 
-			axp209: pmic at 34 {
-				compatible = "x-powers,axp209";
-				reg = <0x34>;
-				interrupts = <0>;
+&pio {
+	ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
+		allwinner,pins = "PC3";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
+	led_pins_olinuxinolime: led_pins at 0 {
+		allwinner,pins = "PH2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_olinuxinolime>;
+&reg_ahci_5v {
+	pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
+	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
 
-		green {
-			label = "a10-olinuxino-lime:green:usr";
-			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
+&reg_usb1_vbus {
+	status = "okay";
+};
 
-	reg_ahci_5v: ahci-5v {
-		pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
-		gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
-		status = "okay";
-	};
+&reg_usb2_vbus {
+	status = "okay";
+};
 
-	reg_usb1_vbus: usb1-vbus {
-		status = "okay";
-	};
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
 
-	reg_usb2_vbus: usb2-vbus {
-		status = "okay";
-	};
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
 };
-- 
2.2.2
