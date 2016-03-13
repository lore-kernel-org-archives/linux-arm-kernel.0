From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 Mar 2016 08:39:37 +0100
Subject: [PATCH 2/2] ARM: dts: sun8i: Add backlight / pwm nodes to
 sun8i-a23-gt90h-v4
In-Reply-To: <1457854777-15825-1-git-send-email-hdegoede@redhat.com>
References: <1457854777-15825-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1457854777-15825-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the backlight / pwm found on a23-gt90h-v4 tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
index 6a22ee3..1be8d5f 100644
--- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
+++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
@@ -47,6 +47,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Allwinner GT90H Quad Core Tablet (v4)";
@@ -56,6 +57,16 @@
 		serial0 = &r_uart;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en_pin_gt90h>;
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <8>;
+		enable-gpios = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -115,6 +126,13 @@
 };
 
 &pio {
+	bl_en_pin_gt90h: bl_en_pin at 0 {
+		allwinner,pins = "PH6";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	mmc0_cd_pin_gt90h: mmc0_cd_pin at 0 {
 		allwinner,pins = "PB4";
 		allwinner,function = "gpio_in";
@@ -123,6 +141,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.7.2
