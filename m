From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Sep 2017 15:46:09 +0200
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: add DT binding for
 meson GPIO interrupt controller
In-Reply-To: <20170918134610.17743-1-jbrunet@baylibre.com>
References: <20170918134610.17743-1-jbrunet@baylibre.com>
Message-ID: <20170918134610.17743-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the device tree bindings description for Amlogic's GPIO
interrupt controller available on the meson8b, gxbb and gxl SoC families

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../amlogic,meson-gpio-intc.txt                    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
new file mode 100644
index 000000000000..633e21ce4b17
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -0,0 +1,35 @@
+Amlogic meson GPIO interrupt controller
+
+Meson SoCs contains an interrupt controller which is able to watch the SoC
+pads and generate an interrupt on edge or level. The controller is essentially
+a 256 pads to 8 GIC interrupt multiplexer, with a filter block to select edge
+or level and polarity. It does not expose all 256 mux inputs because the
+documentation shows that the upper part is not mapped to any pad. The actual
+number of interrupt exposed depends on the SoC.
+
+Required properties:
+
+- compatible : must have "amlogic,meson8-gpio-intc? and either
+   ?amlogic,meson8b-gpio-intc? for meson8b SoCs (S805) or
+   ?amlogic,meson-gxbb-gpio-intc? for GXBB SoCs (S905) or
+   ?amlogic,meson-gxl-gpio-intc? for GXL SoCs (S905X, S912)
+- interrupt-parent : a phandle to the GIC the interrupts are routed to.
+   Usually this is provided at the root level of the device tree as it is
+   common to most of the SoC.
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+   interrupt source. The value must be 2.
+- meson,channel-interrupts: Array with the 8 upstream hwirq numbers. These
+   are the hwirqs used on the parent interrupt controller.
+
+Example:
+
+gpio_interrupt: interrupt-controller at 9880 {
+	compatible = "amlogic,meson-gxbb-gpio-intc",
+		     "amlogic,meson-gpio-intc";
+	reg = <0x0 0x9880 0x0 0x10>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	meson,channel-interrupts = <64 65 66 67 68 69 70 71>;
+};
-- 
2.13.5
