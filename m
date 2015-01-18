From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 18 Jan 2015 13:09:44 +0100
Subject: [PATCH v3 2/3] ARM: dts: sun4i: Add mk802ii board
In-Reply-To: <1421582985-26087-1-git-send-email-hdegoede@redhat.com>
References: <1421582985-26087-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1421582985-26087-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mk802ii is a revised version of the mk802 A10 based hdmi tv-stick, it
features 1G RAM, 4G nand, a hdmi male connector, USB-A receptacle, 2 micro
usb receptacles (OTG & power) and USB-wifi, and does come with an axp209 pmic.

For more details see: http://linux-sunxi.org/Rikomagic_mk802ii

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts | 113 ++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-mk802ii.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index dfb6885..b543e7d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -449,6 +449,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-cubieboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
 	sun4i-a10-mk802.dtb \
+	sun4i-a10-mk802ii.dtb \
 	sun4i-a10-hackberry.dtb \
 	sun4i-a10-inet97fv2.dtb \
 	sun4i-a10-olinuxino-lime.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
new file mode 100644
index 0000000..802eda4
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
@@ -0,0 +1,113 @@
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
+#include "sun4i-a10.dtsi"
+#include "sunxi-common-regulators.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "MK802ii";
+	compatible = "allwinner,mk802ii", "allwinner,sun4i-a10";
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
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp209: pmic at 34 {
+		compatible = "x-powers,axp209";
+		reg = <0x34>;
+		interrupts = <0>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
+
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
2.1.0
