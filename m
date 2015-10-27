From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Tue, 27 Oct 2015 14:15:00 +0200
Subject: [PATCH 6/6] ARM: OMAP2+: dts: cm-t335: add support for PWM backlight
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1445948100-16446-7-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ilya Ledvich <ilya@compulab.co.il>

Add pinmux configuration for ECAP0 pin.
Add node for PWM backlight device.
Use PWM output from ecap0 as backlight source.

Acked-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 0296d3f..571a453 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -39,6 +39,13 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ecap0 0 50000 0>;
+		brightness-levels = <0 51 53 56 62 75 101 152 255>;
+		default-brightness-level = <8>;
+	};
 };
 
 &am33xx_pinmux {
@@ -113,6 +120,13 @@
 		>;
 	};
 
+	ecap0_pins: pinmux_ecap0_pins {
+		pinctrl-single,pins = <
+			/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
+			0x164 0x0
+		>;
+	};
+
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
@@ -222,6 +236,16 @@
 	};
 };
 
+&epwmss0 {
+	status = "okay";
+
+	ecap0: ecap@48300100 {
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ecap0_pins>;
+	};
+};
+
 &gpmc {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.6.0
