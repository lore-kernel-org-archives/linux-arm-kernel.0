From: wigyori@uid0.hu (Zoltan HERPAI)
Date: Thu,  8 Jan 2015 10:34:24 +0100
Subject: [PATCH 1/1] ARM: dts: pcduino: Enable user LED and button support for
 pcDuino
Message-ID: <1420709664-12687-1-git-send-email-wigyori@uid0.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pcDuino board has LEDs connected to PH15/PH16, and back/home/menu
buttons to PH17/18/19 respectively. Enable these via gpio-leds and
gpio-keys. This is shared across the v1 and v2 versions of the board.

Tested on a v2 and verified against the schematics of a v1.

Signed-off-by: Zoltan HERPAI <wigyori@uid0.hu>
Acked-by: Hans de Goede <hdegoede@redhat.com>

---
 arch/arm/boot/dts/sun4i-a10-pcduino.dts |   57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 48161ad..c26a6bb 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -51,6 +51,8 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "LinkSprite pcDuino";
@@ -64,6 +66,22 @@
 			status = "okay";
 		};
 
+		pinctrl at 01c20800 {
+			led_pins_pcduino: led_pins at 0 {
+				allwinner,pins = "PH15", "PH16";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			key_pins_pcduino: key_pins at 0 {
+				allwinner,pins = "PH17", "PH18", "PH19";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+		};
+
 		mdio at 01c0b080 {
 			status = "okay";
 
@@ -126,6 +144,45 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_pcduino>;
+
+		tx {
+			label = "pcduino:green:tx";
+			gpios = <&pio 7 15 GPIO_ACTIVE_LOW>;
+		};
+
+		rx {
+			label = "pcduino:green:rx";
+			gpios = <&pio 7 16 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_pins_pcduino>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 0 {
+			label = "Key Back";
+			linux,code = <KEY_BACK>;
+			gpios = <&pio 7 17 GPIO_ACTIVE_LOW>;
+		};
+		button at 1 {
+			label = "Key Home";
+			linux,code = <KEY_HOME>;
+			gpios = <&pio 7 18 GPIO_ACTIVE_LOW>;
+		};
+		button at 2 {
+			label = "Key Menu";
+			linux,code = <KEY_MENU>;
+			gpios = <&pio 7 19 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		status = "okay";
 	};
-- 
1.7.10.4
