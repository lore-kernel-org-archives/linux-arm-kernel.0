From: yossim@codeaurora.org (Yossi Mansharoff)
Date: Tue, 17 Apr 2018 16:56:30 +0300
Subject: [PATCH v2] arm64: dts: qcom: Collapse usb support into one node
Message-ID: <1523973390-2387-1-git-send-email-yossim@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently have three device nodes for the same USB hardware
block, as evident by the reuse of the same reg address multiple
times. Now that the chipidea driver fully supports OTG with the
MSM wrapper we can collapse all these nodes into one USB device
node, reflecting the true nature of the hardware.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 9ff8487..1505921 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/sound/apq8016-lpass.h>
+#include <dt-bindings/mux/mux.h>
 
 /*
  * GPIO name legend: proper name = the GPIO line is used as GPIO
@@ -371,18 +372,18 @@
 			adp-disable;
 			hnp-disable;
 			srp-disable;
-			dr_mode = "host";
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb_sw_sel_pm>;
+			mux-controls = <&usb_switch>;
+			mux-control-names = "usb_switch";
+
 			ulpi {
 				phy {
 					v1p8-supply = <&pm8916_l7>;
 					v3p3-supply = <&pm8916_l13>;
-					extcon = <&usb_id>;
 				};
 			};
 		};
 
+
 		lpass at 7708000 {
 			status = "okay";
 		};
@@ -512,11 +513,17 @@
 
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
-		vbus-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
+		id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb_id_default>;
 	};
 
+	usb_switch: usb-switch {
+		compatible = "gpio-mux";
+		mux-gpios = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>;
+		#mux-control-cells = <0>;
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
