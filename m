From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 11 May 2016 09:34:22 +0200
Subject: [PATCH v2 2/2] dt-bindings: Add Oxford Semiconductor OXNAS pinctrl
 and gpio bindings
In-Reply-To: <1462952062-5316-1-git-send-email-narmstrong@baylibre.com>
References: <1462952062-5316-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1462952062-5316-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl and gpio DT bindings for Oxford Semiconductor OXNAS SoC Family.
This version supports the ARM926EJ-S based OX810SE SoC with 34 IO pins.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/gpio/gpio_oxnas.txt        | 47 ++++++++++++++++++
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  | 57 ++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
new file mode 100644
index 0000000..928ed4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
@@ -0,0 +1,47 @@
+* Oxford Semiconductor OXNAS SoC GPIO Controller
+
+Please refer to gpio.txt for generic information regarding GPIO bindings.
+
+Required properties:
+ - compatible: "oxsemi,ox810se-gpio"
+ - reg: Base address and length for the device.
+ - interrupts: The port interrupt shared by all pins.
+ - gpio-controller: Marks the port as GPIO controller.
+ - #gpio-cells: Two. The first cell is the pin number and
+   the second cell is used to specify the gpio polarity as defined in
+   defined in <dt-bindings/gpio/gpio.h>:
+      0 = GPIO_ACTIVE_HIGH
+      1 = GPIO_ACTIVE_LOW
+ - interrupt-controller: Marks the device node as an interrupt controller.
+ - #interrupt-cells: Two. The first cell is the GPIO number and second cell
+   is used to specify the trigger type as defined in
+   <dt-bindings/interrupt-controller/irq.h>:
+      IRQ_TYPE_EDGE_RISING
+      IRQ_TYPE_EDGE_FALLING
+      IRQ_TYPE_EDGE_BOTH
+ - gpio-ranges: Interaction with the PINCTRL subsystem, it also specifies the
+   gpio base and count, should be in the format of numeric-gpio-range as
+   specified in the gpio.txt file.
+
+Example:
+
+gpio0: gpio at 0 {
+	compatible = "oxsemi,ox810se-gpio";
+	reg = <0x000000 0x100000>;
+	interrupts = <21>;
+	#gpio-cells = <2>;
+	gpio-controller;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	gpio-ranges = <&pinctrl 0 0 32>;
+};
+
+keys {
+	...
+
+	button-esc {
+		label = "ESC";
+		linux,code = <1>;
+		gpios = <&gpio0 12 0>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
new file mode 100644
index 0000000..d607432
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
@@ -0,0 +1,57 @@
+* Oxford Semiconductor OXNAS SoC Family Pin Controller
+
+Please refer to pinctrl-bindings.txt, ../gpio/gpio.txt, and
+../interrupt-controller/interrupts.txt for generic information regarding
+pin controller, GPIO, and interrupt bindings.
+
+OXNAS 'pin configuration node' is a node of a group of pins which can be
+used for a specific device or function. This node represents configurations of
+pins, optional function, and optional mux related configuration.
+
+Required properties for pin controller node:
+ - compatible: "oxsemi,ox810se-pinctrl"
+ - oxsemi,sys-ctrl: a phandle to the system controller syscon node
+
+Required properties for pin configuration sub-nodes:
+ - pins: List of pins to which the configuration applies.
+
+Optional properties for pin configuration sub-nodes:
+----------------------------------------------------
+ - function: Mux function for the specified pins.
+ - bias-pull-up: Enable weak pull-up.
+
+Example:
+
+pinctrl: pinctrl {
+	compatible = "oxsemi,ox810se-pinctrl";
+
+	/* Regmap for sys registers */
+	oxsemi,sys-ctrl = <&sys>;
+
+	pinctrl_uart2: pinctrl_uart2 {
+		uart2a {
+			pins = "gpio31";
+			function = "fct3";
+		};
+		uart2b {
+			pins = "gpio32";
+			function = "fct3";
+		};
+	};
+};
+
+uart2: serial at 900000 {
+	compatible = "ns16550a";
+	reg = <0x900000 0x100000>;
+	clocks = <&sysclk>;
+	interrupts = <29>;
+	reg-shift = <0>;
+	fifo-size = <16>;
+	reg-io-width = <1>;
+	current-speed = <115200>;
+	no-loopback-test;
+	status = "disabled";
+	resets = <&reset 22>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+};
-- 
1.9.1
