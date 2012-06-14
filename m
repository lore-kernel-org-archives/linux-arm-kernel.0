From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 14 Jun 2012 15:27:25 +0300
Subject: [PATCH 2/3] ARM: OMAP2: Move McBSP fck clock alias to hwmod data for
 OMAP2430
In-Reply-To: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
References: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1339676846-12791-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the existing alias for pad_fck, prcm_fck from the clock data and
add them as opt_clks to the hwmod data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/clock2430_data.c       |   10 ----------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 3b4d09a..90a08c3 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1858,11 +1858,6 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X),
 	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X),
-	CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,	CK_243X),
-	CLK("omap-mcbsp.2",	"pad_fck",	&mcbsp_clks,	CK_243X),
-	CLK("omap-mcbsp.3",	"pad_fck",	&mcbsp_clks,	CK_243X),
-	CLK("omap-mcbsp.4",	"pad_fck",	&mcbsp_clks,	CK_243X),
-	CLK("omap-mcbsp.5",	"pad_fck",	&mcbsp_clks,	CK_243X),
 	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_243X),
 	/* internal analog sources */
 	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_243X),
@@ -1871,11 +1866,6 @@ static struct omap_clk omap2430_clks[] = {
 	/* internal prcm root sources */
 	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_243X),
 	CLK(NULL,	"core_ck",	&core_ck,	CK_243X),
-	CLK("omap-mcbsp.1",	"prcm_fck",	&func_96m_ck,	CK_243X),
-	CLK("omap-mcbsp.2",	"prcm_fck",	&func_96m_ck,	CK_243X),
-	CLK("omap-mcbsp.3",	"prcm_fck",	&func_96m_ck,	CK_243X),
-	CLK("omap-mcbsp.4",	"prcm_fck",	&func_96m_ck,	CK_243X),
-	CLK("omap-mcbsp.5",	"prcm_fck",	&func_96m_ck,	CK_243X),
 	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_243X),
 	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_243X),
 	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_243X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 4d72649..f105314 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -296,6 +296,11 @@ static struct omap_hwmod_class omap2430_mcbsp_hwmod_class = {
 	.rev  = MCBSP_CONFIG_TYPE2,
 };
 
+static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
+	{ .role = "pad_fck", .clk = "mcbsp_clks" },
+	{ .role = "prcm_fck", .clk = "func_96m_ck" },
+};
+
 /* mcbsp1 */
 static struct omap_hwmod_irq_info omap2430_mcbsp1_irqs[] = {
 	{ .name = "tx",		.irq = 59 },
@@ -320,6 +325,8 @@ static struct omap_hwmod omap2430_mcbsp1_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP1_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp2 */
@@ -345,6 +352,8 @@ static struct omap_hwmod omap2430_mcbsp2_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP2_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp3 */
@@ -370,6 +379,8 @@ static struct omap_hwmod omap2430_mcbsp3_hwmod = {
 			.idlest_idle_bit = OMAP2430_ST_MCBSP3_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp4 */
@@ -401,6 +412,8 @@ static struct omap_hwmod omap2430_mcbsp4_hwmod = {
 			.idlest_idle_bit = OMAP2430_ST_MCBSP4_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp5 */
@@ -432,6 +445,8 @@ static struct omap_hwmod omap2430_mcbsp5_hwmod = {
 			.idlest_idle_bit = OMAP2430_ST_MCBSP5_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* MMC/SD/SDIO common */
-- 
1.7.8.6
