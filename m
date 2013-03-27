From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Mar 2013 18:30:42 +0100
Subject: [PATCH v2 08/11] ARM i.MX6q: fix ldb di divider and selector clocks
In-Reply-To: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1364405445-5271-9-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use imx_clk_mux_flags and imx_clk_divider_flags to set the appropriate
flags for the LDB display interface divider and selector clocks.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 5528656..516f03e 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -299,8 +299,8 @@ int __init mx6q_clocks_init(void)
 	clk[gpu3d_shader_sel] = imx_clk_mux("gpu3d_shader_sel", base + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
 	clk[ipu1_sel]         = imx_clk_mux("ipu1_sel",         base + 0x3c, 9,  2, ipu_sels,          ARRAY_SIZE(ipu_sels));
 	clk[ipu2_sel]         = imx_clk_mux("ipu2_sel",         base + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
-	clk[ldb_di0_sel]      = imx_clk_mux("ldb_di0_sel",      base + 0x2c, 9,  3, ldb_di_sels,       ARRAY_SIZE(ldb_di_sels));
-	clk[ldb_di1_sel]      = imx_clk_mux("ldb_di1_sel",      base + 0x2c, 12, 3, ldb_di_sels,       ARRAY_SIZE(ldb_di_sels));
+	clk[ldb_di0_sel]      = imx_clk_mux_flags("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
+	clk[ldb_di1_sel]      = imx_clk_mux_flags("ldb_di1_sel", base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
 	clk[ipu1_di0_pre_sel] = imx_clk_mux("ipu1_di0_pre_sel", base + 0x34, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
 	clk[ipu1_di1_pre_sel] = imx_clk_mux("ipu1_di1_pre_sel", base + 0x34, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
 	clk[ipu2_di0_pre_sel] = imx_clk_mux("ipu2_di0_pre_sel", base + 0x38, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels));
@@ -348,9 +348,9 @@ int __init mx6q_clocks_init(void)
 	clk[ipu1_podf]        = imx_clk_divider("ipu1_podf",        "ipu1_sel",          base + 0x3c, 11, 3);
 	clk[ipu2_podf]        = imx_clk_divider("ipu2_podf",        "ipu2_sel",          base + 0x3c, 16, 3);
 	clk[ldb_di0_div_3_5]  = imx_clk_fixed_factor("ldb_di0_div_3_5", "ldb_di0_sel", 2, 7);
-	clk[ldb_di0_podf]     = imx_clk_divider("ldb_di0_podf",     "ldb_di0_div_3_5",       base + 0x20, 10, 1);
+	clk[ldb_di0_podf]     = imx_clk_divider_flags("ldb_di0_podf", "ldb_di0_div_3_5", base + 0x20, 10, 1, 0);
 	clk[ldb_di1_div_3_5]  = imx_clk_fixed_factor("ldb_di1_div_3_5", "ldb_di1_sel", 2, 7);
-	clk[ldb_di1_podf]     = imx_clk_divider("ldb_di1_podf",     "ldb_di1_div_3_5",   base + 0x20, 11, 1);
+	clk[ldb_di1_podf]     = imx_clk_divider_flags("ldb_di1_podf", "ldb_di1_div_3_5", base + 0x20, 11, 1, 0);
 	clk[ipu1_di0_pre]     = imx_clk_divider("ipu1_di0_pre",     "ipu1_di0_pre_sel",  base + 0x34, 3,  3);
 	clk[ipu1_di1_pre]     = imx_clk_divider("ipu1_di1_pre",     "ipu1_di1_pre_sel",  base + 0x34, 12, 3);
 	clk[ipu2_di0_pre]     = imx_clk_divider("ipu2_di0_pre",     "ipu2_di0_pre_sel",  base + 0x38, 3,  3);
-- 
1.8.2.rc2
