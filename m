From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 30 Aug 2016 17:58:01 +0300
Subject: [PATCH 2/2] ARM: dts: dra7: cpsw: fix clocks tree
In-Reply-To: <20160830145801.10364-1-grygorii.strashko@ti.com>
References: <20160830145801.10364-1-grygorii.strashko@ti.com>
Message-ID: <20160830145801.10364-2-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current clocks tree definition for CPSW/CPTS doesn't
correspond TRM for dra7/am57 SoCs.

CPTS: has to be sourced from gmac_rft_clk_mux clock
CPSW: DPLL_GMAC -> CLKOUT_M2 -> GMAC_250M_CLK -> 1/2 ->
      -> GMAC_MAIN_CLK (125 MHZ)

Hence, correct clock tree for GMAC_MAIN_CLK and use proper
clock for CPTS. This also require updating of CPTS clock
multiplier.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi          |  4 ++--
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d9bfb94..9f14eed 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1717,7 +1717,7 @@
 		mac: ethernet at 48484000 {
 			compatible = "ti,dra7-cpsw","ti,cpsw";
 			ti,hwmods = "gmac";
-			clocks = <&dpll_gmac_ck>, <&gmac_gmii_ref_clk_div>;
+			clocks = <&gmac_main_clk>, <&gmac_rft_clk_mux>;
 			clock-names = "fck", "cpts";
 			cpdma_channels = <8>;
 			ale_entries = <1024>;
@@ -1726,7 +1726,7 @@
 			mac_control = <0x20>;
 			slaves = <2>;
 			active_slave = <0>;
-			cpts_clock_mult = <0x80000000>;
+			cpts_clock_mult = <0x784CFE14>;
 			cpts_clock_shift = <29>;
 			reg = <0x48484000 0x1000
 			       0x48485200 0x2E00>;
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 3f0c61d..3330738e 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1003,6 +1003,14 @@
 		ti,index-power-of-two;
 	};
 
+	gmac_main_clk: gmac_main_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&gmac_250m_dclk_div>;
+		clock-mult = <1>;
+		clock-div = <2>;
+	};
+
 	l3init_480m_dclk_div: l3init_480m_dclk_div at 1ac {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
@@ -1726,14 +1734,6 @@
 		reg = <0x13d0>;
 	};
 
-	gmac_gmii_ref_clk_div: gmac_gmii_ref_clk_div {
-		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
-		clocks = <&dpll_gmac_m2_ck>;
-		clock-mult = <1>;
-		clock-div = <2>;
-	};
-
 	gmac_rft_clk_mux: gmac_rft_clk_mux at 13d0 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
-- 
2.9.2
