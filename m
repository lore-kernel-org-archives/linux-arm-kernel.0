From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 19 Oct 2016 17:21:13 +0200
Subject: [PATCH v2 2/9] dt-bindings: interrupt-controller: add DT binding for
 meson GPIO interrupt controller
In-Reply-To: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1476890480-8884-3-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This commit adds the device tree bindings description for Amlogic's GPIO
interrupt controller available on the meson8, meson8b and gxbb SoC families

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Rob, I did not include the Ack you gave for the RFC as bindings have slightly
changed. Only the interrupt property has be removed following a discussion I
had with Marc

 .../amlogic,meson-gpio-intc.txt                    | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
new file mode 100644
index 000000000000..2464d9a0865d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -0,0 +1,31 @@
+Amlogic meson GPIO interrupt controller
+
+Meson SoCs contains an interrupt controller which is able watch the SoC pads
+and generate an interrupt on edges or level. The controller is essentially a
+256 pads to 8 GIC interrupt multiplexer, with a filter block to select edge
+or level and polarity. We don?t expose all 256 mux inputs because the
+documentation shows that upper part is not mapped to any pad. The actual number
+of interrupt exposed depends on the SoC.
+
+Required properties:
+
+- compatible : should be either
+   "amlogic,meson8-gpio-intc? for meson8 SoCs (AML7826MX) or
+   ?amlogic,meson8b-gpio-intc? for meson8b SoCs (S805) or
+   ?amlogic,meson-gxbb-gpio-intc? for GXBB SoCs (S905)
+- interrupt-parent : a phandle to the GIC the interrupts are routed to.
+   Usually this is provided at the root level of the device tree as it is
+   common to most of the SoC
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+   interrupt source. The value must be 2.
+
+Example:
+
+gpio_interrupt: interrupt-controller at 9880 {
+	compatible = "amlogic,meson-gxbb-gpio-intc";
+	reg = <0x0 0x9880 0x0 0x10>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
-- 
2.7.4
