From: peda@axentia.se (Peter Rosin)
Date: Tue, 20 Nov 2018 21:20:43 +0000
Subject: [PATCH] ARM: dts: at91: nattis: initialize the BLON pin as output-low
 early
Message-ID: <20181120212036.22497-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver initializes BLON (the enable gpio) to
output-high if the gpio is input on probe. Initializing the gpio
to output-low before the driver probes prevents this action by
the pwm-backlight driver and gets rid of a nasty blink of full
backlight with an uninitialized panel.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 911d2c7c1500..0f6d335125e2 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -60,6 +60,8 @@
 
 		power-supply = <&bl_reg>;
 		enable-gpios = <&pioA 20 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_blon>;
 	};
 
 	panel: panel {
@@ -164,6 +166,12 @@
 				      (AT91_PINCTRL_OUTPUT |
 				       AT91_PINCTRL_OUTPUT_VAL(0))>;
 		};
+
+		pinctrl_blon: blon {
+			atmel,pins = <AT91_PIOA 20 AT91_PERIPH_GPIO
+				      (AT91_PINCTRL_OUTPUT |
+				       AT91_PINCTRL_OUTPUT_VAL(0))>;
+		};
 	};
 };
 
-- 
2.11.0
