From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  8 Sep 2016 23:46:48 +0200
Subject: [PATCH 3/4] ARM: dts: split RealView EB 11MPCore variants
In-Reply-To: <1473371209-24086-1-git-send-email-linus.walleij@linaro.org>
References: <1473371209-24086-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1473371209-24086-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There used to be two versions of the RealView EB 11MPCore:

- arm-realview-eb-11mp.dts: the most common variant supported by
  QEMU with the revision C core tile
- arm-realview-eb-revb.dts: for the variant with the elder revision
  B core tile.

As it turns out that there are also a few variants of the
baseboard, unrelated to the coretile, and that these can of
course be mounted on top of each other in all permutations, we
create:

- arm-realview-eb-11mp.dts: the most common variant supported by
  QEMU with the pre-revision D baseboard and the revision C core
  tile.
- arm-realview-eb-11mp-bbrevd.dts: the revision D baseboard
  with the common revision C core tile.
- arm-realview-eb-11mp-ctrevb.dts: the pre-revision D baseboard
  with the revision B core tile.
- arm-realview-eb-11mp-bbrevd-ctrevb.dts: the revision D baseboard
  with the revision B core time.

Or as a table:

           | Core tile: C               | Core tile: B
-----------+----------------------------+-----------------------------------
Baseboard: |                            |
pre-D      |arm-realvie-eb-11mp         | arm-realview-eb-11mp-ctrevb
-----------+----------------------------+-----------------------------------
Baseboard: |                            |
D          |arm-realview-eb-11mp-bbrevd | arm-realview-eb-11mp-bbrevd-ctrevb
-----------+----------------------------+-----------------------------------

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile                         |  4 +-
 .../dts/arm-realview-eb-11mp-bbrevd-ctrevb.dts     | 32 ++++++++
 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dts  | 28 +++++++
 arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dts  | 93 ++++++++++++++++++++++
 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts    | 93 ----------------------
 arch/arm/boot/dts/arm-realview-eb-11mp.dts         |  2 +-
 6 files changed, 157 insertions(+), 95 deletions(-)
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dts
 delete mode 100644 arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6d3519fa07c3..2ec6f6236165 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -610,7 +610,9 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-eb.dtb \
 	arm-realview-eb-bbrevd.dtb \
 	arm-realview-eb-11mp.dtb \
-	arm-realview-eb-11mp-revb.dtb \
+	arm-realview-eb-11mp-bbrevd.dtb \
+	arm-realview-eb-11mp-ctrevb.dtb \
+	arm-realview-eb-11mp-bbrevd-ctrevb.dtb \
 	arm-realview-eb-a9mp.dtb \
 	arm-realview-pba8.dtb \
 	arm-realview-pbx-a9.dtb
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dts b/arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dts
new file mode 100644
index 000000000000..e18769df9fd9
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dts
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "arm-realview-eb-11mp-ctrevb.dts"
+#include "arm-realview-eb-bbrevd.dtsi"
+
+/*
+ * This is the EB with the new Revision D baseboard with SMSC9118 ethernet and
+ * the Rev B core tile.
+ */
+/ {
+	model = "ARM RealView Emulation Baseboard Rev D with ARM11MPCore Core Tile Rev B";
+};
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dts b/arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dts
new file mode 100644
index 000000000000..26b1c69e9f43
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dts
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "arm-realview-eb-11mp.dts"
+#include "arm-realview-eb-bbrevd.dtsi"
+
+/ {
+	model = "ARM RealView Emulation Baseboard Rev D with ARM11MPCore Rev C Core Tile";
+};
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dts b/arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dts
new file mode 100644
index 000000000000..e68527b0d552
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dts
@@ -0,0 +1,93 @@
+/*
+ * Copyright 2016 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "arm-realview-eb-11mp.dts"
+
+/ {
+	model = "ARM RealView Emulation Baseboard with ARM11MPCore Rev B";
+};
+
+/*
+ * The revision B has a distinctly different layout of the syscon, so
+ * append a specific compatible-string.
+ */
+&syscon {
+	compatible = "arm,realview-eb11mp-revb-syscon", "arm,realview-eb-syscon", "syscon", "simple-mfd";
+};
+
+&intc {
+	reg = <0x10101000 0x1000>,
+	      <0x10100100 0x100>;
+};
+
+&L2 {
+	reg = <0x10102000 0x1000>;
+};
+
+&scu {
+	reg = <0x10100000 0x100>;
+};
+
+&twd_timer {
+	reg = <0x10100600 0x20>;
+};
+
+&twd_wdog {
+	reg = <0x10100620 0x20>;
+};
+
+/*
+ * On revision B, we cannot reach the secondary interrupt
+ * controller, as a result, some peripherals that are dependent
+ * on their IRQ cannot be reached, so disable them.
+ */
+&intc_second {
+	status = "disabled";
+};
+
+&gpio0 {
+	status = "disabled";
+};
+
+&gpio1 {
+	status = "disabled";
+};
+
+&gpio2 {
+	status = "disabled";
+};
+
+&serial2 {
+	status = "disabled";
+};
+
+&serial3 {
+	status = "disabled";
+};
+
+&ssp {
+	status = "disabled";
+};
+
+&wdog {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts b/arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts
deleted file mode 100644
index e68527b0d552..000000000000
--- a/arch/arm/boot/dts/arm-realview-eb-11mp-revb.dts
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * Copyright 2016 Linaro Ltd
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "arm-realview-eb-11mp.dts"
-
-/ {
-	model = "ARM RealView Emulation Baseboard with ARM11MPCore Rev B";
-};
-
-/*
- * The revision B has a distinctly different layout of the syscon, so
- * append a specific compatible-string.
- */
-&syscon {
-	compatible = "arm,realview-eb11mp-revb-syscon", "arm,realview-eb-syscon", "syscon", "simple-mfd";
-};
-
-&intc {
-	reg = <0x10101000 0x1000>,
-	      <0x10100100 0x100>;
-};
-
-&L2 {
-	reg = <0x10102000 0x1000>;
-};
-
-&scu {
-	reg = <0x10100000 0x100>;
-};
-
-&twd_timer {
-	reg = <0x10100600 0x20>;
-};
-
-&twd_wdog {
-	reg = <0x10100620 0x20>;
-};
-
-/*
- * On revision B, we cannot reach the secondary interrupt
- * controller, as a result, some peripherals that are dependent
- * on their IRQ cannot be reached, so disable them.
- */
-&intc_second {
-	status = "disabled";
-};
-
-&gpio0 {
-	status = "disabled";
-};
-
-&gpio1 {
-	status = "disabled";
-};
-
-&gpio2 {
-	status = "disabled";
-};
-
-&serial2 {
-	status = "disabled";
-};
-
-&serial3 {
-	status = "disabled";
-};
-
-&ssp {
-	status = "disabled";
-};
-
-&wdog {
-	status = "disabled";
-};
diff --git a/arch/arm/boot/dts/arm-realview-eb-11mp.dts b/arch/arm/boot/dts/arm-realview-eb-11mp.dts
index 87ff602a2a2d..aac1edd4b227 100644
--- a/arch/arm/boot/dts/arm-realview-eb-11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-eb-11mp.dts
@@ -24,7 +24,7 @@
 #include "arm-realview-eb-mp.dtsi"
 
 / {
-	model = "ARM RealView Emulation Baseboard with ARM11MPCore Rev C";
+	model = "ARM RealView Emulation Baseboard with ARM11MPCore Rev C Core Tile";
 	arm,hbi = <0x146>;
 
 	/*
-- 
2.7.4
