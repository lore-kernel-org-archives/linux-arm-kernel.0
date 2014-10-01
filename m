From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  1 Oct 2014 10:06:43 +0100
Subject: [PATCH v3 2/4] ARM: dts: apq8064: Add usb host support.
In-Reply-To: <1412154355-2639-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1412154355-2639-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1412154403-2776-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes to support two usb hosts on APQ8064
SOC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 40 +++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 47 ++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index b396c83..96c7b2c 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -40,6 +40,46 @@
 			};
 		};
 
+		rpm at 108000 {
+			pm8921_s3: pm8921-s3 {
+				regulator-min-microvolt		= <1000000>;
+				regulator-max-microvolt		= <1400000>;
+				qcom,switch-mode-frequency	= <4800000>;
+			};
+
+			pm8921_l3: pm8921-l3 {
+				regulator-min-microvolt = <3050000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			pm8921_l23: pm8921-l23 {
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1900000>;
+			};
+		};
+
+		usb3_phy: phy at 12520000 {
+			status		= "okay";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+		};
+
+		usb4_phy: phy at 12530000 {
+			status		= "okay";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+		};
+
+		usb3: usb at 12520000 {
+			status = "okay";
+		};
+
+		usb4: usb at 12530000 {
+			status = "okay";
+		};
+
 		amba {
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index db5fc59..e33eb03 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -2,6 +2,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+#include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
 #include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
@@ -487,6 +488,52 @@
 			};
 		};
 
+		usb3_phy: phy at 12520000 {
+			compatible	= "qcom,usb-otg-ci";
+			reg		= <0x12520000 0x400>;
+			interrupts	= <0 188 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			dr_mode		= "host";
+
+			clocks		= <&gcc USB_HS3_XCVR_CLK>,
+					  <&gcc USB_HS3_H_CLK>;
+			clock-names	= "core", "iface";
+
+			resets		= <&gcc USB_HS3_RESET>;
+			reset-names	= "link";
+		};
+
+		usb4_phy: phy at 12530000 {
+			compatible	= "qcom,usb-otg-ci";
+			reg		= <0x12530000 0x400>;
+			interrupts	= <0 215 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			dr_mode		= "host";
+
+			clocks		= <&gcc USB_HS4_XCVR_CLK>,
+					  <&gcc USB_HS4_H_CLK>;
+			clock-names	= "core", "iface";
+
+			resets		= <&gcc USB_HS4_RESET>;
+			reset-names	= "link";
+		};
+
+		usb3: usb at 12520000 {
+			compatible	= "qcom,ehci-host";
+			reg		= <0x12520000 0x400>;
+			interrupts	= <0 188 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			usb-phy		= <&usb3_phy>;
+		};
+
+		usb4: usb at 12530000 {
+			compatible	= "qcom,ehci-host";
+			reg		= <0x12530000 0x400>;
+			interrupts	= <0 215 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			usb-phy		= <&usb4_phy>;
+		};
+
 		/* Temporary fixed regulator */
 		vsdcc_fixed: vsdcc-regulator {
 			compatible = "regulator-fixed";
-- 
1.9.1
