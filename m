From: rjui@broadcom.com (Ray Jui)
Date: Mon, 9 Mar 2015 13:44:59 -0700
Subject: [PATCH v6 5/8] pinctrl: Cygnus: define Broadcom Cygnus GPIO/PINCONF
 binding
In-Reply-To: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
References: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
Message-ID: <1425933902-20652-6-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the GPIO/PINCONF device tree binding for Broadcom Cygnus SoC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../bindings/pinctrl/brcm,cygnus-gpio.txt          |   98 ++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
new file mode 100644
index 0000000..6540ca5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
@@ -0,0 +1,98 @@
+Broadcom Cygnus GPIO/PINCONF Controller
+
+Required properties:
+
+- compatible:
+    Must be "brcm,cygnus-ccm-gpio", "brcm,cygnus-asiu-gpio", or
+    "brcm,cygnus-crmu-gpio"
+
+- reg:
+    Define the base and range of the I/O address space that contains the Cygnus
+GPIO/PINCONF controller registers
+
+- #gpio-cells:
+    Must be two. The first cell is the GPIO pin number (within the
+controller's pin space) and the second cell is used for the following:
+    bit[0]: polarity (0 for active high and 1 for active low)
+
+- gpio-controller:
+    Specifies that the node is a GPIO controller
+
+Optional properties:
+
+- interrupts:
+    Interrupt ID
+
+- interrupt-controller:
+    Specifies that the node is an interrupt controller
+
+- pinmux:
+    Specifies the phandle to the IOMUX device, where pins can be individually
+muxed to GPIO
+
+Supported generic PINCONF properties in child nodes:
+
+- pins:
+    The list of pins (within the controller's own pin space) that properties
+in the node apply to. Pin names are "gpio-<pin>"
+
+- bias-disable:
+    Disable pin bias
+
+- bias-pull-up:
+    Enable internal pull up resistor
+
+- bias-pull-down:
+    Enable internal pull down resistor
+
+- drive-strength:
+    Valid drive strength values include 2, 4, 6, 8, 10, 12, 14, 16 (mA)
+
+Example:
+	gpio_ccm: gpio at 1800a000 {
+		compatible = "brcm,cygnus-ccm-gpio";
+		reg = <0x1800a000 0x50>,
+		      <0x0301d164 0x20>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+
+		touch_pins: touch_pins {
+			pwr: pwr {
+				pins = "gpio-0";
+				drive-strength = <16>;
+			};
+
+			event: event {
+				pins = "gpio-1";
+				bias-pull-up;
+			};
+		};
+	};
+
+	gpio_asiu: gpio at 180a5000 {
+		compatible = "brcm,cygnus-asiu-gpio";
+		reg = <0x180a5000 0x668>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+	};
+
+	/*
+	 * Touchscreen that uses the CCM GPIO 0 and 1
+	 */
+	tsc {
+		...
+		...
+		gpio-pwr = <&gpio_ccm 0 0>;
+		gpio-event = <&gpio_ccm 1 0>;
+	};
+
+	/* Bluetooth that uses the ASIU GPIO 5, with polarity inverted */
+	bluetooth {
+		...
+		...
+		bcm,rfkill-bank-sel = <&gpio_asiu 5 1>
+	}
-- 
1.7.9.5
