From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 27 Nov 2012 14:18:17 +0530
Subject: [PATCH v5 12/12] ARM: dts: AM33XX: Add PWM backlight DT data to
 am335x-evmsk
In-Reply-To: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
References: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1354006097-25895-13-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWM output from ecap2 uses as backlight source. Also adds low threshold
value to have a uniform divisions in brightness-levels scales with
inverse polarity.

Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes since v4:
	- Replaced usage of tab with space in compatible field

 arch/arm/boot/dts/am335x-evmsk.dts |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index f5a6162..a50f286 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -51,6 +51,12 @@
 				0x9c 0x27	/* gpmc_ben0_cle.gpio2_5, INPUT | MODE7 */
 			>;
 		};
+
+		ecap2_pins: backlight_pins {
+			pinctrl-single,pins = <
+				0x19c 0x4	/* mcasp0_ahclkr.ecap2_in_pwm2_out MODE4 */
+			>;
+		};
 	};
 
 	ocp {
@@ -94,6 +100,16 @@
 				st,max-limit-z = <750>;
 			};
 		};
+
+		epwmss2: epwmss at 48304000 {
+			status = "okay";
+
+			ecap2: ecap at 48304100 {
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&ecap2_pins>;
+			};
+		};
 	};
 
 	vbat: fixedregulator at 0 {
@@ -170,6 +186,13 @@
 			gpios = <&gpio3 5 0>;
 		};
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ecap2 0 50000 1>;
+		brightness-levels = <0 58 61 66 75 90 125 170 255>;
+		default-brightness-level = <8>;
+	};
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.0.4
