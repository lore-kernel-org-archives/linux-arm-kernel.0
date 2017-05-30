From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 30 May 2017 17:47:46 +0300
Subject: [PATCHv3b 2/5] ARM: OMAP4: hwmod_data: add opt clks for dss_hdmi and
 dss_venc
In-Reply-To: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
Message-ID: <1496155669-1677-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These extra optional clocks are required as main clock for these modules
are going to be routed to the main module clock. Otherwise, the hdmi / tv
clocks are not going to be enabled during usage, leading to failure.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 94f09c7..0855434 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -775,6 +775,7 @@
 
 static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
 };
 
 static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
@@ -785,7 +786,7 @@
 	 * HDMI audio requires to use no-idle mode. Hence,
 	 * set idle mode by software.
 	 */
-	.flags		= HWMOD_SWSUP_SIDLE,
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_OPT_CLKS_NEEDED,
 	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
 	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
@@ -858,11 +859,16 @@
 };
 
 /* dss_venc */
+static struct omap_hwmod_opt_clk dss_venc_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "dss_tv_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
 	.main_clk	= "dss_tv_clk",
+	.flags		= HWMOD_OPT_CLKS_NEEDED,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
@@ -870,6 +876,8 @@
 		},
 	},
 	.parent_hwmod	= &omap44xx_dss_hwmod,
+	.opt_clks	= dss_venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_venc_opt_clks),
 };
 
 /*
-- 
1.9.1
