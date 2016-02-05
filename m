From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri,  5 Feb 2016 19:01:20 +0000
Subject: [PATCH 2/6] arm64: dts: qcom: apq8016-sbc: add usb support
In-Reply-To: <1454698819-13885-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454698819-13885-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1454698880-13973-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds usb otg support on DB410C.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi | 15 ++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          | 35 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
index cbeee0b..4a79dd9 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
@@ -10,4 +10,19 @@
 			output-low;
 		};
 	};
+
+	usb_id_default: usb_id_default {
+		pinmux {
+			function = "gpio";
+			pins = "gpio121";
+		};
+
+		pinconf {
+			pins = "gpio121";
+			function = "gpio";
+			drive-strength = <8>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 9a6c595..e80bdc2 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -151,6 +151,41 @@
 			cd-gpios = <&msmgpio 38 0x1>;
 			status = "okay";
 		};
+
+		usb at 78d9000 {
+			extcon = <&usb_id>, <&usb_id>;
+			status = "okay";
+		};
+
+		usb2513 {
+			compatible = "smsc,usb3503";
+			reset-gpios = <&pm8916_gpios 3 GPIO_ACTIVE_LOW>;
+			initial-mode = <1>;
+		};
+
+		usb_id: usb-id {
+			interrupt-parent = <&msmgpio>;
+			compatible = "linux,extcon-usb-gpio";
+			id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb_id_default>;
+		};
+
+		ehci at 78d9000 {
+			status = "okay";
+		};
+
+		phy at 78d9000 {
+			v1p8-supply = <&pm8916_l7>;
+			v3p3-supply = <&pm8916_l13>;
+			vddcx-supply = <&pm8916_s1>;
+			extcon = <&usb_id>, <&usb_id>;
+			dr_mode = "otg";
+			status = "okay";
+			switch-gpio = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb_sw_sel_pm>;
+		};
 	};
 };
 
-- 
1.9.1
