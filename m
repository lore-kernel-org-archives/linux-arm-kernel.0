From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 Aug 2013 15:46:52 +0200
Subject: [PATCH] ARM: ux500: fix devicetree builds
Message-ID: <1375883212-3266-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@stericsson.com>

The patch set beginning with commit:
"ARM: ux500: Apply a ste-* prefix onto snowball.dts"
thru commit:
"ARM: ux500: Remove u9540.dts as it's been replaced"
altered the names of the ux500 device tree files but forgot
to:

- Rename the ccu8540-pinctrl.dtsi file

- Update #include statements from files using these
  files, so the build broke.

- Update the Makefile for the device trees so the build
  broke.

Fix it up so we can build them all again.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/boot/dts/Makefile                 |  10 +-
 arch/arm/boot/dts/ccu8540-pinctrl.dtsi     | 196 -----------------------------
 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi | 196 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-ccu8540.dts          |   4 +-
 arch/arm/boot/dts/ste-ccu9540.dts          |   2 +-
 arch/arm/boot/dts/ste-href.dtsi            |   2 +-
 arch/arm/boot/dts/ste-hrefprev60.dts       |   6 +-
 arch/arm/boot/dts/ste-hrefv60plus.dts      |   6 +-
 arch/arm/boot/dts/ste-snowball.dts         |   2 +-
 9 files changed, 212 insertions(+), 212 deletions(-)
 delete mode 100644 arch/arm/boot/dts/ccu8540-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..efee128 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -176,11 +176,11 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am43x-epos-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
-dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
-	hrefprev60.dtb \
-	hrefv60plus.dtb \
-	ccu8540.dtb \
-	ccu9540.dtb
+dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
+	ste-hrefprev60.dtb \
+	ste-hrefv60plus.dtb \
+	ste-ccu8540.dtb \
+	ste-ccu9540.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
diff --git a/arch/arm/boot/dts/ccu8540-pinctrl.dtsi b/arch/arm/boot/dts/ccu8540-pinctrl.dtsi
deleted file mode 100644
index e079996..0000000
--- a/arch/arm/boot/dts/ccu8540-pinctrl.dtsi
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * Copyright 2012 ST-Ericsson
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-#include "ste-nomadik-pinctrl.dtsi"
-
-/ {
-	soc {
-		pinctrl {
-			uart0 {
-				uart0_default_mux: uart0_mux {
-					default_mux {
-						ste,function = "u0";
-						ste,pins = "u0_a_1";
-					};
-				};
-
-				uart0_default_mode: uart0_default {
-					default_cfg1 {
-						ste,pins = "GPIO0", "GPIO2";
-						ste,config = <&in_pu>;
-					};
-
-					default_cfg2 {
-						ste,pins = "GPIO1", "GPIO3";
-						ste,config = <&out_hi>;
-					};
-				};
-
-				uart0_sleep_mode: uart0_sleep {
-					sleep_cfg1 {
-						ste,pins = "GPIO0", "GPIO2";
-						ste,config = <&slpm_in_pu>;
-					};
-
-					sleep_cfg2 {
-						ste,pins = "GPIO1", "GPIO3";
-						ste,config = <&slpm_out_hi>;
-					};
-				};
-			};
-
-			uart2 {
-				uart2_default_mode: uart2_default {
-					default_mux {
-						ste,function = "u2";
-						ste,pins = "u2txrx_a_1";
-					};
-
-					default_cfg1 {
-						ste,pins = "GPIO120";
-						ste,config = <&in_pu>;
-					};
-
-					default_cfg2 {
-						ste,pins = "GPIO121";
-						ste,config = <&out_hi>;
-					};
-				};
-
-				uart2_sleep_mode: uart2_sleep {
-					sleep_cfg1 {
-						ste,pins = "GPIO120";
-						ste,config = <&slpm_in_pu>;
-					};
-
-					sleep_cfg2 {
-						ste,pins = "GPIO121";
-						ste,config = <&slpm_out_hi>;
-					};
-				};
-			};
-
-			i2c0 {
-				i2c0_default_mux: i2c_mux {
-					default_mux {
-						ste,function = "i2c0";
-						ste,pins = "i2c0_a_1";
-					};
-				};
-
-				i2c0_default_mode: i2c_default {
-					default_cfg1 {
-						ste,pins = "GPIO147", "GPIO148";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c0_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						ste,pins = "GPIO147", "GPIO148";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-
-			i2c1 {
-				i2c1_default_mux: i2c_mux {
-					default_mux {
-						ste,function = "i2c1";
-						ste,pins = "i2c1_b_2";
-					};
-				};
-
-				i2c1_default_mode: i2c_default {
-					default_cfg1 {
-						ste,pins = "GPIO16", "GPIO17";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c1_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						ste,pins = "GPIO16", "GPIO17";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-
-			i2c2 {
-				i2c2_default_mux: i2c_mux {
-					default_mux {
-						ste,function = "i2c2";
-						ste,pins = "i2c2_b_2";
-					};
-				};
-
-				i2c2_default_mode: i2c_default {
-					default_cfg1 {
-						ste,pins = "GPIO10", "GPIO11";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c2_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						ste,pins = "GPIO11", "GPIO11";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-
-			i2c4 {
-				i2c4_default_mux: i2c_mux {
-					default_mux {
-						ste,function = "i2c4";
-						ste,pins = "i2c4_b_2";
-					};
-				};
-
-				i2c4_default_mode: i2c_default {
-					default_cfg1 {
-						ste,pins = "GPIO122", "GPIO123";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c4_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						ste,pins = "GPIO122", "GPIO123";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-
-			i2c5 {
-				i2c5_default_mux: i2c_mux {
-					default_mux {
-						ste,function = "i2c5";
-						ste,pins = "i2c5_c_2";
-					};
-				};
-
-				i2c5_default_mode: i2c_default {
-					default_cfg1 {
-						ste,pins = "GPIO118", "GPIO119";
-						ste,config = <&in_pu>;
-					};
-				};
-
-				i2c5_sleep_mode: i2c_sleep {
-					sleep_cfg1 {
-						ste,pins = "GPIO118", "GPIO119";
-						ste,config = <&slpm_in_pu>;
-					};
-				};
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi b/arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi
new file mode 100644
index 0000000..e079996
--- /dev/null
+++ b/arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi
@@ -0,0 +1,196 @@
+/*
+ * Copyright 2012 ST-Ericsson
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include "ste-nomadik-pinctrl.dtsi"
+
+/ {
+	soc {
+		pinctrl {
+			uart0 {
+				uart0_default_mux: uart0_mux {
+					default_mux {
+						ste,function = "u0";
+						ste,pins = "u0_a_1";
+					};
+				};
+
+				uart0_default_mode: uart0_default {
+					default_cfg1 {
+						ste,pins = "GPIO0", "GPIO2";
+						ste,config = <&in_pu>;
+					};
+
+					default_cfg2 {
+						ste,pins = "GPIO1", "GPIO3";
+						ste,config = <&out_hi>;
+					};
+				};
+
+				uart0_sleep_mode: uart0_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO0", "GPIO2";
+						ste,config = <&slpm_in_pu>;
+					};
+
+					sleep_cfg2 {
+						ste,pins = "GPIO1", "GPIO3";
+						ste,config = <&slpm_out_hi>;
+					};
+				};
+			};
+
+			uart2 {
+				uart2_default_mode: uart2_default {
+					default_mux {
+						ste,function = "u2";
+						ste,pins = "u2txrx_a_1";
+					};
+
+					default_cfg1 {
+						ste,pins = "GPIO120";
+						ste,config = <&in_pu>;
+					};
+
+					default_cfg2 {
+						ste,pins = "GPIO121";
+						ste,config = <&out_hi>;
+					};
+				};
+
+				uart2_sleep_mode: uart2_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO120";
+						ste,config = <&slpm_in_pu>;
+					};
+
+					sleep_cfg2 {
+						ste,pins = "GPIO121";
+						ste,config = <&slpm_out_hi>;
+					};
+				};
+			};
+
+			i2c0 {
+				i2c0_default_mux: i2c_mux {
+					default_mux {
+						ste,function = "i2c0";
+						ste,pins = "i2c0_a_1";
+					};
+				};
+
+				i2c0_default_mode: i2c_default {
+					default_cfg1 {
+						ste,pins = "GPIO147", "GPIO148";
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c0_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO147", "GPIO148";
+						ste,config = <&slpm_in_pu>;
+					};
+				};
+			};
+
+			i2c1 {
+				i2c1_default_mux: i2c_mux {
+					default_mux {
+						ste,function = "i2c1";
+						ste,pins = "i2c1_b_2";
+					};
+				};
+
+				i2c1_default_mode: i2c_default {
+					default_cfg1 {
+						ste,pins = "GPIO16", "GPIO17";
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c1_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO16", "GPIO17";
+						ste,config = <&slpm_in_pu>;
+					};
+				};
+			};
+
+			i2c2 {
+				i2c2_default_mux: i2c_mux {
+					default_mux {
+						ste,function = "i2c2";
+						ste,pins = "i2c2_b_2";
+					};
+				};
+
+				i2c2_default_mode: i2c_default {
+					default_cfg1 {
+						ste,pins = "GPIO10", "GPIO11";
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c2_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO11", "GPIO11";
+						ste,config = <&slpm_in_pu>;
+					};
+				};
+			};
+
+			i2c4 {
+				i2c4_default_mux: i2c_mux {
+					default_mux {
+						ste,function = "i2c4";
+						ste,pins = "i2c4_b_2";
+					};
+				};
+
+				i2c4_default_mode: i2c_default {
+					default_cfg1 {
+						ste,pins = "GPIO122", "GPIO123";
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c4_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO122", "GPIO123";
+						ste,config = <&slpm_in_pu>;
+					};
+				};
+			};
+
+			i2c5 {
+				i2c5_default_mux: i2c_mux {
+					default_mux {
+						ste,function = "i2c5";
+						ste,pins = "i2c5_c_2";
+					};
+				};
+
+				i2c5_default_mode: i2c_default {
+					default_cfg1 {
+						ste,pins = "GPIO118", "GPIO119";
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c5_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO118", "GPIO119";
+						ste,config = <&slpm_in_pu>;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ste-ccu8540.dts b/arch/arm/boot/dts/ste-ccu8540.dts
index 7df65f0..7f3baf5 100644
--- a/arch/arm/boot/dts/ste-ccu8540.dts
+++ b/arch/arm/boot/dts/ste-ccu8540.dts
@@ -10,8 +10,8 @@
  */
 
 /dts-v1/;
-#include "dbx5x0.dtsi"
-#include "ccu8540-pinctrl.dtsi"
+#include "ste-dbx5x0.dtsi"
+#include "ste-ccu8540-pinctrl.dtsi"
 
 / {
 	model = "ST-Ericsson U8540 platform with Device Tree";
diff --git a/arch/arm/boot/dts/ste-ccu9540.dts b/arch/arm/boot/dts/ste-ccu9540.dts
index ed29ec7..2295087 100644
--- a/arch/arm/boot/dts/ste-ccu9540.dts
+++ b/arch/arm/boot/dts/ste-ccu9540.dts
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-#include "dbx5x0.dtsi"
+#include "ste-dbx5x0.dtsi"
 
 / {
 	model = "ST-Ericsson CCU9540 platform with Device Tree";
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 9db41b9..370e03f 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -10,7 +10,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "dbx5x0.dtsi"
+#include "ste-dbx5x0.dtsi"
 
 / {
 	memory {
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dts b/arch/arm/boot/dts/ste-hrefprev60.dts
index c6bb07d..d8d3b99 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60.dts
@@ -10,9 +10,9 @@
  */
 
 /dts-v1/;
-#include "dbx5x0.dtsi"
-#include "href.dtsi"
-#include "stuib.dtsi"
+#include "ste-dbx5x0.dtsi"
+#include "ste-href.dtsi"
+#include "ste-stuib.dtsi"
 
 / {
 	model = "ST-Ericsson HREF (pre-v60) platform with Device Tree";
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dts b/arch/arm/boot/dts/ste-hrefv60plus.dts
index 3d580d6..6e52ebb 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dts
@@ -10,9 +10,9 @@
  */
 
 /dts-v1/;
-#include "dbx5x0.dtsi"
-#include "href.dtsi"
-#include "stuib.dtsi"
+#include "ste-dbx5x0.dtsi"
+#include "ste-href.dtsi"
+#include "ste-stuib.dtsi"
 
 / {
 	model = "ST-Ericsson HREF (v60+) platform with Device Tree";
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index f1567a0..f1fc128 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -10,7 +10,7 @@
  */
 
 /dts-v1/;
-#include "dbx5x0.dtsi"
+#include "ste-dbx5x0.dtsi"
 
 / {
 	model = "Calao Systems Snowball platform with device tree";
-- 
1.8.1.4
