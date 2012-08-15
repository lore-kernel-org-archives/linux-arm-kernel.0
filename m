From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 15 Aug 2012 12:00:16 +0200
Subject: [PATCH] ARM i.MX6q: Add virtual 1/3.5 dividers in the LDB clock path
Message-ID: <1345024816-6368-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

The ldb_di[01]_podf is implemented as a clk-divider that
divides by 1 or 2. In reality, the ldb_di[01]_ipu_div
dividers divide by either 3.5 or 7. Adding a fixed factor
of 1/3.5 fixes their children's clock rates.

This should probably be converted to rate table based dividers,
once available.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index ea89520..4233d9e 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -152,7 +152,7 @@ enum mx6q_clks {
 	ssi2, ssi3, uart_ipg, uart_serial, usboh3, usdhc1, usdhc2, usdhc3,
 	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
 	pll4_audio, pll5_video, pll6_mlb, pll7_usb_host, pll8_enet, ssi1_ipg,
-	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2,
+	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
 	clk_max
 };
 
@@ -288,8 +288,10 @@ int __init mx6q_clocks_init(void)
 	clk[gpu3d_shader]     = imx_clk_divider("gpu3d_shader",     "gpu3d_shader_sel",  base + 0x18, 29, 3);
 	clk[ipu1_podf]        = imx_clk_divider("ipu1_podf",        "ipu1_sel",          base + 0x3c, 11, 3);
 	clk[ipu2_podf]        = imx_clk_divider("ipu2_podf",        "ipu2_sel",          base + 0x3c, 16, 3);
-	clk[ldb_di0_podf]     = imx_clk_divider("ldb_di0_podf",     "ldb_di0_sel",       base + 0x20, 10, 1);
-	clk[ldb_di1_podf]     = imx_clk_divider("ldb_di1_podf",     "ldb_di1_sel",       base + 0x20, 11, 1);
+	clk[ldb_di0_div_3_5]  = imx_clk_fixed_factor("ldb_di0_div_3_5", "ldb_di0_sel", 2, 7);
+	clk[ldb_di0_podf]     = imx_clk_divider("ldb_di0_podf",     "ldb_di0_div_3_5",       base + 0x20, 10, 1);
+	clk[ldb_di1_div_3_5]  = imx_clk_fixed_factor("ldb_di1_div_3_5", "ldb_di1_sel", 2, 7);
+	clk[ldb_di1_podf]     = imx_clk_divider("ldb_di1_podf",     "ldb_di1_div_3_5",   base + 0x20, 11, 1);
 	clk[ipu1_di0_pre]     = imx_clk_divider("ipu1_di0_pre",     "ipu1_di0_pre_sel",  base + 0x34, 3,  3);
 	clk[ipu1_di1_pre]     = imx_clk_divider("ipu1_di1_pre",     "ipu1_di1_pre_sel",  base + 0x34, 12, 3);
 	clk[ipu2_di0_pre]     = imx_clk_divider("ipu2_di0_pre",     "ipu2_di0_pre_sel",  base + 0x38, 3,  3);
-- 
1.7.10.4
