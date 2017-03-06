From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 6 Mar 2017 09:23:38 -0600
Subject: [PATCH 1/5] ARM: dts: am33xx: Add updated operating-points-v2 table
 for cpu
In-Reply-To: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1488813822-26042-2-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the ti-cpufreq driver has been added, we can now drop the
operating-points table present in am33xx.dtsi for the cpu and add an
operating-points-v2 table with all OPPs available for all silicon
revisions. Also add necessary data for use by ti-cpufreq to selectively
enable the appropriate OPPs at runtime as part of the operating-points
table.

Information from AM335x Data Manual, SPRS717i, Revised December 2015,
Table 5-7.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 87 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9e96d60976b7..9e242943dcec 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -46,19 +46,7 @@
 			device_type = "cpu";
 			reg = <0>;
 
-			/*
-			 * To consider voltage drop between PMIC and SoC,
-			 * tolerance value is reduced to 2% from 4% and
-			 * voltage value is increased as a precaution.
-			 */
-			operating-points = <
-				/* kHz    uV */
-				720000  1285000
-				600000  1225000
-				500000  1125000
-				275000  1125000
-			>;
-			voltage-tolerance = <2>; /* 2 percentage */
+			operating-points-v2 = <&cpu0_opp_table>;
 
 			clocks = <&dpll_mpu_ck>;
 			clock-names = "cpu";
@@ -67,6 +55,79 @@
 		};
 	};
 
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		syscon = <&scm_conf>;
+
+		/*
+		 * The three following nodes are marked with opp-suspend
+		 * because the can not be enabled simultaneously on a
+		 * single SoC.
+		 */
+		opp50 at 300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <950000 931000 969000>;
+			opp-supported-hw = <0x06 0x0010>;
+			opp-suspend;
+		};
+
+		opp100 at 275000000 {
+			opp-hz = /bits/ 64 <275000000>;
+			opp-microvolt = <1100000 1078000 1122000>;
+			opp-supported-hw = <0x01 0x00FF>;
+			opp-suspend;
+		};
+
+		opp100 at 300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1100000 1078000 1122000>;
+			opp-supported-hw = <0x06 0x0020>;
+			opp-suspend;
+		};
+
+		opp100 at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1100000 1078000 1122000>;
+			opp-supported-hw = <0x01 0xFFFF>;
+		};
+
+		opp100 at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1100000 1078000 1122000>;
+			opp-supported-hw = <0x06 0x0040>;
+		};
+
+		opp120 at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1200000 1176000 1224000>;
+			opp-supported-hw = <0x01 0xFFFF>;
+		};
+
+		opp120 at 720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1200000 1176000 1224000>;
+			opp-supported-hw = <0x06 0x0080>;
+		};
+
+		oppturbo at 720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1260000 1234800 1285200>;
+			opp-supported-hw = <0x01 0xFFFF>;
+		};
+
+		oppturbo at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1260000 1234800 1285200>;
+			opp-supported-hw = <0x06 0x0100>;
+		};
+
+		oppnitro at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1325000 1298500 1351500>;
+			opp-supported-hw = <0x04 0x0200>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a8-pmu";
 		interrupts = <3>;
-- 
2.11.0
