From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 19 Feb 2014 15:11:12 -0600
Subject: [PATCH 3/3] dts: socfpga: Update clock entry to support multiple
 parents
In-Reply-To: <1392844273-11918-1-git-send-email-dinguyen@altera.com>
References: <1392844273-11918-1-git-send-email-dinguyen@altera.com>
Message-ID: <1392844273-11918-3-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The periph_pll and sdram_pll can have multiple parents. Update the device tree
to list all the possible parents for the PLLs. Add an entry for the the
f2s_sdram_ref_clk, which is a possible parent for the sdram_pll.

Also remove the clock-frequency entry in the f2s_periph_ref_clk, as this
property should be placed in dts file.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 7752d7c..6d7eaa4 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -92,7 +92,12 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					osc: osc1 {
+					osc1: osc1 {
+						#clock-cells = <0>;
+						compatible = "fixed-clock";
+					};
+
+					osc2: osc2 {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
 					};
@@ -100,7 +105,11 @@
 					f2s_periph_ref_clk: f2s_periph_ref_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
-						clock-frequency = <10000000>;
+					};
+
+					f2s_sdram_ref_clk: f2s_sdram_ref_clk {
+						#clock-cells = <0>;
+						compatible = "fixed-clock";
 					};
 
 					main_pll: main_pll {
@@ -108,7 +117,7 @@
 						#size-cells = <0>;
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-pll-clock";
-						clocks = <&osc>;
+						clocks = <&osc1>;
 						reg = <0x40>;
 
 						mpuclk: mpuclk {
@@ -162,7 +171,7 @@
 						#size-cells = <0>;
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-pll-clock";
-						clocks = <&osc>;
+						clocks = <&osc1>, <&osc2>, <&f2s_periph_ref_clk>;
 						reg = <0x80>;
 
 						emac0_clk: emac0_clk {
@@ -213,7 +222,7 @@
 						#size-cells = <0>;
 						#clock-cells = <0>;
 						compatible = "altr,socfpga-pll-clock";
-						clocks = <&osc>;
+						clocks = <&osc1>, <&osc2>, <&f2s_sdram_ref_clk>;
 						reg = <0xC0>;
 
 						ddr_dqs_clk: ddr_dqs_clk {
-- 
1.7.9.5
