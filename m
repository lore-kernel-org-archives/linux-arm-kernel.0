From: merker@debian.org (Karsten Merker)
Date: Tue, 23 Jun 2015 19:02:28 +0200
Subject: [PATCH V4 1/2] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
In-Reply-To: <1435078949-3383-1-git-send-email-merker@debian.org>
References: <20150618115838.GL11732@lukather>
 <1435078949-3383-1-git-send-email-merker@debian.org>
Message-ID: <1435078949-3383-2-git-send-email-merker@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSI Primo81 is an A31s based tablet, with 1G RAM, 16G NAND,
1024x768 IPS LCD display, mono speaker, 0.3 MP front camera, 2.0 MP
rear camera, 3500 mAh battery, gt911 touchscreen, mma8452 accelerometer
and rtl8188etv usb wifi. Has "power", "volume+" and "volume-" buttons
(both volume buttons are also connected to the UBOOT_SEL pin). The
external connectors are represented by MicroSD slot, MiniHDMI, MicroUSB
OTG and 3.5mm headphone jack. More details are available at
    http://linux-sunxi.org/MSI_Primo81

This initial dts file only provides support for mmc, wifi and uart
(there is no external connector for uart though). Graphics can be used
via simplefb. However, without usb otg, there are no reasonable means
to handle user input yet.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Signed-off-by: Karsten Merker <merker@debian.org>
---
Changelog:

Version 1
=========
- Original patch by Siarhei Siamashka

Version 2
=========
- Use symbolic instead of numeric pinctrl values.

- Change the include syntax from /include/ to #include to make
  the dts build with current kernels.

Version 3
=========
- Use labels for nodes with modifications in relation to the dtsi
  instead of replicating the tree structure.

- Remove the FSF address from the license header as done in
  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/340437.html
  for the other dts files to remove a checkpatch warning.

- Add msi to the vendor prefix list.

- Remove earlyprintk from the default kernel commandline.

- Replace the console kernel commandline parameter by a
  /chosen/stdout-path node and add an alias serial0 -> uart0.

Version 4
=========
- Split out the vendor prefix documentation into a separate patch.

- Add a comment regarding the uart0 accessibility to the corresponding
  entry in the dts.

 arch/arm/boot/dts/Makefile               |   3 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts | 103 +++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 867e6e3..31686c7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -552,7 +552,8 @@ dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31-i7.dtb \
 	sun6i-a31-m9.dtb \
 	sun6i-a31-mele-a1000g-quad.dtb \
-	sun6i-a31s-cs908.dtb
+	sun6i-a31s-cs908.dtb \
+	sun6i-a31s-primo81.dtb
 dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-bananapi.dtb \
 	sun7i-a20-bananapro.dtb \
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
new file mode 100644
index 0000000..bd15ee1
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -0,0 +1,103 @@
+/*
+ * Copyright 2014 Siarhei Siamashka <siarhei.siamashka@gmail.com>
+ * Copyright 2015 Karsten Merker <merker@debian.org>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
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
+#include "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "MSI Primo81 tablet";
+	compatible = "msi,primo81", "allwinner,sun6i-a31s";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+};
+
+&ehci0 {
+	/* rtl8188etv wifi is connected here */
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_primo81>;
+	vmmc-supply = <&reg_vcc3v0>;
+	bus-width = <4>;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
+	cd-inverted;
+	status = "okay";
+};
+
+&pio {
+	mmc0_cd_pin_primo81: mmc0_cd_pin at 0 {
+		allwinner,pins = "PA8";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
+&uart0 {
+	/* The default uart0 pins (PH20: TX, PH21: RX) are not accessible
+	 * on an external connector. Possible ways to get physical access
+	 * to uart0 include:
+	 * - disabling mmc0, changing the pinmuxing for the SD card pins
+	 *   to the uart0 function (PF2: TX, PF4: RX) and using an SD card
+	 *   breakout board
+	 * - opening the case and finding appropriate test points connected
+	 *   to PH20 and PH21
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.1.4
