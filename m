From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  8 Sep 2016 11:30:43 +0200
Subject: [PATCH 2/2] ARM: dts: add device tree for the RealView EB Rev D
Message-ID: <1473327043-31903-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RealView EB revision D is a special case as it appears to be
undocumented in ARM official documents, while the Linux kernel
still contains special code for handling it.

commit be4f3c8691492934c8ee03dbecb3a3a865ac6cd6
"Add RealView/EB support for the LAN9118 Ethernet chip"
adds support for the SMSC LAN9118 chip used on the D revision,
but no other traces of hardware deviations for this variant
can be found.

This created a separate top-level .dts file especially for this
board version, so that it gets registered with the right type
of ethernet controller.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC people: please apply this directly with the first patch.
---
 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/arm-realview-eb-revd.dts | 49 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm/boot/dts/arm-realview-eb-revd.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faacd52370d2..43d2c379d034 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -608,6 +608,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
 	arm-realview-eb.dtb \
+	arm-realview-eb-revd.dtb \
 	arm-realview-eb-11mp.dtb \
 	arm-realview-eb-11mp-revb.dtb \
 	arm-realview-eb-a9mp.dtb \
diff --git a/arch/arm/boot/dts/arm-realview-eb-revd.dts b/arch/arm/boot/dts/arm-realview-eb-revd.dts
new file mode 100644
index 000000000000..2142deffbe4c
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-eb-revd.dts
@@ -0,0 +1,49 @@
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
+#include "arm-realview-eb.dts"
+
+/ {
+	model = "ARM RealView Emulation Baseboard Rev D";
+
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
