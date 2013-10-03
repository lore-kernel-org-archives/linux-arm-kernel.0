From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 13:31:12 +0200
Subject: [PATCH 08/10] ARM: ux500: split the HREF DTS files from two to four
Message-ID: <1380799872-26010-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the device tree conversion did away with the ability to
auto-detect the UIB (User Interface Board) version from attempting
to read an I2C address, we now have to pass the knowledge of
what UIB is mounted through the device tree. This gives rise
to four possible board permutations:

- HREF prior to v60, ST UIB (hrefprev60-stuib)
- HREF prior to v60, TVK1281618 UIB (hrefprev60-tvk)
- HREF v60 and later, ST UIB (href60plus-stuib)
- HREF v60 and later, TVK1281618 UIB (hrefv60plus-tvk)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile                  |  6 ++-
 arch/arm/boot/dts/ste-hrefprev60-stuib.dts  | 28 ++++++++++
 arch/arm/boot/dts/ste-hrefprev60-tvk.dts    | 19 +++++++
 arch/arm/boot/dts/ste-hrefprev60.dts        | 69 -------------------------
 arch/arm/boot/dts/ste-hrefprev60.dtsi       | 65 ++++++++++++++++++++++++
 arch/arm/boot/dts/ste-hrefv60plus-stuib.dts | 30 +++++++++++
 arch/arm/boot/dts/ste-hrefv60plus-tvk.dts   | 21 ++++++++
 arch/arm/boot/dts/ste-hrefv60plus.dts       | 79 -----------------------------
 arch/arm/boot/dts/ste-hrefv60plus.dtsi      | 76 +++++++++++++++++++++++++++
 9 files changed, 243 insertions(+), 150 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-hrefprev60-stuib.dts
 create mode 100644 arch/arm/boot/dts/ste-hrefprev60-tvk.dts
 delete mode 100644 arch/arm/boot/dts/ste-hrefprev60.dts
 create mode 100644 arch/arm/boot/dts/ste-hrefprev60.dtsi
 create mode 100644 arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
 create mode 100644 arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
 delete mode 100644 arch/arm/boot/dts/ste-hrefv60plus.dts
 create mode 100644 arch/arm/boot/dts/ste-hrefv60plus.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cc0f1fb..f1163a4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -189,8 +189,10 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
-	ste-hrefprev60.dtb \
-	ste-hrefv60plus.dtb \
+	ste-hrefprev60-stuib.dtb \
+	ste-hrefprev60-tvk.dtb \
+	ste-hrefv60plus-stuib.dtb \
+	ste-hrefv60plus-tvk.dtb \
 	ste-ccu8540.dtb \
 	ste-ccu9540.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
diff --git a/arch/arm/boot/dts/ste-hrefprev60-stuib.dts b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
new file mode 100644
index 0000000..3e1b974
--- /dev/null
+++ b/arch/arm/boot/dts/ste-hrefprev60-stuib.dts
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2012 ST-Ericsson AB
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "ste-hrefprev60.dtsi"
+#include "ste-href-stuib.dtsi"
+
+/ {
+	model = "ST-Ericsson HREF (pre-v60) and ST UIB";
+	compatible = "st-ericsson,mop500", "st-ericsson,u8500";
+
+	soc {
+		/* Reset line for the BU21013 touchscreen */
+		i2c at 80110000 {
+			bu21013_tp at 5c {
+				reset-gpio = <&tc3589x_gpio 13 0x4>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ste-hrefprev60-tvk.dts b/arch/arm/boot/dts/ste-hrefprev60-tvk.dts
new file mode 100644
index 0000000..59523f8
--- /dev/null
+++ b/arch/arm/boot/dts/ste-hrefprev60-tvk.dts
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2012 ST-Ericsson AB
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "ste-hrefprev60.dtsi"
+#include "ste-href-tvk1281618.dtsi"
+
+/ {
+	model = "ST-Ericsson HREF (pre-v60) and TVK1281618 UIB";
+	compatible = "st-ericsson,mop500", "st-ericsson,u8500";
+};
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dts b/arch/arm/boot/dts/ste-hrefprev60.dts
deleted file mode 100644
index 85c6dd4..0000000
--- a/arch/arm/boot/dts/ste-hrefprev60.dts
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * Copyright 2012 ST-Ericsson AB
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-/dts-v1/;
-#include "ste-dbx5x0.dtsi"
-#include "ste-href.dtsi"
-#include "ste-href-stuib.dtsi"
-#include "ste-href-tvk1281618.dtsi"
-
-/ {
-	model = "ST-Ericsson HREF (pre-v60) platform with Device Tree";
-	compatible = "st-ericsson,mop500", "st-ericsson,u8500";
-
-	gpio_keys {
-		button at 1 {
-			gpios = <&tc3589x_gpio 7 0x4>;
-		};
-	};
-
-	soc {
-		i2c at 80004000 {
-			tps61052 at 33 {
-				compatible = "tps61052";
-				reg = <0x33>;
-			};
-
-			tc3589x at 42 {
-				compatible = "tc3589x";
-				reg = <0x42>;
-				interrupt-parent = <&gpio6>;
-				interrupts = <25 IRQ_TYPE_EDGE_RISING>;
-
-				interrupt-controller;
-				#interrupt-cells = <2>;
-
-				tc3589x_gpio: tc3589x_gpio {
-					compatible = "tc3589x-gpio";
-					interrupts = <0 IRQ_TYPE_EDGE_RISING>;
-
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					gpio-controller;
-					#gpio-cells = <2>;
-				};
-			};
-		};
-
-		i2c at 80110000 {
-			bu21013_tp at 5c {
-				reset-gpio = <&tc3589x_gpio 13 0x4>;
-			};
-		};
-
-		vmmci: regulator-gpio {
-			gpios = <&tc3589x_gpio 18 0x4>;
-			enable-gpio = <&tc3589x_gpio 17 0x4>;
-
-			status = "okay";
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
new file mode 100644
index 0000000..de6b0a0
--- /dev/null
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -0,0 +1,65 @@
+/*
+ * Copyright 2012 ST-Ericsson AB
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ *
+ * Device Tree for the HREF+ prior to the v60 variant.
+ */
+
+#include "ste-dbx5x0.dtsi"
+#include "ste-href.dtsi"
+
+/ {
+	gpio_keys {
+		button at 1 {
+			gpios = <&tc3589x_gpio 7 0x4>;
+		};
+	};
+
+	soc {
+		i2c at 80004000 {
+			tps61052 at 33 {
+				compatible = "tps61052";
+				reg = <0x33>;
+			};
+
+			tc3589x at 42 {
+				compatible = "tc3589x";
+				reg = <0x42>;
+				interrupt-parent = <&gpio6>;
+				interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				tc3589x_gpio: tc3589x_gpio {
+					compatible = "tc3589x-gpio";
+					interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+			};
+		};
+
+		i2c at 80110000 {
+			bu21013_tp at 5c {
+				reset-gpio = <&tc3589x_gpio 13 0x4>;
+			};
+		};
+
+		vmmci: regulator-gpio {
+			gpios = <&tc3589x_gpio 18 0x4>;
+			enable-gpio = <&tc3589x_gpio 17 0x4>;
+
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
new file mode 100644
index 0000000..4da49e7
--- /dev/null
+++ b/arch/arm/boot/dts/ste-hrefv60plus-stuib.dts
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2012 ST-Ericsson AB
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ *
+ * Device Tree for the HREF version 60 or later with the ST UIB
+ */
+
+/dts-v1/;
+#include "ste-hrefv60plus.dtsi"
+#include "ste-href-stuib.dtsi"
+
+/ {
+	model = "ST-Ericsson HREF (v60+) and ST UIB";
+	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
+
+	soc {
+		/* Reset line for the BU21013 touchscreen */
+		i2c at 80110000 {
+			bu21013_tp at 0x5c {
+				reset-gpio = <&gpio4 15 0x4>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts b/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
new file mode 100644
index 0000000..d53cccd
--- /dev/null
+++ b/arch/arm/boot/dts/ste-hrefv60plus-tvk.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright 2012 ST-Ericsson AB
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ *
+ * Device Tree for the HREF version 60 or later with the TVK1281618 UIB
+ */
+
+/dts-v1/;
+#include "ste-hrefv60plus.dtsi"
+#include "ste-href-tvk1281618.dtsi"
+
+/ {
+	model = "ST-Ericsson HREF (v60+) and TVK1281618 UIB";
+	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
+};
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dts b/arch/arm/boot/dts/ste-hrefv60plus.dts
deleted file mode 100644
index 0f222e1..0000000
--- a/arch/arm/boot/dts/ste-hrefv60plus.dts
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * Copyright 2012 ST-Ericsson AB
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-/dts-v1/;
-#include "ste-dbx5x0.dtsi"
-#include "ste-href.dtsi"
-#include "ste-href-stuib.dtsi"
-#include "ste-href-tvk1281618.dtsi"
-
-/ {
-	model = "ST-Ericsson HREF (v60+) platform with Device Tree";
-	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
-
-	gpio_keys {
-		button at 1 {
-			gpios = <&gpio5 25 0x4>;
-		};
-	};
-
-	soc {
-		i2c at 80110000 {
-			bu21013_tp at 0x5c {
-				reset-gpio = <&gpio4 15 0x4>;
-			};
-		};
-
-		// External Micro SD slot
-		sdi0_per1 at 80126000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <4>;
-			mmc-cap-sd-highspeed;
-			mmc-cap-mmc-highspeed;
-			vmmc-supply = <&ab8500_ldo_aux3_reg>;
-
-			cd-gpios  = <&gpio2 31 0x4>; // 95
-
-			status = "okay";
-		};
-
-		// WLAN SDIO channel
-		sdi1_per2 at 80118000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <4>;
-
-			status = "okay";
-		};
-
-		// PoP:ed eMMC
-		sdi2_per3 at 80005000 {
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
-
-			status = "okay";
-		};
-
-		// On-board eMMC
-		sdi4_per2 at 80114000 {
-			arm,primecell-periphid = <0x10480180>;
-		        max-frequency = <100000000>;
-			bus-width = <8>;
-			mmc-cap-mmc-highspeed;
-			vmmc-supply = <&ab8500_ldo_aux2_reg>;
-
-			status = "okay";
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
new file mode 100644
index 0000000..d0f1165
--- /dev/null
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -0,0 +1,76 @@
+/*
+ * Copyright 2012 ST-Ericsson AB
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "ste-dbx5x0.dtsi"
+#include "ste-href.dtsi"
+
+/ {
+	model = "ST-Ericsson HREF (v60+) platform with Device Tree";
+	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
+
+	gpio_keys {
+		button at 1 {
+			gpios = <&gpio5 25 0x4>;
+		};
+	};
+
+	soc {
+		i2c at 80110000 {
+			bu21013_tp at 0x5c {
+				reset-gpio = <&gpio4 15 0x4>;
+			};
+		};
+
+		// External Micro SD slot
+		sdi0_per1 at 80126000 {
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <100000000>;
+			bus-width = <4>;
+			mmc-cap-sd-highspeed;
+			mmc-cap-mmc-highspeed;
+			vmmc-supply = <&ab8500_ldo_aux3_reg>;
+
+			cd-gpios  = <&gpio2 31 0x4>; // 95
+
+			status = "okay";
+		};
+
+		// WLAN SDIO channel
+		sdi1_per2 at 80118000 {
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <100000000>;
+			bus-width = <4>;
+
+			status = "okay";
+		};
+
+		// PoP:ed eMMC
+		sdi2_per3 at 80005000 {
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <100000000>;
+			bus-width = <8>;
+			mmc-cap-mmc-highspeed;
+
+			status = "okay";
+		};
+
+		// On-board eMMC
+		sdi4_per2 at 80114000 {
+			arm,primecell-periphid = <0x10480180>;
+		        max-frequency = <100000000>;
+			bus-width = <8>;
+			mmc-cap-mmc-highspeed;
+			vmmc-supply = <&ab8500_ldo_aux2_reg>;
+
+			status = "okay";
+		};
+	};
+};
-- 
1.8.3.1
