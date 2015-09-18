From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Sep 2015 15:35:39 +0800
Subject: [PATCH 4/4] ARM: dts: sun8i: Add pwm-backlight device for A23/A33 Q8
 format tablets
In-Reply-To: <1442561739-6824-1-git-send-email-wens@csie.org>
References: <1442561739-6824-1-git-send-email-wens@csie.org>
Message-ID: <1442561739-6824-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCD backlight on the A23/A33 Q8 format tablets is enabled
with a GPIO controlled regulator, and brightness controlled with
the SoC's PWM controller.

The backlight is powered from the AXP223 PMIC's DC1SW output,
which is not supported yet. A proper bootloader is required
to enable it.

The brightness levels are arbitrary. The FEX files do not have
such information. As such, actual brightness levels may differ
from device to device.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-q8-common.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
index 4c2d0b459d6f..8a56ff567911 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
@@ -41,11 +41,24 @@
  */
 #include "sunxi-q8-common.dtsi"
 
+#include <dt-bindings/pwm/pwm.h>
+
 / {
 	aliases {
 		serial0 = &r_uart;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en_pin_q8>;
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <8>;
+		enable-gpios = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+		/* backlight is powered by AXP223 DC1SW */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -62,6 +75,13 @@
 };
 
 &pio {
+	bl_en_pin_q8: bl_en_pin at 0 {
+		allwinner,pins = "PH6";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	mmc0_cd_pin_q8: mmc0_cd_pin at 0 {
 		allwinner,pins = "PB4";
 		allwinner,function = "gpio_in";
-- 
2.5.1
