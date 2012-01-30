From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Jan 2012 03:18:15 -0700
Subject: [PATCH 2/7] ARM: OMAP4: hwmod data: remove pseudo-hwmods associated
 with hardreset lines
In-Reply-To: <20120130101251.10450.58423.stgit@dusk>
References: <20120130101251.10450.58423.stgit@dusk>
Message-ID: <20120130101813.10450.9839.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the pseudo-hwmods associated with hardreset lines from the
OMAP4 data file.  Future patches will convert this data to register
hwmods by interfaces, rather than registering hwmods directly; and
these pseudo-hwmods aren't associated with any interfaces.

The hwmod code now resets processor IPs at the hwmod level, rather
than individually.  So, for example, if the IVA device driver code
wishes to place one of the sequencer cores into reset, while leaving
the other active, it must do so itself by calling the appropriate PRM
functions.

This patch will cause a change in the initialization behavior of the
DSP, IVA, and IPU.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  101 +---------------------------
 1 files changed, 3 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f9f1510..a3efb9e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1105,11 +1105,8 @@ static struct omap_hwmod_irq_info omap44xx_dsp_irqs[] = {
 };
 
 static struct omap_hwmod_rst_info omap44xx_dsp_resets[] = {
-	{ .name = "mmu_cache", .rst_shift = 1 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_dsp_c0_resets[] = {
 	{ .name = "dsp", .rst_shift = 0 },
+	{ .name = "mmu_cache", .rst_shift = 1 },
 };
 
 /* dsp -> iva */
@@ -1139,21 +1136,6 @@ static struct omap_hwmod_ocp_if *omap44xx_dsp_slaves[] = {
 	&omap44xx_l4_cfg__dsp,
 };
 
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_dsp_c0_hwmod = {
-	.name		= "dsp_c0",
-	.class		= &omap44xx_dsp_hwmod_class,
-	.clkdm_name	= "tesla_clkdm",
-	.flags		= HWMOD_INIT_NO_RESET,
-	.rst_lines	= omap44xx_dsp_c0_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_c0_resets),
-	.prcm = {
-		.omap4 = {
-			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
-		},
-	},
-};
-
 static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.name		= "dsp",
 	.class		= &omap44xx_dsp_hwmod_class,
@@ -2502,15 +2484,9 @@ static struct omap_hwmod_irq_info omap44xx_ipu_irqs[] = {
 	{ .irq = -1 }
 };
 
-static struct omap_hwmod_rst_info omap44xx_ipu_c0_resets[] = {
+static struct omap_hwmod_rst_info omap44xx_ipu_resets[] = {
 	{ .name = "cpu0", .rst_shift = 0 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_ipu_c1_resets[] = {
 	{ .name = "cpu1", .rst_shift = 1 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_ipu_resets[] = {
 	{ .name = "mmu_cache", .rst_shift = 2 },
 };
 
@@ -2532,36 +2508,6 @@ static struct omap_hwmod_ocp_if *omap44xx_ipu_slaves[] = {
 	&omap44xx_l3_main_2__ipu,
 };
 
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_ipu_c0_hwmod = {
-	.name		= "ipu_c0",
-	.class		= &omap44xx_ipu_hwmod_class,
-	.clkdm_name	= "ducati_clkdm",
-	.flags		= HWMOD_INIT_NO_RESET,
-	.rst_lines	= omap44xx_ipu_c0_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_c0_resets),
-	.prcm = {
-		.omap4 = {
-			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
-		},
-	},
-};
-
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_ipu_c1_hwmod = {
-	.name		= "ipu_c1",
-	.class		= &omap44xx_ipu_hwmod_class,
-	.clkdm_name	= "ducati_clkdm",
-	.flags		= HWMOD_INIT_NO_RESET,
-	.rst_lines	= omap44xx_ipu_c1_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_c1_resets),
-	.prcm = {
-		.omap4 = {
-			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
-		},
-	},
-};
-
 static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.name		= "ipu",
 	.class		= &omap44xx_ipu_hwmod_class,
@@ -2691,15 +2637,9 @@ static struct omap_hwmod_irq_info omap44xx_iva_irqs[] = {
 };
 
 static struct omap_hwmod_rst_info omap44xx_iva_resets[] = {
-	{ .name = "logic", .rst_shift = 2 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_iva_seq0_resets[] = {
 	{ .name = "seq0", .rst_shift = 0 },
-};
-
-static struct omap_hwmod_rst_info omap44xx_iva_seq1_resets[] = {
 	{ .name = "seq1", .rst_shift = 1 },
+	{ .name = "logic", .rst_shift = 2 },
 };
 
 /* iva master ports */
@@ -2732,36 +2672,6 @@ static struct omap_hwmod_ocp_if *omap44xx_iva_slaves[] = {
 	&omap44xx_l3_main_2__iva,
 };
 
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_iva_seq0_hwmod = {
-	.name		= "iva_seq0",
-	.class		= &omap44xx_iva_hwmod_class,
-	.clkdm_name	= "ivahd_clkdm",
-	.flags		= HWMOD_INIT_NO_RESET,
-	.rst_lines	= omap44xx_iva_seq0_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_seq0_resets),
-	.prcm = {
-		.omap4 = {
-			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
-		},
-	},
-};
-
-/* Pseudo hwmod for reset control purpose only */
-static struct omap_hwmod omap44xx_iva_seq1_hwmod = {
-	.name		= "iva_seq1",
-	.class		= &omap44xx_iva_hwmod_class,
-	.clkdm_name	= "ivahd_clkdm",
-	.flags		= HWMOD_INIT_NO_RESET,
-	.rst_lines	= omap44xx_iva_seq1_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_seq1_resets),
-	.prcm = {
-		.omap4 = {
-			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
-		},
-	},
-};
-
 static struct omap_hwmod omap44xx_iva_hwmod = {
 	.name		= "iva",
 	.class		= &omap44xx_iva_hwmod_class,
@@ -5520,7 +5430,6 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* dsp class */
 	&omap44xx_dsp_hwmod,
-	&omap44xx_dsp_c0_hwmod,
 
 	/* dss class */
 	&omap44xx_dss_hwmod,
@@ -5550,16 +5459,12 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* ipu class */
 	&omap44xx_ipu_hwmod,
-	&omap44xx_ipu_c0_hwmod,
-	&omap44xx_ipu_c1_hwmod,
 
 	/* iss class */
 /*	&omap44xx_iss_hwmod, */
 
 	/* iva class */
 	&omap44xx_iva_hwmod,
-	&omap44xx_iva_seq0_hwmod,
-	&omap44xx_iva_seq1_hwmod,
 
 	/* kbd class */
 	&omap44xx_kbd_hwmod,
