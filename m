From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 15 May 2018 10:53:14 +0800
Subject: [PATCH v2 4/5] arm64: dts: hi3660: Add thermal cooling management
In-Reply-To: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
References: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1526352795-6991-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tao Wang <jean.wangtao@linaro.org>

Add nodes and properties for thermal cooling management support.

Signed-off-by: Tao Wang <jean.wangtao@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index a39da09..e20edd9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi3660-clock.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "hisilicon,hi3660";
@@ -64,6 +65,8 @@
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <110>;
 		};
 
 		cpu1: cpu at 1 {
@@ -112,6 +115,8 @@
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <550>;
 		};
 
 		cpu5: cpu at 101 {
@@ -1073,5 +1078,44 @@
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			#thermal-sensor-cells = <1>;
 		};
+
+		thermal-zones {
+
+			cls0: cls0 {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				sustainable-power = <4500>;
+
+				/* sensor ID */
+				thermal-sensors = <&tsensor 1>;
+
+				trips {
+					threshold: trip-point at 0 {
+						temperature = <65000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+
+					target: trip-point at 1 {
+						temperature = <75000>;
+						hysteresis = <1000>;
+						type = "passive";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&target>;
+						contribution = <1024>;
+						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+					map1 {
+						trip = <&target>;
+						contribution = <512>;
+						cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
1.9.1
