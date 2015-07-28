From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 28 Jul 2015 09:13:05 +0100
Subject: [PATCH v2 3/3] ARM: dts: qs600: Add real regulators to sdcc
In-Reply-To: <1438071116-30065-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438071116-30065-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438071185-30192-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds real regulators to sdcc nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 71512b3..34ccb26 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -67,6 +67,12 @@
 					bias-pull-down;
 				};
 
+				pm8921_l5: l5 {
+					regulator-min-microvolt = <2750000>;
+					regulator-max-microvolt = <3000000>;
+					bias-pull-down;
+				};
+
 				pm8921_l23: l23 {
 					regulator-min-microvolt = <1700000>;
 					regulator-max-microvolt = <1900000>;
@@ -140,19 +146,33 @@
 			status = "okay";
 		};
 
+		/* on board fixed 3.3v supply */
+		v3p3_fixed: v3p3 {
+			compatible = "regulator-fixed";
+			regulator-name = "PCIE V3P3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
 		amba {
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
 				status = "okay";
+				vmmc-supply = <&pm8921_l5>;
+				vqmmc-supply = <&pm8921_s4>;
 			};
 
 			/* External micro SD card */
 			sdcc3: sdcc at 12180000 {
 				status = "okay";
+				vmmc-supply = <&v3p3_fixed>;
 			};
 			/* WLAN */
 			sdcc4: sdcc at 121c0000 {
 				status = "okay";
+				vmmc-supply = <&v3p3_fixed>;
+				vqmmc-supply = <&v3p3_fixed>;
 			};
 		};
 	};
-- 
1.9.1
