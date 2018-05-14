From: tommyhebb@gmail.com (Thomas Hebb)
Date: Mon, 14 May 2018 17:58:15 -0400
Subject: [PATCH 2/2] ARM: dts: chromecast: use PWM for LEDs
In-Reply-To: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1526334654.git.tommyhebb@gmail.com>
References: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1526334654.git.tommyhebb@gmail.com>
Message-ID: <90316a6c92204399a4fecfe7cd2a2b808548fa48.1526334654.git.tommyhebb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control the Chromecast's two LEDs using PWM instead of GPIO pins. This
allows for variable brightness.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
 .../boot/dts/berlin2cd-google-chromecast.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index 54221f55bfa2..fb71e5436420 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -66,18 +66,21 @@
 	};
 
 	leds {
-		compatible = "gpio-leds";
+		compatible = "pwm-leds";
+		pinctrl-0 = <&ledpwm_pmux>;
+		pinctrl-names = "default";
 
 		white {
 			label = "white";
-			gpios = <&portc 1 GPIO_ACTIVE_HIGH>;
-			default-state = "keep";
+			pwms = <&pwm 0 600000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
 		};
 
 		red {
 			label = "red";
-			gpios = <&portc 2 GPIO_ACTIVE_HIGH>;
-			default-state = "keep";
+			pwms = <&pwm 1 600000 0>;
+			max-brightness = <255>;
 		};
 	};
 };
@@ -96,3 +99,10 @@
 &usb_phy1 { status = "okay"; };
 
 &usb1 { status = "okay"; };
+
+&soc_pinctrl {
+	ledpwm_pmux: ledpwm-pmux {
+		groups = "G0";
+		function = "pwm";
+	};
+};
-- 
2.17.0
