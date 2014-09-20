From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 20 Sep 2014 22:06:36 +0200
Subject: [PATCH 3/3] ARM: sun7i: cubieboard2: Enable the AXP209
In-Reply-To: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1411243596-15117-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the AXP209 PMIC with the regulators in use on the cubie2.

The RTC regulator can be disabled, but since the RTC driver doesn't grab the
regulator for now, the driver wouldn't work anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 53680983461a..f0b74a38a800 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -91,6 +91,29 @@
 
 				interrupt-controller;
 				#interrupt-cells = <1>;
+
+				regulators {
+					x-powers,dcdc-freq = <1500>;
+
+					vdd_cpu: dcdc2 {
+						vin-supply = <&reg_axp_ipsout>;
+						regulator-always-on;
+					};
+
+					vdd_dll: dcdc3 {
+						vin-supply = <&reg_axp_ipsout>;
+						regulator-always-on;
+					};
+
+					vdd_rtc: ldo1 {
+						vin-supply = <&reg_axp_ipsout>;
+					};
+
+					avcc: ldo2 {
+						vin-supply = <&reg_axp_ipsout>;
+						regulator-always-on;
+					};
+				};
 			};
 		};
 
@@ -140,4 +163,12 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_axp_ipsout: axp_ipsout {
+		compatible = "regulator-fixed";
+		regulator-name = "axp-ipsout";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
-- 
2.1.0
