From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 29 Sep 2014 10:15:27 +0100
Subject: [PATCH 3/4] ARM: DT: apq8064: Add USB OTG support
In-Reply-To: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1411982127-8048-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USB OTG support on USB1 of APQ8064 SOC.
Tested on IFC6410 with ethernet gadget.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 14 +++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 46 ++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index d6036b8..f41fb39 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -40,6 +40,11 @@
 			};
 		};
 
+		/* OTG */
+		usb1_phy:phy at 12500000 {
+			status = "ok";
+		};
+
 		usb3_phy:phy at 12520000 {
 			status = "ok";
 		};
@@ -48,6 +53,15 @@
 			status = "ok";
 		};
 
+		gadget1:gadget at 12500000 {
+			status = "ok";
+		};
+
+		/* OTG */
+		usb1: usb at 12500000 {
+			status = "ok";
+		};
+
 		usb3: usb at 12520000 {
 			status = "ok";
 		};
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 491a136..38d3efa 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -284,6 +284,16 @@
 				qcom,boot-load = <50000>;
 			};
 
+			pm8921_l4: pm8921-l4 {
+				compatible	= "qcom,rpm-pm8921-pldo";
+				reg		= <QCOM_RPM_PM8921_LDO4>;
+
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				qcom,boot-load = <50000>;
+			};
+
 			pm8921_l23: pm8921-l23 {
 				compatible	= "qcom,rpm-pm8921-pldo";
 				reg		= <QCOM_RPM_PM8921_LDO23>;
@@ -296,6 +306,25 @@
 
 		};
 
+		usb1_phy:phy at 12500000 {
+			compatible	= "qcom,usb-otg-ci";
+			reg		= <0x12500000 0x400>;
+			interrupts	= <0 100 0>;
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
@@ -334,6 +363,23 @@
 			reset-names	= "link";
 		};
 
+		gadget1:gadget at 12500000 {
+			compatible	= "qcom,ci-hdrc";
+			reg		= <0x12500000 0x400>;
+			status		= "disabled";
+			dr_mode		= "peripheral";
+			interrupts	= <0 100 0>;
+			usb-phy		= <&usb1_phy>;
+		};
+
+		usb1: usb at 12500000 {
+			compatible	= "qcom,ehci-host";
+			reg		= <0x12500000 0x400>;
+			interrupts	= <0 100 0>;
+			status		= "disabled";
+			usb-phy		= <&usb1_phy>;
+		};
+
 		usb3: usb at 12520000 {
 			compatible	= "qcom,ehci-host";
 			reg		= <0x12520000 0x400>;
-- 
1.9.1
