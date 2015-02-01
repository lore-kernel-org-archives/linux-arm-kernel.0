From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:04 +0100
Subject: [PATCH 20/30] ARM: sun7i: bananapi: Convert to DT label based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-21-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 262 +++++++++++++++----------------
 1 file changed, 130 insertions(+), 132 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 5dd139e7792e..6d1faf069e7e 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -65,160 +65,158 @@
 		serial2 = &uart7;
 	};
 
-	soc at 01c00000 {
-		spi0: spi at 01c05000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&spi0_pins_a>;
-			status = "okay";
-		};
-
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
-			cd-inverted;
-			status = "okay";
-		};
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_bananapi>;
 
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			usb2_vbus-supply = <&reg_usb2_vbus>;
-			status = "okay";
+		green {
+			label = "bananapi:green:usr";
+			gpios = <&pio 7 24 GPIO_ACTIVE_HIGH>;
 		};
+	};
 
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac_power_pin_bananapi>;
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>;
+	};
+};
 
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
+&ahci {
+	status = "okay";
+};
 
-		ahci: sata at 01c18000 {
-			status = "okay";
-		};
+&ehci0 {
+	status = "okay";
+};
 
-		ehci1: usb at 01c1c000 {
-			status = "okay";
-		};
+&ehci1 {
+	status = "okay";
+};
 
-		ohci1: usb at 01c1c400 {
-			status = "okay";
-		};
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	phy = <&phy1>;
+	phy-mode = "rgmii";
+	phy-supply = <&reg_gmac_3v3>;
+	status = "okay";
 
-		pinctrl at 01c20800 {
-			mmc0_cd_pin_bananapi: mmc0_cd_pin at 0 {
-				allwinner,pins = "PH10";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			gmac_power_pin_bananapi: gmac_power_pin at 0 {
-				allwinner,pins = "PH23";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			led_pins_bananapi: led_pins at 0 {
-				allwinner,pins = "PH24";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
 
-		ir0: ir at 01c21800 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&ir0_pins_a>;
-			status = "okay";
-		};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
 
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
+	axp209: pmic at 34 {
+		compatible = "x-powers,axp209";
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
-		uart3: serial at 01c28c00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart3_pins_b>;
-			status = "okay";
-		};
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
 
-		uart7: serial at 01c29c00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart7_pins_a>;
-			status = "okay";
-		};
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
 
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "okay";
+&ir0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir0_pins_a>;
+	status = "okay";
+};
 
-			axp209: pmic at 34 {
-				compatible = "x-powers,axp209";
-				reg = <0x34>;
-				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
+	cd-inverted;
+	status = "okay";
+};
 
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
+&ohci0 {
+	status = "okay";
+};
 
-		i2c2: i2c at 01c2b400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c2_pins_a>;
-			status = "okay";
-		};
+&ohci1 {
+	status = "okay";
+};
 
-		gmac: ethernet at 01c50000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gmac_pins_rgmii_a>;
-			phy = <&phy1>;
-			phy-mode = "rgmii";
-			phy-supply = <&reg_gmac_3v3>;
-			status = "okay";
-
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
+&pio {
+	mmc0_cd_pin_bananapi: mmc0_cd_pin at 0 {
+		allwinner,pins = "PH10";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_bananapi>;
-
-		green {
-			label = "bananapi:green:usr";
-			gpios = <&pio 7 24 GPIO_ACTIVE_HIGH>;
-		};
+	gmac_power_pin_bananapi: gmac_power_pin at 0 {
+		allwinner,pins = "PH23";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	reg_usb1_vbus: usb1-vbus {
-		status = "okay";
+	led_pins_bananapi: led_pins at 0 {
+		allwinner,pins = "PH24";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+};
 
-	reg_usb2_vbus: usb2-vbus {
-		status = "okay";
-	};
+&reg_usb1_vbus {
+	status = "okay";
+};
 
-	reg_gmac_3v3: gmac-3v3 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_bananapi>;
-		regulator-name = "gmac-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <100000>;
-		enable-active-high;
-		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>;
-	};
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_a>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins_b>;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart7_pins_a>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
 };
-- 
2.2.2
