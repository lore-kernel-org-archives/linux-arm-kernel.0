From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 09 May 2016 08:19:49 +0200
Subject: [PATCH] ARM: dts: exynos: Only Odroid XU3-family boards use DTSI with
 CPU thermal nodes
Message-ID: <1462774789-15360-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the CPU thermal nodes directly in Odroid XU3-family common DTS
because it is the only user of it. Keeping it in separate DTSI node does
not bring benefits because:
1. It is not re-usable on other non-fan boards (fan is referenced),
2. It won't be re-used on future Odroid XU board because different
   CPU cluster behavior.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi      | 103 ---------------------
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  94 ++++++++++++++++++-
 2 files changed, 92 insertions(+), 105 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi

diff --git a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
deleted file mode 100644
index 3e4c4ad96d63..000000000000
--- a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * Device tree sources for Exynos5422 thermal zone
- *
- * Copyright (c) 2015 Lukasz Majewski <l.majewski@samsung.com>
- *			Anand Moon <linux.amoon@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <dt-bindings/thermal/thermal.h>
-
-/ {
-	thermal-zones {
-		cpu0_thermal: cpu0-thermal {
-			thermal-sensors = <&tmu_cpu0 0>;
-			polling-delay-passive = <250>;
-			polling-delay = <0>;
-			trips {
-				cpu_alert0: cpu-alert-0 {
-					temperature = <50000>; /* millicelsius */
-					hysteresis = <5000>; /* millicelsius */
-					type = "active";
-				};
-				cpu_alert1: cpu-alert-1 {
-					temperature = <60000>; /* millicelsius */
-					hysteresis = <5000>; /* millicelsius */
-					type = "active";
-				};
-				cpu_alert2: cpu-alert-2 {
-					temperature = <70000>; /* millicelsius */
-					hysteresis = <5000>; /* millicelsius */
-					type = "active";
-				};
-				cpu_crit0: cpu-crit-0 {
-					temperature = <120000>; /* millicelsius */
-					hysteresis = <0>; /* millicelsius */
-					type = "critical";
-				};
-				/*
-				 * Exyunos542x support only 4 trip-points
-				 * so for these polling mode is required.
-				 * Start polling at temperature level of last
-				 * interrupt-driven trip: cpu_alert2
-				 */
-				cpu_alert3: cpu-alert-3 {
-					temperature = <70000>; /* millicelsius */
-					hysteresis = <10000>; /* millicelsius */
-					type = "passive";
-				};
-				cpu_alert4: cpu-alert-4 {
-					temperature = <85000>; /* millicelsius */
-					hysteresis = <10000>; /* millicelsius */
-					type = "passive";
-				};
-
-			};
-			cooling-maps {
-				map0 {
-				     trip = <&cpu_alert0>;
-				     cooling-device = <&fan0 0 1>;
-				};
-				map1 {
-				     trip = <&cpu_alert1>;
-				     cooling-device = <&fan0 1 2>;
-				};
-				map2 {
-				     trip = <&cpu_alert2>;
-				     cooling-device = <&fan0 2 3>;
-				};
-				/*
-				 * When reaching cpu_alert3, reduce CPU
-				 * by 2 steps. On Exynos5422/5800 that would
-				 * be: 1500 MHz and 1100 MHz.
-				 */
-				map3 {
-				     trip = <&cpu_alert3>;
-				     cooling-device = <&cpu0 0 2>;
-				};
-				map4 {
-				     trip = <&cpu_alert3>;
-				     cooling-device = <&cpu4 0 2>;
-				};
-
-				/*
-				 * When reaching cpu_alert4, reduce CPU
-				 * further, down to 600 MHz (11 steps for big,
-				 * 7 steps for LITTLE).
-				 */
-				map5 {
-				     trip = <&cpu_alert4>;
-				     cooling-device = <&cpu0 3 7>;
-				};
-				map6 {
-				     trip = <&cpu_alert4>;
-				     cooling-device = <&cpu4 3 11>;
-				};
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 2a4e10bc8801..ff05041835e5 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -1,9 +1,11 @@
 /*
  * Hardkernel Odroid XU3 board device tree source
  *
- * Copyright (c) 2014 Collabora Ltd.
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
+ * Copyright (c) 2014 Collabora Ltd.
+ * Copyright (c) 2015 Lukasz Majewski <l.majewski@samsung.com>
+ *                    Anand Moon <linux.amoon@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -16,7 +18,6 @@
 #include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5800.dtsi"
 #include "exynos5422-cpus.dtsi"
-#include "exynos5422-cpu-thermal.dtsi"
 
 / {
 	memory {
@@ -54,6 +55,95 @@
 		#cooling-cells = <2>;
 		cooling-levels = <0 130 170 230>;
 	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			thermal-sensors = <&tmu_cpu0 0>;
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+			trips {
+				cpu_alert0: cpu-alert-0 {
+					temperature = <50000>; /* millicelsius */
+					hysteresis = <5000>; /* millicelsius */
+					type = "active";
+				};
+				cpu_alert1: cpu-alert-1 {
+					temperature = <60000>; /* millicelsius */
+					hysteresis = <5000>; /* millicelsius */
+					type = "active";
+				};
+				cpu_alert2: cpu-alert-2 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <5000>; /* millicelsius */
+					type = "active";
+				};
+				cpu_crit0: cpu-crit-0 {
+					temperature = <120000>; /* millicelsius */
+					hysteresis = <0>; /* millicelsius */
+					type = "critical";
+				};
+				/*
+				 * Exynos542x supports only 4 trip-points
+				 * so for these polling mode is required.
+				 * Start polling at temperature level of last
+				 * interrupt-driven trip: cpu_alert2
+				 */
+				cpu_alert3: cpu-alert-3 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <10000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_alert4: cpu-alert-4 {
+					temperature = <85000>; /* millicelsius */
+					hysteresis = <10000>; /* millicelsius */
+					type = "passive";
+				};
+
+			};
+			cooling-maps {
+				map0 {
+				     trip = <&cpu_alert0>;
+				     cooling-device = <&fan0 0 1>;
+				};
+				map1 {
+				     trip = <&cpu_alert1>;
+				     cooling-device = <&fan0 1 2>;
+				};
+				map2 {
+				     trip = <&cpu_alert2>;
+				     cooling-device = <&fan0 2 3>;
+				};
+				/*
+				 * When reaching cpu_alert3, reduce CPU
+				 * by 2 steps. On Exynos5422/5800 that would
+				 * be: 1500 MHz and 1100 MHz.
+				 */
+				map3 {
+				     trip = <&cpu_alert3>;
+				     cooling-device = <&cpu0 0 2>;
+				};
+				map4 {
+				     trip = <&cpu_alert3>;
+				     cooling-device = <&cpu4 0 2>;
+				};
+
+				/*
+				 * When reaching cpu_alert4, reduce CPU
+				 * further, down to 600 MHz (11 steps for big,
+				 * 7 steps for LITTLE).
+				 */
+				map5 {
+				     trip = <&cpu_alert4>;
+				     cooling-device = <&cpu0 3 7>;
+				};
+				map6 {
+				     trip = <&cpu_alert4>;
+				     cooling-device = <&cpu4 3 11>;
+				};
+			};
+		};
+	};
+
 };
 
 &bus_wcore {
-- 
1.9.1
