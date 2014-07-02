From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Jul 2014 19:53:04 -0300
Subject: [PATCH v2] ARM: imx6: Fix procedure to switch the parent of LDB_DI_CLK
Message-ID: <1404341584-21668-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk tree,
the glitchy parent mux of ldb_di[x]_clk can cause a glitch to enter the
ldb_di_ipu_div divider. If the divider gets locked up, no ldb_di[x]_clk is
generated, and the LVDS display will hang when the ipu_di_clk is sourced from
ldb_di_clk.

To fix the problem, both the new and current parent of the ldb_di_clk should
be disabled before the switch. This patch ensures that correct steps are
followed when ldb_di_clk parent is switched in the beginning of boot.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:

- Remove cpu_is_imx6dl() from disable_anatop_clocks.
- Do not use bit 31 of CCM_ANALOG_PFD_528n

 arch/arm/mach-imx/clk-imx6q.c | 125 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index f092ee13..2d2179c 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -108,6 +108,123 @@ static struct clk_div_table video_div_table[] = {
 
 static unsigned int share_count_esai;
 
+static void init_ldb_clks(unsigned int new_parent)
+{
+	struct device_node *np;
+	static void __iomem *ccm_base;
+	unsigned int reg;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ccm");
+	ccm_base = of_iomap(np, 0);
+	WARN_ON(!ccm_base);
+
+	/*
+	 * Need to follow a strict procedure when changing the LDB
+	 * clock, else we can introduce a glitch. Things to keep in
+	 * mind:
+	 * 1. The current and new parent clocks must be disabled.
+	 * 2. The default clock for ldb_dio_clk is mmdc_ch1 which has
+	 * no CG bit.
+	 * 3. In the RTL implementation of the LDB_DI_CLK_SEL mux
+	 * the top four options are in one mux and the PLL3 option along
+	 * with another option is in the second mux. There is third mux
+	 * used to decide between the first and second mux.
+	 * The code below switches the parent to the bottom mux first
+	 * and then manipulates the top mux. This ensures that no glitch
+	 * will enter the divider.
+	 *
+	 * Need to disable MMDC_CH1 clock manually as there is no CG bit
+	 * for this clock. The only way to disable this clock is to move
+	 * it to pll3_sw_clk and then to disable pll3_sw_clk
+	 * Make sure periph2_clk2_sel is set to pll3_sw_clk
+	 */
+	reg = readl_relaxed(ccm_base + 0x18);
+	reg &= ~(1 << 20);
+	writel_relaxed(reg, ccm_base + 0x18);
+
+	/* Set MMDC_CH1 mask bit */
+	reg = readl_relaxed(ccm_base + 0x4);
+	reg |= 1 << 16;
+	writel_relaxed(reg, ccm_base + 0x4);
+
+	/*
+	 * Set the periph2_clk_sel to the top mux so that
+	 * mmdc_ch1 is from pll3_sw_clk.
+	 */
+	reg = readl_relaxed(ccm_base + 0x14);
+	reg |= 1 << 26;
+	writel_relaxed(reg, ccm_base + 0x14);
+
+	/* Wait for the clock switch */
+	while (readl_relaxed(ccm_base + 0x48))
+		;
+
+	/* Disable pll3_sw_clk by selecting the bypass clock source */
+	reg = readl_relaxed(ccm_base + 0xc);
+	reg |= 1 << 0;
+	writel_relaxed(reg, ccm_base + 0xc);
+
+	/* Set the ldb_di0_clk and ldb_di1_clk to 111b */
+	reg = readl_relaxed(ccm_base + 0x2c);
+	reg |= ((7 << 9) | (7 << 12));
+	writel_relaxed(reg, ccm_base + 0x2c);
+
+	/* Set the ldb_di0_clk and ldb_di1_clk to 100b */
+	reg = readl_relaxed(ccm_base + 0x2c);
+	reg &= ~((7 << 9) | (7 << 12));
+	reg |= ((4 << 9) | (4 << 12));
+	writel_relaxed(reg, ccm_base + 0x2c);
+
+	/* Perform the LDB parent clock switch */
+	clk_set_parent(clk[IMX6QDL_CLK_LDB_DI0_SEL], clk[new_parent]);
+	clk_set_parent(clk[IMX6QDL_CLK_LDB_DI0_SEL], clk[new_parent]);
+
+	/* Unbypass pll3_sw_clk */
+	reg = readl_relaxed(ccm_base + 0xc);
+	reg &= ~(1 << 0);
+	writel_relaxed(reg, ccm_base + 0xc);
+
+	/*
+	 * Set the periph2_clk_sel back to the bottom mux so that
+	 * mmdc_ch1 is from its original parent.
+	 */
+	reg = readl_relaxed(ccm_base + 0x14);
+	reg &= ~(1 << 26);
+	writel_relaxed(reg, ccm_base + 0x14);
+
+	/* Wait for the clock switch */
+	while (readl_relaxed(ccm_base + 0x48))
+		;
+
+	/* Clear MMDC_CH1 mask bit */
+	reg = readl_relaxed(ccm_base + 0x4);
+	reg &= ~(1 << 16);
+	writel_relaxed(reg, ccm_base + 0x4);
+}
+
+static void disable_anatop_clocks(void __iomem *anatop_base)
+{
+	unsigned int reg;
+
+	/* Make sure PFDs are disabled@boot. */
+	reg = readl_relaxed(anatop_base + 0x100);
+	/* Cannot gate PFD2 if pll2_pfd2_396m is the parent of MMDC clock */
+	if (clk_get_parent(clk[IMX6QDL_CLK_PERIPH_PRE]) == clk[IMX6QDL_CLK_PLL2_PFD2_396M])
+		reg |= 0x00008080;
+	else
+		reg |= 0x00808080;
+	writel_relaxed(reg, anatop_base + 0x100);
+
+	reg = readl_relaxed(anatop_base + 0xf0);
+	reg |= 0x80808080;
+	writel_relaxed(reg, anatop_base + 0xf0);
+
+	/* Make sure PLLs is disabled */
+	reg = readl_relaxed(anatop_base + 0xa0);
+	reg &= ~(1 << 13);
+	writel_relaxed(reg, anatop_base + 0xa0);
+}
+
 static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -200,6 +317,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_PLL5_OST_DIV] = clk_register_divider_table(NULL, "pll5_post_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_lock);
 	clk[IMX6QDL_CLK_PLL5_VIDEO_DIV] = clk_register_divider_table(NULL, "pll5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm_lock);
 
+	disable_anatop_clocks(base);
+
 	np = ccm_node;
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
@@ -407,10 +526,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk_register_clkdev(clk[IMX6QDL_CLK_ENET_REF], "enet_ref", NULL);
 
 	if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
-	    cpu_is_imx6dl()) {
-		clk_set_parent(clk[IMX6QDL_CLK_LDB_DI0_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
-		clk_set_parent(clk[IMX6QDL_CLK_LDB_DI1_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
-	}
+	    cpu_is_imx6dl())
+		init_ldb_clks(IMX6QDL_CLK_PLL5_VIDEO_DIV);
 
 	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI0_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
 	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI1_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VIDEO_DIV]);
-- 
1.8.3.2
