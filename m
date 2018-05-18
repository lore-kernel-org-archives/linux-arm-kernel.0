From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 17 May 2018 23:26:38 -0700
Subject: [PATCH v3 3/3] arm64: dts: qcom: msm8996: Add ufs related nodes
In-Reply-To: <20180518062638.31777-1-bjorn.andersson@linaro.org>
References: <20180518062638.31777-1-bjorn.andersson@linaro.org>
Message-ID: <20180518062638.31777-4-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the UFS QMP phy node and the UFS host controller node, now that we
have working UFS and the necessary clocks in place.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |  8 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 85 ++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 8be666ea92bd..00e3ecd1180a 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -122,6 +122,14 @@
 			status = "okay";
 		};
 
+		phy at 627000 {
+			status = "okay";
+		};
+
+		ufshc at 624000 {
+			status = "okay";
+		};
+
 		phy at 34000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 37b7152cb064..221bb3d383c5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -633,6 +633,91 @@
 			#interrupt-cells = <4>;
 		};
 
+		ufsphy: phy at 627000 {
+			compatible = "qcom,msm8996-ufs-phy-qmp-14nm";
+			reg = <0x627000 0xda8>;
+			reg-names = "phy_mem";
+			#phy-cells = <0>;
+
+			vdda-phy-supply = <&pm8994_l28>;
+			vdda-pll-supply = <&pm8994_l12>;
+
+			vdda-phy-max-microamp = <18380>;
+			vdda-pll-max-microamp = <9440>;
+
+			vddp-ref-clk-supply = <&pm8994_l25>;
+			vddp-ref-clk-max-microamp = <100>;
+			vddp-ref-clk-always-on;
+
+			clock-names = "ref_clk_src", "ref_clk";
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&gcc GCC_UFS_CLKREF_CLK>;
+			status = "disabled";
+
+			power-domains = <&gcc UFS_GDSC>;
+		};
+
+		ufshc at 624000 {
+			compatible = "qcom,ufshc";
+			reg = <0x624000 0x2500>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+
+			phys = <&ufsphy>;
+			phy-names = "ufsphy";
+
+			vcc-supply = <&pm8994_l20>;
+			vccq-supply = <&pm8994_l25>;
+			vccq2-supply = <&pm8994_s4>;
+
+			vcc-max-microamp = <600000>;
+			vccq-max-microamp = <450000>;
+			vccq2-max-microamp = <450000>;
+
+			clock-names =
+				"core_clk_src",
+				"core_clk",
+				"bus_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro_src",
+				"core_clk_unipro",
+				"core_clk_ice",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk";
+			clocks =
+				<&gcc UFS_AXI_CLK_SRC>,
+				<&gcc GCC_UFS_AXI_CLK>,
+				<&gcc GCC_SYS_NOC_UFS_AXI_CLK>,
+				<&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+				<&gcc GCC_UFS_AHB_CLK>,
+				<&gcc UFS_ICE_CORE_CLK_SRC>,
+				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
+				<&gcc GCC_UFS_ICE_CORE_CLK>,
+				<&rpmcc RPM_SMD_LN_BB_CLK>,
+				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
+			freq-table-hz =
+				<100000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<150000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			lanes-per-direction = <1>;
+			status = "disabled";
+
+			ufs_variant {
+				compatible = "qcom,ufs_variant";
+			};
+		};
+
 		mmcc: clock-controller at 8c0000 {
 			compatible = "qcom,mmcc-msm8996";
 			#clock-cells = <1>;
-- 
2.17.0
