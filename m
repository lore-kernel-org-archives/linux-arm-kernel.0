From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 20 May 2015 09:11:39 +0530
Subject: [PATCH V5 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <cover.1432091956.git.viresh.kumar@linaro.org>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
Message-ID: <4690ad854263d6553debab67d65d230105c206ec.1432091956.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms (Like Qualcomm's SoCs), it is not decided until
runtime on what OPPs to use. The OPP tables can be fixed at compile
time, but which table to use is found out only after reading some efuses
(sort of an prom) and knowing characteristics of the SoC.

To support such platform we need to pass multiple OPP tables per device
and hardware should be able to choose one and only one table out of
those.

Update OPP-v2 bindings to support that.

Acked-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index d132e2927b21..7f30d9b07db7 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -46,6 +46,9 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP descriptor in their DT node. The OPP core will use this phandle
 to find the operating points for the device.
 
+Devices may want to choose OPP tables at runtime and so can provide a list of
+phandles here. But only *one* of them should be chosen at runtime.
+
 
 * OPP Descriptor Node
 
@@ -61,6 +64,9 @@ This describes the OPPs belonging to a device. This node can have following
   reference an OPP.
 
 Optional properties:
+- opp-name: Name of the OPP table, to uniquely identify it if more than one OPP
+  table is supplied in "operating-points-v2" property of device.
+
 - opp-shared: Indicates that device nodes using this OPP descriptor's phandle
   switch their DVFS state together, i.e. they share clock/voltage/current lines.
   Missing property means devices have independent clock/voltage/current lines,
@@ -394,3 +400,49 @@ Example 4: Handling multiple regulators
 		};
 	};
 };
+
+Example 5: Multiple OPP tables
+
+/ {
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cortex-a7";
+			...
+
+			opp-supply = <&cpu_supply>
+			operating-points-v2 = <&cpu0_opp0>, <&cpu0_opp1>;
+		};
+	};
+
+	cpu0_opp0: opp0 {
+		compatible = "operating-points-v2";
+		opp-name = "opp-slow";
+		opp-shared;
+
+		entry00 {
+			opp-hz = <600000000>;
+			...
+		};
+
+		entry01 {
+			opp-hz = <800000000>;
+			...
+		};
+	};
+
+	cpu0_opp1: opp1 {
+		compatible = "operating-points-v2";
+		opp-name = "opp-fast";
+		opp-shared;
+
+		entry10 {
+			opp-hz = <1000000000>;
+			...
+		};
+
+		entry11 {
+			opp-hz = <1100000000>;
+			...
+		};
+	};
+};
-- 
2.4.0
