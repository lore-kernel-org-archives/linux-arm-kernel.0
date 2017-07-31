From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 31 Jul 2017 12:14:42 +0530
Subject: [PATCH 2/4] arm64: dts: msm8996: Add device node for qcom qmp-phy for
 usb
In-Reply-To: <1501483484-2207-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1501483484-2207-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <1501483484-2207-3-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding required device node for USB3 QMP phy present on
msm8996 chipset to enable support for the same. This phy
provides super speed usb functionality for dwc3 controller
on msm8996.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |  4 ++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 33 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 4476e9238150..2bab37594b5d 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -89,6 +89,10 @@
 			status = "okay";
 		};
 
+		phy at 7410000 {
+			status = "okay";
+		};
+
 		phy at 7411000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 019ec9345dbc..c0cdbdf49410 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -639,6 +639,39 @@
 			};
 		};
 
+		phy at 7410000 {
+			compatible = "qcom,msm8996-qmp-usb3-phy";
+			reg = <0x7410000 0x1c4>;
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_USB3_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			vdda-phy-supply = <&pm8994_l28>;
+			vdda-pll-supply = <&pm8994_l12>;
+
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				<&gcc GCC_USB3PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+			status = "disabled";
+
+			ssusb_phy_0: lane at 7410200 {
+				reg = <0x7410200 0x200>,
+					<0x7410400 0x130>,
+					<0x7410600 0x1a8>;
+				#phy-cells = <0>;
+
+				clock-output-names = "usb3_phy_pipe_clk_src";
+				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+			};
+		};
+
 		hsusb_phy1: phy at 7411000 {
 			compatible = "qcom,msm8996-qusb2-phy";
 			reg = <0x7411000 0x180>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
