From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  8 Apr 2014 18:25:51 -0700
Subject: [PATCH 1/2] ARM: dts: msm: Add 8921 PMIC to ssbi bus
Message-ID: <1397006752-19494-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PMIC and the sub-devices that are currently supported in
the kernel to the DT.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 16 +++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi    | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index a58fb88315f6..6f61c54a653e 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -1,6 +1,22 @@
+#include <dt-bindings/input/input.h>
+
 #include "qcom-msm8960.dtsi"
 
 / {
 	model = "Qualcomm MSM8960 CDP";
 	compatible = "qcom,msm8960-cdp", "qcom,msm8960";
+
+};
+
+&pmicintc {
+	keypad at 148 {
+		linux,keymap = <
+			MATRIX_KEY(0, 0, KEY_VOLUMEUP)
+			MATRIX_KEY(0, 1, KEY_VOLUMEDOWN)
+			MATRIX_KEY(0, 2, KEY_CAMERA_FOCUS)
+			MATRIX_KEY(0, 3, KEY_CAMERA)
+			>;
+		keypad,num-rows = <1>;
+		keypad,num-columns = <5>;
+	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 997b7b94e117..fb7d3beece6d 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -124,6 +124,43 @@
 		compatible = "qcom,ssbi";
 		reg = <0x500000 0x1000>;
 		qcom,controller-type = "pmic-arbiter";
+
+		pmicintc: pmic at 0 {
+			compatible = "qcom,pm8921";
+			interrupt-parent = <&msmgpio>;
+			interrupts = <104 8>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pwrkey at 1c {
+				compatible = "qcom,pm8921-pwrkey";
+				reg = <0x1c>;
+				interrupt-parent = <&pmicintc>;
+				interrupts = <50 1>, <51 1>;
+				debounce = <15625>;
+				pull-up;
+			};
+
+			keypad at 148 {
+				compatible = "qcom,pm8921-keypad";
+				reg = <0x148>;
+				interrupt-parent = <&pmicintc>;
+				interrupts = <74 1>, <75 1>;
+				debounce = <15>;
+				scan-delay = <32>;
+				row-hold = <91500>;
+			};
+
+			rtc at 11d {
+				compatible = "qcom,pm8921-rtc";
+				interrupt-parent = <&pmicintc>;
+				interrupts = <39 1>;
+				reg = <0x11d>;
+				allow-set-time;
+			};
+		};
 	};
 
 	rng at 1a500000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
