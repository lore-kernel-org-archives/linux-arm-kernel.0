From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 26 Aug 2016 14:17:58 -0600
Subject: [PATCH v5 16/16] ARM64: dts: Define CPU power domain for MSM8916
In-Reply-To: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1472242678-33700-17-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define power domain and the power states for the domain as defined by
the PSCI firmware. The 8916 firmware supports OS initiated method of
powering off the CPU clusters.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 11bdc24..e6d8c3b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -99,6 +99,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU1: cpu at 1 {
@@ -108,6 +109,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU2: cpu at 2 {
@@ -117,6 +119,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU3: cpu at 3 {
@@ -126,6 +129,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		L2_0: l2-cache {
@@ -142,12 +146,33 @@
 				min-residency-us = <2000>;
 				local-timer-stop;
 			};
+
+			CLUSTER_RET: cluster_retention {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWR_DWN: cluster_gdhs {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
 		};
 	};
 
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD: cpu-pd at 0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
+		};
 	};
 
 	pmu {
-- 
2.7.4
