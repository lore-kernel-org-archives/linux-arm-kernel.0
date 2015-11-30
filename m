From: heiko.stuebner@collabora.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 30 Nov 2015 14:13:17 +0100
Subject: [PATCH 1/2] ARM: dts: rockchip: update the thermal management on
 rk3288
Message-ID: <2402718.WBE9iyTUZ2@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Caesar Wang <wxt@rock-chips.com>

In some cases the machine radiating is very poor,sometime the temperature
is rising very quickly on heavy loading.So we need have more frequent
polling and better granularity.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
---
 arch/arm/boot/dts/rk3288-thermal.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-thermal.dtsi b/arch/arm/boot/dts/rk3288-thermal.dtsi
index 3404066..651b962 100644
--- a/arch/arm/boot/dts/rk3288-thermal.dtsi
+++ b/arch/arm/boot/dts/rk3288-thermal.dtsi
@@ -52,7 +52,7 @@ reserve_thermal: reserve_thermal {
 };
 
 cpu_thermal: cpu_thermal {
-	polling-delay-passive = <1000>; /* milliseconds */
+	polling-delay-passive = <100>; /* milliseconds */
 	polling-delay = <5000>; /* milliseconds */
 
 	thermal-sensors = <&tsadc 1>;
@@ -63,6 +63,11 @@ cpu_thermal: cpu_thermal {
 			hysteresis = <2000>; /* millicelsius */
 			type = "passive";
 		};
+		cpu_alert1: cpu_alert1 {
+			temperature = <75000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
 		cpu_crit: cpu_crit {
 			temperature = <90000>; /* millicelsius */
 			hysteresis = <2000>; /* millicelsius */
@@ -74,13 +79,18 @@ cpu_thermal: cpu_thermal {
 		map0 {
 			trip = <&cpu_alert0>;
 			cooling-device =
+				<&cpu0 THERMAL_NO_LIMIT 6>;
+		};
+		map1 {
+			trip = <&cpu_alert1>;
+			cooling-device =
 				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 		};
 	};
 };
 
 gpu_thermal: gpu_thermal {
-	polling-delay-passive = <1000>; /* milliseconds */
+	polling-delay-passive = <100>; /* milliseconds */
 	polling-delay = <5000>; /* milliseconds */
 
 	thermal-sensors = <&tsadc 2>;
-- 
2.6.1
