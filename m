From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 6 Oct 2017 16:09:53 +0800
Subject: [PATCH v2] arm64: dts: mediatek: Add cpuidle support for MT2712
Message-ID: <1507277393-30356-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPU idle state nodes to enable C1/C2 idle states.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---

changes since v1:
- Rebase to 4.14-rc1.

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 57d0396..5d4e406 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -39,6 +39,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a35";
 			reg = <0x000>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		cpu1: cpu at 1 {
@@ -46,6 +47,7 @@
 			compatible = "arm,cortex-a35";
 			reg = <0x001>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		cpu2: cpu at 200 {
@@ -53,6 +55,29 @@
 			compatible = "arm,cortex-a72";
 			reg = <0x200>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		};
+
+		idle-states {
+			entry-method = "arm,psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <100>;
+				exit-latency-us = <80>;
+				min-residency-us = <2000>;
+				arm,psci-suspend-param = <0x0010000>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <350>;
+				exit-latency-us = <80>;
+				min-residency-us = <3000>;
+				arm,psci-suspend-param = <0x1010000>;
+			};
 		};
 	};
 
-- 
1.9.1
