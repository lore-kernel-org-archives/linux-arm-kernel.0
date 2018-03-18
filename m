From: andre.przywara@arm.com (Andre Przywara)
Date: Sun, 18 Mar 2018 23:28:47 +0000
Subject: [PATCH v2 4/4] dts: sunxi: A64: Add PWM controllers
In-Reply-To: <20180318232847.14278-1-andre.przywara@arm.com>
References: <20180318232847.14278-1-andre.przywara@arm.com>
Message-ID: <20180318232847.14278-5-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A64 SoC features two PWM controllers, which are fully
compatible to the one used in the A13 and H3 chips.
Add the respective device nodes (one for the "normal" PWM, the other for
the one in the CPUS domain) and the pin their output is connected to.
On the A64 the "normal" PWM is muxed together with one of the MDIO pins
used to communicate with the Ethernet PHY, so it won't be usable on many
boards. But the Pinebook laptop uses this pin for controlling the LCD
backlight.
The CPUS PWM pin however is routed to the "RPi2" header, at the same
location as the PWM pin on the RaspberryPi.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d783d164b9c3..fda1783b1c86 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -321,6 +321,11 @@
 				bias-pull-up;
 			};
 
+			pwm_pin: pwm_pin {
+				pins = "PD22";
+				function = "pwm";
+			};
+
 			rmii_pins: rmii_pins {
 				pins = "PD10", "PD11", "PD13", "PD14", "PD17",
 				       "PD18", "PD19", "PD20", "PD22", "PD23";
@@ -537,6 +542,15 @@
 			#interrupt-cells = <3>;
 		};
 
+		pwm: pwm at 1c21400 {
+			compatible = "allwinner,sun50i-a64-pwm",
+				     "allwinner,sun5i-a13-pwm";
+			reg = <0x01c21400 0x400>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		rtc: rtc at 1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
@@ -563,6 +577,15 @@
 			#reset-cells = <1>;
 		};
 
+		r_pwm: pwm at 1f03800 {
+			compatible = "allwinner,sun50i-a64-pwm",
+				     "allwinner,sun5i-a13-pwm";
+			reg = <0x01f03800 0x400>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun50i-a64-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
@@ -578,6 +601,11 @@
 				pins = "PL0", "PL1";
 				function = "s_rsb";
 			};
+
+			r_pwm_pin: pwm {
+				pins = "PL10";
+				function = "s_pwm";
+			};
 		};
 
 		r_rsb: rsb at 1f03400 {
-- 
2.14.1
