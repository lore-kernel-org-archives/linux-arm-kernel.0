From: leigh@solinno.co.uk (Leigh Brown)
Date: Wed, 25 Mar 2015 21:33:50 +0000
Subject: [PATCH] ARM: mvebu: GPIO reset on GlobalScale Mirabox
Message-ID: <1427319230-2500-1-git-send-email-leigh@solinno.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the system reset button on the GlobalScale Mirabox.
The reset button is connected via GPIO so add a gpio-keys entry for
it in the device tree file.  Patch is based on the implementation
in armada-370-netgear-rn102.dts but using the GPIO pin specified in
the original patch by Ezequiel Garcia from 2013.

Tested with the triggerhappy daemon.

Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
---
 arch/arm/boot/dts/armada-370-mirabox.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index e1b0eb6..41f453d 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "armada-370.dtsi"
 
@@ -78,6 +79,18 @@
 				};
 			};
 
+			gpio-keys {
+				compatible = "gpio-keys";
+				pinctrl-0 = <&reset_button_pin>;
+				pinctrl-names = "default";
+
+				reset-button {
+					label = "Reset Button";
+					linux,code = <KEY_RESTART>;
+					gpios = <&gpio1 26 GPIO_ACTIVE_LOW>;
+				};
+			};
+
 			mdio {
 				pinctrl-0 = <&mdio_pins>;
 				pinctrl-names = "default";
@@ -168,5 +181,10 @@
 		marvell,pins = "mpp64", "mpp65";
 		marvell,function = "gpio";
 	};
+
+	reset_button_pin: reset-button-pin {
+		marvell,pins = "mpp58";
+		marvell,function = "gpio";
+	};
 };
 
-- 
2.1.4
