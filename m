From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  9 Jan 2018 12:55:13 +0100
Subject: [PATCH v3] dt: psci: Update DT bindings to support hierarchical PSCI
 states
Message-ID: <1515498913-24291-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lina Iyer <lina.iyer@linaro.org>

Update DT bindings to represent hierarchical CPU and CPU domain idle states
for PSCI. Also update the PSCI examples to clearly show how flattened and
hierarchical idle states can be represented in DT.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Added Rob's reviewed-by-tag.
	- Addressed comments from Sudeep. 

Changes in v2:
        - Addressed comments from Rob.
        - Updated some labels in the examples to get more consistency.

For your information, I have picked up the work from Lina Iyer around the so
called CPU cluster idling series [1,2] and I working on new versions. However,
I decided to post the updates to the PSCI DT bindings first, as they will be
needed to be agreed upon before further changes can be done to the PSCI
firmware driver.

Note, these bindings have been discussed over and over again, at LKML, but
especially also at various Linux conferences, like LPC and Linaro Connect. We
finally came to a conclusion and the changes we agreed upon, should be
reflected in this update.

Of course, it's a while ago since the latest discussions, but hopefully people
don't have too hard time to remember.

Kind regards
Uffe

[1]
https://www.spinics.net/lists/arm-kernel/msg566200.html

[2]
https://lwn.net/Articles/716300/

---
 Documentation/devicetree/bindings/arm/psci.txt | 156 +++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index a2c4f1d..17aa3d3 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -105,7 +105,163 @@ Case 3: PSCI v0.2 and PSCI v0.1.
 		...
 	};
 
+ARM systems can have multiple cores sometimes in hierarchical arrangement.
+This often, but not always, maps directly to the processor power topology of
+the system. Individual nodes in a topology have their own specific power states
+and can be better represented in DT hierarchically.
+
+For these cases, the definitions of the idle states for the CPUs and the CPU
+topology, must conform to the domain idle state specification [3]. The domain
+idle states themselves, must be compatible with the defined 'domain-idle-state'
+binding [1], and also need to specify the arm,psci-suspend-param property for
+each idle state.
+
+DT allows representing CPUs and CPU idle states in two different ways -
+
+The flattened model as given in Example 1, lists CPU's idle states followed by
+the domain idle state that the CPUs may choose. Note that the idle states are
+all compatible with "arm,idle-state".
+
+Example 2 represents the hierarchical model of CPUs and domain idle states.
+CPUs define their domain provider in their psci DT node. The domain controls
+the power to the CPU and possibly other h/w blocks that would enter an idle
+state along with the CPU. The CPU's idle states may therefore be considered as
+the domain's idle states and have the compatible "arm,idle-state". Such domains
+may also be embedded within another domain that may represent common h/w blocks
+between these CPUs. The idle states of the CPU topology shall be represented as
+the domain's idle states.
+
+In PSCI firmware v1.0, the OS-Initiated mode is introduced. In order to use it,
+the hierarchical representation must be used.
+
+Example 1: Flattened representation of CPU and domain idle states
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>,
+					  <&CLUSTER_PWRDN>;
+		};
+
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>,
+					  <&CLUSTER_PWRDN>;
+		};
+
+		idle-states {
+			CPU_PWRDN: cpu-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x000001>;
+				entry-latency-us = <10>;
+				exit-latency-us = <10>;
+				min-residency-us = <100>;
+			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+Example 2: Hierarchical representation of CPU and domain idle states
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD0>;
+		};
+
+		CPU1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD1>;
+		};
+
+		idle-states {
+			CPU_PWRDN: cpu-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x000001>;
+				entry-latency-us = <10>;
+				exit-latency-us = <10>;
+				min-residency-us = <100>;
+			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-power-down {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CPU_PWRDN>;
+			power-domains = <&CLUSTER_PD>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&CPU_PWRDN>;
+			power-domains = <&CLUSTER_PD>;
+		};
+
+		CLUSTER_PD: cluster-pd {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+		};
+	};
+
 [1] Kernel documentation - ARM idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
 [2] Power State Coordination Interface (PSCI) specification
     http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
+[3]. PM Domains description
+    Documentation/devicetree/bindings/power/power_domain.txt
-- 
2.7.4
