From: achew@nvidia.com (Andrew Chew)
Date: Mon, 1 Apr 2013 14:53:26 -0700
Subject: [PATCH V6 7/9] ARM: vt8500: Provide regulator to pwm-backlight
In-Reply-To: <1364853208-32503-1-git-send-email-achew@nvidia.com>
References: <1364853208-32503-1-git-send-email-achew@nvidia.com>
Message-ID: <1364853208-32503-8-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/wm8850-w70v2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/wm8850-w70v2.dts b/arch/arm/boot/dts/wm8850-w70v2.dts
index fcc660c..25c96d0 100644
--- a/arch/arm/boot/dts/wm8850-w70v2.dts
+++ b/arch/arm/boot/dts/wm8850-w70v2.dts
@@ -37,11 +37,20 @@
 		};
 	};
 
+	backlight_power: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight-power";
+		enable-active-high;
+		regulator-boot-on;
+		gpio = <&gpio 0 7 0>;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 0 50000 1>;	/* duty inverted */
 
 		brightness-levels = <0 40 60 80 100 130 190 255>;
 		default-brightness-level = <5>;
+		power-supply = <&backlight_power>;
 	};
 };
-- 
1.8.1.5
