From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 23 Sep 2017 08:15:30 +0800
Subject: [PATCH 2/3] arm64: allwinner: a64: add CPU opp table
In-Reply-To: <20170923001531.14285-1-icenowy@aosc.io>
References: <20170923001531.14285-1-icenowy@aosc.io>
Message-ID: <20170923001531.14285-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the operating table for the CPU (ARM cores) on Allwinner A64 SoC.

OPPs higher to 816MHz is temporarily dropped, to prevent overheat on
boards with AXP803 support and undervoltage on boards without AXP803
support.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 20aba7b186aa..0532da4939eb 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -52,6 +52,23 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-648000000 {
+			opp-hz = /bits/ 64 <648000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -61,6 +78,10 @@
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu at 1 {
@@ -68,6 +89,7 @@
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu2: cpu at 2 {
@@ -75,6 +97,7 @@
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu3: cpu at 3 {
@@ -82,6 +105,7 @@
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
 
-- 
2.13.5
