From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Jun 2016 15:48:00 +0200
Subject: [RFC v4 1/7] Documentation: extcon: usb-gpio: update usb-gpio binding
 description
In-Reply-To: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
References: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465393686-16644-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Baldyga <r.baldyga@samsung.com>

Add information about VBUS pin detection support, 'debounce' property
and some other details.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Acked-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 .../devicetree/bindings/extcon/extcon-usb-gpio.txt | 28 ++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
index af0b903de293..7096f399b771 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
+++ b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
@@ -1,16 +1,40 @@
 USB GPIO Extcon device
 
-This is a virtual device used to generate USB cable states from the USB ID pin
-connected to a GPIO pin.
+This is a virtual device used to generate USB cable states from the USB
+ID and VBUS signals connected to GPIO pins.
+
+The extcon cable states USB and USB_HOST are actually VBUS and !ID
+pin states and do not indicate what mode the USB needs to operate in.
+That decision is done by the USB stack.
+
+Some devices have only one of these GPIO pins, so we support cases when
+only one of them is present. Hence properties 'id-gpio' and 'vbus-gpio'
+are described as optional, but at least one of them has to be present
+in extcon-usb-gpio node.
+
+In general we have three cases:
+1. If VBUS and ID gpios are present we pass them as is
+	USB-HOST = !ID, USB = VBUS
+2. If only VBUS gpio is present we assume that ID pin is always High.
+	USB-HOST = false, USB = VBUS.
+3. If only ID pin is available we infer the VBUS pin states based on ID.
+	USB-HOST = !ID, USB = ID
 
 Required properties:
 - compatible: Should be "linux,extcon-usb-gpio"
+
+Optional properties
 - id-gpio: gpio for USB ID pin. See gpio binding.
+- vbus-gpio: gpio for USB VBUS pin. See gpio binding.
+- debounce: gpio debounce time in milliseconds (u32).
+
 
 Example: Examples of extcon-usb-gpio node in dra7-evm.dts as listed below:
 	extcon_usb1 {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
+		vbus-gpio = <&gpio6 2 GPIO_ACTIVE_HIGH>;
+		debounce = <25>;
 	}
 
 	&omap_dwc3_1 {
-- 
1.9.1
