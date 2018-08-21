From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 21 Aug 2018 22:34:48 +0300
Subject: [RFC] clk: imx6: Mark imx_clk_mux as glitchy by default
Message-ID: <e56c6f0acfe7afb885d2cb67e1e069f7edd0d2d7.1534879459.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With some exceptions clk muxes on imx6 are "glitchy": If the output
is not gated before reparenting then high-frequency pulses can occur and
cause unpredictable behavior. Only a very small subset of muxes are
listed as "glitchless" in the reference manual.

Adapt to this by adding the CLK_SET_PARENT_GATE flag by default to
imx_clk_mux. Add imx_clk_mux_glitchless for the muxes listed as
glitchless and which don't already have have custom behavior.

The CLK_SET_PARENT_GATE flags enables a small check inside the clk core
which make clk_set_parent return -EBUSY if the clock is active. Ensuring
outputs are gated prior to calling set_parent is up to the clk
consumers.

The effect of this patch is that drivers which perform unsafe operations
which mostly work will receive errors instead, possibly breaking
functionality.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---

Unfortunately one of the misbehaving drivers is ldb for LVDS display and
it seems to be a real issue: ldb enable/disable does reparenting on an
active clk used by IPU.

The imx_ldb_encoder_disable function will try to change the parent of
clk_sel to what it was before enabling but at this point the crtc
(inside ipu) is still active. With this patch it gets -EBUSY instead.

This happens because the DRM core disables encoders before crtc (and
backwards on enable). This assumption is reasonable, having an "encoder"
feed a clk back into the "crtc" is odd and needs special handling by the
driver.

Perhaps ipu_di_enable/disable should be handled in atomic_commit_tail
instead of at the crtc level?

More concretely on 6qp-sdb blanking the display happens like this:
 * imx_ldb_encoder_disable switches ipu1_di0_sel to ipu1_di0_pre from ldb_di1_podf
 * reparenting to ipu1_di0_pre enables it and its parents up to pll5
 * possibly glitchy muxing
 * ipu_di_disable disables ipu1_di0 (and parents, up to pll5)

---
 drivers/clk/imx/clk-imx6q.c   |  4 ++--
 drivers/clk/imx/clk-imx6sl.c  |  2 +-
 drivers/clk/imx/clk-imx6sll.c |  2 +-
 drivers/clk/imx/clk-imx6sx.c  |  2 +-
 drivers/clk/imx/clk-imx6ul.c  |  2 +-
 drivers/clk/imx/clk.h         | 16 ++++++++++++----
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8c7c2fcb8d94..0434d943b1bc 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -547,16 +547,16 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
 	/*                                              name                reg       shift width parent_names     num_parents */
 	clk[IMX6QDL_CLK_STEP]             = imx_clk_mux("step",	            base + 0xc,  8,  1, step_sels,	   ARRAY_SIZE(step_sels));
-	clk[IMX6QDL_CLK_PLL1_SW]          = imx_clk_mux("pll1_sw",	    base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
+	clk[IMX6QDL_CLK_PLL1_SW]          = imx_clk_mux_glitchless("pll1_sw",           base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
 	clk[IMX6QDL_CLK_PERIPH_PRE]       = imx_clk_mux("periph_pre",       base + 0x18, 18, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
 	clk[IMX6QDL_CLK_PERIPH2_PRE]      = imx_clk_mux("periph2_pre",      base + 0x18, 21, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
 	clk[IMX6QDL_CLK_PERIPH_CLK2_SEL]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
 	clk[IMX6QDL_CLK_PERIPH2_CLK2_SEL] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
-	clk[IMX6QDL_CLK_AXI_SEL]          = imx_clk_mux("axi_sel",          base + 0x14, 6,  2, axi_sels,          ARRAY_SIZE(axi_sels));
+	clk[IMX6QDL_CLK_AXI_SEL]          = imx_clk_mux_glitchless("axi_sel",           base + 0x14, 6,  2, axi_sels,          ARRAY_SIZE(axi_sels));
 	clk[IMX6QDL_CLK_ESAI_SEL]         = imx_clk_mux("esai_sel",         base + 0x20, 19, 2, audio_sels,        ARRAY_SIZE(audio_sels));
 	clk[IMX6QDL_CLK_ASRC_SEL]         = imx_clk_mux("asrc_sel",         base + 0x30, 7,  2, audio_sels,        ARRAY_SIZE(audio_sels));
 	clk[IMX6QDL_CLK_SPDIF_SEL]        = imx_clk_mux("spdif_sel",        base + 0x30, 20, 2, audio_sels,        ARRAY_SIZE(audio_sels));
 	if (clk_on_imx6q()) {
 		clk[IMX6QDL_CLK_GPU2D_AXI]        = imx_clk_mux("gpu2d_axi",        base + 0x18, 0,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index eb6bcbf345a3..0d1aaaafd6f4 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -289,11 +289,11 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	WARN_ON(!base);
 	ccm_base = base;
 
 	/*                                              name                reg       shift width parent_names     num_parents */
 	clks[IMX6SL_CLK_STEP]             = imx_clk_mux("step",             base + 0xc,  8,  1, step_sels,         ARRAY_SIZE(step_sels));
-	clks[IMX6SL_CLK_PLL1_SW]          = imx_clk_mux("pll1_sw",          base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
+	clks[IMX6SL_CLK_PLL1_SW]          = imx_clk_mux_glitchless("pll1_sw",           base + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
 	clks[IMX6SL_CLK_OCRAM_ALT_SEL]    = imx_clk_mux("ocram_alt_sel",    base + 0x14, 7,  1, ocram_alt_sels,    ARRAY_SIZE(ocram_alt_sels));
 	clks[IMX6SL_CLK_OCRAM_SEL]        = imx_clk_mux("ocram_sel",        base + 0x14, 6,  1, ocram_sels,        ARRAY_SIZE(ocram_sels));
 	clks[IMX6SL_CLK_PRE_PERIPH2_SEL]  = imx_clk_mux("pre_periph2_sel",  base + 0x18, 21, 2, pre_periph_sels,   ARRAY_SIZE(pre_periph_sels));
 	clks[IMX6SL_CLK_PRE_PERIPH_SEL]   = imx_clk_mux("pre_periph_sel",   base + 0x18, 18, 2, pre_periph_sels,   ARRAY_SIZE(pre_periph_sels));
 	clks[IMX6SL_CLK_PERIPH2_CLK2_SEL] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 52379ee49aec..83bea3b1a416 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -182,11 +182,11 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	np = ccm_node;
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
 	clks[IMX6SLL_CLK_STEP] 	 	  = imx_clk_mux("step", base + 0x0c, 8, 1, step_sels, ARRAY_SIZE(step_sels));
-	clks[IMX6SLL_CLK_PLL1_SW] 	  = imx_clk_mux_flags("pll1_sw",   base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
+	clks[IMX6SLL_CLK_PLL1_SW] 	  = imx_clk_mux_glitchless("pll1_sw",           base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels));
 	clks[IMX6SLL_CLK_AXI_ALT_SEL]	  = imx_clk_mux("axi_alt_sel",	   base + 0x14, 7,  1, axi_alt_sels, ARRAY_SIZE(axi_alt_sels));
 	clks[IMX6SLL_CLK_AXI_SEL] 	  = imx_clk_mux_flags("axi_sel",   base + 0x14, 6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
 	clks[IMX6SLL_CLK_PERIPH_PRE]	  = imx_clk_mux("periph_pre",      base + 0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
 	clks[IMX6SLL_CLK_PERIPH2_PRE]	  = imx_clk_mux("periph2_pre",     base + 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
 	clks[IMX6SLL_CLK_PERIPH_CLK2_SEL]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels));
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index d9f2890ffe62..c8f2d5aa8a74 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -265,11 +265,11 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
 	/*                                                name                reg           shift   width   parent_names       num_parents */
 	clks[IMX6SX_CLK_STEP]               = imx_clk_mux("step",             base + 0xc,   8,      1,      step_sels,         ARRAY_SIZE(step_sels));
-	clks[IMX6SX_CLK_PLL1_SW]            = imx_clk_mux("pll1_sw",          base + 0xc,   2,      1,      pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
+	clks[IMX6SX_CLK_PLL1_SW]            = imx_clk_mux_glitchless("pll1_sw",             base + 0xc,   2,      1,      pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
 	clks[IMX6SX_CLK_OCRAM_SEL]          = imx_clk_mux("ocram_sel",        base + 0x14,  6,      2,      ocram_sels,        ARRAY_SIZE(ocram_sels));
 	clks[IMX6SX_CLK_PERIPH_PRE]         = imx_clk_mux("periph_pre",       base + 0x18,  18,     2,      periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
 	clks[IMX6SX_CLK_PERIPH2_PRE]        = imx_clk_mux("periph2_pre",      base + 0x18,  21,     2,      periph2_pre_sels,   ARRAY_SIZE(periph2_pre_sels));
 	clks[IMX6SX_CLK_PERIPH_CLK2_SEL]    = imx_clk_mux("periph_clk2_sel",  base + 0x18,  12,     2,      periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
 	clks[IMX6SX_CLK_PERIPH2_CLK2_SEL]   = imx_clk_mux("periph2_clk2_sel", base + 0x18,  20,     1,      periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 361b43f9742e..085c35dfd262 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -234,11 +234,11 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 
 	clks[IMX6UL_CA7_SECONDARY_SEL]	  = imx_clk_mux("ca7_secondary_sel", base + 0xc, 3, 1, ca7_secondary_sels, ARRAY_SIZE(ca7_secondary_sels));
 	clks[IMX6UL_CLK_STEP]		  = imx_clk_mux("step", base + 0x0c, 8, 1, step_sels, ARRAY_SIZE(step_sels));
-	clks[IMX6UL_CLK_PLL1_SW]	  = imx_clk_mux_flags("pll1_sw",   base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
+	clks[IMX6UL_CLK_PLL1_SW]	  = imx_clk_mux_glitchless("pll1_sw",   base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels));
 	clks[IMX6UL_CLK_AXI_ALT_SEL]	  = imx_clk_mux("axi_alt_sel",		base + 0x14, 7,  1, axi_alt_sels, ARRAY_SIZE(axi_alt_sels));
 	clks[IMX6UL_CLK_AXI_SEL]	  = imx_clk_mux_flags("axi_sel",	base + 0x14, 6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
 	clks[IMX6UL_CLK_PERIPH_PRE]	  = imx_clk_mux("periph_pre",       base + 0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
 	clks[IMX6UL_CLK_PERIPH2_PRE]	  = imx_clk_mux("periph2_pre",      base + 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
 	clks[IMX6UL_CLK_PERIPH_CLK2_SEL]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels));
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8076ec040f37..a28268e81824 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -193,12 +193,12 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			CLK_SET_RATE_NO_REPARENT, reg, shift,
-			width, 0, &imx_ccm_lock);
+			CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
+			reg, shift, width, 0, &imx_ccm_lock);
 }
 
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
@@ -210,12 +210,20 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 static inline struct clk *imx_clk_mux_flags(const char *name,
 		void __iomem *reg, u8 shift, u8 width, const char **parents,
 		int num_parents, unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
-			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
-			&imx_ccm_lock);
+			flags | CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
+static inline struct clk *imx_clk_mux_glitchless(const char *name, void __iomem *reg,
+		u8 shift, u8 width, const char **parents, int num_parents)
+{
+	return clk_register_mux(NULL, name, parents, num_parents,
+			CLK_SET_RATE_NO_REPARENT,
+			reg, shift, width, 0, &imx_ccm_lock);
 }
 
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
-- 
2.17.1
