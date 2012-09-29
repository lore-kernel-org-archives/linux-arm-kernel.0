From: avinashphilip@ti.com (Philip, Avinash)
Date: Sat, 29 Sep 2012 16:05:20 +0530
Subject: [PATCH 2/2] ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evm
In-Reply-To: <1348914920-30737-1-git-send-email-avinashphilip@ti.com>
References: <1348914920-30737-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1348914920-30737-3-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWM output from ecap0 uses as backlight source. Also adds low threshold
value to have a uniform divisions in brightness-levels scales.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
---
:100644 100644 a5c4c62... 5516098... M	arch/arm/boot/dts/am335x-evm.dts
 arch/arm/boot/dts/am335x-evm.dts |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index a5c4c62..5516098 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -24,6 +24,14 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am33xx_pinmux: pinmux at 44e10800 {
+		ecap0_pins: backlight_pins {
+			pinctrl-single,pins = <
+				0x164 0x0	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial at 44e09000 {
 			status = "okay";
@@ -75,6 +83,12 @@
 				reg = <0x48>;
 			};
 		};
+
+		ecap0: ecap at 48300100 {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&ecap0_pins>;
+		};
 	};
 
 	vbat: fixedregulator at 0 {
@@ -90,6 +104,13 @@
 		regulator-name = "lis3_reg";
 		regulator-boot-on;
 	};
+
+	backlight {
+		compatible	= "pwm-backlight";
+		pwms = <&ecap0 0 50000 0>;
+		brightness-levels = <0 51 53 56 62 75 101 152 255>;
+		default-brightness-level = <8>;
+	};
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.0.4
