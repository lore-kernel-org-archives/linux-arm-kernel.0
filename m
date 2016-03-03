From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Mar 2016 12:40:04 +0100
Subject: [PATCH 11/17] dt-bindings: Add PLX Technology OXNAS pinctrl and gpio
 bindings
In-Reply-To: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457005210-18485-12-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/gpio/gpio_oxnas.txt        |  27 ++++++
 .../bindings/pinctrl/plxtech,pinctrl.txt           | 100 +++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/plxtech,pinctrl.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
new file mode 100644
index 0000000..0ef6c55
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
@@ -0,0 +1,27 @@
+PLX Technology OXNAS SoC GPIO Controller
+==========================================
+
+Required properties:
+- compatible: "plxtech,nas782x-gpio".
+- reg: Should contain GPIO controller registers location and length
+- interrupts: Should be the port interrupt shared by all the pins.
+- #gpio-cells: Should be two.  The first cell is the pin number and
+  the second cell is used to specify optional parameters (currently
+  unused).
+- gpio-controller: Marks the device node as a GPIO controller.
+
+optional properties:
+- #gpio-lines: Number of gpio if absent 32.
+
+
+Example:
+	gpio0: gpio at 000000 {
+		compatible = "plxtech,nas782x-gpio";
+		reg = <0x000000 0x100000>;
+		interrupts = <21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#gpio-lines = <32>;
+	};
diff --git a/Documentation/devicetree/bindings/pinctrl/plxtech,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/plxtech,pinctrl.txt
new file mode 100644
index 0000000..30f013f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/plxtech,pinctrl.txt
@@ -0,0 +1,100 @@
+PLX Technology OXNAS SoC Pinmux Controller
+==========================================
+
+The OXNAS Pinmux Controller, enables the IC to share one PAD to several
+functional blocks. The sharing is done by multiplexing the PAD input/output
+signals. For each PAD there are up to 8 muxing options (called periph modes).
+Since different modules require different PAD settings
+(like pull up, keeper, etc) the contoller controls also the PAD settings
+parameters.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+OXNAS pin configuration node is a node of a group of pins which can be
+used for a specific device or function. This node represents both mux and config
+of the pins in that group. The 'pins' selects the function mode(also named pin
+mode) this pin can work on and the 'config' configures various pad settings
+such as pull-up, multi drive, etc.
+
+Required properties for iomux controller:
+- compatible: "plxtech,nas782x-pinctrl" or "plxtech,ox810se-pinctrl"
+- plxtech,mux-mask: array of mask (periph per bank) to describe if a pin can be
+  configured in this periph mode. All the periph and bank need to be describe.
+- plxtech,sys-ctrl: a phandle to the system controller syscon node
+
+How to create such array:
+
+Each column will represent the possible peripheral of the pinctrl
+Each line will represent a pio bank
+
+For example :
+Peripheral: 2 ( A and B)
+Bank: 2 (A, B and C)
+=>
+
+  /*    A         B     */
+  0xffffffff 0xffc00c3b  /* pioA */
+  0xffffffff 0x7fff3ccf  /* pioB */
+
+For each peripheral/bank we will descibe in a u32 if a pin can be
+configured in it by putting 1 to the pin bit (1 << pin)
+
+Required properties for pin configuration node:
+- plxtech,pins: 4 integers array, represents a group of pins mux and config
+  setting. The format is plxtech,pins = <PIN_BANK PIN_BANK_NUM PERIPH CONFIG>.
+  The PERIPH 0 means gpio, PERIPH 1 is periph A, PERIPH 2 is periph B...
+  PIN_BANK 0 is pioA, PIN_BANK 1 is pioB...
+
+Bits used for CONFIG:
+ - None Yet
+
+Examples:
+
+pinctrl: pinctrl {
+	compatible = "plxtech,nas782x-pinctrl", "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	/* Regmap for sys registers */
+	plxtech,sys-ctrl = <&sys>;
+
+	/* Default, all-open mux-map */
+	plxtech,mux-mask = <
+		 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF
+		 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF
+		 >;
+
+	uart0 {
+		pinctrl_uart0: uart0 {
+			plxtech,pins = <0 31 3 0
+					0 32 3 0>;
+		};
+		pinctrl_uart0_modem: uart0_modem {
+			plxtech,pins = <0 27 3 0
+					0 28 3 0
+					0 29 3 0
+					0 30 3 0
+					0 33 3 0
+					0 34 3 0>;
+		};
+	};
+};
+
+uart0: uart at 200000 {
+	compatible = "ns16550a";
+	reg = <0x200000 0x100000>;
+	clocks = <&sysclk>;
+	interrupts = <23>;
+	reg-shift = <0>;
+	fifo-size = <16>;
+	reg-io-width = <1>;
+	current-speed = <115200>;
+	no-loopback-test;
+	status = "disabled";
+	resets = <&reset 17>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+};
-- 
1.9.1
