From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:29:52 +0200
Subject: [PATCH 1/4] dt-bindings: gpio: update desription of LPC32xx GPIO
 controller
In-Reply-To: <1447982995-30231-1-git-send-email-vz@mleia.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
Message-ID: <1447982995-30231-2-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the purpose of better description of NXP LPC32xx GPIO controller
hardware in device tree format, extend the existing description with
device tree subnodes, which represent 6 GPIO banks within the
controller.

Note, client interface to the GPIO controller is untouched.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 .../devicetree/bindings/gpio/gpio_lpc32xx.txt      | 121 ++++++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt b/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
index 4981936..d2da63c 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
@@ -15,7 +15,43 @@ Required properties:
    2) pin number
    3) optional parameters:
       - bit 0 specifies polarity (0 for normal, 1 for inverted)
-- reg: Index of the GPIO group
+- #address-cells: should be 2, which stands for GPIO bank id and
+  physical base address of this GPIO bank.
+- #size-cells: should be 1, total size of GPIO bank registers.
+
+The NXP LPC32xx SoC GPIO controller device node must contain a list
+of device nodes representing GPIO banks and their descriptions.
+
+The format of subnodes should follow the description below.
+
+Required properties:
+- reg: should contain 3 integer values:
+   1) GPIO bank id from 0 to 5,
+   2) physical base address of this GPIO bank,
+   3) total size of the GPIO bank registers.
+
+Optional properties:
+- gpio-bank-name: human readable name of a GPIO bank,
+- gpio-no-output-state: property of P2 bank, which has special,
+  mapping of its control registers,
+- gpio-offset: property of P3/GPIO bank, offset of bits representing
+  GPIO lines in output and direction registers,
+- gpios: number of GPIO lines per GPIO bank, if this property is
+  omitted, then gpio-input-mask must be present,
+- gpio-input-mask: should contain two bitmasks, the first bitmask is
+  the mapping of GPIO lines to input status register, the second
+  bitmask should be a subset of the first bitmask and it represents
+  input GPIO lines, which may serve as an interrupt source,
+  if gpio-input-mask roperty is omitted, gpios property should be
+  present,
+- interrupts: list of parent interrupts mapped to input GPIO lines,
+- interrupts-extended: list of parent interrupts mapped to input GPIO
+  lines, used if parent interrupts are provided by more than one
+  interrupt controller, this option is used by GPI bank,
+- interrupt-controller: indicates that GPIO bank may serve as an
+  interrupt controller,
+- #interrupt-cells: if interrupt-controller property is present,
+  it should be 2, interrupt id and its flags.
 
 Example:
 
@@ -24,6 +60,89 @@ Example:
 		reg = <0x40028000 0x1000>;
 		gpio-controller;
 		#gpio-cells = <3>; /* bank, pin, flags */
+
+		ranges = <0 0x0 0x40028000 0x00001000>,
+			 <1 0x0 0x40028000 0x00001000>,
+			 <2 0x0 0x40028000 0x00001000>,
+			 <3 0x0 0x40028000 0x00001000>,
+			 <4 0x0 0x40028000 0x00001000>,
+			 <5 0x0 0x40028000 0x00001000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		gpio_p0: gpio-controller at 0 {
+			reg = <0 0x40 0x1C>;
+			gpio-bank-name = "p0";
+			gpios = <8>;
+
+			interrupt-parent = <&sic2>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gpio_p1: gpio-controller at 1 {
+			reg = <1 0x60 0x1C>;
+			gpio-bank-name = "p1";
+			gpios = <24>;
+
+			interrupt-parent = <&sic2>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gpio_p2: gpio-controller at 2 {
+			reg = <2 0x10 0x18>;
+			gpio-bank-name = "p2";
+			gpios = <13>;
+			gpio-no-output-state;
+		};
+
+		gpio_gpio: gpio-controller at 3 {
+			reg = <3 0x00 0x1C>;
+			gpio-bank-name = "gpio";
+			gpio-offset = <25>;
+			gpio-input-mask = <0x01007c00>, <0x01007c00>;
+
+			interrupt-parent = <&sic2>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+				     <1 IRQ_TYPE_LEVEL_HIGH>,
+				     <2 IRQ_TYPE_LEVEL_HIGH>,
+				     <3 IRQ_TYPE_LEVEL_HIGH>,
+				     <4 IRQ_TYPE_LEVEL_HIGH>,
+				     <5 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio_gpi: gpio-controller at 4 {
+			reg = <4 0x00 0x04>;
+			gpio-bank-name = "gpi";
+			gpio-input-only;
+			gpio-input-mask = <0x1aff83ff>, <0x100803ff>;
+
+			interrupts-extended =
+				<&sic2 22 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2 23 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2 24 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2 25 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2 26 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2 27 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2 28 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2 15 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2  9 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2 10 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic2 11 IRQ_TYPE_LEVEL_HIGH>,
+				<&sic1  4 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio_gpo: gpio-controller at 5 {
+			reg = <5 0x00 0x10>;
+			gpio-bank-name = "gpo";
+			gpios = <24>;
+			gpio-output-only;
+		};
 	};
 
 	leds {
-- 
2.1.4
