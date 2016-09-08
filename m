From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  8 Sep 2016 23:46:47 +0200
Subject: [PATCH 2/4] ARM: dts: add device tree for the RealView EB Rev D
In-Reply-To: <1473371209-24086-1-git-send-email-linus.walleij@linaro.org>
References: <1473371209-24086-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1473371209-24086-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RealView EB baseboard revision D is a special case as it appears
to be undocumented in ARM official documents, while the Linux kernel
still contains special code for handling it.

commit be4f3c8691492934c8ee03dbecb3a3a865ac6cd6
"Add RealView/EB support for the LAN9118 Ethernet chip"
adds support for the SMSC LAN9118 chip used on the D revision of
the baseboard, but no other traces of hardware deviations for this
variant can be found.

This creates a separate top-level .dts file especially for this
board version, so that it gets registered with the right type
of ethernet controller. The ethernet controller modifications
are then put into a separate .dtsi file so it can be overlaid
on other EB variants using the revision D baseboard.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rename DTS file to arm-realview-eb-bbrevd.dts to signify
  that the baseboard is revision D.
- Split off a DTSI file to be used for other variants.
---
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/arm-realview-eb-bbrevd.dts  | 29 +++++++++++++++++
 arch/arm/boot/dts/arm-realview-eb-bbrevd.dtsi | 45 +++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-bbrevd.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-bbrevd.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faacd52370d2..6d3519fa07c3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -608,6 +608,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
 	arm-realview-eb.dtb \
+	arm-realview-eb-bbrevd.dtb \
 	arm-realview-eb-11mp.dtb \
 	arm-realview-eb-11mp-revb.dtb \
 	arm-realview-eb-a9mp.dtb \
diff --git a/arch/arm/boot/dts/arm-realview-eb-bbrevd.dts b/arch/arm/boot/dts/arm-realview-eb-bbrevd.dts
new file mode 100644
index 000000000000..f533c8b49d97
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-bbrevd.dts
@@ -0,0 +1,29 @@
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
+/* This derives from the Realview Baseboard, and overlays the new ethernet */
+#include "arm-realview-eb.dts"
+#include "arm-realview-eb-bbrevd.dtsi"
+
+/ {
+	model = "ARM RealView Emulation Baseboard Rev D";
+};
diff --git a/arch/arm/boot/dts/arm-realview-eb-bbrevd.dtsi b/arch/arm/boot/dts/arm-realview-eb-bbrevd.dtsi
new file mode 100644
index 000000000000..a79e1d1d30a7
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-bbrevd.dtsi
@@ -0,0 +1,45 @@
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
+/ {
+	/* Introduce a fixed regulator for the new ethernet controller */
+	veth: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "veth";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+};
+
+/*
+ * The revision D has a different ethernet controller that the elder boards:
+ * the older board uses LAN91C111 but the new one uses LAN9118.
+ */
+&ethernet {
+	compatible = "smsc,lan9118", "smsc,lan9115";
+	phy-mode = "mii";
+	smsc,irq-active-high;
+	smsc,irq-push-pull;
+	vdd33a-supply = <&veth>;
+	vddvario-supply = <&veth>;
+};
-- 
2.7.4
