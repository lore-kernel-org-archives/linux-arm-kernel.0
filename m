From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri, 29 Apr 2016 02:53:17 +0200
Subject: [RFC v5 4/4] gpio: dt-bindings: add gpio-mmio bindings
In-Reply-To: <cover.1461888822.git.chunkeey@googlemail.com>
References: <cover.1461888822.git.chunkeey@googlemail.com>
Message-ID: <a0ded4d0161f7ab3cd1945741d95d2718dbe4f44.1461888822.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>

This patch adds the device tree bindings for the gpio-mmio.
The gpio-mmio is already part of a the GPIO generic library.

Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 .../devicetree/bindings/gpio/gpio-mmio.txt         | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mmio.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.txt b/Documentation/devicetree/bindings/gpio/gpio-mmio.txt
new file mode 100644
index 0000000..cc7f0b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.txt
@@ -0,0 +1,73 @@
+Bindings for the generic driver for memory-mapped GPIO controllers.
+
+Required properties:
+	- compatible: should be "linux,gpio-mmio"
+	- reg-names: must contain
+		"dat" - data register
+		may contain
+		"set" - data set register
+		"clr" - data clear register
+		"dirout" - direction output register
+		"dirin" - direction input register
+	- reg: address + size pairs describing the GPIO register sets;
+		order must correspond with the order of entries in reg-names
+	- #gpio-cells = must be set to 2
+	- gpio-controller: Marks the device node as a gpio controller.
+
+Optional properties:
+	- ngpio: specifies the number of gpio mapped in the register.
+	- big-endian: force big endian register accesses.
+	- big-endian-byte-order: assign GPIOs in reverse order.
+	- unreadable-reg-set: data set register is not readable.
+	- read-output-reg-set: cache value set for reads.
+	- unreadable-reg-dir: dirout/dirin register is not readable.
+	- no-output: GPIOs are read-only.
+
+The GPIO generic library provides support for memory-mapped GPIO
+controllers. The configuration is detected by which resources are present.
+The simplest form of a GPIO controller that the driver support is just a
+single "dat" register, where GPIO state can be read and/or written.
+However, the driver supports far more:
+	- 8/16/32/64 bits registers. The number of GPIOs is automatically
+	  determined by the width of the registers.
+	- GPIO controllers with clear/set registers.
+	- GPIO controllers with a single "dat" register.
+	- Big endian bits/GPIOs ordering.
+
+For setting GPIO's there are three configurations:
+	1. single input/output register resource (named "dat"),
+	2. set/clear pair (named "set" and "clr"),
+	3. single output register resource and single input resource
+	   ("set" and dat").
+
+For setting the GPIO direction, there are three configurations:
+	a. simple bidirectional GPIOs that requires no configuration.
+	b. an output direction register (named "dirout")
+	   where a 1 bit indicates the GPIO is an output.
+	c. an input direction register (named "dirin")
+	   where a 1 bit indicates the GPIO is an input.
+
+Examples:
+
+	/* Configuration for single input/output register
+	 * for eight simple bidirectional GPIOs.
+	 */
+	gpio_a_1 {
+		compatible = "linux,gpio-mmio";
+		reg = <0x18000000 0x1>;
+		reg-names = "dat";
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	/* Configuration for set/clear pair registers with
+	 * 32 output direction register GPIOs.
+	 */
+	gpio_b_2 {
+		compatible = "linux,gpio-mmio";
+		reg = <0x18000000 0x4>, <0x18000010 0x4>,
+		      <0x18000004 0x4>, <0x18000008 0x4>;
+		reg-names = "dat", "set", "clr", "dirout";
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
-- 
2.8.1
