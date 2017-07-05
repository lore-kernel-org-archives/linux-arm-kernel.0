From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed,  5 Jul 2017 20:53:14 +0900
Subject: [PATCH v3 1/2] ARM: dts: uniphier: add nodes of thermal monitor and
 thermal zone for PXs2
In-Reply-To: <1499255595-31805-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1499255595-31805-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1499255595-31805-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of thermal monitor and thermal zone for UniPhier PXs2 SoC.
The thermal monitor is included in sysctrl.
Furthermore, add cpuN labels for reference in cooling-device property.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 43 ++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index e9e031d..1ff5531 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -52,7 +52,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
@@ -60,9 +60,10 @@
 			enable-method = "psci";
 			next-level-cache = <&l2>;
 			operating-points-v2 = <&cpu_opp>;
+			#cooling-cells = <2>;
 		};
 
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
@@ -72,7 +73,7 @@
 			operating-points-v2 = <&cpu_opp>;
 		};
 
-		cpu at 2 {
+		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
@@ -82,7 +83,7 @@
 			operating-points-v2 = <&cpu_opp>;
 		};
 
-		cpu at 3 {
+		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
@@ -150,6 +151,34 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal {
+			polling-delay-passive = <250>;	/* 250ms */
+			polling-delay = <1000>;		/* 1000ms */
+			thermal-sensors = <&pvtctl>;
+
+			trips {
+				cpu_crit: cpu_crit {
+					temperature = <95000>;	/* 95C */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+				cpu_alert: cpu_alert {
+					temperature = <85000>;	/* 85C */
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0 (-1) (-1)>;
+				};
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -387,6 +416,12 @@
 				compatible = "socionext,uniphier-pxs2-reset";
 				#reset-cells = <1>;
 			};
+
+			pvtctl: pvtctl {
+				compatible = "socionext,uniphier-pxs2-thermal";
+				interrupts = <0 3 4>;
+				#thermal-sensor-cells = <0>;
+			};
 		};
 	};
 };
-- 
2.7.4
