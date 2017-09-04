From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon,  4 Sep 2017 10:16:31 +0900
Subject: [PATCH v4 2/2] arm64: dts: uniphier: add nodes of thermal monitor and
 thermal zone for LD20
In-Reply-To: <1504487791-20582-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1504487791-20582-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1504487791-20582-3-git-send-email-hayashi.kunihiko@socionext.com>
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
index 1ca0c86..5bb63a2 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -50,3 +50,7 @@
 &i2c0 {
 	status = "okay";
 };
+
+&pvtctl {
+	socionext,tmod-calibration = <0x0f22 0x68ee>;
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index a29c279..0f733ad 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -46,6 +46,7 @@
 			clocks = <&sys_clk 32>;
 			enable-method = "psci";
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu at 1 {
@@ -64,6 +65,7 @@
 			clocks = <&sys_clk 33>;
 			enable-method = "psci";
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu at 101 {
@@ -173,6 +175,38 @@
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
 	soc at 0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -410,6 +444,12 @@
 			watchdog {
 				compatible = "socionext,uniphier-wdt";
 			};
+
+			pvtctl: pvtctl {
+				compatible = "socionext,uniphier-ld20-thermal";
+				interrupts = <0 3 4>;
+				#thermal-sensor-cells = <0>;
+			};
 		};
 
 		nand: nand at 68000000 {
-- 
2.7.4
