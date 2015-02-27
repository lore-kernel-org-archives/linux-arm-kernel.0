From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Feb 2015 21:14:32 +0000
Subject: [PATCH 2/4] ARM: sti: stih410-clocks: Identify critical clocks as
 always-on
In-Reply-To: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
References: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1425071674-16995-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lots of platforms contain clocks which if turned off would prove fatal.
The only way to recover is to restart the board(s).  This driver takes
references to clocks which are required to be always-on in order to
prevent the common clk framework from trying to turn them off during
the clk_disabled_unused() procedure.

In this patch we are identifying clocks, which if gated would render
the STiH410 development board unserviceable.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih410-clock.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 6b5803a..7b257c2 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -103,6 +103,7 @@
 				clocks = <&clk_sysin>;
 
 				clock-output-names = "clk-s-a0-pll-ofd-0";
+				clock-always-on = "clk-s-a0-pll-ofd-0";
 			};
 
 			clk_s_a0_flexgen: clk-s-a0-flexgen {
@@ -115,6 +116,8 @@
 
 				clock-output-names = "clk-ic-lmi0",
 						     "clk-ic-lmi1";
+
+				clock-always-on = "clk-ic-lmi0";
 			};
 		};
 
@@ -142,6 +145,7 @@
 				clocks = <&clk_sysin>;
 
 				clock-output-names = "clk-s-c0-pll0-odf-0";
+				clock-always-on = "clk-s-c0-pll0-odf-0";
 			};
 
 			clk_s_c0_pll1: clk-s-c0-pll1 {
@@ -204,6 +208,12 @@
 						     "clk-clust-hades",
 						     "clk-hwpe-hades",
 						     "clk-fc-hades";
+
+				clock-always-on = "clk-icn-cpu",
+						  "clk-tx-icn-dmu",
+						  "clk-ext2fa9",
+						  "clk-icn-lmi",
+						  "clk-icn-sbc";
 			};
 		};
 
-- 
1.9.1
