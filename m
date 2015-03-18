From: howard.chen@linaro.org (Howard Chen)
Date: Wed, 18 Mar 2015 14:00:32 +0800
Subject: [RFC] ARM: dts: mt8173: Add psci-0.2 cpuidle support
Message-ID: <1426658432-29333-1-git-send-email-howard.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add device tree for psci-0.2 on mt8173 platform
add device tree for cupidle-arm64 on mt8173 platform

Signed-off-by: Howard Chen <howard.chen@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 8554ec3..96dff1e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -48,6 +48,8 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x000>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
 		};
 
 		cpu1: cpu at 1 {
@@ -55,6 +57,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x001>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
 		};
 
 		cpu2: cpu at 100 {
@@ -62,6 +65,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
 		};
 
 		cpu3: cpu at 101 {
@@ -69,15 +73,33 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
 		};
+
+		idle-states {
+			entry-method = "arm,psci-0.2";
+
+			CPU_SLEEP_0_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <600>;
+				exit-latency-us = <600>;
+				min-residency-us = <1200>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1010000>;
+				entry-latency-us = <800>;
+				exit-latency-us = <1000>;
+				min-residency-us = <2000>;
+				wakeup-latency-us = <1000>;
+			};
 	};
 
 	psci {
-		compatible = "arm,psci";
+		compatible = "arm,psci-0.2";
 		method = "smc";
-		cpu_suspend   = <0x84000001>;
-		cpu_off	      = <0x84000002>;
-		cpu_on	      = <0x84000003>;
 	};
 
 	uart_clk: dummy26m {
-- 
1.9.1
