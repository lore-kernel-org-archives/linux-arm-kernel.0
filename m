From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:18 +0900
Subject: [PATCH 09/29] ARM: shmobile: r8a7791/koelsch dts: Add DVFS parameters
 into cpu0 node for r8a7791
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <a57004eca542428a444025847098b2af4e52a81c.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Add needed information inside CPU0 for the generic cpufreq-cpu0 driver.

- voltage-tolerance = 1%
  It reflects the tolerance for the CPU voltage defined inside the OPP
  table. Due to the lack of proper OPP definition, use an arbitrary safe
  value.
- clock-latency = 300 us
  Approximate worst-case latency to do a full DVFS transition for every
  OPPs. Due to the lack of HW information, use an arbitrary safe value.
  Note: The term transition-latency will be more accurate to define this
  value since the clock transition latency is not the only parameter that
  will define the overall DVFS transition.
- operating-points = < kHz - uV >
  List of 6 operating points. All of them are using the same voltage
  since DVS is not supported in R-CAR Gen2.
- clocks
  phandle to the CPU clock source. This clock source is used for all the
  2 CortexA15 located inside the same cluster.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |  4 ++++
 arch/arm/boot/dts/r8a7791.dtsi        | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 95331d7..b2e6616 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -429,3 +429,7 @@
 		regulator-always-on;
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+};
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d683982..b639006 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -45,6 +45,17 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1500000000>;
+			voltage-tolerance = <1>; /* 1% */
+			clocks = <&cpg_clocks R8A7791_CLK_Z>;
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1500000 1000000>,
+					   <1312500 1000000>,
+					   <1125000 1000000>,
+					   < 937500 1000000>,
+					   < 750000 1000000>,
+					   < 375000 1000000>;
 		};
 
 		cpu1: cpu at 1 {
-- 
2.0.0.rc2
