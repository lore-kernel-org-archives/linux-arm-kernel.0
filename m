From: plaes@plaes.org (Priit Laes)
Date: Mon,  7 Dec 2015 09:26:00 +0200
Subject: [PATCH 1/2] ARM: dts: sun4i: gemei-g9: Add touchscreen (Goodix
 gt801x2) support
In-Reply-To: <1449473161-3535-1-git-send-email-plaes@plaes.org>
References: <1449473161-3535-1-git-send-email-plaes@plaes.org>
Message-ID: <1449473161-3535-2-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Goodix GT801 2+1 is a touchscreen controller supporting up to
10 touches.

Enable pin and wakeup pin support is currently not implemented:
 - enable pin (PI16, specified in FEX) seems to be wrong
 - wakeup pin needs some additional reverse engineering work

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 1d73a98..52e6275 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -48,6 +48,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Gemei G9 Tablet";
@@ -65,11 +66,11 @@
 /*
  * TODO:
  *   2x cameras via CSI
- *   audio input
+ *   audio input (+ ext. amplifier enable GPIO)
  *   AXP battery management
  *   NAND
  *   OTG
- *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
+ *   Touchscreen enable and wakeup pins
  */
 &codec {
 	status = "okay";
@@ -114,6 +115,27 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+
+	touchscreen at 55 {
+		compatible = "goodix,gt801_2plus1";
+		reg = <0x55>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
+
+		/*
+		 * TODO - figure out the wakeup pin:
+		 *   ctp_wakeup = port:PB13<1><default><default><1>
+		 * TODO - find correct GPIO pin, PI16 seems to be incorrect:
+		 *   ctp_en     = port:PI16<1><default><default><0>
+		 */
+	};
+};
+
 &lradc {
 	vref-supply = <&reg_ldo2>;
 
-- 
2.6.3
