From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Fri, 18 Dec 2015 11:52:22 +0300
Subject: [PATCH 3/4] ARM: dts: sun7i: Add backlight node to Wexler TAB7200
 tablet
In-Reply-To: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
References: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
Message-ID: <1450428742-5737-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a backlight for controlling the lcd panel backlight on Wexler TAB7200 tablet

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index 1dc9079..f47e5f1 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -48,6 +48,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Wexler TAB7200";
@@ -57,6 +58,16 @@
 		serial0 = &uart0;
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_enable_pin>;
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -158,6 +169,13 @@
 };
 
 &pio {
+	bl_enable_pin: bl_enable_pin at 0 {
+		allwinner,pins = "PH7";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	ts_reset_pin: ts_reset_pin at 0 {
 		allwinner,pins = "PB13";
 		allwinner,function = "gpio_out";
-- 
2.4.10
