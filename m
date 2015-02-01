From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:49:56 +0100
Subject: [PATCH 12/30] ARM: sun5i: a10s: olinuxino micro: Convert to DT label
 based syntax
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-13-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to lessen the amount of duplication of the DT tree, ease the
new and follow the trend that prefers to use label based references
when overriding DTSI nodes, convert the board to this syntax

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 315 +++++++++++------------
 1 file changed, 157 insertions(+), 158 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 2bbc93b935ca..aa88ee887381 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -65,184 +65,183 @@
 		serial2 = &uart3;
 	};
 
-	soc at 01c00000 {
-		emac: ethernet at 01c0b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&emac_pins_a>;
-			phy = <&phy1>;
-			status = "okay";
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxino>;
+
+		green {
+			label = "a10s-olinuxino-micro:green:usr";
+			gpios = <&pio 4 3 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
 		};
+	};
+};
 
-		mdio at 01c0b080 {
-			status = "okay";
+&ehci0 {
+	status = "okay";
+};
 
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_pins_a>;
+	phy = <&phy1>;
+	status = "okay";
+};
 
-		mmc0: mmc at 01c0f000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino_micro>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-			cd-inverted;
-			status = "okay";
-		};
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
 
-		mmc1: mmc at 01c10000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc1_pins_a>, <&mmc1_cd_pin_olinuxino_micro>;
-			vmmc-supply = <&reg_vcc3v3>;
-			bus-width = <4>;
-			cd-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
-			cd-inverted;
-			status = "okay";
-		};
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
 
-		usbphy: phy at 01c13400 {
-			usb1_vbus-supply = <&reg_usb1_vbus>;
-			status = "okay";
-		};
+	at24 at 50 {
+		compatible = "at,24c16";
+		pagesize = <16>;
+		reg = <0x50>;
+		read-only;
+	};
+};
 
-		ehci0: usb at 01c14000 {
-			status = "okay";
-		};
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
 
-		ohci0: usb at 01c14400 {
-			status = "okay";
-		};
+&lradc {
+	vref-supply = <&reg_vcc3v0>;
+	status = "okay";
 
-		pinctrl at 01c20800 {
-			mmc0_cd_pin_olinuxino_micro: mmc0_cd_pin at 0 {
-				allwinner,pins = "PG1";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			mmc1_cd_pin_olinuxino_micro: mmc1_cd_pin at 0 {
-				allwinner,pins = "PG13";
-				allwinner,function = "gpio_in";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			led_pins_olinuxino: led_pins at 0 {
-				allwinner,pins = "PE3";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_20_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			usb1_vbus_pin_olinuxino_m: usb1_vbus_pin at 0 {
-				allwinner,pins = "PB10";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
+	button at 191 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <191274>;
+	};
 
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
-				label = "Enter";
-				linux,code = <KEY_ENTER>;
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
-		};
+	button at 392 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <392644>;
+	};
 
-		uart0: serial at 01c28000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
+	button at 601 {
+		label = "Menu";
+		linux,code = <KEY_MENU>;
+		channel = <0>;
+		voltage = <601151>;
+	};
 
-		uart2: serial at 01c28800 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart2_pins_a>;
-			status = "okay";
-		};
+	button at 795 {
+		label = "Enter";
+		linux,code = <KEY_ENTER>;
+		channel = <0>;
+		voltage = <795090>;
+	};
 
-		uart3: serial at 01c28c00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart3_pins_a>;
-			status = "okay";
-		};
+	button at 987 {
+		label = "Home";
+		linux,code = <KEY_HOMEPAGE>;
+		channel = <0>;
+		voltage = <987387>;
+	};
+};
 
-		i2c0: i2c at 01c2ac00 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins_a>;
-			status = "okay";
-		};
+&mdio {
+	status = "okay";
 
-		i2c1: i2c at 01c2b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c1_pins_a>;
-			status = "okay";
-
-			at24 at 50 {
-				compatible = "at,24c16";
-				pagesize = <16>;
-				reg = <0x50>;
-				read-only;
-			};
-		};
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
 
-		i2c2: i2c at 01c2b400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c2_pins_a>;
-			status = "okay";
-		};
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino_micro>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_a>, <&mmc1_cd_pin_olinuxino_micro>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	mmc0_cd_pin_olinuxino_micro: mmc0_cd_pin at 0 {
+		allwinner,pins = "PG1";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_olinuxino>;
+	mmc1_cd_pin_olinuxino_micro: mmc1_cd_pin at 0 {
+		allwinner,pins = "PG13";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
 
-		green {
-			label = "a10s-olinuxino-micro:green:usr";
-			gpios = <&pio 4 3 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
+	led_pins_olinuxino: led_pins at 0 {
+		allwinner,pins = "PE3";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	reg_usb1_vbus: usb1-vbus {
-		pinctrl-0 = <&usb1_vbus_pin_olinuxino_m>;
-		gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>;
-		status = "okay";
+	usb1_vbus_pin_olinuxino_m: usb1_vbus_pin at 0 {
+		allwinner,pins = "PB10";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&reg_usb1_vbus {
+	pinctrl-0 = <&usb1_vbus_pin_olinuxino_m>;
+	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins_a>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins_a>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
+
-- 
2.2.2
