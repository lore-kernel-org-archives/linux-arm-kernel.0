From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 18:32:39 -0700
Subject: [PATCH 4/4] ARM: dts: msm8974: Add modem smp2p and smd nodes
In-Reply-To: <1459215159-2576-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459215159-2576-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459215159-2576-4-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d872ddc2d190..79c9cfcabf77 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -168,6 +168,31 @@
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <0 27 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smp2p-wcnss {
 		compatible = "qcom,smp2p";
 		qcom,smem = <451>, <431>;
@@ -548,6 +573,13 @@
 	smd {
 		compatible = "qcom,smd";
 
+		modem {
+			interrupts = <0 25 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,ipc = <&apcs 8 12>;
+			qcom,smd-edge = <0>;
+		};
+
 		rpm {
 			interrupts = <0 168 1>;
 			qcom,ipc = <&apcs 8 0>;
-- 
2.5.0
