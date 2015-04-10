From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Apr 2015 13:34:16 +0100
Subject: [PATCH v2 04/12] ARM: dts: apq8064: Add USB OTG support
In-Reply-To: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428669256-10948-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USB OTG support on USB1 of APQ8064 SOC.
Tested on IFC6410 with ethernet gadget.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 17 ++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 32 ++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 8fe60fc..122bf34 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -116,6 +116,14 @@
 			};
 		};
 
+		/* OTG */
+		usb1_phy: phy at 12500000 {
+			status		= "okay";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l4>;
+		};
+
 		usb3_phy: phy at 12520000 {
 			status		= "okay";
 			vddcx-supply	= <&pm8921_s3>;
@@ -130,6 +138,15 @@
 			v1p8-supply	= <&pm8921_l23>;
 		};
 
+		gadget1: gadget at 12500000 {
+			status = "okay";
+		};
+
+		/* OTG */
+		usb1: usb at 12500000 {
+			status = "okay";
+		};
+
 		usb3: usb at 12520000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 99d8e07..5aac9a5 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -301,6 +301,21 @@
 			};
 		};
 
+		usb1_phy: phy at 12500000 {
+			compatible	= "qcom,usb-otg-ci";
+			reg		= <0x12500000 0x400>;
+			interrupts	= <GIC_SPI 100 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			dr_mode		= "host";
+
+			clocks		= <&gcc USB_HS1_XCVR_CLK>,
+					  <&gcc USB_HS1_H_CLK>;
+			clock-names	= "core", "iface";
+
+			resets		= <&gcc USB_HS1_RESET>;
+			reset-names	= "link";
+		};
+
 		usb3_phy: phy at 12520000 {
 			compatible	= "qcom,usb-otg-ci";
 			reg		= <0x12520000 0x400>;
@@ -331,6 +346,23 @@
 			reset-names	= "link";
 		};
 
+		gadget1: gadget at 12500000 {
+			compatible	= "qcom,ci-hdrc";
+			reg		= <0x12500000 0x400>;
+			status		= "disabled";
+			dr_mode		= "peripheral";
+			interrupts	= <GIC_SPI 100 IRQ_TYPE_NONE>;
+			usb-phy		= <&usb1_phy>;
+		};
+
+		usb1: usb at 12500000 {
+			compatible	= "qcom,ehci-host";
+			reg		= <0x12500000 0x400>;
+			interrupts	= <GIC_SPI 100 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			usb-phy		= <&usb1_phy>;
+		};
+
 		usb3: usb at 12520000 {
 			compatible	= "qcom,ehci-host";
 			reg		= <0x12520000 0x400>;
-- 
1.9.1
