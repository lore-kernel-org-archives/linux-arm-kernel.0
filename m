From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu, 20 Oct 2016 11:56:05 -0700
Subject: [PATCH 4/4] arm64: dts: msm8996: Add SMP2P and APCS nodes
In-Reply-To: <1476989765-7524-1-git-send-email-spjoshi@codeaurora.org>
References: <1476989765-7524-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1476989765-7524-4-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SMP2P and APCS DT nodes required for Qualcomm ADSP
Peripheral Image Loader.

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0a810f5..3edb56b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -169,6 +169,31 @@
 		method = "smc";
 	};
 
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <0 158 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 16 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,state-cells = <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smem {
 		compatible = "qcom,smem";
 
@@ -205,6 +230,11 @@
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		apcs: syscon at 9820000 {
+			compatible = "syscon";
+			reg = <0x9820000 0x1000>;
+		};
+
 		gcc: clock-controller at 300000 {
 			compatible = "qcom,gcc-msm8996";
 			#clock-cells = <1>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
