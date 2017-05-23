From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Tue, 23 May 2017 18:30:37 +0530
Subject: [PATCH] ARM: dts: sun5i: a13: Add Olimex SOM board dts support
Message-ID: <1495544437-32463-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@openedev.com>

Add support for Olimex A13-512-SOM board, and this particular
design is like A13-SOM-WIFI can mount on-top of A13-SOM.

https://www.olimex.com/Products/SOM/A13/A13-SOM-512/
https://www.olimex.com/Products/SOM/A13/A13-SOM-WIFI/open-source-hardware

Features:
- A13 Cortex A8 processor at 1GHz, 3D Mali400 GPU
- 512MB DDR3 memory
- MicroSD card connector
- UART console connector
- Status LEDs
- BL-8188-8M WiFi wireless module with Realtek RTL8188CUS chip
- USB-OTG with mini USB connector

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Jagan Teki <jagan@openedev.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts | 174 ++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c5e1d9..45c6e65 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -830,6 +830,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a13-licheepi-one.dtb \
 	sun5i-a13-olinuxino.dtb \
 	sun5i-a13-olinuxino-micro.dtb \
+	sun5i-a13-olinuxino-som.dtb \
 	sun5i-a13-q8-tablet.dtb \
 	sun5i-a13-utoo-p66.dtb \
 	sun5i-gr8-chip-pro.dtb \
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts
new file mode 100644
index 0000000..3bb3b7d
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-som.dts
@@ -0,0 +1,174 @@
+/*
+ * Copyright 2012 Maxime Ripard <maxime.ripard@free-electrons.com>
+ * Copyright 2013 Hans de Goede <hdegoede@redhat.com>
+ * Copyright 2017 Jagan Teki <jagan@openedev.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "sun5i-a13.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	model = "Olimex A13-Olinuxino SOM";
+	compatible = "olimex,a13-olinuxino-som", "allwinner,sun5i-a13";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxinom>;
+
+		power {
+			label = "a13-olinuxino-micro:green:power";
+			gpios = <&pio 6 9 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxinom>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&pio {
+	mmc0_cd_pin_olinuxinom: mmc0_cd_pin at 0 {
+		allwinner,pins = "PG0";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	led_pins_olinuxinom: led_pins at 0 {
+		allwinner,pins = "PG9";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PG2";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+		allwinner,pins = "PG1";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_DOWN>;
+	};
+
+	usb0_vbus_pin_olinuxinom: usb0_vbus_pin at 0 {
+		allwinner,pins = "PG12";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	usb1_vbus_pin_olinuxinom: usb1_vbus_pin at 0 {
+		allwinner,pins = "PG11";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&reg_usb0_vbus {
+	pinctrl-0 = <&usb0_vbus_pin_olinuxinom>;
+	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	pinctrl-0 = <&usb1_vbus_pin_olinuxinom>;
+	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_b>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
+	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
+	usb0_vbus_det-gpio = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
1.9.1
