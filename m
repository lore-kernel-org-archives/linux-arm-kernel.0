From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  6 Jan 2015 16:47:44 +0100
Subject: [PATCH 2/3] ARM: imx6: Make the LDB_DI0 and LDB_DI1 clocks read-only.
In-Reply-To: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
References: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1420559265-7333-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk tree,
the glitchy parent mux of ldb_di[x]_clk can cause a glitch to enter the
ldb_di_ipu_div divider. If the divider gets locked up, no ldb_di[x]_clk is
generated, and the LVDS display will hang when the ipu_di_clk is sourced from
ldb_di_clk.

To fix the problem, both the new and current parent of the ldb_di_clk should
be disabled before the switch. As this can not be guaranteed by the clock
framework during runtime, make the ldb_di[x]_sel muxes read-only. A workaround
to set the muxes once during boot could be added to the kernel or bootloader.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c | 10 ++--------
 arch/arm/mach-imx/clk.h       |  8 ++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index f2e7cfc..2e379fb 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -296,8 +296,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
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
@@ -491,12 +491,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 
 	clk_register_clkdev(clk[IMX6QDL_CLK_ENET_REF], "enet_ref", NULL);
 
-	if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
-	    cpu_is_imx6dl()) {
-		clk_set_parent(clk[IMX6QDL_CLK_LDB_DI0_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
-		clk_set_parent(clk[IMX6QDL_CLK_LDB_DI1_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
-	}
-
 	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI0_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
 	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI1_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
 	clk_set_parent(clk[IMX6QDL_CLK_IPU2_DI0_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 5ef82e2..3f56b93 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -124,6 +124,14 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 			&imx_ccm_lock);
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
2.1.4
