From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:49:02 +0200
Subject: [PATCH 13/13] ARM: dts: mvebu: add support for Linksys WRT3200ACM
 (Rango)
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-14-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linksys WRT3200ACM (Rango) is the lates Armada-385 based router in
the Linksys WRT AC Series which got released in October 2016.

The file armada-385-linksys-rango.dts is loosly based off of a DTS
authored by Imre Kaloz.

As Rango is part of the armada-385-linksys family of boards use the
armada-385-linksys.dtsi as basis. As for functional differences to Imre
Kaloz dts, the wlan LEDs aren't connected to the expander chip pca9635
but directly to GPIOs. Then mpp47 controls the USB2.0 port and not the
USB3.0 port, so use the correct GPIO mpp44 for it.

Other changes can be categorized as just cleanup / reorganization due to
using the armada-385-linksys.dtsi.

URL: https://github.com/openwrt/openwrt/blob/0abc3fa5a996daf7dafdc7794ccfe3fa7e955c5a/target/linux/mvebu/files/arch/arm/boot/dts/armada-385-linksys-rango.dts
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

---

Notes:

  The sdhci node is taken as is, the current node lets one use the
  wireless part of the attached sd8887. There is an issue with the
  initalization of the bluetooth firmware though. Haven't had the time
  to investigate that in depth so far but shouldn't hold up the Rango
  addition.

  The non-removable property might be more appropriate than broken-cd
  though.

  Checkpatch complains about the line length of the URL, though not much
  room there. Checkpatch also complains about the vendor prefix linksys
  not being documented, however this follows the examples given by the
  other boards.
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/armada-385-linksys-rango.dts | 203 +++++++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-linksys-rango.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c5e1d9..6be2974 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -999,6 +999,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
 	armada-385-db-ap.dtb \
 	armada-385-linksys-caiman.dtb \
 	armada-385-linksys-cobra.dtb \
+	armada-385-linksys-rango.dtb \
 	armada-385-linksys-shelby.dtb \
 	armada-385-synology-ds116.dtb \
 	armada-385-turris-omnia.dtb \
diff --git a/arch/arm/boot/dts/armada-385-linksys-rango.dts b/arch/arm/boot/dts/armada-385-linksys-rango.dts
new file mode 100644
index 0000000..86f3207
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-linksys-rango.dts
@@ -0,0 +1,203 @@
+/*
+ * Device Tree file for the Linksys WRT3200ACM (Rango)
+ *
+ * Copyright (C) 2016 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is licensed under the terms of the GNU General Public
+ *     License version 2.  This program is licensed "as is" without
+ *     any warranty of any kind, whether express or implied.
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
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "armada-385-linksys.dtsi"
+
+/ {
+	model = "Linksys WRT3200ACM";
+	compatible = "linksys,rango", "linksys,armada385", "marvell,armada385",
+		     "marvell,armada380";
+};
+
+&expander0 {
+	wan_amber at 0 {
+		label = "rango:amber:wan";
+		reg = <0x0>;
+	};
+
+	wan_white at 1 {
+		label = "rango:white:wan";
+		reg = <0x1>;
+	};
+
+	usb2 at 5 {
+		label = "rango:white:usb2";
+		reg = <0x5>;
+	};
+
+	usb3_1 at 6 {
+		label = "rango:white:usb3_1";
+		reg = <0x6>;
+	};
+
+	usb3_2 at 7 {
+		label = "rango:white:usb3_2";
+		reg = <0x7>;
+	};
+
+	wps_white at 8 {
+		label = "rango:white:wps";
+		reg = <0x8>;
+	};
+
+	wps_amber at 9 {
+		label = "rango:amber:wps";
+		reg = <0x9>;
+	};
+};
+
+&gpio_leds {
+	power {
+		gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
+		label = "rango:white:power";
+	};
+
+	sata {
+		gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		label = "rango:white:sata";
+	};
+
+	wlan_2g {
+		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		label = "rango:white:wlan_2g";
+	};
+
+	wlan_5g {
+		gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+		label = "rango:white:wlan_5g";
+	};
+};
+
+&gpio_leds_pins {
+	marvell,pins = "mpp21", "mpp45", "mpp46", "mpp56";
+};
+
+&nand {
+	/* AMD/Spansion S34ML02G2 256MiB, OEM Layout */
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x200000>;  /* 2MiB */
+		read-only;
+	};
+
+	partition at 200000 {
+		label = "u_env";
+		reg = <0x200000 0x20000>;    /* 128KiB */
+	};
+
+	partition at 220000 {
+		label = "s_env";
+		reg = <0x220000 0x40000>;    /* 256KiB */
+	};
+
+	partition at 7e0000 {
+		label = "devinfo";
+		reg = <0x7e0000 0x40000>;   /* 256KiB */
+		read-only;
+	};
+
+	partition at 820000 {
+		label = "sysdiag";
+		reg = <0x820000 0x1e0000>;   /* 1920KiB */
+		read-only;
+	};
+
+	/* kernel1 overlaps with rootfs1 by design */
+	partition at a00000 {
+		label = "kernel1";
+		reg = <0xa00000 0x5000000>;  /* 80MiB */
+	};
+
+	partition at 1000000 {
+		label = "rootfs1";
+		reg = <0x1000000 0x4a00000>;  /* 74MiB */
+	};
+
+	/* kernel2 overlaps with rootfs2 by design */
+	partition at 5a00000 {
+		label = "kernel2";
+		reg = <0x5a00000 0x5000000>; /* 80MiB */
+	};
+
+	partition at 6000000 {
+		label = "rootfs2";
+		reg = <0x6000000 0x4a00000>; /* 74MiB */
+	};
+
+	/*
+	 * 86MiB, last MiB is for the BBT, not writable
+	 */
+	partition at aa00000 {
+		label = "syscfg";
+		reg = <0xaa00000 0x5600000>;
+	};
+
+	/*
+	 * Unused area between "s_env" and "devinfo".
+	 * Moved here because otherwise the renumbered
+	 * partitions would break the bootloader
+	 * supplied bootargs
+	 */
+	partition at 180000 {
+		label = "unused_area";
+		reg = <0x260000 0x5c0000>;   /* 5.75MiB */
+	};
+};
+
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhci_pins>;
+	no-1-8-v;
+	broken-cd;
+	wp-inverted;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&usb3_1_vbus {
+	gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3_1_vbus_pins {
+	marvell,pins = "mpp44";
+};
-- 
2.10.2
