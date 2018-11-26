From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:57 +0100
Subject: [PATCH 31/40] arm64: dts: renesas: Add CPU capacity-dmips-mhz
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <2250d856b279d992c392170860a78c2482b1859c.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xh@renesas.com>

Set the capacity-dmips-mhz for R-Car Gen3 SoCs, that is based on
dhrystone. The average in 10 times of dhrystone result as follows:

r8a7795 SoC (A57x4 + A53x4)
  CPU   max-freq   dhrystone
  ---------------------------------
  A57   1500 MHz  11470943 lps/s
  A53   1200 MHz   4798583 lps/s

r8a7796 SoC (A57x2 + A53x4)
  CPU   max-freq   dhrystone
  ---------------------------------
  A57   1500 MHz  11463526 lps/s
  A53   1200 MHz   4793276 lps/s

Based on above, capacity-dmips-mhz values are calculated as follows:

r8a7795 SoC
  A57 : 1024 / (11470943 / 1500) * (11470943 / 1500) = 1024
  A53 : 1024 / (11470943 / 1500) * ( 4798583 / 1200) =  535

r8a7796 SoC
  A57 : 1024 / (11463526 / 1500) * (11463526 / 1500) = 1024
  A53 : 1024 / (11463526 / 1500) * ( 4793276 / 1200) =  535

However, since each CPUs have different max frequencies, the final
CPU capacities of A53 are scaled by this difference, the values are
as follows.

[r8a7795 SoC]
  $ cat /sys/devices/system/cpu/cpu*/cpu_capacity
  1024	<---- CPU capacity of A57
  1024
  1024
  1024
  428	<---- CPU capacity of A53
  428
  428
  428

[r8a7796 SoC]
  $ cat /sys/devices/system/cpu/cpu*/cpu_capacity
  1024	<---- CPU capacity of A57
  1024
  428	<---- CPU capacity of A53
  428
  428
  428

Signed-off-by: Gaku Inami <gaku.inami.xh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 408ff4e8170a..e94a5f2dbd08 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -157,6 +157,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
 
@@ -169,6 +170,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
 
@@ -181,6 +183,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
 
@@ -193,6 +196,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
 
@@ -205,6 +209,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <535>;
 		};
 
 		a53_1: cpu at 101 {
@@ -216,6 +221,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <535>;
 		};
 
 		a53_2: cpu at 102 {
@@ -227,6 +233,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <535>;
 		};
 
 		a53_3: cpu at 103 {
@@ -238,6 +245,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7795_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <535>;
 		};
 
 		L2_CA57: cache-controller-0 {
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index b12bf73bb03b..369d0bccc651 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -162,6 +162,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7796_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
 
@@ -174,6 +175,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7796_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
 
@@ -186,6 +188,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7796_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <535>;
 		};
 
 		a53_1: cpu at 101 {
@@ -197,6 +200,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7796_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <535>;
 		};
 
 		a53_2: cpu at 102 {
@@ -208,6 +212,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7796_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <535>;
 		};
 
 		a53_3: cpu at 103 {
@@ -219,6 +224,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A7796_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <535>;
 		};
 
 		L2_CA57: cache-controller-0 {
-- 
2.11.0
