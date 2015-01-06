From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  6 Jan 2015 16:47:45 +0100
Subject: [PATCH 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
References: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1420559265-7333-3-git-send-email-p.zabel@pengutronix.de>
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
followed when ldb_di_clk parent is switched in the beginning of boot. The
glitchy muxes are then registered as read-only. The clock parent can be selected
using the assigned-clocks and assigned-clock-parents properties of the ccm
device tree node:

	&clks {
		assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
				  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
		assigned-clock-parents = <&clks IMX6QDL_CLK_MMDC_CH1_AXI>,
					 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
	};

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c | 201 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 2e379fb..77aa7b17 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -120,9 +120,80 @@ static unsigned int share_count_ssi1;
 static unsigned int share_count_ssi2;
 static unsigned int share_count_ssi3;
 
+static int ldb_di_sel_by_clock_id(int clock_id)
+{
+	switch (clock_id) {
+	case IMX6QDL_CLK_PLL5_VIDEO_DIV:
+		return 0;
+	case IMX6QDL_CLK_PLL2_PFD0_352M:
+		return 1;
+	case IMX6QDL_CLK_PLL2_PFD2_396M:
+		return 2;
+	case IMX6QDL_CLK_MMDC_CH1_AXI:
+		return 3;
+	case IMX6QDL_CLK_PLL3_USB_OTG:
+		return 4;
+	default:
+		return -ENOENT;
+	}
+}
+
+static void of_assigned_ldb_sels(struct device_node *node,
+				 int *ldb_di0_sel, int *ldb_di1_sel)
+{
+	struct of_phandle_args clkspec;
+	int index, rc, num_parents;
+	int parent, child, sel;
+
+	num_parents = of_count_phandle_with_args(node, "assigned-clock-parents",
+						 "#clock-cells");
+	for (index = 0; index < num_parents; index++) {
+		rc = of_parse_phandle_with_args(node, "assigned-clock-parents",
+					"#clock-cells", index, &clkspec);
+		if (rc < 0) {
+			/* skip empty (null) phandles */
+			if (rc == -ENOENT)
+				continue;
+			else
+				return;
+		}
+		if (clkspec.np != node || clkspec.args[0] >= IMX6QDL_CLK_END) {
+			pr_err("ccm: parent clock %d not in ccm\n", index);
+			return;
+		}
+		parent = clkspec.args[0];
+
+		rc = of_parse_phandle_with_args(node, "assigned-clocks",
+				"#clock-cells", index, &clkspec);
+		if (rc < 0)
+			return;
+		if (clkspec.np != node || clkspec.args[0] >= IMX6QDL_CLK_END) {
+			pr_err("ccm: child clock %d not in ccm\n", index);
+			return;
+		}
+		child = clkspec.args[0];
+
+		if (child != IMX6QDL_CLK_LDB_DI0_SEL &&
+		    child != IMX6QDL_CLK_LDB_DI1_SEL)
+			continue;
+
+		sel = ldb_di_sel_by_clock_id(parent);
+		if (sel < 0)
+			pr_err("ccm: invalid ldb_di parent clock\n");
+
+		if (child == IMX6QDL_CLK_LDB_DI0_SEL)
+			*ldb_di0_sel = sel;
+		if (child == IMX6QDL_CLK_LDB_DI1_SEL)
+			*ldb_di1_sel = sel;
+	}
+}
+
 #define CCM_CCDR		0x04
+#define CCM_CCSR		0x0c
+#define CCM_CS2CDR		0x2c
 
 #define CCDR_MMDC_CH1_MASK	BIT(16)
+#define CCSR_PLL3_SW_CLK_SEL	BIT(0)
 
 static void __init imx6q_mmdc_ch1_mask_handshake(void __iomem *ccm_base)
 {
@@ -133,6 +204,124 @@ static void __init imx6q_mmdc_ch1_mask_handshake(void __iomem *ccm_base)
 	writel_relaxed(reg, ccm_base + CCM_CCDR);
 }
 
+/*
+ * The only way to disable the MMDC_CH1 clock is to move it to pll3_sw_clk
+ * via periph2_clk2_sel and then to disable pll3_sw_clk by selecting the
+ * bypass clock source, since there is no CG bit for mmdc_ch1.
+ */
+static void mmdc_ch1_disable(void __iomem *ccm_base)
+{
+	unsigned int reg;
+
+	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2_CLK2_SEL],
+		       clk[IMX6QDL_CLK_PLL3_USB_OTG]);
+
+	/*
+	 * Handshake with mmdc_ch1 module must be masked when changing
+	 * periph2_clk_sel.
+	 */
+	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2], clk[IMX6QDL_CLK_PERIPH2_CLK2]);
+
+	/* Disable pll3_sw_clk by selecting the bypass clock source */
+	reg = readl_relaxed(ccm_base + CCM_CCSR);
+	reg |= CCSR_PLL3_SW_CLK_SEL;
+	writel_relaxed(reg, ccm_base + CCM_CCSR);
+}
+
+static void mmdc_ch1_reenable(void __iomem *ccm_base)
+{
+	unsigned int reg;
+
+	/* Enable pll3_sw_clk by disabling the bypass */
+	reg = readl_relaxed(ccm_base + CCM_CCSR);
+	reg &= ~CCSR_PLL3_SW_CLK_SEL;
+	writel_relaxed(reg, ccm_base + CCM_CCSR);
+
+	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2], clk[IMX6QDL_CLK_PERIPH2_PRE]);
+}
+
+/*
+ * Need to follow a strict procedure when changing the LDB
+ * clock, else we can introduce a glitch. Things to keep in
+ * mind:
+ * 1. The current and new parent clocks must be disabled.
+ * 2. The default clock for ldb_dio_clk is mmdc_ch1 which has
+ * no CG bit.
+ * 3. In the RTL implementation of the LDB_DI_CLK_SEL mux
+ * the top four options are in one mux and the PLL3 option along
+ * with another option is in the second mux. There is third mux
+ * used to decide between the first and second mux.
+ * The code below switches the parent to the bottom mux first
+ * and then manipulates the top mux. This ensures that no glitch
+ * will enter the divider.
+ */
+static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base)
+{
+	unsigned int reg;
+	int ldb_di0_sel[4] = { 0 };
+	int ldb_di1_sel[4] = { 0 };
+	int i;
+
+	reg = readl_relaxed(ccm_base + CCM_CS2CDR);
+	ldb_di0_sel[0] = (reg >> 9) & 7;
+	ldb_di1_sel[0] = (reg >> 12) & 7;
+
+	of_assigned_ldb_sels(np, &ldb_di0_sel[3], &ldb_di1_sel[3]);
+
+	if (ldb_di0_sel[0] == ldb_di0_sel[3] &&
+	    ldb_di1_sel[0] == ldb_di1_sel[3])
+		return;
+
+	if (ldb_di0_sel[0] != 3 || ldb_di1_sel[0] != 3)
+		pr_warn("ccm: ldb_di_sel already changed from reset value\n");
+
+	if (ldb_di0_sel[0] > 3 || ldb_di1_sel[0] > 3 ||
+	    ldb_di0_sel[3] > 3 || ldb_di1_sel[3] > 3) {
+		pr_err("ccm: ldb_di_sel workaround only for top mux\n");
+		return;
+	}
+
+	ldb_di0_sel[1] = ldb_di0_sel[0] | 4;
+	ldb_di0_sel[2] = ldb_di0_sel[3] | 4;
+	ldb_di1_sel[1] = ldb_di1_sel[0] | 4;
+	ldb_di1_sel[2] = ldb_di1_sel[3] | 4;
+
+	mmdc_ch1_disable(ccm_base);
+
+	for (i = 1; i < 4; i++) {
+		reg = readl_relaxed(ccm_base + CCM_CS2CDR);
+		reg &= ~((7 << 9) | (7 << 12));
+		reg |= ((ldb_di0_sel[i] << 9) | (ldb_di1_sel[i] << 12));
+		writel_relaxed(reg, ccm_base + CCM_CS2CDR);
+	}
+
+	mmdc_ch1_reenable(ccm_base);
+}
+
+static void disable_anatop_clocks(void __iomem *anatop_base)
+{
+	unsigned int reg;
+
+	/* Make sure PFDs are disabled@boot. */
+	reg = readl_relaxed(anatop_base + 0x100);
+	/* Cannot gate PFD2 if pll2_pfd2_396m is the parent of MMDC clock */
+	if (clk_get_parent(clk[IMX6QDL_CLK_PERIPH_PRE]) ==
+	    clk[IMX6QDL_CLK_PLL2_PFD2_396M])
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
@@ -269,6 +458,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_PLL5_POST_DIV] = clk_register_divider_table(NULL, "pll5_post_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_lock);
 	clk[IMX6QDL_CLK_PLL5_VIDEO_DIV] = clk_register_divider_table(NULL, "pll5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm_lock);
 
+	disable_anatop_clocks(base);
+
 	np = ccm_node;
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
@@ -296,6 +487,16 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_GPU3D_SHADER_SEL] = imx_clk_mux("gpu3d_shader_sel", base + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
 	clk[IMX6QDL_CLK_IPU1_SEL]         = imx_clk_mux("ipu1_sel",         base + 0x3c, 9,  2, ipu_sels,          ARRAY_SIZE(ipu_sels));
 	clk[IMX6QDL_CLK_IPU2_SEL]         = imx_clk_mux("ipu2_sel",         base + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
+
+	/*
+	 * The LDB_DI0/1_SEL muxes are registered read-only due to a hardware
+	 * bug. Set the muxes to the requested values before registering the
+	 * ldb_di_sel clocks.
+	 */
+	if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
+	    cpu_is_imx6dl())
+		init_ldb_clks(np, base);
+
 	clk[IMX6QDL_CLK_LDB_DI0_SEL]      = imx_clk_mux_ldb("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
 	clk[IMX6QDL_CLK_LDB_DI1_SEL]      = imx_clk_mux_ldb("ldb_di1_sel", base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
 	clk[IMX6QDL_CLK_IPU1_DI0_PRE_SEL] = imx_clk_mux_flags("ipu1_di0_pre_sel", base + 0x34, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_SET_RATE_PARENT);
-- 
2.1.4
