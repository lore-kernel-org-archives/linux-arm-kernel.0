From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 30 Sep 2014 15:10:10 +0100
Subject: [PATCH v2 3/4] ARM: dts: apq8064: Add USB OTG support
In-Reply-To: <1412086159-20894-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1412086159-20894-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1412086210-21025-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USB OTG support on USB1 of APQ8064 SOC.
Tested on IFC6410 with ethernet gadget.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 14 ++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 36 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 3288bf7..f221e9e 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -40,6 +40,11 @@
 			};
 		};
 
+		/* OTG */
+		usb1_phy: phy at 12500000 {
+			status = "okay";
+		};
+
 		usb3_phy: phy at 12520000 {
 			status = "okay";
 		};
@@ -48,6 +53,15 @@
 			status = "okay";
 		};
 
+		gadget1: gadget at 12500000 {
+			status = "ok";
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
index b2dd549..28643fb 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -544,6 +544,25 @@
 
 		};
 
+		usb1_phy:phy at 12500000 {
+			compatible	= "qcom,usb-otg-ci";
+			reg		= <0x12500000 0x400>;
+			interrupts	= <0 100 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			dr_mode		= "host";
+
+			clocks		= <&gcc USB_HS1_XCVR_CLK>,
+					  <&gcc USB_HS1_H_CLK>;
+			clock-names	= "core", "iface";
+
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l4>;
+
+			resets		= <&gcc USB_HS1_RESET>;
+			reset-names	= "link";
+		};
+
 		usb3_phy:phy at 12520000 {
 			compatible	= "qcom,usb-otg-ci";
 			reg		= <0x12520000 0x400>;
@@ -582,6 +601,23 @@
 			reset-names	= "link";
 		};
 
+		gadget1:gadget at 12500000 {
+			compatible	= "qcom,ci-hdrc";
+			reg		= <0x12500000 0x400>;
+			status		= "disabled";
+			dr_mode		= "peripheral";
+			interrupts	= <0 100 IRQ_TYPE_NONE>;
+			usb-phy		= <&usb1_phy>;
+		};
+
+		usb1: usb at 12500000 {
+			compatible	= "qcom,ehci-host";
+			reg		= <0x12500000 0x400>;
+			interrupts	= <0 100 IRQ_TYPE_NONE>;
+			status		= "disabled";
+			usb-phy		= <&usb1_phy>;
+		};
+
 		usb3: usb at 12520000 {
 			compatible	= "qcom,ehci-host";
 			reg		= <0x12520000 0x400>;
-- 
1.9.1
