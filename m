From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 18 Aug 2016 17:11:35 +0200
Subject: [PATCH 2/2] ARM: dts: sun6i: Add new dts file for tablets using the
 inet-q972 PCB
In-Reply-To: <1471533095-13432-1-git-send-email-hdegoede@redhat.com>
References: <1471533095-13432-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1471533095-13432-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dts file for tablets using the generic inet-q972 PCB.

Tablets with this PCB feature a mini-hdmi output, micro-usb usb-host,
micro-usb usb-otg, 3.5mm headphone jack, a micro sd slot,
(mini) power-barrel and an usb wifi module.

This has been tested on a 9.7" 1024x768 qware qw tb9718-qhd tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts | 100 +++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 498ebfd..5d984c9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -743,6 +743,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31-mele-a1000g-quad.dtb \
 	sun6i-a31s-colorfly-e708-q1.dtb \
 	sun6i-a31s-cs908.dtb \
+	sun6i-a31s-inet-q972.dtb \
 	sun6i-a31s-primo81.dtb \
 	sun6i-a31s-sina31s.dtb \
 	sun6i-a31s-sinovoip-bpi-m2.dtb \
diff --git a/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts b/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
new file mode 100644
index 0000000..b115533
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
@@ -0,0 +1,100 @@
+/*
+ * Copyright 2016 Hans de Goede <hdegoede@redhat.com>
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
+#include "sun6i-a31s.dtsi"
+#include "sun6i-a31-reference-design-tablet.dtsi"
+
+/ {
+	model = "iNet Q972 tablet";
+	compatible = "inet-tek,inet-q972", "allwinner,sun6i-a31s";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+
+	ft5406ee8: touchscreen at 38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		interrupt-parent = <&pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>; /* PA3 */
+		touchscreen-size-x = <768>;
+		touchscreen-size-y = <1024>;
+		touchscreen-swapped-x-y;
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_aldo3>;
+	status = "okay";
+
+	button at 200 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <200000>;
+	};
+
+	button at 900 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <900000>;
+	};
+
+	button at 1200 {
+		label = "Back";
+		linux,code = <KEY_BACK>;
+		channel = <0>;
+		voltage = <1200000>;
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
-- 
2.7.4
