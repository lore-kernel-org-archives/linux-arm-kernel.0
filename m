From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Apr 2015 13:34:09 +0100
Subject: [PATCH v2 03/12] ARM: dts: apq8064: Add usb host support.
In-Reply-To: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428669249-10906-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes to support two usb hosts on APQ8064
SOC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 22 ++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 47 ++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index ca2d7ba..8fe60fc 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -116,6 +116,28 @@
 			};
 		};
 
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
index 19629c9..99d8e07 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -2,6 +2,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+#include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -300,6 +301,52 @@
 			};
 		};
 
+		usb3_phy: phy at 12520000 {
+			compatible	= "qcom,usb-otg-ci";
+			reg		= <0x12520000 0x400>;
+			interrupts	= <GIC_SPI 188 IRQ_TYPE_NONE>;
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
+			interrupts	= <GIC_SPI 215 IRQ_TYPE_NONE>;
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
+			interrupts	= <GIC_SPI 188 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			usb-phy		= <&usb3_phy>;
+		};
+
+		usb4: usb at 12530000 {
+			compatible	= "qcom,ehci-host";
+			reg		= <0x12530000 0x400>;
+			interrupts	= <GIC_SPI 215 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			usb-phy		= <&usb4_phy>;
+		};
+
 		/* Temporary fixed regulator */
 		vsdcc_fixed: vsdcc-regulator {
 			compatible = "regulator-fixed";
-- 
1.9.1
