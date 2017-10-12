From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 12 Oct 2017 20:36:15 +0900
Subject: [PATCH v8 1/2] dt-bindings: gpio: uniphier: add UniPhier GPIO binding
In-Reply-To: <1507808176-5223-1-git-send-email-yamada.masahiro@socionext.com>
References: <1507808176-5223-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1507808176-5223-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This GPIO controller is used on UniPhier SoC family.

The vendor specific property "socionext,interrupt-ranges" is for
specifying interrupt mapping to the parent interrupt controller
because the mapping is not contiguous.  It works like "ranges",
but transforms "interrupts" instead of "reg".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
---

 .../devicetree/bindings/gpio/gpio-uniphier.txt     | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 include/dt-bindings/gpio/uniphier-gpio.h           | 18 ++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 create mode 100644 include/dt-bindings/gpio/uniphier-gpio.h

diff --git a/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt b/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
new file mode 100644
index 0000000..fed9158
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
@@ -0,0 +1,52 @@
+UniPhier GPIO controller
+
+Required properties:
+- compatible: Should be "socionext,uniphier-gpio".
+- reg: Specifies offset and length of the register set for the device.
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells: Should be 2.  The first cell is the pin number and the second
+  cell is used to specify optional parameters.
+- interrupt-parent: Specifies the parent interrupt controller.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells: Should be 2.  The first cell defines the interrupt number.
+  The second cell bits[3:0] is used to specify trigger type as follows:
+    1 = low-to-high edge triggered
+    2 = high-to-low edge triggered
+    4 = active high level-sensitive
+    8 = active low level-sensitive
+  Valid combinations are 1, 2, 3, 4, 8.
+- ngpios: Specifies the number of GPIO lines.
+- gpio-ranges: Mapping to pin controller pins (as described in gpio.txt)
+- socionext,interrupt-ranges: Specifies an interrupt number mapping between
+  this GPIO controller and its interrupt parent, in the form of arbitrary
+  number of <child-interrupt-base parent-interrupt-base length> triplets.
+
+Optional properties:
+- gpio-ranges-group-names: Used for named gpio ranges (as described in gpio.txt)
+
+Example:
+	gpio: gpio at 55000000 {
+		compatible = "socionext,uniphier-gpio";
+		reg = <0x55000000 0x200>;
+		interrupt-parent = <&aidet>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl 0 0 0>;
+		gpio-ranges-group-names = "gpio_range";
+		ngpios = <248>;
+		socionext,interrupt-ranges = <0 48 16>, <16 154 5>, <21 217 3>;
+	};
+
+Consumer Example:
+
+	sdhci0_pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(29, 4) GPIO_ACTIVE_LOW>;
+	};
+
+Please note UNIPHIER_GPIO_PORT(29, 4) represents PORT294 in the SoC document.
+Unfortunately, only the one's place is octal in the port numbering.  (That is,
+PORT 8, 9, 18, 19, 28, 29, ... are missing.)  UNIPHIER_GPIO_PORT() is a helper
+macro to calculate 29 * 8 + 4.
diff --git a/MAINTAINERS b/MAINTAINERS
index caacc88..2474032 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2029,6 +2029,7 @@ M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 F:	arch/arm/boot/dts/uniphier*
 F:	arch/arm/include/asm/hardware/cache-uniphier.h
 F:	arch/arm/mach-uniphier/
diff --git a/include/dt-bindings/gpio/uniphier-gpio.h b/include/dt-bindings/gpio/uniphier-gpio.h
new file mode 100644
index 0000000..9f0ad17
--- /dev/null
+++ b/include/dt-bindings/gpio/uniphier-gpio.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2017 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ */
+
+#ifndef _DT_BINDINGS_GPIO_UNIPHIER_H
+#define _DT_BINDINGS_GPIO_UNIPHIER_H
+
+#define UNIPHIER_GPIO_LINES_PER_BANK	8
+
+#define UNIPHIER_GPIO_IRQ_OFFSET	((UNIPHIER_GPIO_LINES_PER_BANK) * 15)
+
+#define UNIPHIER_GPIO_PORT(bank, line)	\
+			((UNIPHIER_GPIO_LINES_PER_BANK) * (bank) + (line))
+
+#define UNIPHIER_GPIO_IRQ(n)		((UNIPHIER_GPIO_IRQ_OFFSET) + (n))
+
+#endif /* _DT_BINDINGS_GPIO_UNIPHIER_H */
-- 
2.7.4
