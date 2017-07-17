From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 17 Jul 2017 16:14:31 +0800
Subject: [PATCH v2 5/5] arm64: dts: rockchip: update the thermal zones for
 RK3399 SoCs
In-Reply-To: <1500279271-15249-1-git-send-email-wxt@rock-chips.com>
References: <1500279271-15249-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1500279271-15249-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As RK3399 had used the Power allocator thermal governor by default,
enabled this to manage thermals by dynamically allocating and limiting
power to devices.

Also, this patch supported the dynamic-power-coefficient/sustainable_power
and GPU's power model for needed parameters with thermal IPA.

The Thermal power allocator governor works optimatly with two passive trip
points, for the better performance we will use the trip-point0 with 70
degree above which the governor control starts operating and trip-point1
with 85 degree is the target temperature by controlling.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- foo@ will produce warnings when used without reg property.
- update the commit to explain the two passive trip points changed.

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 62 +++++++++++++++-----------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 77d67cb..6d8a5eb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -147,7 +147,7 @@
 			enable-method = "psci";
 			#cooling-cells = <2>; /* min followed by max */
 			clocks = <&cru ARMCLKB>;
-			dynamic-power-coefficient = <100>;
+			dynamic-power-coefficient = <436>;
 		};
 
 		cpu_b1: cpu at 101 {
@@ -156,7 +156,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLKB>;
-			dynamic-power-coefficient = <100>;
+			dynamic-power-coefficient = <436>;
 		};
 	};
 
@@ -690,24 +690,25 @@
 	};
 
 	thermal_zones: thermal-zones {
-		cpu_thermal: cpu {
+		soc_thermal: soc-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <1000>;
+			sustainable-power = <1000>;
 
 			thermal-sensors = <&tsadc 0>;
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				threshold: trip-point0 {
 					temperature = <70000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu_alert1: cpu_alert1 {
-					temperature = <75000>;
+				target: trip-point1 {
+					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				cpu_crit: cpu_crit {
+				soc_crit: soc-crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -716,45 +717,31 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert0>;
+					trip = <&target>;
 					cooling-device =
-						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <4096>;
 				};
 				map1 {
-					trip = <&cpu_alert1>;
+					trip = <&target>;
 					cooling-device =
-						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+				map2 {
+					trip = <&target>;
+					cooling-device =
+						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <4096>;
 				};
 			};
 		};
 
-		gpu_thermal: gpu {
+		gpu_thermal: gpu-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsadc 1>;
-
-			trips {
-				gpu_alert0: gpu_alert0 {
-					temperature = <75000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-				gpu_crit: gpu_crit {
-					temperature = <95000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&gpu_alert0>;
-					cooling-device =
-						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
 		};
 	};
 
@@ -1451,8 +1438,17 @@
 			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "gpu", "job", "mmu";
 		clocks = <&cru ACLK_GPU>;
+		#cooling-cells = <2>;
 		power-domains = <&power RK3399_PD_GPU>;
 		status = "disabled";
+
+		gpu_power_model: power_model {
+			compatible = "arm,mali-simple-power-model";
+			static-coefficient = <1079403>;
+			dynamic-coefficient = <977>;
+			ts = <32000 4700 (-80) 2>;
+			thermal-zone = "gpu-thermal";
+		};
 	};
 
 	pinctrl: pinctrl {
-- 
2.7.4
