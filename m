From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 30 Aug 2016 17:58:00 +0300
Subject: [RESEND PATCH 1/2] ARM: dts: dra7: Fix clock data for
 gmac_gmii_ref_clk_div
Message-ID: <20160830145801.10364-1-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "J.D. Schroeder" <jay.schroeder@garmin.com>

This commit fixes the clock data inside the DRA7xx clocks device tree
structure for the gmac_gmii_ref_clk_div clock. This clock is actually
the GMAC_MAIN_CLK and has nothing to do with the register at address
0x4a0093d0. If CLKSEL_REF bit 24 inside of CM_GMAC_GMAC_CLKCTRL, is
set to 1 in order to use the GMAC_RMII_CLK instead of the
GMAC_RMII_HS_CLK, the kernel generates a clock divider warning:
    WARNING: CPU: 0 PID: 0 at drivers/clk/clk-divider.c:129 clk_divider_recalc_rate+0xa8/0xe0()
    gmac_gmii_ref_clk_div: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set

By properly configuring the gmac_gmii_ref_clk_div (GMAC_MAIN_CLK) to
have the parent of dpll_gmac_m2_ck always divided by 2 the warning is
resolved and the clock tree is fixed up.

Additionally, a new clock called rmii_50mhz_clk_mux is defined that
does utilize CM_GMAC_GMAC_CLKCTRL[24] CLKSEL_REF to configure the
source clock for the RMII_50MHZ_CLK.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
Reviewed-by: Trenton Andres <trenton.andres@garmin.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Hi Tony,

Originally this patch was posted (and acked) here
https://lkml.org/lkml/2016/4/27/272, 
but it, unfortunatelly, has never been merged. 
So re-send + minor subj change.

 arch/arm/boot/dts/dra7xx-clocks.dtsi | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 8378b44..3f0c61d 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1718,13 +1718,20 @@
 		reg = <0x0c00>;
 	};
 
-	gmac_gmii_ref_clk_div: gmac_gmii_ref_clk_div at 13d0 {
+	rmii_50mhz_clk_mux: rmii_50mhz_clk_mux at 13d0 {
 		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&dpll_gmac_m2_ck>;
+		compatible = "ti,mux-clock";
+		clocks = <&dpll_gmac_h11x2_ck>, <&rmii_clk_ck>;
 		ti,bit-shift = <24>;
 		reg = <0x13d0>;
-		ti,dividers = <2>;
+	};
+
+	gmac_gmii_ref_clk_div: gmac_gmii_ref_clk_div {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&dpll_gmac_m2_ck>;
+		clock-mult = <1>;
+		clock-div = <2>;
 	};
 
 	gmac_rft_clk_mux: gmac_rft_clk_mux at 13d0 {
-- 
2.9.2
