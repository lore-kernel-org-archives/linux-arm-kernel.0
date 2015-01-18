From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 18 Jan 2015 13:09:45 +0100
Subject: [PATCH v3 3/3] ARM: dts: sun5i: Add mk802_a10s board
In-Reply-To: <1421582985-26087-1-git-send-email-hdegoede@redhat.com>
References: <1421582985-26087-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1421582985-26087-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mk802_a10s re-uses is the "classic" mk802 case and functionality, but has
an A10s SoC inside rather then the A10, it features 512M or 1G RAM, 4G nand,
a mini-hdmi female connector, USB-A receptacle, mini-usb receptacle (OTG)
and a sdio realtek wifi chip. Unlike the original mk802 it does have a pmic,
the axp152.

For more details see: http://linux-sunxi.org/Semitime_g2

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/sun5i-a10s-mk802.dts | 125 +++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-mk802.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b543e7d..a3f58cf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -456,6 +456,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-pcduino.dtb
 dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a10s-auxtek-t004.dtb \
+	sun5i-a10s-mk802.dtb \
 	sun5i-a10s-olinuxino-micro.dtb \
 	sun5i-a10s-r7-tv-dongle.dtb \
 	sun5i-a13-hsg-h702.dtb \
diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
new file mode 100644
index 0000000..399866a
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -0,0 +1,125 @@
+/*
+ * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
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
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+#include "sun5i-a10s.dtsi"
+#include "sunxi-common-regulators.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "MK802-A10s";
+	compatible = "allwinner,mk802_a10s", "allwinner,sun5i-a10s";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_mk802_a10s>;
+
+		red {
+			label = "mk802:red:usr";
+			gpios = <&pio 1 2 GPIO_ACTIVE_HIGH>; /* PB2 */
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
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_mk802_a10s>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
+	cd-inverted;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	led_pins_mk802_a10s: led_pins at 0 {
+		allwinner,pins = "PB2";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	mmc0_cd_pin_mk802_a10s: mmc0_cd_pin at 0 {
+		allwinner,pins = "PG1";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	usb1_vbus_pin_mk802_a10s: usb1_vbus_pin at 0 {
+		allwinner,pins = "PB10";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&reg_usb1_vbus {
+	pinctrl-0 = <&usb1_vbus_pin_mk802_a10s>;
+	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
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
+	status = "okay";
+};
-- 
2.1.0
