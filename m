From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Jan 2015 12:34:08 +0800
Subject: [PATCH v3 8/9] ARM: dts: sun4i: Add cpu thermal zones to dtsi
In-Reply-To: <1421037249-28461-1-git-send-email-wens@csie.org>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
Message-ID: <1421037249-28461-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core temperature sensor now supports thermal zones. Add a thermal
zone mapping for the cpus with passive cooling (cpufreq throttling).

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

changes since v2:

    none

changes since v1:

    - Use thermal dt bindings macros in cooling-device

---
 arch/arm/boot/dts/sun4i-a10.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7fb4e912f510..f0dc246dc69e 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -12,6 +12,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/thermal/thermal.h>
+
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -67,6 +69,38 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&rtp>;
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					/* milliCelsius */
+					temperature = <850000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu_crit {
+					/* milliCelsius */
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	memory {
 		reg = <0x40000000 0x80000000>;
 	};
-- 
2.1.4
