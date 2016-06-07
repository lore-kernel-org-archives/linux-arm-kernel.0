From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Jun 2016 12:19:29 +0100
Subject: [PATCH 5/6] ARM: sti: stih410-clocks: Identify critical clocks
In-Reply-To: <20160607111930.10375-1-lee.jones@linaro.org>
References: <20160607111930.10375-1-lee.jones@linaro.org>
Message-ID: <20160607111930.10375-6-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lots of platforms contain clocks which if turned off would prove fatal.
The only way to recover is to restart the board(s).  This driver takes
references to clocks which are required to be always-on.  The Common
Clk Framework will then take references to them.  This way they will
not be turned off during the clk_disabled_unused() procedure.

In this patch we are identifying clocks, which if gated would render
the STiH410 development board unserviceable.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih410-clock.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index d1f2aca..fd50496 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -103,6 +103,7 @@
 				clocks = <&clk_sysin>;
 
 				clock-output-names = "clk-s-a0-pll-ofd-0";
+				clock-critical = <0>; /* clk-s-a0-pll-ofd-0 */
 			};
 
 			clk_s_a0_flexgen: clk-s-a0-flexgen {
@@ -115,6 +116,7 @@
 
 				clock-output-names = "clk-ic-lmi0",
 						     "clk-ic-lmi1";
+				clock-critical = <CLK_IC_LMI0>;
 			};
 		};
 
@@ -129,6 +131,7 @@
 					     "clk-s-c0-fs0-ch1",
 					     "clk-s-c0-fs0-ch2",
 					     "clk-s-c0-fs0-ch3";
+			clock-critical = <0>; /* clk-s-c0-fs0-ch0 */
 		};
 
 		clk_s_c0: clockgen-c at 09103000 {
@@ -142,6 +145,7 @@
 				clocks = <&clk_sysin>;
 
 				clock-output-names = "clk-s-c0-pll0-odf-0";
+				clock-critical = <0>; /* clk-s-c0-pll0-odf-0 */
 			};
 
 			clk_s_c0_pll1: clk-s-c0-pll1 {
@@ -204,6 +208,11 @@
 						     "clk-clust-hades",
 						     "clk-hwpe-hades",
 						     "clk-fc-hades";
+				clock-critical = <CLK_ICN_CPU>,
+						 <CLK_TX_ICN_DMU>,
+						 <CLK_EXT2F_A9>,
+						 <CLK_ICN_LMI>,
+						 <CLK_ICN_SBC>;
 			};
 		};
 
-- 
2.8.3
