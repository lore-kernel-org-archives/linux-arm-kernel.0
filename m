From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 28 May 2015 12:59:56 +0530
Subject: [PATCH V6 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <cover.1432797343.git.viresh.kumar@linaro.org>
References: <cover.1432797343.git.viresh.kumar@linaro.org>
Message-ID: <edc2aa263b678c6ab9eca5e7d60edf6bd1133760.1432797343.git.viresh.kumar@linaro.org>
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
index 0ca96e73d2a3..f6f75545149e 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -45,6 +45,9 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP table in their DT node. The OPP core will use this phandle to
 find the operating points for the device.
 
+Devices may want to choose OPP tables at runtime and so can provide a list of
+phandles here. But only *one* of them should be chosen at runtime.
+
 If required, this can be extended for SoC vendor specfic bindings. Such bindings
 should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
 and should have a compatible description like: "operating-points-v2-<vendor>".
@@ -63,6 +66,9 @@ This describes the OPPs belonging to a device. This node can have following
   reference an OPP.
 
 Optional properties:
+- opp-name: Name of the OPP table, to uniquely identify it if more than one OPP
+  table is supplied in "operating-points-v2" property of device.
+
 - opp-shared: Indicates that device nodes using this OPP Table Node's phandle
   switch their DVFS state together, i.e. they share clock/voltage/current lines.
   Missing property means devices have independent clock/voltage/current lines,
@@ -396,3 +402,49 @@ Example 4: Handling multiple regulators
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
+			operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;
+		};
+	};
+
+	cpu0_opp_table_slow: opp_table_slow {
+		compatible = "operating-points-v2";
+		opp-name = "slow";
+		opp-shared;
+
+		opp00 {
+			opp-hz = <600000000>;
+			...
+		};
+
+		opp01 {
+			opp-hz = <800000000>;
+			...
+		};
+	};
+
+	cpu0_opp_table_fast: opp_table_fast {
+		compatible = "operating-points-v2";
+		opp-name = "fast";
+		opp-shared;
+
+		opp10 {
+			opp-hz = <1000000000>;
+			...
+		};
+
+		opp11 {
+			opp-hz = <1100000000>;
+			...
+		};
+	};
+};
-- 
2.4.0
