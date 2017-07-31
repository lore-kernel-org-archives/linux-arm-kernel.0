From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 31 Jul 2017 12:14:44 +0530
Subject: [PATCH 4/4] arm64: dts: msm8996: Add device node for qcom,dwc3
In-Reply-To: <1501483484-2207-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1501483484-2207-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <1501483484-2207-5-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding required device node for couple of DWC3 controllers
present on msm8996 chipset to enable High speed and Super
speed USB support.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    | 24 +++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       | 34 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 57 ++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
index b1142c45fdc9..8e379782597a 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
@@ -24,4 +24,28 @@
 			power-source = <PM8994_GPIO_S4>; // 1.8V
 		};
 	};
+
+	usb3_vbus_det_gpio: pm8996_gpio22 {
+		pinconf {
+			pins = "gpio22";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
+};
+
+&pmi8994_gpios {
+	usb2_vbus_det_gpio: pmi8996_gpio6 {
+		pinconf {
+			pins = "gpio6";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index a493f797f9f1..271624f567be 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -13,6 +13,7 @@
 
 #include "msm8996.dtsi"
 #include "pm8994.dtsi"
+#include "pmi8994.dtsi"
 #include "apq8096-db820c-pins.dtsi"
 #include "apq8096-db820c-pmic-pins.dtsi"
 #include <dt-bindings/input/input.h>
@@ -104,6 +105,39 @@
 		phy at 7412000 {
 			status = "okay";
 		};
+
+		usb at 6a00000 {
+			status = "okay";
+
+			dwc3 at 6a00000 {
+				extcon = <&usb3_id>;
+				dr_mode = "otg";
+			};
+		};
+
+		usb3_id: usb3-id {
+			compatible = "linux,extcon-usb-gpio";
+			id-gpio = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb3_vbus_det_gpio>;
+		};
+
+		usb at 7600000 {
+			status = "okay";
+
+			dwc3 at 7600000 {
+				extcon = <&usb2_id>;
+				dr_mode = "otg";
+				maximum-speed = "high-speed";
+			};
+		};
+
+		usb2_id: usb2-id {
+			compatible = "linux,extcon-usb-gpio";
+			id-gpio = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb2_vbus_det_gpio>;
+		};
 	};
 
 
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 670af2b8d244..bfe7b9723247 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -767,6 +767,63 @@
 			nvmem-cells = <&qusb2s_hstx_trim>;
 			status = "disabled";
 		};
+
+		usb2: usb at 7600000 {
+			compatible = "qcom,dwc3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
+				<&gcc GCC_USB20_MASTER_CLK>,
+				<&gcc GCC_USB20_MOCK_UTMI_CLK>,
+				<&gcc GCC_USB20_SLEEP_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>;
+
+			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB20_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <60000000>;
+
+			power-domains = <&gcc USB30_GDSC>;
+			status = "disabled";
+
+			dwc3 at 7600000 {
+				compatible = "snps,dwc3";
+				reg = <0x7600000 0xcc00>;
+				interrupts = <0 138 0>;
+				phys = <&hsusb_phy2>;
+				phy-names = "usb2-phy";
+			};
+		};
+
+		usb3: usb at 6a00000 {
+			compatible = "qcom,dwc3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
+				<&gcc GCC_USB30_MASTER_CLK>,
+				<&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+				<&gcc GCC_USB30_MOCK_UTMI_CLK>,
+				<&gcc GCC_USB30_SLEEP_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>;
+
+			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <120000000>;
+
+			power-domains = <&gcc USB30_GDSC>;
+			status = "disabled";
+
+			dwc3 at 6a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x6a00000 0xcc00>;
+				interrupts = <0 131 0>;
+				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
 	};
 
 	adsp-pil {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
