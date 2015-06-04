From: howard.chen@linaro.org (Howard Chen)
Date: Thu,  4 Jun 2015 15:13:37 +0800
Subject: [PATCH v4] ARM: dts: mt8173: support arm64 cpuidle-dt
Message-ID: <1433402017-7711-1-git-send-email-howard.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an idle-states node to describe the mt8173 idle states and
also adds references to the idle-states node in all CPU nodes.

Changes:

v4:
- Refine the property ordering.

v3:
- Add the local-timer-stop property.

v2:
- Remove the change to the PSCI version.
- Remove the cluster idle state.
- Fine tune the latency properties of the idle state.

Signed-off-by: Howard Chen <howard.chen@linaro.org>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 27237a1..5587375 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -49,6 +49,8 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x000>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
 		cpu1: cpu at 1 {
@@ -56,6 +58,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x001>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
 		cpu2: cpu at 100 {
@@ -63,6 +66,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
 		cpu3: cpu at 101 {
@@ -70,6 +74,20 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		idle-states {
+			entry-method = "arm,psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <639>;
+				exit-latency-us = <680>;
+				min-residency-us = <1088>;
+				arm,psci-suspend-param = <0x0010000>;
+			};
 		};
 	};
 
-- 
1.9.1
