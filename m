From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 8 Feb 2018 15:27:32 +0100
Subject: [PATCH 1/6] dt-bindings: mfd: Add ST Multi-Function eXpander driver
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518100057-23234-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the
STMicroelectronics Multi-Function eXpander (MFX).

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/mfd/st-mfx.txt | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st-mfx.txt

diff --git a/Documentation/devicetree/bindings/mfd/st-mfx.txt b/Documentation/devicetree/bindings/mfd/st-mfx.txt
new file mode 100644
index 0000000..423d800
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st-mfx.txt
@@ -0,0 +1,51 @@
+STMicroelectronics Multi-Function eXpander
+
+ST Multi-Function eXpander (MFX) is a slave controller using I2C for
+communication with the main MCU. Its main features are gpio expansion, main
+MCU IDD measurement (IDD is the amount of current that flows through VDD)
+and resistive touchscreen controller.
+
+Required properties:
+- compatible: must be "st,mfx"
+- reg: I2C address of the device
+- interrupts: interrupt triggered by MFX_IRQ_OUT signal
+- interrupt-parent: interrupt controller MFX is connected to
+- interrupt-controller: marks the device as an interrupt controller
+- #interrupt-cells: should be <1>, index of the interrupt within the
+  controller, in accordance with the "one cell" variant of
+  <devicetree/bindings/interrupt-controller/interrupt.txt>
+
+Optional nodes:
+
+* GPIO eXpander
+MFX provides 16 programmable GPIOs, and it is also possible to recover 8
+alternate GPIOs if the main functions are not used (touchscreen controller and
+IDD measurement not enabled).
+
+Required properties:
+- compatible : must be "st,mfx-gpio"
+- interrupt-parent : must be <&mfx>
+- interrupts = must be <0>
+- gpio-controller: marks the device node as a GPIO controller
+- #gpio-cells: should be <2>, the first cell is the GPIO offset on this GPIO
+  controller, the second cell is the gpio flags in accordance with
+  <dt-bindings/gpio/st-mfx-gpio.h>.
+
+Example:
+
+	mfx: mfx at 42 {
+		compatible = "st,mfx";
+		reg = <0x42>;
+		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&gpioi>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		mfxgpio: mfx_gpio {
+			compatible = "st,mfx-gpio";
+			interrupt-parent = <&mfx>;
+			interrupts = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
-- 
2.7.4
