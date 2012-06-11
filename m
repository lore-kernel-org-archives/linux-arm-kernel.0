From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 10 Jun 2012 18:46:26 -0600
Subject: [PATCHv2 11/12] ARM: OMAP4: clock data: add clockdomains for clocks
 used as main clocks
In-Reply-To: <20120611004502.20034.8840.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
Message-ID: <20120611004623.20034.52760.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until the OMAP4 code is converted to disable the use of the clock
framework-based clockdomain enable/disable sequence, any clock used as
a hwmod main_clk must have a clockdomain associated with it.  This
patch populates some clock structure clockdomain names to resolve the
following warnings during kernel init:

omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
omap_hwmod: trace_clk_div_ck: missing clockdomain for trace_clk_div_ck.
omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
omap_hwmod: ddrphy_ck: missing clockdomain for ddrphy_ck.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2172f66..e2b701e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -84,6 +84,7 @@ static struct clk slimbus_clk = {
 
 static struct clk sys_32k_ck = {
 	.name		= "sys_32k_ck",
+	.clkdm_name	= "prm_clkdm",
 	.rate		= 32768,
 	.ops		= &clkops_null,
 };
@@ -512,6 +513,7 @@ static struct clk ddrphy_ck = {
 	.name		= "ddrphy_ck",
 	.parent		= &dpll_core_m2_ck,
 	.ops		= &clkops_null,
+	.clkdm_name	= "l3_emif_clkdm",
 	.fixed_div	= 2,
 	.recalc		= &omap_fixed_divisor_recalc,
 };
@@ -769,6 +771,7 @@ static const struct clksel dpll_mpu_m2_div[] = {
 static struct clk dpll_mpu_m2_ck = {
 	.name		= "dpll_mpu_m2_ck",
 	.parent		= &dpll_mpu_ck,
+	.clkdm_name	= "cm_clkdm",
 	.clksel		= dpll_mpu_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_MPU,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
@@ -1149,6 +1152,7 @@ static const struct clksel l3_div_div[] = {
 static struct clk l3_div_ck = {
 	.name		= "l3_div_ck",
 	.parent		= &div_core_ck,
+	.clkdm_name	= "cm_clkdm",
 	.clksel		= l3_div_div,
 	.clksel_reg	= OMAP4430_CM_CLKSEL_CORE,
 	.clksel_mask	= OMAP4430_CLKSEL_L3_MASK,
@@ -2824,6 +2828,7 @@ static const struct clksel trace_clk_div_div[] = {
 static struct clk trace_clk_div_ck = {
 	.name		= "trace_clk_div_ck",
 	.parent		= &pmd_trace_clk_mux_ck,
+	.clkdm_name	= "emu_sys_clkdm",
 	.clksel		= trace_clk_div_div,
 	.clksel_reg	= OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
 	.clksel_mask	= OMAP4430_CLKSEL_PMD_TRACE_CLK_MASK,
