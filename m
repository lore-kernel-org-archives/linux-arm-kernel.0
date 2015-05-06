From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed,  6 May 2015 01:37:55 -0700
Subject: [PATCH 1/3] dt-bindings: add brcmstb-gpio GPIO binding
In-Reply-To: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1430901477-10678-2-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding for Broadcom STB "UPG GIO" GPIO controller.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 .../devicetree/bindings/gpio/brcm,brcmstb-gpio.txt |   65 ++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
new file mode 100644
index 0000000..435f1bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
@@ -0,0 +1,65 @@
+Broadcom STB "UPG GIO" GPIO controller
+
+The controller's registers are organized as sets of eight 32-bit
+registers with each set controlling a bank of up to 32 pins.  A single
+interrupt is shared for all of the banks handled by the controller.
+
+Required properties:
+
+- compatible:
+    Must be "brcm,brcmstb-gpio"
+
+- reg:
+    Define the base and range of the I/O address space containing
+    the brcmstb GPIO controller registers
+
+- #gpio-cells:
+    Should be <2>.  The first cell is the pin number (within the controller's
+    pin space), and the second is used for the following:
+    bit[0]: polarity (0 for active-high, 1 for active-low)
+
+- gpio-controller:
+    Specifies that the node is a GPIO controller.
+
+- brcm,gpio-bank-widths:
+    Number of GPIO lines for each bank.  Number of elements must
+    correspond to number of banks suggested by the 'reg' property.
+
+Optional properties:
+
+- interrupts:
+    The interrupt shared by all GPIO lines for this controller.
+
+- interrupt-parent:
+    phandle of the parent interrupt controller
+
+- #interrupt-cells:
+    Should be <2>.  The first cell is the GPIO number, the second should specify
+    flags.  The following subset of flags is supported:
+    - bits[3:0] trigger type and level flags
+        1 = low-to-high edge triggered
+        2 = high-to-low edge triggered
+        4 = active high level-sensitive
+        8 = active low level-sensitive
+      Valid combinations are 1, 2, 3, 4, 8.
+    See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+- interrupt-controller:
+    Marks the device node as an interrupt controller
+
+- interrupt-names:
+    The name of the IRQ resource used by this controller
+
+Example:
+	upg_gio: gpio at f040a700 {
+		#gpio-cells = <0x2>;
+		#interrupt-cells = <0x2>;
+		compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
+		gpio-controller;
+		interrupt-controller;
+		reg = <0xf040a700 0x80>;
+		interrupt-parent = <0xf>;
+		interrupts = <0x6>;
+		interrupt-names = "upg_gio";
+		brcm,gpio-bank-widths = <0x20 0x20 0x20 0x18>;
+	};
-- 
1.7.9.5
