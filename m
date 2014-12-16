From: rjui@broadcom.com (Ray Jui)
Date: Mon, 15 Dec 2014 18:18:25 -0800
Subject: [PATCH v6 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <1418696307-19392-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1418696307-19392-1-git-send-email-rjui@broadcom.com>
Message-ID: <1418696307-19392-2-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the GPIO device tree binding for Broadcom Cygnus SoC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../devicetree/bindings/gpio/brcm,cygnus-gpio.txt  |   82 ++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,cygnus-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/brcm,cygnus-gpio.txt b/Documentation/devicetree/bindings/gpio/brcm,cygnus-gpio.txt
new file mode 100644
index 0000000..dca322a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/brcm,cygnus-gpio.txt
@@ -0,0 +1,82 @@
+Broadcom Cygnus GPIO Controller
+
+Required properties:
+
+- compatible:
+    Must be "brcm,cygnus-gpio"
+
+- reg:
+    Define the base and range of the I/O address space that contain the Cygnus
+GPIO controller registers
+
+- ngpios:
+    Total number of GPIOs the controller provides
+
+- #gpio-cells:
+    Must be two. The first cell is the GPIO pin number (within the
+controller's domain) and the second cell is used for the following:
+    bit[0]: polarity (0 for normal and 1 for inverted)
+    bit[18:16]: internal pull up/down: 0 - pull up/down disabled
+                                       1 - pull up enabled
+                                       2 - pull down enabled
+    bit[22:20]: drive strength: 0 - 2 mA
+                                1 - 4 mA
+                                2 - 6 mA
+                                3 - 8 mA
+                                4 - 10 mA
+                                5 - 12 mA
+                                6 - 14 mA
+                                7 - 16 mA
+
+- gpio-controller:
+    Specifies that the node is a GPIO controller
+
+Optional properties:
+
+- interrupt-controller:
+    Specifies that the node is an interrupt controller. Not all Cygnus GPIO
+interfaces support interrupt, e.g., the CRMU GPIO controller does not have its
+interrupt routed to the main processor's GIC
+
+- interrupts:
+    The interrupt outputs from the GPIO controller.
+
+- no-drv-strength:
+    Specifies the GPIO controller does not support drive strength configuration
+
+Example:
+	gpio_asiu: gpio at 180a5000 {
+		compatible = "brcm,cygnus-gpio";
+		reg = <0x180a5000 0x668>;
+		ngpios = <122>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gpio_crmu: gpio at 03024800 {
+		compatible = "brcm,cygnus-gpio";
+		reg = <0x03024800 0x50>;
+		ngpios = <6>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		no-drv-strength;
+	};
+
+	/*
+	 * Touchscreen that uses the ASIU GPIO 100, with internal pull-up
+	 * enabled
+	 */
+	tsc {
+		...
+		...
+		gpio-event = <&gpio_asiu 100 0x10000>;
+	};
+
+	/* Bluetooth that uses the CRMU GPIO 2, with polarity inverted */
+	bluetooth {
+		...
+		...
+		bcm,rfkill-bank-sel = <&gpio_crmu 2 1>
+	}
-- 
1.7.9.5
