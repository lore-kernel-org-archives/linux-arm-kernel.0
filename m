From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 29 Sep 2014 10:15:00 +0100
Subject: [PATCH 2/4] ARM: DT: apq8064: Add usb host support.
In-Reply-To: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1411982100-7964-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes to support two usb hosts on APQ8064
SOC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 16 ++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 85 ++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index b396c83..d6036b8 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -40,6 +40,22 @@
 			};
 		};
 
+		usb3_phy:phy at 12520000 {
+			status = "ok";
+		};
+
+		usb4_phy:phy at 12530000 {
+			status = "ok";
+		};
+
+		usb3: usb at 12520000 {
+			status = "ok";
+		};
+
+		usb4: usb at 12530000 {
+			status = "ok";
+		};
+
 		amba {
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 9c2c8e6..491a136 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -263,6 +263,91 @@
 			#address-cells	= <1>;
 			#size-cells	= <0>;
 
+			pm8921_s3: pm8921-s3 {
+				compatible	= "qcom,rpm-pm8921-smps";
+				reg		= <QCOM_RPM_PM8921_SMPS3>;
+
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1400000>;
+				qcom,boot-load 		= <49360>;
+				qcom,switch-mode-frequency = <3200000>;
+				regulator-always-on;
+			};
+
+			pm8921_l3: pm8921-l3 {
+				compatible	= "qcom,rpm-pm8921-pldo";
+				reg		= <QCOM_RPM_PM8921_LDO3>;
+
+				regulator-min-microvolt = <3050000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				qcom,boot-load = <50000>;
+			};
+
+			pm8921_l23: pm8921-l23 {
+				compatible	= "qcom,rpm-pm8921-pldo";
+				reg		= <QCOM_RPM_PM8921_LDO23>;
+
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1800000>;
+				qcom,boot-load = <50000>;
+				regulator-always-on;
+			};
+
+		};
+
+		usb3_phy:phy at 12520000 {
+			compatible	= "qcom,usb-otg-ci";
+			reg		= <0x12520000 0x400>;
+			interrupts	= <0 188 0>;
+			status		= "disabled";
+			dr_mode		= "host";
+
+			clocks		= <&gcc USB_HS3_XCVR_CLK>,
+					  <&gcc USB_HS3_H_CLK>;
+			clock-names	= "core", "iface";
+
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+
+			resets		= <&gcc USB_HS3_RESET>;
+			reset-names	= "link";
+		};
+
+		usb4_phy:phy at 12530000 {
+			compatible	= "qcom,usb-otg-ci";
+			reg		= <0x12530000 0x400>;
+			interrupts	= <0 215 0>;
+			status		= "disabled";
+			dr_mode		= "host";
+
+			clocks		= <&gcc USB_HS4_XCVR_CLK>,
+					  <&gcc USB_HS4_H_CLK>;
+			clock-names	= "core", "iface";
+
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+
+			resets		= <&gcc USB_HS4_RESET>;
+			reset-names	= "link";
+		};
+
+		usb3: usb at 12520000 {
+			compatible	= "qcom,ehci-host";
+			reg		= <0x12520000 0x400>;
+			interrupts	= <0 188 0>;
+			status		= "disabled";
+			usb-phy		= <&usb3_phy>;
+		};
+
+		usb4: usb at 12530000 {
+			compatible	= "qcom,ehci-host";
+			reg		= <0x12530000 0x400>;
+			interrupts	= <0 215 0>;
+			status		= "disabled";
+			usb-phy		= <&usb4_phy>;
 		};
 
 		/* Temporary fixed regulator */
-- 
1.9.1
