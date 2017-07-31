From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 31 Jul 2017 12:14:43 +0530
Subject: [PATCH 3/4] arm64: dts: msm8996: Add device node for qcom qmp-phy for
 pcie
In-Reply-To: <1501483484-2207-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1501483484-2207-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <1501483484-2207-4-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required device node for QMP phy based 3-lane PCIe phy
present on msm8996 chipset to enable support for the same.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |  4 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 62 ++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 2bab37594b5d..a493f797f9f1 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -89,6 +89,10 @@
 			status = "okay";
 		};
 
+		phy at 34000 {
+			status = "okay";
+		};
+
 		phy at 7410000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c0cdbdf49410..670af2b8d244 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -639,6 +639,68 @@
 			};
 		};
 
+		phy at 34000 {
+			compatible = "qcom,msm8996-qmp-pcie-phy";
+			reg = <0x34000 0x488>;
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				<&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			vdda-phy-supply = <&pm8994_l28>;
+			vdda-pll-supply = <&pm8994_l12>;
+
+			resets = <&gcc GCC_PCIE_PHY_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
+			reset-names = "phy", "common", "cfg";
+			status = "disabled";
+
+			pciephy_0: lane at 35000 {
+				reg = <0x035000 0x130>,
+					<0x035200 0x200>,
+					<0x035400 0x1dc>;
+				#phy-cells = <0>;
+
+				clock-output-names = "pcie_0_pipe_clk_src";
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+				resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+				reset-names = "lane0";
+			};
+
+			pciephy_1: lane at 36000 {
+				reg = <0x036000 0x130>,
+					<0x036200 0x200>,
+					<0x036400 0x1dc>;
+				#phy-cells = <0>;
+
+				clock-output-names = "pcie_1_pipe_clk_src";
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+				clock-names = "pipe1";
+				resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+				reset-names = "lane1";
+			};
+
+			pciephy_2: lane at 37000 {
+				reg = <0x037000 0x130>,
+					<0x037200 0x200>,
+					<0x037400 0x1dc>;
+				#phy-cells = <0>;
+
+				clock-output-names = "pcie_2_pipe_clk_src";
+				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
+				clock-names = "pipe2";
+				resets = <&gcc GCC_PCIE_2_PHY_BCR>;
+				reset-names = "lane2";
+			};
+		};
+
 		phy at 7410000 {
 			compatible = "qcom,msm8996-qmp-usb3-phy";
 			reg = <0x7410000 0x1c4>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
