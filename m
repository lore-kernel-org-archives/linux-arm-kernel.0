From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Tue, 21 Apr 2015 14:05:16 +0200
Subject: [PATCH v2 5/7] ARM: at91/dt: at91-kizbox: leds related changes
In-Reply-To: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
References: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1429617918-32086-6-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This:
 * moves to pwm-leds using tcb-pwm driver and
 * renames leds to pwm:<color>:<function>.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
---
 arch/arm/boot/dts/at91-kizbox.dts | 53 +++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 73e4559..b19f568 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -8,6 +8,7 @@
  */
 /dts-v1/;
 #include "at91sam9g20.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Overkiz Kizbox";
@@ -112,32 +113,46 @@
 		};
 	};
 
-	leds {
-		compatible = "gpio-leds";
+	pwm_leds {
+		compatible = "pwm-leds";
 
-		led1g {
-			label = "led1:green";
-			gpios = <&pioB 0 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
+		network_green {
+			label = "pwm:green:network";
+			pwms = <&tcb_pwm 2 10000000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
 		};
 
-		led1r {
-			label = "led1:red";
-			gpios = <&pioB 1 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
+		network_red {
+			label = "pwm:red:network";
+			pwms = <&tcb_pwm 3 10000000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
 		};
 
-		led2g {
-			label = "led2:green";
-			gpios = <&pioB 2 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
-			default-state = "on";
+		user_green {
+			label = "pwm:green:user";
+			pwms = <&tcb_pwm 0 10000000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
 		};
 
-		led2r {
-			label = "led2:red";
-			gpios = <&pioB 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
+		user_red {
+			label = "pwm:red:user";
+			pwms = <&tcb_pwm 1 10000000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
 		};
 	};
+
+	tcb_pwm: pwm {
+		compatible = "atmel,tcb-pwm";
+		#pwm-cells = <3>;
+		tc-block = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tcb1_tioa0
+			     &pinctrl_tcb1_tioa1
+			     &pinctrl_tcb1_tioa2
+			     &pinctrl_tcb1_tiob0>;
+	};
 };
-- 
1.9.1
