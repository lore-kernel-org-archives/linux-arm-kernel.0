From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Jan 2015 10:35:24 +0800
Subject: [PATCH 14/17] ARM: dts: sun4i: Add cpu thermal zones to dtsi
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Message-ID: <1420511727-8242-15-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core temperature sensor now supports thermal zones. Add a thermal
zone mapping for the cpus with passive cooling (cpufreq throttling).

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ce3af83dd80b..eb626833ac86 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -64,6 +64,38 @@
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
+					cooling-device = <&cpu0 (-1) (-1)>;
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
