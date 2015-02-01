From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:11 +0100
Subject: [PATCH 27/30] ARM: sun7i: olinuxino lime2: Convert to DT label based
 syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-28-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 288 ++++++++++++------------
 1 file changed, 143 insertions(+), 145 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 260dbd3bf29d..5e57157f742d 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -57,176 +57,174 @@
 	model = "Olimex A20-OLinuXino-LIME2";
 	compatible = "olimex,a20-olinuxino-lime2", "allwinner,sun7i-a20";
 
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
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxinolime>;
 
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			usb2_vbus-supply = <&reg_usb2_vbus>;
-			status = "okay";
+		green {
+			label = "a20-olinuxino-lime2:green:usr";
+			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
 		};
+	};
 
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
 
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
 
-		ahci: sata at 01c18000 {
-			target-supply = <&reg_ahci_5v>;
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
+	status = "okay";
 
-		pinctrl at 01c20800 {
-			ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
-				allwinner,pins = "PC3";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
 
-			led_pins_olinuxinolime: led_pins at 0 {
-				allwinner,pins = "PH2";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
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
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		acin-supply = <&reg_axp_ipsout>;
+		vin2-supply = <&reg_axp_ipsout>;
+		vin3-supply = <&reg_axp_ipsout>;
+		ldo24in-supply = <&reg_axp_ipsout>;
+		ldo3in-supply = <&reg_axp_ipsout>;
+
+		regulators {
+			vdd_rtc: ldo1 {
+				regulator-min-microvolt = <1300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
 			};
-		};
 
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
+			avcc: ldo2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
 
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
-
-				acin-supply = <&reg_axp_ipsout>;
-				vin2-supply = <&reg_axp_ipsout>;
-				vin3-supply = <&reg_axp_ipsout>;
-				ldo24in-supply = <&reg_axp_ipsout>;
-				ldo3in-supply = <&reg_axp_ipsout>;
-
-				regulators {
-					vdd_rtc: ldo1 {
-						regulator-min-microvolt = <1300000>;
-						regulator-max-microvolt = <1300000>;
-						regulator-always-on;
-					};
-
-					avcc: ldo2 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <3300000>;
-						regulator-always-on;
-					};
-
-					vcc_csi0: ldo3 {
-						regulator-min-microvolt = <700000>;
-						regulator-max-microvolt = <3500000>;
-						regulator-always-on;
-					};
-
-					vcc_csi1: ldo4 {
-						regulator-min-microvolt = <1250000>;
-						regulator-max-microvolt = <3300000>;
-						regulator-always-on;
-					};
-
-					vdd_cpu: dcdc2 {
-						regulator-min-microvolt = <700000>;
-						regulator-max-microvolt = <2275000>;
-						regulator-always-on;
-					};
-
-					vdd_int: dcdc3 {
-						regulator-min-microvolt = <700000>;
-						regulator-max-microvolt = <3500000>;
-						regulator-always-on;
-					};
-				};
+			vcc_csi0: ldo3 {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-always-on;
 			};
-		};
 
-		i2c1: i2c at 01c2b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c1_pins_a>;
-			status = "okay";
-		};
+			vcc_csi1: ldo4 {
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
 
-		gmac: ethernet at 01c50000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gmac_pins_rgmii_a>;
-			phy = <&phy1>;
-			phy-mode = "rgmii";
-			status = "okay";
+			vdd_cpu: dcdc2 {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <2275000>;
+				regulator-always-on;
+			};
 
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
+			vdd_int: dcdc3 {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-always-on;
 			};
 		};
 	};
+};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_olinuxinolime>;
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
 
-		green {
-			label = "a20-olinuxino-lime2:green:usr";
-			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
 
-	reg_ahci_5v: ahci-5v {
-		pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
-		gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
-		status = "okay";
-	};
+&ohci0 {
+	status = "okay";
+};
 
-	reg_usb1_vbus: usb1-vbus {
-		status = "okay";
-	};
+&ohci1 {
+	status = "okay";
+};
 
-	reg_usb2_vbus: usb2-vbus {
-		status = "okay";
+&pio {
+	ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
+		allwinner,pins = "PC3";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	reg_axp_ipsout: axp_ipsout {
-		compatible = "regulator-fixed";
-		regulator-name = "axp-ipsout";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
+	led_pins_olinuxinolime: led_pins at 0 {
+		allwinner,pins = "PH2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&reg_ahci_5v {
+	pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
+	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
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
