From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 11 Apr 2013 12:23:32 +0200
Subject: [PATCH] ARM i.MX6q: Fix periph_clk2_sel and periph2_clk2_sel clocks
Message-ID: <1365675812-21600-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The periph_clk2_sel mux can be set to pll3, pll1, or
osc/pll2-bypass/pll2_burn_in_clk. The periph2_clk2_sel
mux can be set to pll3 or pll2.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 65319d5..bdeddf3 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -177,7 +177,8 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 static const char *step_sels[]	= { "osc", "pll2_pfd2_396m", };
 static const char *pll1_sw_sels[]	= { "pll1_sys", "step", };
 static const char *periph_pre_sels[]	= { "pll2_bus", "pll2_pfd2_396m", "pll2_pfd0_352m", "pll2_198m", };
-static const char *periph_clk2_sels[]	= { "pll3_usb_otg", "osc", };
+static const char *periph_clk2_sels[]	= { "pll3_usb_otg", "pll1_sys", "osc", "dummy", };
+static const char *periph2_clk2_sels[]	= { "pll3_usb_otg", "pll2_bus", };
 static const char *periph_sels[]	= { "periph_pre", "periph_clk2", };
 static const char *periph2_sels[]	= { "periph2_pre", "periph2_clk2", };
 static const char *axi_sels[]		= { "periph", "pll2_pfd2_396m", "pll3_pfd1_540m", };
@@ -369,8 +370,8 @@ int __init mx6q_clocks_init(void)
 	clk[pll1_sw]          = imx_clk_mux("pll1_sw",	        base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
 	clk[periph_pre]       = imx_clk_mux("periph_pre",       base + 0x18, 18, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
 	clk[periph2_pre]      = imx_clk_mux("periph2_pre",      base + 0x18, 21, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
-	clk[periph_clk2_sel]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 1, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
-	clk[periph2_clk2_sel] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
+	clk[periph_clk2_sel]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
+	clk[periph2_clk2_sel] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
 	clk[axi_sel]          = imx_clk_mux("axi_sel",          base + 0x14, 6,  2, axi_sels,          ARRAY_SIZE(axi_sels));
 	clk[esai_sel]         = imx_clk_mux("esai_sel",         base + 0x20, 19, 2, audio_sels,        ARRAY_SIZE(audio_sels));
 	clk[asrc_sel]         = imx_clk_mux("asrc_sel",         base + 0x30, 7,  2, audio_sels,        ARRAY_SIZE(audio_sels));
-- 
1.8.2.rc2
