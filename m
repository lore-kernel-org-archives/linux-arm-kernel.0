From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 13 Nov 2018 14:05:55 +0100
Subject: [PATCH 2/6] ARM: dts: rockchip: convert rk3188 to opp-v2
In-Reply-To: <20181113130559.31221-1-heiko@sntech.de>
References: <20181113130559.31221-1-heiko@sntech.de>
Message-ID: <20181113130559.31221-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

The fact that OPPs specified only on cpu0 work is Linux specific and
normally cpu frequencies should be specified for each cpu core.
To facilitate this without needing to duplicate the frequency table
each time, convert to opp-v2 before adding references to all cores.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 55 ++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index fd896b0a46e3..9d8c4c560e51 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -23,37 +23,70 @@
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x0>;
-			operating-points = <
-				/* kHz    uV */
-				1608000 1350000
-				1416000 1250000
-				1200000 1150000
-				1008000 1075000
-				 816000  975000
-				 600000  950000
-				 504000  925000
-				 312000  875000
-			>;
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 		cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x2>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 		cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x3>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <875000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <925000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <950000>;
+			opp-suspend;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <975000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1075000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1150000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1250000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <1350000>;
 		};
 	};
 
-- 
2.18.0
