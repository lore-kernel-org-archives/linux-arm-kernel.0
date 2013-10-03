From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 13:31:00 +0200
Subject: [PATCH 07/10] ARM: ux500: split HREF UIB files
Message-ID: <1380799860-25972-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create two different UIB (User Interface Board) include files: one per
UIB simply. The include files now only handle the devices on that
very UIB.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-stuib.dtsi      | 80 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 20 ++++++++
 arch/arm/boot/dts/ste-hrefprev60.dts       |  3 +-
 arch/arm/boot/dts/ste-hrefv60plus.dts      |  3 +-
 arch/arm/boot/dts/ste-stuib.dtsi           | 80 ------------------------------
 5 files changed, 104 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-href-stuib.dtsi
 create mode 100644 arch/arm/boot/dts/ste-href-tvk1281618.dtsi
 delete mode 100644 arch/arm/boot/dts/ste-stuib.dtsi

diff --git a/arch/arm/boot/dts/ste-href-stuib.dtsi b/arch/arm/boot/dts/ste-href-stuib.dtsi
new file mode 100644
index 0000000..524e332
--- /dev/null
+++ b/arch/arm/boot/dts/ste-href-stuib.dtsi
@@ -0,0 +1,80 @@
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
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	soc {
+		i2c at 80004000 {
+			stmpe1601: stmpe1601 at 40 {
+				compatible = "st,stmpe1601";
+				reg = <0x40>;
+				interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+				interrupt-parent = <&gpio6>;
+				interrupt-controller;
+
+				wakeup-source;
+				st,autosleep-timeout = <1024>;
+
+				stmpe_keypad {
+					compatible = "st,stmpe-keypad";
+
+					debounce-interval = <64>;
+					st,scan-count = <8>;
+					st,no-autorepeat;
+
+					linux,keymap = <0x205006b
+							0x4010074
+							0x3050072
+							0x1030004
+							0x502006a
+							0x500000a
+							0x5008b
+							0x706001c
+							0x405000b
+							0x6070003
+							0x3040067
+							0x303006c
+							0x60400e7
+							0x602009e
+							0x4020073
+							0x5050002
+							0x4030069
+							0x3020008>;
+				};
+			};
+		};
+
+		i2c at 80110000 {
+			bu21013_tp at 5c {
+				compatible = "rohm,bu21013_tp";
+				reg = <0x5c>;
+				touch-gpio = <&gpio2 20 0x4>;
+				avdd-supply = <&ab8500_ldo_aux1_reg>;
+
+				rohm,touch-max-x = <384>;
+				rohm,touch-max-y = <704>;
+				rohm,flip-y;
+			};
+
+			bu21013_tp at 5d {
+				compatible = "rohm,bu21013_tp";
+				reg = <0x5d>;
+				touch-gpio = <&gpio2 20 0x4>;
+				avdd-supply = <&ab8500_ldo_aux1_reg>;
+
+				rohm,touch-max-x = <384>;
+				rohm,touch-max-y = <704>;
+				rohm,flip-y;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
new file mode 100644
index 0000000..89e1485
--- /dev/null
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -0,0 +1,20 @@
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
+ * Device Tree for the TVK1281618 UIB
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	soc {
+		/* Add Synaptics touch screen, TC35892 keypad etc here */
+	};
+};
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dts b/arch/arm/boot/dts/ste-hrefprev60.dts
index 5016dc9..85c6dd4 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60.dts
@@ -12,7 +12,8 @@
 /dts-v1/;
 #include "ste-dbx5x0.dtsi"
 #include "ste-href.dtsi"
-#include "ste-stuib.dtsi"
+#include "ste-href-stuib.dtsi"
+#include "ste-href-tvk1281618.dtsi"
 
 / {
 	model = "ST-Ericsson HREF (pre-v60) platform with Device Tree";
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dts b/arch/arm/boot/dts/ste-hrefv60plus.dts
index b82ae50..0f222e1 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dts
@@ -12,7 +12,8 @@
 /dts-v1/;
 #include "ste-dbx5x0.dtsi"
 #include "ste-href.dtsi"
-#include "ste-stuib.dtsi"
+#include "ste-href-stuib.dtsi"
+#include "ste-href-tvk1281618.dtsi"
 
 / {
 	model = "ST-Ericsson HREF (v60+) platform with Device Tree";
diff --git a/arch/arm/boot/dts/ste-stuib.dtsi b/arch/arm/boot/dts/ste-stuib.dtsi
deleted file mode 100644
index 524e332..0000000
--- a/arch/arm/boot/dts/ste-stuib.dtsi
+++ /dev/null
@@ -1,80 +0,0 @@
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
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	soc {
-		i2c at 80004000 {
-			stmpe1601: stmpe1601 at 40 {
-				compatible = "st,stmpe1601";
-				reg = <0x40>;
-				interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
-				interrupt-parent = <&gpio6>;
-				interrupt-controller;
-
-				wakeup-source;
-				st,autosleep-timeout = <1024>;
-
-				stmpe_keypad {
-					compatible = "st,stmpe-keypad";
-
-					debounce-interval = <64>;
-					st,scan-count = <8>;
-					st,no-autorepeat;
-
-					linux,keymap = <0x205006b
-							0x4010074
-							0x3050072
-							0x1030004
-							0x502006a
-							0x500000a
-							0x5008b
-							0x706001c
-							0x405000b
-							0x6070003
-							0x3040067
-							0x303006c
-							0x60400e7
-							0x602009e
-							0x4020073
-							0x5050002
-							0x4030069
-							0x3020008>;
-				};
-			};
-		};
-
-		i2c at 80110000 {
-			bu21013_tp at 5c {
-				compatible = "rohm,bu21013_tp";
-				reg = <0x5c>;
-				touch-gpio = <&gpio2 20 0x4>;
-				avdd-supply = <&ab8500_ldo_aux1_reg>;
-
-				rohm,touch-max-x = <384>;
-				rohm,touch-max-y = <704>;
-				rohm,flip-y;
-			};
-
-			bu21013_tp at 5d {
-				compatible = "rohm,bu21013_tp";
-				reg = <0x5d>;
-				touch-gpio = <&gpio2 20 0x4>;
-				avdd-supply = <&ab8500_ldo_aux1_reg>;
-
-				rohm,touch-max-x = <384>;
-				rohm,touch-max-y = <704>;
-				rohm,flip-y;
-			};
-		};
-	};
-};
-- 
1.8.3.1
