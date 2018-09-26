From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Sep 2018 21:23:39 +0800
Subject: [PATCH] ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees
Message-ID: <20180926132339.24737-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bananapi released an updated revision of the H3/H5 based Bananapi M2+.
Version 1.2 enables voltage control for the CPU's regulator by using
a GPIO line to toggle a MOSFET that can change the effective resistance
value in the regulator's feedback network.

This patch adds a common .dtsi file for this new revision, which
includes the original common sunxi-bananapi-m2-plus.dtsi file, and
adds the GPIO-controlled regulator and a cpu-supply reference. H3
and H5 variant dts files are added as well.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/sun8i-h3-bananapi-m2-plus-v1.2.dts    | 13 ++++++++
 .../boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 31 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../sun50i-h5-bananapi-m2-plus-v1.2.dts       | 11 +++++++
 5 files changed, 57 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts
 create mode 100644 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 92dc4f05cf23..2a1a8c6625ad 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1033,6 +1033,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h2-plus-orangepi-r1.dtb \
 	sun8i-h2-plus-orangepi-zero.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
+	sun8i-h3-bananapi-m2-plus-v1.2.dtb \
 	sun8i-h3-beelink-x2.dtb \
 	sun8i-h3-libretech-all-h3-cc.dtb \
 	sun8i-h3-nanopi-m1.dtb	\
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts
new file mode 100644
index 000000000000..fc4a8c3d084d
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
+ */
+
+/dts-v1/;
+#include "sun8i-h3.dtsi"
+#include "sunxi-bananapi-m2-plus-v1.2.dtsi"
+
+/ {
+	model = "Banana Pi BPI-M2-Plus v1.2 H3";
+	compatible = "bananapi,bpi-m2-plus-v1.2", "allwinner,sun8i-h3";
+};
diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
new file mode 100644
index 000000000000..53edd1faee99
--- /dev/null
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
+ */
+
+#include "sunxi-bananapi-m2-plus.dtsi"
+
+/ {
+	/*
+	 * Bananapi M2+ v1.2 uses a GPIO line to change the effective
+	 * resistance on the CPU regulator's feedback pin.
+	 */
+	reg_vdd_cpux: vdd-cpux {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-cpux";
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-ramp-delay = <50>; /* 4ms */
+		gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
+		gpios-states = <0x1>;
+		states = <1100000 0x0
+			  1300000 0x1>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 27de09abf712..8d4f97f279e0 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinebook.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus-v1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-cc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
new file mode 100644
index 000000000000..2e2b14c0ae75
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
+
+/dts-v1/;
+#include "sun50i-h5.dtsi"
+#include <arm/sunxi-bananapi-m2-plus-v1.2.dtsi>
+
+/ {
+	model = "Banana Pi BPI-M2-Plus v1.2 H5";
+	compatible = "bananapi,bpi-m2-plus-v1.2", "allwinner,sun50i-h5";
+};
-- 
2.19.0
