From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 15:02:35 +0100
Subject: [PATCH 1/3] ARM: dts: at91: sama5d2 Xplained: set pin muxing for usb
 gadget and usb host
In-Reply-To: <cover.1456840819.git.nicolas.ferre@atmel.com>
References: <cover.1456840819.git.nicolas.ferre@atmel.com>
Message-ID: <1993c13ec2351fa16c16c660c1023075b7870e20.1456840819.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

For USB gadget on port A (device mode):
- pin PA31 is configured as an input GPIO which triggers an interrupt when
  vbus is detected on USB port A.
- pin PB9 is configured as an output GPIO and set to low level so the
  board doesn't supply vbus to USB port A.

For USB host:
- pin PB10 is configured as an output GPIO and is active at high level.
  The ohci driver will activate this pin so the board supplies vbus to USB
  port B.
- pin PB9 should be configured as an output GPIO and active at high level
  to use to USB port A in host mode (conflicts with USB gadget).

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 75341eec2dfd..382ccfb4a2b6 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -46,6 +46,7 @@
 #include "sama5d2.dtsi"
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Atmel SAMA5D2 Xplained";
@@ -71,11 +72,20 @@
 
 	ahb {
 		usb0: gadget at 00300000 {
+			atmel,vbus-gpio = <&pioA 31 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
 		};
 
 		usb1: ohci at 00400000 {
 			num-ports = <3>;
+			atmel,vbus-gpio = <0 /* &pioA 41 GPIO_ACTIVE_HIGH */
+					   &pioA 42 GPIO_ACTIVE_HIGH
+					   0
+					  >;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb_default>;
 			status = "okay";
 		};
 
@@ -376,6 +386,17 @@
 						 <PIN_PB12__UTXD3>;
 					bias-disable;
 				};
+
+				pinctrl_usb_default: usb_default {
+					pinmux = <PIN_PB10__GPIO>;
+					bias-disable;
+				};
+
+				pinctrl_usba_vbus: usba_vbus {
+					pinmux = <PIN_PA31__GPIO>;
+					bias-disable;
+				};
+
 			};
 		};
 	};
-- 
2.1.3
