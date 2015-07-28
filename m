From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 28 Jul 2015 09:12:58 +0100
Subject: [PATCH v2 2/3] ARM: dts: ifc6410: add real regulators for sdcc nodes.
In-Reply-To: <1438071116-30065-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438071116-30065-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438071178-30150-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds real regulators for all the three sdcc nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 4cf967f..88d6655 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -74,6 +74,12 @@
 					bias-pull-down;
 				};
 
+				pm8921_l5: l5 {
+					regulator-min-microvolt = <2750000>;
+					regulator-max-microvolt = <3000000>;
+					bias-pull-down;
+				};
+
 				pm8921_l6: l6 {
 					regulator-min-microvolt = <2950000>;
 					regulator-max-microvolt = <2950000>;
@@ -85,9 +91,25 @@
 					regulator-max-microvolt = <1900000>;
 					bias-pull-down;
 				};
+
+				pm8921_lvs1: lvs1 {
+					bias-pull-down;
+				};
 			};
 		};
 
+		ext_3p3v: regulator-fixed at 1 {
+			compatible = "regulator-fixed";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-name = "ext_3p3v";
+			regulator-type = "voltage";
+			startup-delay-us = <0>;
+			gpio = <&tlmm_pinmux 77 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+
 		gsbi3: gsbi at 16200000 {
 			status = "okay";
 			qcom,mode = <GSBI_PROT_I2C>;
@@ -188,11 +210,14 @@
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
 				status = "okay";
+				vmmc-supply = <&pm8921_l5>;
+				vqmmc-supply = <&pm8921_s4>;
 			};
 
 			/* External micro SD card */
 			sdcc3: sdcc at 12180000 {
 				status = "okay";
+				vmmc-supply = <&pm8921_l6>;
 				pinctrl-names	= "default";
 				pinctrl-0	= <&card_detect>;
 				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
@@ -200,6 +225,8 @@
 			/* WLAN */
 			sdcc4: sdcc at 121c0000 {
 				status = "okay";
+				vmmc-supply = <&ext_3p3v>;
+				vqmmc-supply = <&pm8921_lvs1>;
 			};
 		};
 	};
-- 
1.9.1
