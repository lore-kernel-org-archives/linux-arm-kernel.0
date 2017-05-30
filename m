From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:34 +0200
Subject: [PATCH 53/58] ARM: dts: at91: kizbox: switch to new pwm-atmel-tcb
 binding
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-54-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new pwm-atmel-tcb binding that avoid wasting TCB channels.

Cc: Antoine Aubert <a.aubert@overkiz.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-kizbox.dts | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index c6bf08f8201e..c831f605a974 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -43,6 +43,29 @@
 				};
 			};
 
+			tcb1: timer at fffdc000 {
+				tcb1_pwm0: pwm at 0 {
+					compatible = "atmel,tcb-pwm";
+					#pwm-cells = <3>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_tcb1_tioa0 &pinctrl_tcb1_tiob0>;
+				};
+
+				tcb1_pwm1: pwm at 1 {
+					compatible = "atmel,tcb-pwm";
+					#pwm-cells = <3>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_tcb1_tioa1>;
+				};
+
+				tcb1_pwm2: pwm at 2 {
+					compatible = "atmel,tcb-pwm";
+					#pwm-cells = <3>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_tcb1_tioa2>;
+				};
+			};
+
 			macb0: ethernet at fffc4000 {
 				phy-mode = "mii";
 				pinctrl-0 = <&pinctrl_macb_rmii
@@ -122,41 +145,30 @@
 
 		network_green {
 			label = "pwm:green:network";
-			pwms = <&tcb_pwm 2 10000000 PWM_POLARITY_INVERTED>;
+			pwms = <&tcb1_pwm1 0 10000000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 
 		network_red {
 			label = "pwm:red:network";
-			pwms = <&tcb_pwm 4 10000000 PWM_POLARITY_INVERTED>;
+			pwms = <&tcb1_pwm2 0 10000000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 
 		user_green {
 			label = "pwm:green:user";
-			pwms = <&tcb_pwm 0 10000000 PWM_POLARITY_INVERTED>;
+			pwms = <&tcb1_pwm0 0 10000000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 
 		user_red {
 			label = "pwm:red:user";
-			pwms = <&tcb_pwm 1 10000000 PWM_POLARITY_INVERTED>;
+			pwms = <&tcb1_pwm0 1 10000000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 	};
-
-	tcb_pwm: pwm {
-		compatible = "atmel,tcb-pwm";
-		#pwm-cells = <3>;
-		tc-block = <1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_tcb1_tioa0
-			     &pinctrl_tcb1_tioa1
-			     &pinctrl_tcb1_tioa2
-			     &pinctrl_tcb1_tiob0>;
-	};
 };
-- 
2.11.0
