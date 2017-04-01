From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  1 Apr 2017 14:55:19 +0200
Subject: [PATCH 1/1] clk: meson: gxbb: remove the "cpu_clk" from the GXBB and
 GXL driver
In-Reply-To: <20170401125519.7339-1-martin.blumenstingl@googlemail.com>
References: <20170401125519.7339-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170401125519.7339-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that the "cpu_clk" was carried over from the meson8b clock
controller driver. On Meson GX (GXBB/GXL/GXM) the registers which are
used by the cpu_clk have a different purpose (in other words: they don't
control the CPU clock anymore). HHI_SYS_CPU_CLK_CNTL1 bits 31:24 are
reserved according to the public S905 datasheet, while bit 23 is the
"A53_trace_clk_DIS" gate (which according to the datasheet should only
be used in case a silicon bug is discovered) and bits 22:20 are a
divider (A53_trace_clk). The meson clk-cpu code however expects that
bits 28:20 are reserved for a divider (according to the public S805
datasheet this "SCALE_DIV: This value represents an N+1 divider of the
input clock.").

The CPU clock on Meson GX SoCs is provided by the SCPI DVFS clock
driver instead. Two examples from a Meson GXL S905X SoC:
- vcpu (SCPI DVFS clock 0) rate: 1000000000 / cpu_clk rate: 708000000
- vcpu (SCPI DVFS clock 0) rate: 1512000000 / cpu_clk rate: 708000000

Unfortunately the CLKID_CPUCLK was already exported (but is currently
not used) to DT. Due to the removal of this clock definition there is
now a hole in the clk_hw_onecell_data (which is not a problem because
this case is already handled in gxbb_clkc_probe).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/gxbb.c              | 64 ++---------------------------------
 drivers/clk/meson/gxbb.h              |  2 +-
 include/dt-bindings/clock/gxbb-clkc.h |  1 -
 3 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index ad5f027af1a2..7cf88ca9bdce 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -278,20 +278,6 @@ static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
 	{ /* sentinel */ },
 };
 
-static const struct clk_div_table cpu_div_table[] = {
-	{ .val = 1, .div = 1 },
-	{ .val = 2, .div = 2 },
-	{ .val = 3, .div = 3 },
-	{ .val = 2, .div = 4 },
-	{ .val = 3, .div = 6 },
-	{ .val = 4, .div = 8 },
-	{ .val = 5, .div = 10 },
-	{ .val = 6, .div = 12 },
-	{ .val = 7, .div = 14 },
-	{ .val = 8, .div = 16 },
-	{ /* sentinel */ },
-};
-
 static struct meson_clk_pll gxbb_fixed_pll = {
 	.m = {
 		.reg_off = HHI_MPLL_CNTL,
@@ -612,21 +598,10 @@ static struct meson_clk_mpll gxbb_mpll2 = {
 };
 
 /*
- * FIXME cpu clocks and the legacy composite clocks (e.g. clk81) are both PLL
- * post-dividers and should be modeled with their respective PLLs via the
- * forthcoming coordinated clock rates feature
+ * FIXME The legacy composite clocks (e.g. clk81) are both PLL post-dividers
+ * and should be modeled with their respective PLLs via the forthcoming
+ * coordinated clock rates feature
  */
-static struct meson_clk_cpu gxbb_cpu_clk = {
-	.reg_off = HHI_SYS_CPU_CLK_CNTL1,
-	.div_table = cpu_div_table,
-	.clk_nb.notifier_call = meson_clk_cpu_notifier_cb,
-	.hw.init = &(struct clk_init_data){
-		.name = "cpu_clk",
-		.ops = &meson_clk_cpu_ops,
-		.parent_names = (const char *[]){ "sys_pll" },
-		.num_parents = 1,
-	},
-};
 
 static u32 mux_table_clk81[]	= { 6, 5, 7 };
 
@@ -1045,7 +1020,6 @@ static MESON_GATE(gxbb_ao_i2c, HHI_GCLK_AO, 4);
 static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
 	.hws = {
 		[CLKID_SYS_PLL]		    = &gxbb_sys_pll.hw,
-		[CLKID_CPUCLK]		    = &gxbb_cpu_clk.hw,
 		[CLKID_HDMI_PLL]	    = &gxbb_hdmi_pll.hw,
 		[CLKID_FIXED_PLL]	    = &gxbb_fixed_pll.hw,
 		[CLKID_FCLK_DIV2]	    = &gxbb_fclk_div2.hw,
@@ -1165,7 +1139,6 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
 static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 	.hws = {
 		[CLKID_SYS_PLL]		    = &gxbb_sys_pll.hw,
-		[CLKID_CPUCLK]		    = &gxbb_cpu_clk.hw,
 		[CLKID_HDMI_PLL]	    = &gxbb_hdmi_pll.hw,
 		[CLKID_FIXED_PLL]	    = &gxbb_fixed_pll.hw,
 		[CLKID_FCLK_DIV2]	    = &gxbb_fclk_div2.hw,
@@ -1430,7 +1403,6 @@ struct clkc_data {
 	unsigned int clk_dividers_count;
 	struct meson_clk_audio_divider *const *clk_audio_dividers;
 	unsigned int clk_audio_dividers_count;
-	struct meson_clk_cpu *cpu_clk;
 	struct clk_hw_onecell_data *hw_onecell_data;
 };
 
@@ -1447,7 +1419,6 @@ static const struct clkc_data gxbb_clkc_data = {
 	.clk_dividers_count = ARRAY_SIZE(gxbb_clk_dividers),
 	.clk_audio_dividers = gxbb_audio_dividers,
 	.clk_audio_dividers_count = ARRAY_SIZE(gxbb_audio_dividers),
-	.cpu_clk = &gxbb_cpu_clk,
 	.hw_onecell_data = &gxbb_hw_onecell_data,
 };
 
@@ -1464,7 +1435,6 @@ static const struct clkc_data gxl_clkc_data = {
 	.clk_dividers_count = ARRAY_SIZE(gxbb_clk_dividers),
 	.clk_audio_dividers = gxbb_audio_dividers,
 	.clk_audio_dividers_count = ARRAY_SIZE(gxbb_audio_dividers),
-	.cpu_clk = &gxbb_cpu_clk,
 	.hw_onecell_data = &gxl_hw_onecell_data,
 };
 
@@ -1479,8 +1449,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	const struct clkc_data *clkc_data;
 	void __iomem *clk_base;
 	int ret, clkid, i;
-	struct clk_hw *parent_hw;
-	struct clk *parent_clk;
 	struct device *dev = &pdev->dev;
 
 	clkc_data = of_device_get_match_data(&pdev->dev);
@@ -1502,9 +1470,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_mplls_count; i++)
 		clkc_data->clk_mplls[i]->base = clk_base;
 
-	/* Populate the base address for CPU clk */
-	clkc_data->cpu_clk->base = clk_base;
-
 	/* Populate base address for gates */
 	for (i = 0; i < clkc_data->clk_gates_count; i++)
 		clkc_data->clk_gates[i]->reg = clk_base +
@@ -1538,29 +1503,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 			goto iounmap;
 	}
 
-	/*
-	 * Register CPU clk notifier
-	 *
-	 * FIXME this is wrong for a lot of reasons. First, the muxes should be
-	 * struct clk_hw objects. Second, we shouldn't program the muxes in
-	 * notifier handlers. The tricky programming sequence will be handled
-	 * by the forthcoming coordinated clock rates mechanism once that
-	 * feature is released.
-	 *
-	 * Furthermore, looking up the parent this way is terrible. At some
-	 * point we will stop allocating a default struct clk when registering
-	 * a new clk_hw, and this hack will no longer work. Releasing the ccr
-	 * feature before that time solves the problem :-)
-	 */
-	parent_hw = clk_hw_get_parent(&clkc_data->cpu_clk->hw);
-	parent_clk = parent_hw->clk;
-	ret = clk_notifier_register(parent_clk, &clkc_data->cpu_clk->clk_nb);
-	if (ret) {
-		pr_err("%s: failed to register clock notifier for cpu_clk\n",
-				__func__);
-		goto iounmap;
-	}
-
 	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
 			clkc_data->hw_onecell_data);
 
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 17c6aef033ff..36330c2d4433 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -171,7 +171,7 @@
  * to be exposed to client nodes in DT: include/dt-bindings/clock/gxbb-clkc.h
  */
 #define CLKID_SYS_PLL		  0
-/* CLKID_CPUCLK */
+/* ID 1 is unused (it was used by the non-existing CLKID_CPUCLK before) */
 /* CLKID_HDMI_PLL */
 #define CLKID_FIXED_PLL		  3
 /* CLKID_FCLK_DIV2 */
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 4516bc4253b5..54faf83a4851 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -5,7 +5,6 @@
 #ifndef __GXBB_CLKC_H
 #define __GXBB_CLKC_H
 
-#define CLKID_CPUCLK		1
 #define CLKID_HDMI_PLL		2
 #define CLKID_FCLK_DIV2		4
 #define CLKID_FCLK_DIV3		5
-- 
2.12.1
