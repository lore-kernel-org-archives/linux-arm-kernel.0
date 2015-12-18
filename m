From: fan.chen@mediatek.com (Fan Chen)
Date: Fri, 18 Dec 2015 10:42:31 +0800
Subject: [PATCH 4/4] arm64: dts: mediatek: Improve cpuidle latency on MT8173
In-Reply-To: <1450406551-1741-1-git-send-email-fan.chen@mediatek.com>
References: <1450406551-1741-1-git-send-email-fan.chen@mediatek.com>
Message-ID: <1450406551-1741-5-git-send-email-fan.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

All according to the exact profiling result:
First, each CPU cluster needs its own nodes due to the latency gap
between each other.
Second, tune the parameters to enter the lowest idle state as much time
as possible without disturbing the system performance for
power-saving demand.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   34 +++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 77c1f84..0ae3983 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -69,7 +69,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x100>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
 		};
 
 		cpu3: cpu at 101 {
@@ -77,7 +77,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x101>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_1 &CLUSTER_SLEEP_1>;
 		};
 
 		idle-states {
@@ -86,18 +86,36 @@
 			CPU_SLEEP_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
 				local-timer-stop;
-				entry-latency-us = <639>;
-				exit-latency-us = <680>;
-				min-residency-us = <1088>;
+				entry-latency-us = <72>;
+				exit-latency-us = <66>;
+				min-residency-us = <458>;
 				arm,psci-suspend-param = <0x0010000>;
 			};
 
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
 				compatible = "arm,idle-state";
 				local-timer-stop;
-				entry-latency-us = <800>;
-				exit-latency-us = <1000>;
-				min-residency-us = <2000>;
+				entry-latency-us = <145>;
+				exit-latency-us = <60>;
+				min-residency-us = <331>;
+				arm,psci-suspend-param = <0x1010000>;
+			};
+
+			CPU_SLEEP_1: cpu-sleep-1 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <72>;
+				exit-latency-us = <66>;
+				min-residency-us = <516>;
+				arm,psci-suspend-param = <0x0010000>;
+			};
+
+			CLUSTER_SLEEP_1: cluster-sleep-1 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <287>;
+				exit-latency-us = <62>;
+				min-residency-us = <1423>;
 				arm,psci-suspend-param = <0x1010000>;
 			};
 		};
-- 
1.7.9.5
