From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 24 Sep 2010 01:08:08 -0600
Subject: [PATCH 01/12] OMAP4: clocks: Update clock tree for ES2
In-Reply-To: <20100924070643.14014.11359.stgit@twilight.localdomain>
References: <20100924070643.14014.11359.stgit@twilight.localdomain>
Message-ID: <20100924070806.14014.40.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

This patch updates the clock tree with all the
changes in OMAP4430 ES2.

clock nodes added
-1- tie_low_clock_ck
-2- abe_dpll_bypass_clk_mux_ck

clock nodes deleted
-1- dpll_sys_ref_clk
-2- per_sgx_fclk
-3- usbphyocp2scp_ick

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
[paul at pwsan.com: added comment re ES1 clocks to top of file]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |  172 +++++++++++++++-------------------
 1 files changed, 74 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e10db7a..f39552b 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -17,6 +17,10 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * XXX Some of the ES1 clocks have been removed/changed; once support
+ * is added for discriminating clocks by ES level, these should be added back
+ * in.
  */
 
 #include <linux/kernel.h>
@@ -175,21 +179,27 @@ static struct clk sys_clkin_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static struct clk tie_low_clock_ck = {
+	.name		= "tie_low_clock_ck",
+	.rate		= 0,
+	.ops		= &clkops_null,
+};
+
 static struct clk utmi_phy_clkout_ck = {
 	.name		= "utmi_phy_clkout_ck",
-	.rate		= 12000000,
+	.rate		= 60000000,
 	.ops		= &clkops_null,
 };
 
 static struct clk xclk60mhsp1_ck = {
 	.name		= "xclk60mhsp1_ck",
-	.rate		= 12000000,
+	.rate		= 60000000,
 	.ops		= &clkops_null,
 };
 
 static struct clk xclk60mhsp2_ck = {
 	.name		= "xclk60mhsp2_ck",
-	.rate		= 12000000,
+	.rate		= 60000000,
 	.ops		= &clkops_null,
 };
 
@@ -201,39 +211,23 @@ static struct clk xclk60motg_ck = {
 
 /* Module clocks and DPLL outputs */
 
-static const struct clksel_rate div2_1to2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
-
-static const struct clksel dpll_sys_ref_clk_div[] = {
-	{ .parent = &sys_clkin_ck, .rates = div2_1to2_rates },
+static const struct clksel abe_dpll_bypass_clk_mux_sel[] = {
+	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
+	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
 	{ .parent = NULL },
 };
 
-static struct clk dpll_sys_ref_clk = {
-	.name		= "dpll_sys_ref_clk",
+static struct clk abe_dpll_bypass_clk_mux_ck = {
+	.name		= "abe_dpll_bypass_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
-	.clksel		= dpll_sys_ref_clk_div,
-	.clksel_reg	= OMAP4430_CM_DPLL_SYS_REF_CLKSEL,
-	.clksel_mask	= OMAP4430_CLKSEL_0_0_MASK,
 	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-};
-
-static const struct clksel abe_dpll_refclk_mux_sel[] = {
-	{ .parent = &dpll_sys_ref_clk, .rates = div_1_0_rates },
-	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk abe_dpll_refclk_mux_ck = {
 	.name		= "abe_dpll_refclk_mux_ck",
-	.parent		= &dpll_sys_ref_clk,
-	.clksel		= abe_dpll_refclk_mux_sel,
+	.parent		= &sys_clkin_ck,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_ABE_PLL_REF_CLKSEL,
 	.clksel_mask	= OMAP4430_CLKSEL_0_0_MASK,
@@ -244,7 +238,7 @@ static struct clk abe_dpll_refclk_mux_ck = {
 /* DPLL_ABE */
 static struct dpll_data dpll_abe_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_ABE,
-	.clk_bypass	= &sys_clkin_ck,
+	.clk_bypass	= &abe_dpll_bypass_clk_mux_ck,
 	.clk_ref	= &abe_dpll_refclk_mux_ck,
 	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_ABE,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
@@ -310,6 +304,12 @@ static struct clk abe_clk = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
+static const struct clksel_rate div2_1to2_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
+	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 0 },
+};
+
 static const struct clksel aess_fclk_div[] = {
 	{ .parent = &abe_clk, .rates = div2_1to2_rates },
 	{ .parent = NULL },
@@ -380,14 +380,14 @@ static struct clk dpll_abe_m3_ck = {
 };
 
 static const struct clksel core_hsd_byp_clk_mux_sel[] = {
-	{ .parent = &dpll_sys_ref_clk, .rates = div_1_0_rates },
+	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
 	{ .parent = &dpll_abe_m3_ck, .rates = div_1_1_rates },
 	{ .parent = NULL },
 };
 
 static struct clk core_hsd_byp_clk_mux_ck = {
 	.name		= "core_hsd_byp_clk_mux_ck",
-	.parent		= &dpll_sys_ref_clk,
+	.parent		= &sys_clkin_ck,
 	.clksel		= core_hsd_byp_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_CLKSEL_DPLL_CORE,
@@ -400,7 +400,7 @@ static struct clk core_hsd_byp_clk_mux_ck = {
 static struct dpll_data dpll_core_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_CORE,
 	.clk_bypass	= &core_hsd_byp_clk_mux_ck,
-	.clk_ref	= &dpll_sys_ref_clk,
+	.clk_ref	= &sys_clkin_ck,
 	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_CORE,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_CORE,
@@ -418,7 +418,7 @@ static struct dpll_data dpll_core_dd = {
 
 static struct clk dpll_core_ck = {
 	.name		= "dpll_core_ck",
-	.parent		= &dpll_sys_ref_clk,
+	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_core_dd,
 	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_null,
@@ -596,14 +596,14 @@ static struct clk dpll_core_m7_ck = {
 };
 
 static const struct clksel iva_hsd_byp_clk_mux_sel[] = {
-	{ .parent = &dpll_sys_ref_clk, .rates = div_1_0_rates },
+	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
 	{ .parent = &div_iva_hs_clk, .rates = div_1_1_rates },
 	{ .parent = NULL },
 };
 
 static struct clk iva_hsd_byp_clk_mux_ck = {
 	.name		= "iva_hsd_byp_clk_mux_ck",
-	.parent		= &dpll_sys_ref_clk,
+	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
@@ -612,7 +612,7 @@ static struct clk iva_hsd_byp_clk_mux_ck = {
 static struct dpll_data dpll_iva_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_IVA,
 	.clk_bypass	= &iva_hsd_byp_clk_mux_ck,
-	.clk_ref	= &dpll_sys_ref_clk,
+	.clk_ref	= &sys_clkin_ck,
 	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_IVA,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_IVA,
@@ -630,7 +630,7 @@ static struct dpll_data dpll_iva_dd = {
 
 static struct clk dpll_iva_ck = {
 	.name		= "dpll_iva_ck",
-	.parent		= &dpll_sys_ref_clk,
+	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_iva_dd,
 	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_omap3_noncore_dpll_ops,
@@ -672,7 +672,7 @@ static struct clk dpll_iva_m5_ck = {
 static struct dpll_data dpll_mpu_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_MPU,
 	.clk_bypass	= &div_mpu_hs_clk,
-	.clk_ref	= &dpll_sys_ref_clk,
+	.clk_ref	= &sys_clkin_ck,
 	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_MPU,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_MPU,
@@ -690,7 +690,7 @@ static struct dpll_data dpll_mpu_dd = {
 
 static struct clk dpll_mpu_ck = {
 	.name		= "dpll_mpu_ck",
-	.parent		= &dpll_sys_ref_clk,
+	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_mpu_dd,
 	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_omap3_noncore_dpll_ops,
@@ -724,14 +724,14 @@ static struct clk per_hs_clk_div_ck = {
 };
 
 static const struct clksel per_hsd_byp_clk_mux_sel[] = {
-	{ .parent = &dpll_sys_ref_clk, .rates = div_1_0_rates },
+	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
 	{ .parent = &per_hs_clk_div_ck, .rates = div_1_1_rates },
 	{ .parent = NULL },
 };
 
 static struct clk per_hsd_byp_clk_mux_ck = {
 	.name		= "per_hsd_byp_clk_mux_ck",
-	.parent		= &dpll_sys_ref_clk,
+	.parent		= &sys_clkin_ck,
 	.clksel		= per_hsd_byp_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_CLKSEL_DPLL_PER,
@@ -744,7 +744,7 @@ static struct clk per_hsd_byp_clk_mux_ck = {
 static struct dpll_data dpll_per_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_PER,
 	.clk_bypass	= &per_hsd_byp_clk_mux_ck,
-	.clk_ref	= &dpll_sys_ref_clk,
+	.clk_ref	= &sys_clkin_ck,
 	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_PER,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_PER,
@@ -762,7 +762,7 @@ static struct dpll_data dpll_per_dd = {
 
 static struct clk dpll_per_ck = {
 	.name		= "dpll_per_ck",
-	.parent		= &dpll_sys_ref_clk,
+	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_per_dd,
 	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_omap3_noncore_dpll_ops,
@@ -858,8 +858,8 @@ static struct clk dpll_per_m7_ck = {
 /* DPLL_UNIPRO */
 static struct dpll_data dpll_unipro_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_UNIPRO,
-	.clk_bypass	= &dpll_sys_ref_clk,
-	.clk_ref	= &dpll_sys_ref_clk,
+	.clk_bypass	= &sys_clkin_ck,
+	.clk_ref	= &sys_clkin_ck,
 	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_UNIPRO,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_UNIPRO,
@@ -877,7 +877,7 @@ static struct dpll_data dpll_unipro_dd = {
 
 static struct clk dpll_unipro_ck = {
 	.name		= "dpll_unipro_ck",
-	.parent		= &dpll_sys_ref_clk,
+	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_unipro_dd,
 	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_omap3_noncore_dpll_ops,
@@ -914,7 +914,7 @@ static struct clk usb_hs_clk_div_ck = {
 static struct dpll_data dpll_usb_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_USB,
 	.clk_bypass	= &usb_hs_clk_div_ck,
-	.clk_ref	= &dpll_sys_ref_clk,
+	.clk_ref	= &sys_clkin_ck,
 	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_USB,
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_USB,
@@ -933,7 +933,7 @@ static struct dpll_data dpll_usb_dd = {
 
 static struct clk dpll_usb_ck = {
 	.name		= "dpll_usb_ck",
-	.parent		= &dpll_sys_ref_clk,
+	.parent		= &sys_clkin_ck,
 	.dpll_data	= &dpll_usb_dd,
 	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_omap3_noncore_dpll_ops,
@@ -1222,7 +1222,7 @@ static struct clk per_abe_24m_fclk = {
 static const struct clksel pmd_stm_clock_mux_sel[] = {
 	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
 	{ .parent = &dpll_core_m6_ck, .rates = div_1_1_rates },
-	{ .parent = &dpll_per_m7_ck, .rates = div_1_2_rates },
+	{ .parent = &tie_low_clock_ck, .rates = div_1_2_rates },
 	{ .parent = NULL },
 };
 
@@ -1240,10 +1240,15 @@ static struct clk pmd_trace_clk_mux_ck = {
 	.recalc		= &followparent_recalc,
 };
 
+static const struct clksel syc_clk_div_div[] = {
+	{ .parent = &sys_clkin_ck, .rates = div2_1to2_rates },
+	{ .parent = NULL },
+};
+
 static struct clk syc_clk_div_ck = {
 	.name		= "syc_clk_div_ck",
 	.parent		= &sys_clkin_ck,
-	.clksel		= dpll_sys_ref_clk_div,
+	.clksel		= syc_clk_div_div,
 	.clksel_reg	= OMAP4430_CM_ABE_DSS_SYS_CLKSEL,
 	.clksel_mask	= OMAP4430_CLKSEL_0_0_MASK,
 	.ops		= &clkops_null,
@@ -1407,26 +1412,9 @@ static struct clk fdif_fck = {
 	.clkdm_name	= "iss_clkdm",
 };
 
-static const struct clksel per_sgx_fclk_div[] = {
-	{ .parent = &dpll_per_m2x2_ck, .rates = div3_1to4_rates },
-	{ .parent = NULL },
-};
-
-static struct clk per_sgx_fclk = {
-	.name		= "per_sgx_fclk",
-	.parent		= &dpll_per_m2x2_ck,
-	.clksel		= per_sgx_fclk_div,
-	.clksel_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
-	.clksel_mask	= OMAP4430_CLKSEL_PER_192M_MASK,
-	.ops		= &clkops_null,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate,
-};
-
 static const struct clksel sgx_clk_mux_sel[] = {
 	{ .parent = &dpll_core_m7_ck, .rates = div_1_0_rates },
-	{ .parent = &per_sgx_fclk, .rates = div_1_1_rates },
+	{ .parent = &dpll_per_m7_ck, .rates = div_1_1_rates },
 	{ .parent = NULL },
 };
 
@@ -1515,12 +1503,6 @@ static struct clk gpmc_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static const struct clksel dmt1_clk_mux_sel[] = {
-	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
-	{ .parent = &sys_32k_ck, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
-
 /*
  * Merged dmt1_clk_mux into gptimer1
  * gptimer1 renamed temporarily into gpt1 to match OMAP3 convention
@@ -1528,7 +1510,7 @@ static const struct clksel dmt1_clk_mux_sel[] = {
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
 	.parent		= &sys_clkin_ck,
-	.clksel		= dmt1_clk_mux_sel,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
@@ -1546,7 +1528,7 @@ static struct clk gpt1_fck = {
 static struct clk gpt10_fck = {
 	.name		= "gpt10_fck",
 	.parent		= &sys_clkin_ck,
-	.clksel		= dmt1_clk_mux_sel,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
@@ -1564,7 +1546,7 @@ static struct clk gpt10_fck = {
 static struct clk gpt11_fck = {
 	.name		= "gpt11_fck",
 	.parent		= &sys_clkin_ck,
-	.clksel		= dmt1_clk_mux_sel,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
@@ -1582,7 +1564,7 @@ static struct clk gpt11_fck = {
 static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
 	.parent		= &sys_clkin_ck,
-	.clksel		= dmt1_clk_mux_sel,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
@@ -1600,7 +1582,7 @@ static struct clk gpt2_fck = {
 static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
 	.parent		= &sys_clkin_ck,
-	.clksel		= dmt1_clk_mux_sel,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
@@ -1618,7 +1600,7 @@ static struct clk gpt3_fck = {
 static struct clk gpt4_fck = {
 	.name		= "gpt4_fck",
 	.parent		= &sys_clkin_ck,
-	.clksel		= dmt1_clk_mux_sel,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
@@ -1714,7 +1696,7 @@ static struct clk gpt8_fck = {
 static struct clk gpt9_fck = {
 	.name		= "gpt9_fck",
 	.parent		= &sys_clkin_ck,
-	.clksel		= dmt1_clk_mux_sel,
+	.clksel		= abe_dpll_bypass_clk_mux_sel,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
@@ -1735,11 +1717,16 @@ static struct clk hdq1w_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static const struct clksel hsi_fclk_div[] = {
+	{ .parent = &dpll_per_m2x2_ck, .rates = div3_1to4_rates },
+	{ .parent = NULL },
+};
+
 /* Merged hsi_fclk into hsi */
 static struct clk hsi_ick = {
 	.name		= "hsi_ick",
 	.parent		= &dpll_per_m2x2_ck,
-	.clksel		= per_sgx_fclk_div,
+	.clksel		= hsi_fclk_div,
 	.clksel_reg	= OMAP4430_CM_L3INIT_HSI_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_24_25_MASK,
 	.ops		= &clkops_omap2_dflt,
@@ -2315,21 +2302,11 @@ static struct clk usb_tll_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbphyocp2scp_ick = {
-	.name		= "usbphyocp2scp_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk usim_fck = {
-	.name		= "usim_fck",
+static struct clk usim_ick = {
+	.name		= "usim_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_WKUP_USIM_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
+	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.parent		= &sys_32k_ck,
 	.recalc		= &followparent_recalc,
@@ -2483,11 +2460,12 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"virt_27000000_ck",		&virt_27000000_ck,	CK_443X),
 	CLK(NULL,	"virt_38400000_ck",		&virt_38400000_ck,	CK_443X),
 	CLK(NULL,	"sys_clkin_ck",			&sys_clkin_ck,	CK_443X),
+	CLK(NULL,	"tie_low_clock_ck",		&tie_low_clock_ck,	CK_443X),
 	CLK(NULL,	"utmi_phy_clkout_ck",		&utmi_phy_clkout_ck,	CK_443X),
 	CLK(NULL,	"xclk60mhsp1_ck",		&xclk60mhsp1_ck,	CK_443X),
 	CLK(NULL,	"xclk60mhsp2_ck",		&xclk60mhsp2_ck,	CK_443X),
 	CLK(NULL,	"xclk60motg_ck",		&xclk60motg_ck,	CK_443X),
-	CLK(NULL,	"dpll_sys_ref_clk",		&dpll_sys_ref_clk,	CK_443X),
+	CLK(NULL,	"abe_dpll_bypass_clk_mux_ck",	&abe_dpll_bypass_clk_mux_ck,	CK_443X),
 	CLK(NULL,	"abe_dpll_refclk_mux_ck",	&abe_dpll_refclk_mux_ck,	CK_443X),
 	CLK(NULL,	"dpll_abe_ck",			&dpll_abe_ck,	CK_443X),
 	CLK(NULL,	"dpll_abe_m2x2_ck",		&dpll_abe_m2x2_ck,	CK_443X),
@@ -2566,7 +2544,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"emif1_ick",			&emif1_ick,	CK_443X),
 	CLK(NULL,	"emif2_ick",			&emif2_ick,	CK_443X),
 	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
-	CLK(NULL,	"per_sgx_fclk",			&per_sgx_fclk,	CK_443X),
 	CLK(NULL,	"gfx_fck",			&gfx_fck,	CK_443X),
 	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_443X),
 	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_443X),
@@ -2637,8 +2614,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK("musb_hdrc",	"ick",				&usb_otg_ick,	CK_443X),
 	CLK(NULL,	"usb_tll_ick",			&usb_tll_ick,	CK_443X),
-	CLK(NULL,	"usbphyocp2scp_ick",		&usbphyocp2scp_ick,	CK_443X),
-	CLK(NULL,	"usim_fck",			&usim_fck,	CK_443X),
+	CLK(NULL,	"usim_ick",			&usim_ick,	CK_443X),
 	CLK("omap_wdt",	"fck",				&wdt2_fck,	CK_443X),
 	CLK(NULL,	"wdt3_fck",			&wdt3_fck,	CK_443X),
 	CLK(NULL,	"otg_60m_gfclk_ck",		&otg_60m_gfclk_ck,	CK_443X),
