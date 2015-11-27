From: dawei.chien@mediatek.com (Dawei Chien)
Date: Fri, 27 Nov 2015 17:32:05 +0800
Subject: [PATCH v4 1/3] arm64: dts: mt8173: Add thermal zone node.
In-Reply-To: <1448616727-29367-1-git-send-email-dawei.chien@mediatek.com>
References: <1448616727-29367-1-git-send-email-dawei.chien@mediatek.com>
Message-ID: <1448616727-29367-2-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds thermal zone node to Mediatek MT8173 dtsi file.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
This patch is based on patchset:
https://lkml.org/lkml/2015/11/18/84
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index fda805d..4114cee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -188,6 +188,49 @@
 		clock-output-names = "cpum_ck";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&thermal 0>;
+			sustainable-power = <1500>; /* milliwatts */
+
+			trips {
+				threshold: trip-point at 0 {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				target: trip-point at 1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu_crit at 0 {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map at 0 {
+					trip = <&target>;
+					cooling-device = <&cpu0 0 0>;
+					contribution = <1024>;
+				};
+				map at 1 {
+					trip = <&target>;
+					cooling-device = <&cpu2 0 0>;
+					contribution = <2048>;
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
1.7.9.5
