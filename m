From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon, 14 Aug 2017 17:50:40 +0800
Subject: [PATCH v3 01/10] arm64: dts: hi3660: enable idle states
In-Reply-To: <20170814095049.27701-1-guodong.xu@linaro.org>
References: <20170814095049.27701-1-guodong.xu@linaro.org>
Message-ID: <20170814095049.27701-2-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

There are two clusters on the Hi3660, the first one is Cortex-A53 based
and the other one is Cortex-A73 based. These two clusters have different
idle states.

Thanks to Daniel Lezcano's recent changes, the generic ARM cpuidle
driver can now support several clusters with different idle states, thus
supporting the big.Little architecture.

In addition to the WFI idle state which is the default shallowest state
for all ARM cpus, the Hi3660 supports the following states:

 - CA53 CPUs:
        - CPU_SLEEP:       CPU power off state
        - CLUSTER_SLEEP_0: Cluster power off state

 - CA73 CPUs:
        - CPU_NAP:         CPU retention state
        - CPU_SLEEP:       CPU power off state
        - CLUSTER_SLEEP_1: Cluster power off state

This patch adds the idle states description for the Hi3660 to the device
tree.

Cc: Kevin Wang <jean.wangtao@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 63 +++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index c6a1961..8921310 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -58,6 +58,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
 		cpu1: cpu at 1 {
@@ -65,6 +66,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
 		cpu2: cpu at 2 {
@@ -72,6 +74,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
 		cpu3: cpu at 3 {
@@ -79,6 +82,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 		};
 
 		cpu4: cpu at 100 {
@@ -86,6 +90,11 @@
 			device_type = "cpu";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <
+					&CPU_NAP
+					&CPU_SLEEP
+					&CLUSTER_SLEEP_1
+			>;
 		};
 
 		cpu5: cpu at 101 {
@@ -93,6 +102,11 @@
 			device_type = "cpu";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <
+					&CPU_NAP
+					&CPU_SLEEP
+					&CLUSTER_SLEEP_1
+			>;
 		};
 
 		cpu6: cpu at 102 {
@@ -100,6 +114,11 @@
 			device_type = "cpu";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			cpu-idle-states = <
+					&CPU_NAP
+					&CPU_SLEEP
+					&CLUSTER_SLEEP_1
+			>;
 		};
 
 		cpu7: cpu at 103 {
@@ -107,6 +126,50 @@
 			device_type = "cpu";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			cpu-idle-states = <
+					&CPU_NAP
+					&CPU_SLEEP
+					&CLUSTER_SLEEP_1
+			>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_NAP: cpu-nap {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0000001>;
+				entry-latency-us = <7>;
+				exit-latency-us = <2>;
+				min-residency-us = <15>;
+			};
+
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <40>;
+				exit-latency-us = <70>;
+				min-residency-us = <3000>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x1010000>;
+				entry-latency-us = <500>;
+				exit-latency-us = <5000>;
+				min-residency-us = <20000>;
+			};
+
+			CLUSTER_SLEEP_1: cluster-sleep-1 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x1010000>;
+				entry-latency-us = <1000>;
+				exit-latency-us = <5000>;
+				min-residency-us = <20000>;
+			};
 		};
 	};
 
-- 
2.10.2
