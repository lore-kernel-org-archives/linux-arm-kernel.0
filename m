From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 12 Jul 2018 17:13:00 -0400
Subject: [PATCH v2 21/21] arm64: dts: qcom: sdm845: Add dpu to sdm845 dts file
In-Reply-To: <CAL_Jsq+OnWnJ2BtTOKfiAHRF=xuKhLJqtROYc5Er-n56PxTBLA@mail.gmail.com>
References: <CAL_Jsq+OnWnJ2BtTOKfiAHRF=xuKhLJqtROYc5Er-n56PxTBLA@mail.gmail.com>
Message-ID: <20180712211311.147851-1-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DPU is short for the Display Processing Unit. It is the display
controller on Qualcomm SDM845 chips.

While the dts is pretty sparse for sdm845 atm, the only piece
we're missing is the iommu. It's commented out for now, and should be
uncommented once support is provided.

Changes in v2:
 - Beefed up commit message
 - Use SoC specific compatibles for mdss and dpu
 - Use assigned-clocks to set initial clock frequency

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 200 +++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb3c995..f1f4cdc9cb63 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5,6 +5,8 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,dispcc-sdm845.h>
+#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -221,6 +223,204 @@
 			#interrupt-cells = <2>;
 		};
 
+		mdss: mdss at ae00000 {
+			compatible = "qcom,sdm845-mdss";
+			reg = <0xae00000 0x1000>;
+			reg-names = "mdss_phys";
+
+			power-domains = <&dispcc 0>;
+
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&gcc GCC_DISP_AXI_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+			clock-names = "iface", "bus", "core";
+
+			assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
+			assigned-clock-rates = <300000000>;
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			/* iommus = <&apps_iommu 0>; */
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			mdss_mdp: mdp at ae01000 {
+				compatible = "qcom,sdm845-dpu";
+				reg = <0x0ae01000 0x8f000>,
+				      <0x0aeb0000 0x2008>;
+				reg-names = "mdp_phys", "vbif_phys";
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_AXI_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "iface", "bus", "core", "vsync";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
+						  <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <300000000>,
+						       <19200000>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 0 {
+						reg = <0>;
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&dsi0_in>;
+						};
+					};
+
+					port at 1 {
+						reg = <1>;
+						dpu_intf2_out: endpoint {
+							remote-endpoint = <&dsi1_in>;
+						};
+					};
+				};
+			};
+
+			dsi0: dsi at ae94000 {
+				compatible = "qcom,mdss-dsi-ctrl";
+				reg = <0xae94000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4 0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_AXI_CLK>;
+				clock-names = "byte_clk",
+					      "byte_intf_clk",
+					      "pixel_clk",
+					      "core_clk",
+					      "iface_clk",
+					      "bus_clk";
+
+				phys = <&dsi0_phy>;
+				phy-names = "dsi-phy";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 0 {
+						reg = <0>;
+						dsi0_in: endpoint {
+							remote-endpoint = <&dpu_intf1_out>;
+						};
+					};
+
+					port at 1 {
+						reg = <1>;
+						dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi0_phy: dsi-phy at ae94400 {
+				compatible = "qcom,dsi-phy-10nm";
+				reg = <0xae94400 0x200>,
+				      <0xae94a00 0x1e0>,
+				      <0xae94600 0x280>;
+				reg-names = "dsi_phy",
+					    "dsi_pll",
+					    "dsi_phy_lane";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>;
+				clock-names = "iface_clk";
+			};
+
+			dsi1: dsi at ae96000 {
+				compatible = "qcom,mdss-dsi-ctrl";
+				reg = <0xae96000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <5 0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK1_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC1_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_AXI_CLK>;
+				clock-names = "byte_clk",
+					      "byte_intf_clk",
+					      "pixel_clk",
+					      "core_clk",
+					      "iface_clk",
+					      "bus_clk";
+
+				phys = <&dsi1_phy>;
+				phy-names = "dsi-phy";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 0 {
+						reg = <0>;
+						dsi1_in: endpoint {
+							remote-endpoint = <&dpu_intf2_out>;
+						};
+					};
+
+					port at 1 {
+						reg = <1>;
+						dsi1_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi1_phy: dsi-phy at ae96400 {
+				compatible = "qcom,dsi-phy-10nm";
+				reg = <0xae96400 0x200>,
+				      <0xae96a00 0x10e>,
+				      <0xae96600 0x280>;
+				reg-names = "dsi_phy",
+					    "dsi_pll",
+					    "dsi_phy_lane";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>;
+				clock-names = "iface_clk";
+			};
+		};
+
+		dispcc: qcom,dispcc at af00000 {
+			compatible = "qcom,sdm845-dispcc";
+			reg = <0xaf00000 0x10000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi at c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
Sean Paul, Software Engineer, Google / Chromium OS
