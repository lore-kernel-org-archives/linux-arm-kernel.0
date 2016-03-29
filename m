From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 18:32:36 -0700
Subject: [PATCH 1/4] ARM: dts: qcom: msm8974: Add USB gadget nodes
Message-ID: <1459215159-2576-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Add the necessary nodes for USB gadget on MSM8974 and enable these for
Honami.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |  8 +++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 38 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index a0398b69f4f2..453eede25a43 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -367,6 +367,14 @@
 		};
 
 	};
+
+	usb-phy at f9a55000 {
+		status = "ok";
+	};
+
+	usb at f9a55000 {
+		status = "ok";
+	};
 };
 
 &spmi_bus {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index ef5330578431..927075137b76 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -489,6 +489,44 @@
 			#dma-cells = <1>;
 			qcom,ee = <0>;
 		};
+
+		usb1_phy: usb-phy at f9a55000 {
+			compatible = "qcom,usb-otg-snps";
+
+			reg = <0xf9a55000 0x400>;
+			interrupts-extended = <&intc 0 134 0>, <&intc 0 140 0>,
+				<&spmi_bus 0 0x9 0 0>;
+			interrupt-names = "core_irq", "async_irq", "pmic_id_irq";
+
+			vddcx-supply = <&pm8841_s2>;
+			v3p3-supply = <&pm8941_l24>;
+			v1p8-supply = <&pm8941_l6>;
+
+			dr_mode = "otg";
+			qcom,phy-init-sequence = <0x63 0x81 0xfffffff>;
+			qcom,otg-control = <1>;
+			qcom,phy-num = <0>;
+
+			resets = <&gcc GCC_USB2A_PHY_BCR>, <&gcc GCC_USB_HS_BCR>;
+			reset-names = "phy", "link";
+
+			clocks = <&gcc GCC_XO_CLK>, <&gcc GCC_USB_HS_SYSTEM_CLK>,
+				<&gcc GCC_USB_HS_AHB_CLK>;
+			clock-names = "phy", "core", "iface";
+
+			status = "disabled";
+		};
+
+		usb at f9a55000 {
+			compatible = "qcom,ci-hdrc";
+			reg = <0xf9a55000 0x400>;
+			dr_mode = "otg";
+			interrupts = <0 134 0>, <0 140 0>;
+			interrupt-names = "core_irq", "async_irq";
+			usb-phy = <&usb1_phy>;
+
+			status = "disabled";
+		};
 	};
 
 	smd {
-- 
2.5.0
