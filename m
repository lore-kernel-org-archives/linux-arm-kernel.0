From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 17 Oct 2016 22:29:13 -0200
Subject: [PATCH RESEND 2/3] clk: imx6: Make the LDB_DI0 and LDB_DI1 clocks
 read-only
In-Reply-To: <1476750554-21961-1-git-send-email-festevam@gmail.com>
References: <1476750554-21961-1-git-send-email-festevam@gmail.com>
Message-ID: <1476750554-21961-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk
tree, the glitchy parent mux of ldb_di[x]_clk can cause a glitch to
enter the ldb_di_ipu_div divider. If the divider gets locked up, no
ldb_di[x]_clk is generated, and the LVDS display will hang when the
ipu_di_clk is sourced from ldb_di_clk.

To fix the problem, both the new and current parent of the ldb_di_clk
should be disabled before the switch. As this can not be guaranteed by
the clock framework during runtime, make the ldb_di[x]_sel muxes read-only.
A workaround to set the muxes once during boot could be added to the
kernel or bootloader.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/clk/imx/clk-imx6q.c | 10 ++--------
 drivers/clk/imx/clk.h       |  8 ++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 66825a8..a4f4de5 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -345,8 +345,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk[IMX6QDL_CLK_GPU3D_SHADER_SEL] = imx_clk_mux("gpu3d_shader_sel", base + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
 	clk[IMX6QDL_CLK_IPU1_SEL]         = imx_clk_mux("ipu1_sel",         base + 0x3c, 9,  2, ipu_sels,          ARRAY_SIZE(ipu_sels));
 	clk[IMX6QDL_CLK_IPU2_SEL]         = imx_clk_mux("ipu2_sel",         base + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
-	clk[IMX6QDL_CLK_LDB_DI0_SEL]      = imx_clk_mux_flags("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
-	clk[IMX6QDL_CLK_LDB_DI1_SEL]      = imx_clk_mux_flags("ldb_di1_sel", base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
+	clk[IMX6QDL_CLK_LDB_DI0_SEL]      = imx_clk_mux_ldb("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
+	clk[IMX6QDL_CLK_LDB_DI1_SEL]      = imx_clk_mux_ldb("ldb_di1_sel", base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
 	clk[IMX6QDL_CLK_IPU1_DI0_PRE_SEL] = imx_clk_mux_flags("ipu1_di0_pre_sel", base + 0x34, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_SET_RATE_PARENT);
 	clk[IMX6QDL_CLK_IPU1_DI1_PRE_SEL] = imx_clk_mux_flags("ipu1_di1_pre_sel", base + 0x34, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_SET_RATE_PARENT);
 	clk[IMX6QDL_CLK_IPU2_DI0_PRE_SEL] = imx_clk_mux_flags("ipu2_di0_pre_sel", base + 0x38, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_SET_RATE_PARENT);
@@ -597,12 +597,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 
 	clk_register_clkdev(clk[IMX6QDL_CLK_ENET_REF], "enet_ref", NULL);
 
-	if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
-	    clk_on_imx6dl()) {
-		clk_set_parent(clk[IMX6QDL_CLK_LDB_DI0_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
-		clk_set_parent(clk[IMX6QDL_CLK_LDB_DI1_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
-	}
-
 	clk_set_rate(clk[IMX6QDL_CLK_PLL3_PFD1_540M], 540000000);
 	if (clk_on_imx6dl())
 		clk_set_parent(clk[IMX6QDL_CLK_IPU1_SEL], clk[IMX6QDL_CLK_PLL3_PFD1_540M]);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3799ff8..4afad3b 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -75,6 +75,14 @@ static inline struct clk *imx_clk_fixed(const char *name, int rate)
 	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
+static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *reg,
+		u8 shift, u8 width, const char **parents, int num_parents)
+{
+	return clk_register_mux(NULL, name, parents, num_parents,
+			CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT, reg,
+			shift, width, CLK_MUX_READ_ONLY, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_fixed_factor(const char *name,
 		const char *parent, unsigned int mult, unsigned int div)
 {
-- 
2.7.4
