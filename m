From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 27 Sep 2017 11:45:42 +0900
Subject: [PATCH v7 1/2] dt-bindings: gpio: uniphier: add UniPhier GPIO binding
In-Reply-To: <1506480343-9597-1-git-send-email-yamada.masahiro@socionext.com>
References: <1506480343-9597-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1506480343-9597-2-git-send-email-yamada.masahiro@socionext.com>
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


 .../devicetree/bindings/gpio/gpio-uniphier.txt     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-uniphier.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt b/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
new file mode 100644
index 0000000..6d9251a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
@@ -0,0 +1,40 @@
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
-- 
2.7.4
