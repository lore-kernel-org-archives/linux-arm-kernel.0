From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 1 Aug 2016 08:53:03 -0600
Subject: [PATCH v2 14/14] ARM64: dts: Define CPU power domain for MSM8916
In-Reply-To: <1469829385-11511-15-git-send-email-lina.iyer@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-15-git-send-email-lina.iyer@linaro.org>
Message-ID: <20160801145303.GH1369@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29 2016 at 15:57 -0600, Lina Iyer wrote:
>Define power domain and the power states for the domain as defined by
>the PSCI firmware. The 8916 firmware supports OS initiated method of
>powering off the CPU clusters.
>
>Cc: <devicetree@vger.kernel.org>
>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>---
> arch/arm64/boot/dts/qcom/msm8916.dtsi | 27 +++++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>index 3029773..d122fa1 100644
>--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>@@ -64,6 +64,7 @@
> 			next-level-cache = <&L2_0>;
> 			enable-method = "psci";
> 			cpu-idle-states = <&CPU_SPC>;
>+			power-domains = <&CPU_PD>;
> 		};
>
> 		CPU1: cpu at 1 {
>@@ -73,6 +74,7 @@
> 			next-level-cache = <&L2_0>;
> 			enable-method = "psci";
> 			cpu-idle-states = <&CPU_SPC>;
>+			power-domains = <&CPU_PD>;
> 		};
>
> 		CPU2: cpu at 2 {
>@@ -82,6 +84,7 @@
> 			next-level-cache = <&L2_0>;
> 			enable-method = "psci";
> 			cpu-idle-states = <&CPU_SPC>;
>+			power-domains = <&CPU_PD>;
> 		};
>
> 		CPU3: cpu at 3 {
>@@ -91,6 +94,7 @@
> 			next-level-cache = <&L2_0>;
> 			enable-method = "psci";
> 			cpu-idle-states = <&CPU_SPC>;
>+			power-domains = <&CPU_PD>;
> 		};
>
> 		L2_0: l2-cache {
>@@ -110,6 +114,29 @@
> 		};
> 	};
>
>+	CPU_PD: cpu-pd at 0 {
>+		#power-domain-cells = <0>;
>+		domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
>+	};
>+
>+	cpu-domain-states {
I think, these state nodes should be a child of the psci node.

Mark, do you think, that makes sense?

-- Lina
>+		CLUSTER_RET: domain_ret {
>+			compatible = "arm,idle-state";
>+			arm,psci-suspend-param = <0x1000010>;
>+			entry-latency-us = <500>;
>+			exit-latency-us = <500>;
>+			residency-us = <2000>;
>+		 };
>+
>+		CLUSTER_PWR_DWN: domain_gdhs {
>+			compatible = "arm,idle-state";
>+			arm,psci-suspend-param = <0x1000030>;
>+			entry-latency-us = <2000>;
>+			exit-latency-us = <2000>;
>+			residency-us = <6000>;
>+		};
>+	};
>+
> 	psci {
> 		compatible = "arm,psci-1.0";
> 		method = "smc";
>-- 
>2.7.4
>
