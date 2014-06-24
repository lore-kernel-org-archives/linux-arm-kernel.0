From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Jun 2014 14:03:53 -0700
Subject: [PATCH v2 1/2] ARM: dts: msm: Add 8921 PMIC to ssbi bus
Message-ID: <1403643834-4484-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PMIC and the sub-devices that are currently supported in
the kernel to the DT.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 15 ++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi    | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index 8f75cc4c8340..8b10812c0cda 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -1,3 +1,5 @@
+#include <dt-bindings/input/input.h>
+
 #include "qcom-msm8960.dtsi"
 
 / {
@@ -14,3 +16,16 @@
 		};
 	};
 };
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
+};
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 5303e53e34dc..2f677247744d 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -143,6 +143,43 @@
 			compatible = "qcom,ssbi";
 			reg = <0x500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
+
+			pmicintc: pmic at 0 {
+				compatible = "qcom,pm8921";
+				interrupt-parent = <&msmgpio>;
+				interrupts = <104 8>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pwrkey at 1c {
+					compatible = "qcom,pm8921-pwrkey";
+					reg = <0x1c>;
+					interrupt-parent = <&pmicintc>;
+					interrupts = <50 1>, <51 1>;
+					debounce = <15625>;
+					pull-up;
+				};
+
+				keypad at 148 {
+					compatible = "qcom,pm8921-keypad";
+					reg = <0x148>;
+					interrupt-parent = <&pmicintc>;
+					interrupts = <74 1>, <75 1>;
+					debounce = <15>;
+					scan-delay = <32>;
+					row-hold = <91500>;
+				};
+
+				rtc at 11d {
+					compatible = "qcom,pm8921-rtc";
+					interrupt-parent = <&pmicintc>;
+					interrupts = <39 1>;
+					reg = <0x11d>;
+					allow-set-time;
+				};
+			};
 		};
 
 		rng at 1a500000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
