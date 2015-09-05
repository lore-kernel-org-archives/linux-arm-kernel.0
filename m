From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  5 Sep 2015 16:55:53 +0200
Subject: [PATCH 3/3] ARM: dts: sun5i: Add dts file for q8 formfactor a13 based
 tablets
In-Reply-To: <1441464953-26351-1-git-send-email-hdegoede@redhat.com>
References: <1441464953-26351-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1441464953-26351-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commits adds a generic dts file for q8 formfactor a13 based tablets.

The tablets ship in many variants, with the difference mainly being the
touchscreen controller / accelerometer / wifi chip used.

The wifi is USB based, and thus not listed in devicetree.

The touchscreen controller / accelerometer may turn out to be a problem
once we add support for those. We can either do something with devicetree
overlays, or add sun5i-a13-<touchscreen>-<accelerometer>.dts files. The
latter is what the android mod community is doing with firmware images.

This dts was tested with an a13 q8 tablet with a pcb labelled: "94V-0",
silead gsl1680 touchscreen controller and a mc32x0 accelerometer.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts | 60 +++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c08883c..6d43044 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -573,6 +573,7 @@ dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a13-inet-98v-rev2.dtb \
 	sun5i-a13-olinuxino.dtb \
 	sun5i-a13-olinuxino-micro.dtb \
+	sun5i-a13-q8-tablet.dtb \
 	sun5i-a13-utoo-p66.dtb \
 	sun5i-r8-chip.dtb
 dtb-$(CONFIG_MACH_SUN6I) += \
diff --git a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
new file mode 100644
index 0000000..72e93ac
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
@@ -0,0 +1,60 @@
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
+#include "sun5i-q8-common.dtsi"
+
+/ {
+	model = "Q8 A13 Tablet";
+	compatible = "allwinner,q8-a13", "allwinner,sun5i-a13";
+};
+
+&reg_ldo3 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_ldo3>;
+};
-- 
2.4.3
