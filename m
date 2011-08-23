From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 23 Aug 2011 15:28:17 +0300
Subject: [PATCH 7/9] OMAP4: HWMOD: fix DSS clock data
In-Reply-To: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1314102499-30407-8-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP4 HWMOD data currently contains errors with DSS clocks:

dss_hdmi and dss_venc have their main_clks wrong. The clocks should be
dss_48mhz_clk and dss_tv_clk, respectively.

These problems were temporarily fixed with the DSS patches
9ede365aa6f74428a1f69c21ca1cf21213167576 ("HACK: OMAP: DSS2: clk hack
for OMAP2/3"), and df5d3ed23cf73ee0763a8963003bda9b69d9620f ("OMAP:
DSS2: HDMI: fix hdmi clock name"), which can be reverted after this
patch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4c2ac7e..8b74058 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1257,7 +1257,7 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_slaves[] = {
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 	{ .role = "tv_clk", .clk = "dss_tv_clk" },
-	{ .role = "video_clk", .clk = "dss_48mhz_clk" },
+	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
 };
 
 static struct omap_hwmod omap44xx_dss_hwmod = {
@@ -1637,7 +1637,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.clkdm_name	= "l3_dss_clkdm",
 	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
@@ -1800,7 +1800,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_tv_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
-- 
1.7.4.1
