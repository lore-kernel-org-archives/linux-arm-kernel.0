From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 10 May 2015 12:16:23 +0530
Subject: [PATCH 6/6] ARM: dts: sun8i: Add ET-Q8 A33 support
In-Reply-To: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1431240383-12763-7-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ET-Q8_A33 is A33 based cheap tablet in common Q8 format.

It has 512MB RAM, 4GB Nand, 7" Display, RDA5900P wifi, GSL1680 touch, etc.

Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
---
 arch/arm/boot/dts/Makefile            |   3 +-
 arch/arm/boot/dts/sun8i-a33-et-q8.dts | 108 ++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-a33-et-q8.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 82f4b9b..d44b1d6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -570,7 +570,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-wexler-tab7200.dtb
 dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a23-ippo-q8h-v5.dtb \
-	sun8i-a23-ippo-q8h-v1.2.dtb
+	sun8i-a23-ippo-q8h-v1.2.dtb \
+	sun8i-a33-et-q8.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
diff --git a/arch/arm/boot/dts/sun8i-a33-et-q8.dts b/arch/arm/boot/dts/sun8i-a33-et-q8.dts
new file mode 100644
index 0000000..260d5a3
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a33-et-q8.dts
@@ -0,0 +1,108 @@
+/*
+ * Copyright 2015 Vishnu Patekar
+ * Vishnu Patekar <vishnupatekar0510@gmail.com>
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
+#include "sun8i-a33.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	model = "ET Q8 A33 ";
+	compatible = "et-q8-q33", "allwinner,sun8i", "allwinner,sun8i-a33";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,115200";
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_vcc3v0>;
+	status = "okay";
+
+	button at 200 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <200000>;
+	};
+
+	button at 400 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <400000>;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	/* pull-ups and devices require PMIC regulator */
+	status = "failed";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
-- 
1.9.1
