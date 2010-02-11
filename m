From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 11 Feb 2010 11:16:32 -0700
Subject: [PATCH 03/13] OMAP2xxx clock: GFX functional clock rates are not
	independently changeable
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Message-ID: <20100211181628.795.33736.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the OMAP242x TRM Rev X Figure 5-15 "Clock Output Control
- Functional Clocks 2", the GFX functional clocks should be marked
both DELAYED_APP and CONFIG_PARTICIPANT, meaning that their rates must
be reprogrammed as part of a larger OPP set change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/clock2xxx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index f20a4b2..d08d545 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -737,7 +737,6 @@ static struct clk ssi_l4_ick = {
  * divided value of fclk.
  *
  */
-/* XXX REVISIT: GFX clock is part of CONFIG_PARTICIPANT, no? doublecheck. */
 
 /* This clksel struct is shared between gfx_3d_fck and gfx_2d_fck */
 static const struct clksel gfx_fck_clksel[] = {
@@ -764,6 +763,7 @@ static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
@@ -779,6 +779,7 @@ static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
