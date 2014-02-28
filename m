From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Feb 2014 21:25:22 +0000
Subject: [PATCH 2/2] ARM: add support for Cubox-i PWM-driven front panel LED
Message-ID: <E1WJUvq-0003wg-3I@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The front panel LED on the Cubox-i is driven by one of the iMX6 PWM
channels, and is wired between the PWM output and supply.  This means
that outputting a low level results in the LED being turned on, so we
need the duty cycle inverted.

There's a question about whether the output inversion should be at the
pwm or pwm-leds level - setting the output inversion bit in the iMX6
results in a PWM duty cycle of zero outputting logic zero, meaning that
the LED is fully on.  This is undesirable, as it becomes impossible to
turn the LED fully off.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index c2a24888a276..7971387c2e13 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -12,6 +12,20 @@
 		pinctrl-0 = <&pinctrl_cubox_i_ir>;
 	};
 
+	pwmleds {
+		compatible = "pwm-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cubox_i_pwm1>;
+
+		front {
+			active-low;
+			default-brightness = <128>;
+			label = "imx6:red:front";
+			max-brightness = <248>;
+			pwms = <&pwm1 0 50000>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 
@@ -82,6 +96,10 @@
 			>;
 		};
 
+		pinctrl_cubox_i_pwm1: cubox-i-pwm1-front-led {
+			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b0>;
+		};
+
 		pinctrl_cubox_i_spdif: cubox-i-spdif {
 			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x13091>;
 		};
-- 
1.8.3.1
