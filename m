From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 14:59:08 +0100
Subject: [PATCH 2/4] ARM: dts: sun5i: Add backlight node to UTOO P66 tablet
In-Reply-To: <1448027950-14629-1-git-send-email-hdegoede@redhat.com>
References: <1448027950-14629-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1448027950-14629-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the lcd panel backlight on the UTOO P66 tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index eb793d5..5236c1e 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -47,11 +47,21 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Utoo P66";
 	compatible = "utoo,p66", "allwinner,sun5i-a13";
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		/* Note levels of 10 / 20% result in backlight off */
+		brightness-levels = <0 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <6>;
+		/* TODO: backlight uses axp gpio1 as enable pin */
+	};
+
 	i2c_lcd: i2c at 0 {
 		/* The lcd panel i2c interface is hooked up via gpios */
 		compatible = "i2c-gpio";
@@ -201,6 +211,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
-- 
2.5.0
