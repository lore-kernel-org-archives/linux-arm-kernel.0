From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 14 Jun 2017 16:23:31 +0800
Subject: [PATCH v3 14/21] arm64: dts: hi3660: enable idle states
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Message-ID: <20170614082338.15673-15-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

On Hi3660 there have two clusters, one is CA53 cluster and another is
CA73 cluster. This two clusters have different idle states separately.
With Daniel Lezcano's patch (ARM: cpuidle: Support asymmetric idle
definition), now ARM idle driver can support different clusters with
different idle states.

Base on this, this patch is to bind two clusters idle states on Hi3660.
Except the "WFI" states are enabled by default for all CPUs, this patch
also binds below extra idle states:

- CA53 CPUs have two more states:
  CPU_SLEEP:       CPU power off state
  CLUSTER_SLEEP_0: Cluster power off state

- CA73 CPUs have three more states:
  CPU_NAP:         CPU retention state
  CPU_SLEEP:       CPU power off state
  CLUSTER_SLEEP_1: Cluster power off state

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kevin Wang <jean.wangtao@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 63 +++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index e138973..4101bf5 100644
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
