From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 22 Apr 2016 18:02:53 +0800
Subject: [RESEND PATCH 7/8] ARM: dts: rockchip: move the rk3288 thermal data
 into rk3288.dtsi
In-Reply-To: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
References: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1461319374-10024-8-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be standard to manage for rockchip SoCs,  move the thermal
data into rk3288 dtsi, we needn't to add a new file for thermal.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
---

 arch/arm/boot/dts/rk3288-thermal.dtsi | 118 ----------------------------------
 arch/arm/boot/dts/rk3288.dtsi         |  73 ++++++++++++++++++++-
 2 files changed, 72 insertions(+), 119 deletions(-)
 delete mode 100644 arch/arm/boot/dts/rk3288-thermal.dtsi

diff --git a/arch/arm/boot/dts/rk3288-thermal.dtsi b/arch/arm/boot/dts/rk3288-thermal.dtsi
deleted file mode 100644
index 651b962..0000000
--- a/arch/arm/boot/dts/rk3288-thermal.dtsi
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * Device Tree Source for RK3288 SoC thermal
- *
- * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include <dt-bindings/thermal/thermal.h>
-
-reserve_thermal: reserve_thermal {
-	polling-delay-passive = <1000>; /* milliseconds */
-	polling-delay = <5000>; /* milliseconds */
-
-	thermal-sensors = <&tsadc 0>;
-};
-
-cpu_thermal: cpu_thermal {
-	polling-delay-passive = <100>; /* milliseconds */
-	polling-delay = <5000>; /* milliseconds */
-
-	thermal-sensors = <&tsadc 1>;
-
-	trips {
-		cpu_alert0: cpu_alert0 {
-			temperature = <70000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "passive";
-		};
-		cpu_alert1: cpu_alert1 {
-			temperature = <75000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "passive";
-		};
-		cpu_crit: cpu_crit {
-			temperature = <90000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "critical";
-		};
-	};
-
-	cooling-maps {
-		map0 {
-			trip = <&cpu_alert0>;
-			cooling-device =
-				<&cpu0 THERMAL_NO_LIMIT 6>;
-		};
-		map1 {
-			trip = <&cpu_alert1>;
-			cooling-device =
-				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-		};
-	};
-};
-
-gpu_thermal: gpu_thermal {
-	polling-delay-passive = <100>; /* milliseconds */
-	polling-delay = <5000>; /* milliseconds */
-
-	thermal-sensors = <&tsadc 2>;
-
-	trips {
-		gpu_alert0: gpu_alert0 {
-			temperature = <70000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "passive";
-		};
-		gpu_crit: gpu_crit {
-			temperature = <90000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "critical";
-		};
-	};
-
-	cooling-maps {
-		map0 {
-			trip = <&gpu_alert0>;
-			cooling-device =
-				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 3071e94..0db8b35 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -454,7 +454,78 @@
 	};
 
 	thermal-zones {
-		#include "rk3288-thermal.dtsi"
+		reserve_thermal: reserve_thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&tsadc 0>;
+		};
+
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <100>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_alert1: cpu_alert1 {
+					temperature = <75000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_crit: cpu_crit {
+					temperature = <90000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT 6>;
+				};
+				map1 {
+					trip = <&cpu_alert1>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu_thermal: gpu_thermal {
+			polling-delay-passive = <100>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&tsadc 2>;
+
+			trips {
+				gpu_alert0: gpu_alert0 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				gpu_crit: gpu_crit {
+					temperature = <90000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
 	};
 
 	tsadc: tsadc at ff280000 {
-- 
1.9.1
