From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 20 Aug 2011 23:42:40 -0600
Subject: [PATCH 3/5] OMAP4: HWMOD: fix DSS opt clocks
In-Reply-To: <20110821053355.20198.23847.stgit@dusk>
References: <20110821053355.20198.23847.stgit@dusk>
Message-ID: <20110821054239.20198.6307.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove the extra dss_dss_clk from dss_core's opt-clocks. dss_dss_clk is
the fck, and thus not an opt-clock.

Add HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core so that dss_core's
reset can finish.

Remove the opt clocks for dispc, as they are not needed.

Change the main_clk for hdmi and venc to dss_48mhz_clk and dss_tv_clk,
respectively.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..8b74058 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1257,12 +1257,12 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_slaves[] = {
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 	{ .role = "tv_clk", .clk = "dss_tv_clk" },
-	{ .role = "dss_clk", .clk = "dss_dss_clk" },
-	{ .role = "video_clk", .clk = "dss_48mhz_clk" },
+	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
 };
 
 static struct omap_hwmod omap44xx_dss_hwmod = {
 	.name		= "dss_core",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap44xx_dss_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
 	.main_clk	= "dss_dss_clk",
@@ -1358,12 +1358,6 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] = {
 	&omap44xx_l4_per__dss_dispc,
 };
 
-static struct omap_hwmod_opt_clk dss_dispc_opt_clks[] = {
-	{ .role = "sys_clk", .clk = "dss_sys_clk" },
-	{ .role = "tv_clk", .clk = "dss_tv_clk" },
-	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
-};
-
 static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap44xx_dispc_hwmod_class,
@@ -1377,8 +1371,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
-	.opt_clks	= dss_dispc_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
 	.slaves		= omap44xx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1645,7 +1637,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.clkdm_name	= "l3_dss_clkdm",
 	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
@@ -1808,7 +1800,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_tv_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
