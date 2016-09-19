From: eric@anholt.net (Eric Anholt)
Date: Mon, 19 Sep 2016 17:13:12 +0100
Subject: [PATCH 1/3] dt-bindings: Add a binding for the RPi firmware GPIO
 driver.
Message-ID: <20160919161314.25858-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RPi firmware exposes all of the board's GPIO lines through
property calls.  Linux chooses to control most lines directly through
the pinctrl driver, but for the FXL6408 GPIO expander on the Pi3, we
need to access them through the firmware.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/gpio/gpio-raspberrypi-firmware.txt    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt b/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
new file mode 100644
index 000000000000..2b635c23a6f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
@@ -0,0 +1,22 @@
+Raspberry Pi power domain driver
+
+Required properties:
+
+- compatible:		Should be "raspberrypi,firmware-gpio"
+- gpio-controller:	Marks the device node as a gpio controller
+- #gpio-cells:		Should be <2> for GPIO number and flags
+- ngpios:		Number of GPIO lines to control.  See gpio.txt
+- firmware:		Reference to the RPi firmware device node
+- raspberrypi,firmware-gpio-offset:
+			Number the firmware uses for the first GPIO line
+			  controlled by this driver
+
+Example:
+fxl6408: firmware-gpio-128 {
+	compatible = "raspberrypi,firmware-gpio";
+	gpio-controller;
+	#gpio-cells = <2>;
+	firmware = <&firmware>;
+	ngpios = <8>;
+	raspberrypi,firmware-gpio-offset = <128>;
+};
-- 
2.9.3
