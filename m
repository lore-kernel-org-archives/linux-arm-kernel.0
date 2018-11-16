From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:34:29 +0530
Subject: [PATCH 06/10] ARM64: dts: mediatek: Add all CPUs in cooling maps
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <3c7c9155ac01a2d745ba5e4434c958820200d088.1542362530.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 9 ++++++---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index fe0c875f1d95..53e707df98d9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -170,17 +170,20 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu_passive>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map1 {
 					trip = <&cpu_active>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map2 {
 					trip = <&cpu_hot>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index abd2f15a544b..e578f7d18038 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -275,12 +275,14 @@
 			cooling-maps {
 				map at 0 {
 					trip = <&target>;
-					cooling-device = <&cpu0 0 0>;
+					cooling-device = <&cpu0 0 0>,
+							 <&cpu1 0 0>;
 					contribution = <3072>;
 				};
 				map at 1 {
 					trip = <&target>;
-					cooling-device = <&cpu2 0 0>;
+					cooling-device = <&cpu2 0 0>,
+							 <&cpu3 0 0>;
 					contribution = <1024>;
 				};
 			};
-- 
2.19.1.568.g152ad8e3369a
