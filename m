From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu,  4 Aug 2016 17:05:00 -0600
Subject: [PATCH v3 13/15] dt/bindings: Add PSCI OS-Initiated PM Domains
 bindings
In-Reply-To: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1470351902-43103-14-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings for defining a OS-Initiated based CPU PM domain.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/devicetree/bindings/arm/psci.txt | 64 ++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index a2c4f1d..e1b2926 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -105,7 +105,71 @@ Case 3: PSCI v0.2 and PSCI v0.1.
 		...
 	};
 
+PSCI v1.0 onwards, supports OS-Initiated mode for powering off CPU domains
+from the firmware. Such PM domains for which the PSCI firmware driver acts
+as pseudo-controller, may also be specified in the DT along with the domain
+idle states.
+
+The domain definitions must follow the domain idle state specifications per
+[3].
+
+The domain idle states must be specified using the optional node -
+
+- domain-states
+
+The domain states themselves must be compatible with 'arm,idle-state' defined
+in [1]  and need to specify the arm,psci-suspend-param property for each idle
+state. More information on defining CPU PM domains is available in [4].
+
+Example: OS-Iniated PSCI based PM domains
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
+			power-domains = <&CPU_PD>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD: cpu-pd at 0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
+		};
+
+		domain-states {
+			CLUSTER_RET: domain_ret {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWR_DWN: domain_gdhs {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+		};
+	};
+
+
 [1] Kernel documentation - ARM idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
 [2] Power State Coordination Interface (PSCI) specification
     http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
+[3]. PM Domains description
+    Documentation/devicetree/bindings/power/power_domain.txt
+[4]. CPU PM Domains description
+    Documentation/power/cpu_domains.txt
-- 
2.7.4
