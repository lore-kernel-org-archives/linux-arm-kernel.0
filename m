From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 13 Nov 2017 01:25:21 +0000
Subject: [RFC PATCH 1/3] dt-bindings: pinctrl: sunxi: document new generic
 binding
In-Reply-To: <20171113012523.2328-1-andre.przywara@arm.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
Message-ID: <20171113012523.2328-2-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far all the Allwinner pinctrl drivers provided a table in the
kernel to describe all the pins and the link between the pinctrl functions
names (strings) and their respective mux values (register values).

Extend the binding to put those mappings in the DT, so that any SoC can
describe its pinctrl and GPIO data fully there instead of relying on
tables.
This uses a generic compatible name, to be prepended with an SoC
specific name in the node.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 6f2ec9af0de2..c1ea755229da 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -28,6 +28,7 @@ Required properties:
   "allwinner,sun50i-a64-r-pinctrl"
   "allwinner,sun50i-h5-pinctrl"
   "nextthing,gr8-pinctrl"
+  "allwinner,sunxi-pinctrl"	(see below)
 
 - reg: Should contain the register physical address and length for the
   pin controller.
@@ -69,6 +70,63 @@ Optional sub-node properties:
   - bias-pull-down
   - drive-strength
 
+** Generic pinctrl binding
+The above binding requires knowledge of the actual mux setting values for
+each supported SoC in the code parsing the DT (for instance the kernel).
+The generic binding puts this information in the DT. It uses the
+"allwinner,sunxi-pinctrl" compatible, in addition to some SoC specific string.
+It extends the above described binding as follows:
+Required properties:
+- allwinner,gpio-pins: An array of 32-bit numbers to denote the number of
+  implemented pins per pin controller port. Non-implemented ports can specify
+  0 here. There will be as many ports as this array has elements.
+- allwinner,irq-pin-map: Contains a number of IRQ port maps, describing the
+  relationship between interrupt banks and GPIO pins. Each map has six 32-bit
+  members:
+  <[IRQ port] [1st IRQ pin] [GPIO port] [1st GPIO pin] [mux value] [length]>
+  This maps the first [length] IRQ pins starting with [IRQ port]:[1st IRQ pin]
+  to [GPIO port]:[1st GPIO pin], all using [mux value] to select the IRQ
+  functionality.
+
+Optional properties:
+- allwinner,port-base: The number of GPIO ports to skip at the beginning.
+- allwinner,irq-bank-base: The number of IRQ banks to skip at the beginning.
+- allwinner,irq-read-needs-mux: Specifies that reading the line level of
+  a pin configured as an IRQ pin is not possible. A driver needs to switch
+  to the GPIO-in function to be able to read the level.
+
+Required properties for subnodes:
+- pinmux: An array of mux values to write into the respective MMIO register
+  bits for this pin when selecting the function. If this array has less
+  elements than pins, the *last* value will be used for all pins beyond that.
+  This allows to use a single element for the (likely) case all pins use the
+  same mux value.
+
+The binding described above can be extended in this manner to be supported
+by *both* an existing driver and some generic driver. Existing drivers will
+ignore the new properties and revert to their internal table instead.
+
+Example:
+  pinctrl at 1c20800 {
+	compatible = "allwinner,sun50i-a64-pinctrl",
+		     "allwinner,sunxi-pinctrl";
+	reg = <0x01c20800 0x400>;
+	clocks = <&ccu 58>, <&hosc>, <&losc>;
+	/* No PortA, PB0-PB9, PC0-PC16, PD0-PD24, ... */
+	allwinner,gpio-pins = <0 10 17 25 18 7 14 12>;
+	/* banks B, G and H can trigger interrupts, using mux value 6 */
+	allwinner,irq-pin-map= <0 0 1 0 6 10>,
+			       <1 0 6 0 6 14>,
+			       <2 0 7 0 6 12>;
+	i2c1_pins: i2c1_pins {
+		pins = "PH2", "PH3";
+		function = "i2c1";
+		/* Both pins use a mux value of 2 to select this function. */
+		pinmux = <2>;
+	};
+	...
+  };
+
 *** Deprecated pin configuration and multiplexing binding
 
 Required subnode-properties:
-- 
2.14.1
