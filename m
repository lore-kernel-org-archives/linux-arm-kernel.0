From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 11 Feb 2010 11:16:44 -0700
Subject: [PATCH 04/13] OMAP2xxx clock: drop DELAYED_APP flag from non-clksel
	clocks
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Message-ID: <20100211181632.795.88849.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DELAYED_APP flag is effective only with clksel clocks, so drop it from
clocks that are not rate-changeable or that use non-clksel rate changing code
(e.g., virt_prcm_set).

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/clock2xxx_data.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index d08d545..aa37761 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -512,7 +512,7 @@ static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dsp_irate_ick,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
 };
@@ -522,7 +522,7 @@ static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dsp_irate_ick,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 };
@@ -779,7 +779,7 @@ static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= CONFIG_PARTICIPANT,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
@@ -2068,7 +2068,6 @@ static struct clk mmchsdb2_fck = {
 static struct clk virt_prcm_set = {
 	.name		= "virt_prcm_set",
 	.ops		= &clkops_null,
-	.flags		= DELAYED_APP,
 	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
 	.recalc		= &omap2_table_mpu_recalc,	/* sets are keyed on mpu rate */
 	.set_rate	= &omap2_select_table_rate,
