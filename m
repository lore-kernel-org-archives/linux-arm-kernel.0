From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri,  2 Mar 2018 14:56:38 -0700
Subject: [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
In-Reply-To: <20180302215638.6145-1-jcrouse@codeaurora.org>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
Message-ID: <20180302215638.6145-3-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the nodes and other bits to describe the Adreno GPU and GMU
devices.

Change-Id: Ibf4dc0ebb0ac03d8b6b8e65747e142c440e70b0a
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 120 +++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 7b5c16eb63b7..cc6d367ee55e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -312,5 +312,125 @@
 				status = "disabled";
 			};
 		};
+
+		adreno_smmu: arm,smmu-adreno at 5040000 {
+			compatible = "qcom,msm8996-smmu-v2";
+			reg = <0x5040000 0x10000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <2>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clock_gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&clock_gcc GCC_GPU_CFG_AHB_CLK>;
+			clock-names = "bus", "iface";
+
+			power-domains = <&clock_gpucc GPU_CX_GDSC>;
+		};
+
+		gpu_opp_table: adreno-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-710000000 {
+				opp-hz = /bits/ 64 <710000000>;
+				qcom,arc-level = <416>;
+			};
+
+			opp-675000000 {
+				opp-hz = /bits/ 64 <675000000>;
+				qcom,arc-level = <384>;
+			};
+
+			opp-596000000 {
+				opp-hz = /bits/ 64 <596000000>;
+				qcom,arc-level = <320>;
+			};
+
+			opp-520000000 {
+				opp-hz = /bits/ 64 <520000000>;
+				qcom,arc-level = <256>;
+			};
+
+			opp-414000000 {
+				opp-hz = /bits/ 64 <414000000>;
+				qcom,arc-level = <192>;
+			};
+
+			opp-342000000 {
+				opp-hz = /bits/ 64 <342000000>;
+				qcom,arc-level = <128>;
+			};
+
+			opp-257000000 {
+				opp-hz = /bits/ 64 <257000000>;
+				qcom,arc-level = <64>;
+			};
+		};
+
+		gpu at 5000000 {
+			compatible = "qcom,adreno-630.2", "qcom,adreno";
+			#stream-id-cells = <16>;
+
+			reg = <0x5000000 0x40000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			/*
+			 * Look ma, no clocks! The GPU clocks and power are
+			 * controlled entirely by the GMU
+			 */
+
+			interrupts = <GCI_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "kgsl_3d0_irq";
+
+			iommus = <&adreno_smmu 0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			gmu = <&gmu>;
+		};
+
+		gmu_opp_table: adreno-gmu-opp-table {
+			compatible = "operating-points-v2";
+
+			opp-400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				qcom,arc-level = <128>;
+			};
+
+			opp-200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+				qcom,arc-level = <48>;
+			};
+		};
+
+		gmu: gmu at 506a000 {
+			compatible="qcom,adreno-gmu";
+
+			reg = <0x506a000 0x30000>,
+			      <0xb200000 0x300000>;
+			reg-names = "gmu", "gmu_pdc";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&clock_gpucc GPU_CC_CX_GMU_CLK>,
+				 <&clock_gpucc GPU_CC_CXO_CLK>,
+				 <&clock_gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&clock_gcc GCC_GPU_MEMNOC_GFX_CLK>;
+			clock-names = "gmu", "cxo", "axi", "memnoc";
+
+			power-domains = <&clock_gpucc GPU_CX_GDSC>;
+			iommus = <&adreno_smmu 5>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+		};
 	};
 };
-- 
2.16.1
