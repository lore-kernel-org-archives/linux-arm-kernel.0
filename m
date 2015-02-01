From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:50:12 +0100
Subject: [PATCH 28/30] ARM: sun7i: olinuxino micro: Convert to DT label based
 syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-29-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 364 ++++++++++++------------
 1 file changed, 181 insertions(+), 183 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 714e15ac5416..814cf166f6a1 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -32,216 +32,214 @@
 		spi1 = &spi2;
 	};
 
-	soc at 01c00000 {
-		spi1: spi at 01c06000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&spi1_pins_a>;
-			status = "okay";
-		};
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxino>;
 
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
-			cd-inverted;
-			status = "okay";
+		green {
+			label = "a20-olinuxino-micro:green:usr";
+			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
 		};
+	};
+};
 
-		mmc3: mmc at 01c12000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olinuxinom>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
-			cd-inverted;
-			status = "okay";
-		};
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
 
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			usb2_vbus-supply = <&reg_usb2_vbus>;
-			status = "okay";
-		};
+&ehci0 {
+	status = "okay";
+};
 
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
+&ehci1 {
+	status = "okay";
+};
 
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_mii_a>;
+	phy = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
 
-		spi2: spi at 01c17000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&spi2_pins_a>;
-			status = "okay";
-		};
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
 
-		ahci: sata at 01c18000 {
-			target-supply = <&reg_ahci_5v>;
-			status = "okay";
-		};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
 
-		ehci1: usb at 01c1c000 {
-			status = "okay";
-		};
+	axp209: pmic at 34 {
+		compatible = "x-powers,axp209";
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 
-		ohci1: usb at 01c1c400 {
-			status = "okay";
-		};
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
 
-		pinctrl at 01c20800 {
-			mmc3_cd_pin_olinuxinom: mmc3_cd_pin at 0 {
-				allwinner,pins = "PH11";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			led_pins_olinuxino: led_pins at 0 {
-				allwinner,pins = "PH2";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
 
-		lradc: lradc at 01c22800 {
-			vref-supply = <&reg_vcc3v0>;
-			status = "okay";
-
-			button at 191 {
-				label = "Volume Up";
-				linux,code = <KEY_VOLUMEUP>;
-				channel = <0>;
-				voltage = <191274>;
-			};
-
-			button at 392 {
-				label = "Volume Down";
-				linux,code = <KEY_VOLUMEDOWN>;
-				channel = <0>;
-				voltage = <392644>;
-			};
-
-			button at 601 {
-				label = "Menu";
-				linux,code = <KEY_MENU>;
-				channel = <0>;
-				voltage = <601151>;
-			};
-
-			button at 795 {
-				label = "Search";
-				linux,code = <KEY_SEARCH>;
-				channel = <0>;
-				voltage = <795090>;
-			};
-
-			button at 987 {
-				label = "Home";
-				linux,code = <KEY_HOMEPAGE>;
-				channel = <0>;
-				voltage = <987387>;
-			};
-
-			button at 1184 {
-				label = "Esc";
-				linux,code = <KEY_ESC>;
-				channel = <0>;
-				voltage = <1184678>;
-			};
-
-			button at 1398 {
-				label = "Enter";
-				linux,code = <KEY_ENTER>;
-				channel = <0>;
-				voltage = <1398804>;
-			};
-		};
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
 
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
+&lradc {
+	vref-supply = <&reg_vcc3v0>;
+	status = "okay";
 
-		uart6: serial at 01c29800 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart6_pins_a>;
-			status = "okay";
-		};
+	button at 191 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <191274>;
+	};
 
-		uart7: serial at 01c29c00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart7_pins_a>;
-			status = "okay";
-		};
+	button at 392 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <392644>;
+	};
 
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "okay";
+	button at 601 {
+		label = "Menu";
+		linux,code = <KEY_MENU>;
+		channel = <0>;
+		voltage = <601151>;
+	};
 
-			axp209: pmic at 34 {
-				compatible = "x-powers,axp209";
-				reg = <0x34>;
-				interrupt-parent = <&nmi_intc>;
-				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	button at 795 {
+		label = "Search";
+		linux,code = <KEY_SEARCH>;
+		channel = <0>;
+		voltage = <795090>;
+	};
 
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
+	button at 987 {
+		label = "Home";
+		linux,code = <KEY_HOMEPAGE>;
+		channel = <0>;
+		voltage = <987387>;
+	};
 
-		i2c1: i2c at 01c2b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c1_pins_a>;
-			status = "okay";
-		};
+	button at 1184 {
+		label = "Esc";
+		linux,code = <KEY_ESC>;
+		channel = <0>;
+		voltage = <1184678>;
+	};
 
-		i2c2: i2c at 01c2b400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c2_pins_a>;
-			status = "okay";
-		};
+	button at 1398 {
+		label = "Enter";
+		linux,code = <KEY_ENTER>;
+		channel = <0>;
+		voltage = <1398804>;
+	};
+};
 
-		gmac: ethernet at 01c50000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gmac_pins_mii_a>;
-			phy = <&phy1>;
-			phy-mode = "mii";
-			status = "okay";
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
+	cd-inverted;
+	status = "okay";
+};
 
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
-	};
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olinuxinom>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+	cd-inverted;
+	status = "okay";
+};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_olinuxino>;
+&ohci0 {
+	status = "okay";
+};
 
-		green {
-			label = "a20-olinuxino-micro:green:usr";
-			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
+&ohci1 {
+	status = "okay";
+};
 
-	reg_ahci_5v: ahci-5v {
-		status = "okay";
+&pio {
+	mmc3_cd_pin_olinuxinom: mmc3_cd_pin at 0 {
+		allwinner,pins = "PH11";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 
-	reg_usb1_vbus: usb1-vbus {
-		status = "okay";
+	led_pins_olinuxino: led_pins at 0 {
+		allwinner,pins = "PH2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+};
 
-	reg_usb2_vbus: usb2-vbus {
-		status = "okay";
-	};
+&reg_ahci_5v {
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
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins_a>;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart6_pins_a>;
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
