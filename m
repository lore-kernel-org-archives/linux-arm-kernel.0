From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon,  6 Jun 2016 17:57:23 -0700
Subject: [PATCH] ARM: dts: msm8916: Add smsm and smp2p nodes
Message-ID: <1465261044-2762-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the smsm and smp2p nodes for the hexagon and wcnss
cores.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 82 +++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 3ca609a11648..30c448909727 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -620,6 +620,88 @@
 			};
 		};
 	};
+
+	hexagon-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <0 27 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		hexagon_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,state-cells = <1>;
+		};
+
+		hexagon_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	wcnss-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <451>, <431>;
+
+		interrupts = <0 143 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 18>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <4>;
+
+		wcnss_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,state-cells = <1>;
+		};
+
+		wcnss_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smsm {
+		compatible = "qcom,smsm";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		qcom,ipc-1 = <&apcs 0 13>;
+		qcom,ipc-6 = <&apcs 0 19>;
+
+		apps_smsm: apps at 0 {
+			reg = <0>;
+
+			#qcom,state-cells = <1>;
+		};
+
+		hexagon_smsm: hexagon at 1 {
+			reg = <1>;
+			interrupts = <0 26 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		wcnss_smsm: wcnss at 6 {
+			reg = <6>;
+			interrupts = <0 144 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
 };
 
 #include "msm8916-pins.dtsi"
-- 
2.5.0
