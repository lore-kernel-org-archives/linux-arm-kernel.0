From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 28 Feb 2012 04:10:55 -0700
Subject: [PATCH 6/9] ARM: OMAP4: hwmod data: remove bandgap hwmod
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Message-ID: <20120228111054.808.24406.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 407a6888f7362cb3dabe69ea6d9dcf3c750dc56a ("OMAP4: hwmod data:
Add AESS, McPDM, bandgap, counter_32k, MMC, KBD, ISS & IPU") adds a
hwmod for the bandgap die temperature sensor IP block.  This IP block
has no interconnect port or firewall region, nor does it have an
independent register space or OCP control registers.  Its registers
are embedded in the System Control Module (SCM) IP block.  So it
appears that the bandgap device should be created by the SCM driver.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   30 ----------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 264c988..8dfed19 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -824,33 +824,6 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 };
 
 /*
- * 'bandgap' class
- * bangap reference for ldo regulators
- */
-
-static struct omap_hwmod_class omap44xx_bandgap_hwmod_class = {
-	.name	= "bandgap",
-};
-
-/* bandgap */
-static struct omap_hwmod_opt_clk bandgap_opt_clks[] = {
-	{ .role = "fclk", .clk = "bandgap_fclk" },
-};
-
-static struct omap_hwmod omap44xx_bandgap_hwmod = {
-	.name		= "bandgap",
-	.class		= &omap44xx_bandgap_hwmod_class,
-	.clkdm_name	= "l4_wkup_clkdm",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_WKUP_BANDGAP_CLKCTRL_OFFSET,
-		},
-	},
-	.opt_clks	= bandgap_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(bandgap_opt_clks),
-};
-
-/*
  * 'counter' class
  * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
  */
@@ -5436,9 +5409,6 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* aess class */
 /*	&omap44xx_aess_hwmod, */
 
-	/* bandgap class */
-	&omap44xx_bandgap_hwmod,
-
 	/* counter class */
 /*	&omap44xx_counter_32k_hwmod, */
 
