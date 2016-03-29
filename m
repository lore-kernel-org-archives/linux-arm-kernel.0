From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 29 Mar 2016 19:27:15 +0800
Subject: [PATCH v3 4/4] arm64: dts: register Hi6220's thermal zone for power
 allocator
In-Reply-To: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
References: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1459250835-25561-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With profiling Hi6220's power modeling so get dynamic coefficient and
sustainable power. So pass these parameters from DT.

Now enable power allocator with only one actor for CPU part, so directly
use cluster0's thermal sensor for monitoring temperature.

Reviewed-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 50ba1b0..1c7b133 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi6220-clock.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "hisilicon,hi6220";
@@ -87,6 +88,7 @@
 			cooling-max-level = <0>;
 			#cooling-cells = <2>; /* min followed by max */
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			dynamic-power-coefficient = <311>;
 		};
 
 		cpu1: cpu at 1 {
@@ -322,5 +324,38 @@
 			clock-names = "thermal_clk";
 			#thermal-sensor-cells = <1>;
 		};
+
+		thermal-zones {
+
+			cls0: cls0 {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				sustainable-power = <3326>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsensor 2>;
+
+				trips {
+					threshold: trip-point at 0 {
+						temperature = <65000>;
+						hysteresis = <0>;
+						type = "passive";
+					};
+
+					target: trip-point at 1 {
+						temperature = <75000>;
+						hysteresis = <0>;
+						type = "passive";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&target>;
+						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
1.9.1
