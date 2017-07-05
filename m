From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed,  5 Jul 2017 20:53:15 +0900
Subject: [PATCH v3 2/2] arm64: dts: uniphier: add nodes of thermal monitor and
 thermal zone for LD20
In-Reply-To: <1499255595-31805-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1499255595-31805-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1499255595-31805-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of thermal monitor and thermal zone for UniPhier LD20 SoC.
The thermal monitor is included in sysctrl.

Furthermore, since the reference board doesn't have a calibrated value of
thermal monitor, this patch gives the default value for LD20 reference
board.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |  4 +++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 40 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 609162a..d7f6b39 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -86,3 +86,7 @@
 &i2c0 {
 	status = "okay";
 };
+
+&pvtctl {
+	socionext,tmod-calibration = <0x0f22 0x68ee>;
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a6b3a70..22d04111 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -82,6 +82,7 @@
 			clocks = <&sys_clk 32>;
 			enable-method = "psci";
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu at 1 {
@@ -100,6 +101,7 @@
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu at 101 {
@@ -209,6 +211,38 @@
 			     <1 10 4>;
 	};
 
+	thermal-zones {
+		cpu_thermal {
+			polling-delay-passive = <250>;	/* 250ms */
+			polling-delay = <1000>;		/* 1000ms */
+			thermal-sensors = <&pvtctl>;
+
+			trips {
+				cpu_crit: cpu_crit {
+					temperature = <110000>;	/* 110C */
+					hysteresis = <2000>;
+					type = "critical";
+				};
+				cpu_alert: cpu_alert {
+					temperature = <100000>;	/* 100C */
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0 (-1) (-1)>;
+				};
+				map1 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu2 (-1) (-1)>;
+				};
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -417,6 +451,12 @@
 				compatible = "socionext,uniphier-ld20-reset";
 				#reset-cells = <1>;
 			};
+
+			pvtctl: pvtctl {
+				compatible = "socionext,uniphier-ld20-thermal";
+				interrupts = <0 3 4>;
+				#thermal-sensor-cells = <0>;
+			};
 		};
 	};
 };
-- 
2.7.4
