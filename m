From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Fri, 21 Oct 2016 16:19:19 -0700
Subject: [PATCH v3 4/4] arm64: dts: msm8996: Add SMP2P and APCS nodes
In-Reply-To: <1477091959-19580-1-git-send-email-spjoshi@codeaurora.org>
References: <1477091959-19580-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1477091959-19580-5-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SMP2P and APCS DT nodes required for Qualcomm ADSP
Peripheral Image Loader.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 60d2d20c..9e960c1 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -175,6 +175,30 @@
 		method = "smc";
 	};
 
+	adsp-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
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
 		memory-region = <&smem_mem>;
@@ -203,6 +227,11 @@
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
