From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 18 Feb 2014 13:09:33 +0000
Subject: [PATCH RFC 2/2] ARM: add support for Cubox-i PWM-driven front panel
 LED
Message-ID: <E1WFkQX-0005JX-OC@rmk-PC.arm.linux.org.uk>
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
=-DO NOT APPLY-=
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 64daa3b311f6..d9fbd7ff17df 100644
=-DO NOT APPLY-= a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
=+DO NOT APPLY+= b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -12,6 +12,20 @@
 		pinctrl-0 = <&pinctrl_cubox_i_ir>;
 	};
 
=+DO NOT APPLY+=	pwmleds {
=+DO NOT APPLY+=		compatible = "pwm-leds";
=+DO NOT APPLY+=		pinctrl-names = "default";
=+DO NOT APPLY+=		pinctrl-0 = <&pinctrl_cubox_i_pwm1>;
=+DO NOT APPLY+=
=+DO NOT APPLY+=		front {
=+DO NOT APPLY+=			active-low;
=+DO NOT APPLY+=			default-brightness = <128>;
=+DO NOT APPLY+=			label = "imx6:red:front";
=+DO NOT APPLY+=			max-brightness = <248>;
=+DO NOT APPLY+=			pwms = <&pwm1 0 50000>;
=+DO NOT APPLY+=		};
=+DO NOT APPLY+=	};
=+DO NOT APPLY+=
 	regulators {
 		compatible = "simple-bus";
 
@@ -88,6 +102,10 @@
 			>;
 		};
 
=+DO NOT APPLY+=		pinctrl_cubox_i_pwm1: cubox-i-pwm1-front-led {
=+DO NOT APPLY+=			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b0>;
=+DO NOT APPLY+=		};
=+DO NOT APPLY+=
 		pinctrl_cubox_i_spdif: cubox-i-spdif {
 			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0>;
 		};
-- 
1.8.3.1
