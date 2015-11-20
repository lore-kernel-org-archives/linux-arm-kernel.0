From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 14:59:09 +0100
Subject: [PATCH 3/4] ARM: dts: sun4i: Add backlight node to pov protab2 ips9
 tablet
In-Reply-To: <1448027950-14629-1-git-send-email-hdegoede@redhat.com>
References: <1448027950-14629-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1448027950-14629-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the lcd panel backlight on the pov protab2 ips9
tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 0e5124f..1f92ec7 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -47,6 +47,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Point of View Protab2-IPS9";
@@ -56,6 +57,16 @@
 		serial0 = &uart0;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en_pin_protab>;
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <8>;
+		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -145,6 +156,13 @@
 };
 
 &pio {
+	bl_en_pin_protab: bl_en_pin at 0 {
+		allwinner,pins = "PH7";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	touchscreen_pins: touchscreen_pins at 0 {
 		allwinner,pins = "PA5", "PB13";
 		allwinner,function = "gpio_out";
@@ -167,6 +185,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>;
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
-- 
2.5.0
