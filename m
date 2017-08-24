From: rocky.hao@rock-chips.com (Rocky Hao)
Date: Thu, 24 Aug 2017 18:27:54 +0800
Subject: [PATCH 4/5] arm: dts: rockchip: add thermal nodes for RV1108 SoC
In-Reply-To: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Message-ID: <1503570475-7850-5-git-send-email-rocky.hao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add thermal zone and dynamic CPU power coefficients for RV1108

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index dbdd8c2180e7..cae920b6a145 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -43,6 +43,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/rv1108-cru.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/thermal/thermal.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -69,6 +70,8 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf00>;
+			#cooling-cells = <2>; /* min followed by max */
+			dynamic-power-coefficient = <75>;
 		};
 	};
 
@@ -275,6 +278,43 @@
 		status = "disabled";
 	};
 
+	thermal-zones {
+		soc_thermal: soc-thermal {
+			polling-delay-passive = <20>;
+			polling-delay = <1000>;
+			sustainable-power = <50>;
+
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				threshold: trip-point0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				target: trip-point1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				soc_crit: soc-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <4096>;
+				};
+			};
+		};
+
+	};
+
 	tsadc: tsadc at 10370000 {
 		compatible = "rockchip,rv1108-tsadc";
 		reg = <0x10370000 0x100>;
-- 
1.9.1
