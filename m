From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 26 Aug 2014 16:58:22 +0800
Subject: [PATCH 2/2] ARM: imx: add lvds1_in and lvds2_in clocks
In-Reply-To: <1409043502-29081-1-git-send-email-shawn.guo@freescale.com>
References: <1409043502-29081-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1409043502-29081-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lvds_in clocks are coming from external clock source via pad ANACLK.
Since lvds_in and lvds_gate clocks cannot be enabled simultaneously, we
need to call imx_clk_gate_exclusive() to register these clocks.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c             | 10 ++++++++--
 include/dt-bindings/clock/imx6qdl-clock.h |  6 +++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 2edcebf67cee..e6c60188ec14 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -119,6 +119,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_CKIL] = imx_obtain_fixed_clock("ckil", 0);
 	clk[IMX6QDL_CLK_CKIH] = imx_obtain_fixed_clock("ckih1", 0);
 	clk[IMX6QDL_CLK_OSC] = imx_obtain_fixed_clock("osc", 0);
+	/* Clock source from external clock via ANACLK1/2 PADs */
+	clk[IMX6QDL_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
+	clk[IMX6QDL_CLK_ANACLK2] = imx_obtain_fixed_clock("anaclk2", 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	base = of_iomap(np, 0);
@@ -176,8 +179,11 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	 * the "output_enable" bit as a gate, even though it's really just
 	 * enabling clock output.
 	 */
-	clk[IMX6QDL_CLK_LVDS1_GATE] = imx_clk_gate("lvds1_gate", "lvds1_sel", base + 0x160, 10);
-	clk[IMX6QDL_CLK_LVDS2_GATE] = imx_clk_gate("lvds2_gate", "lvds2_sel", base + 0x160, 11);
+	clk[IMX6QDL_CLK_LVDS1_GATE] = imx_clk_gate_exclusive("lvds1_gate", "lvds1_sel", base + 0x160, 10, BIT(12));
+	clk[IMX6QDL_CLK_LVDS2_GATE] = imx_clk_gate_exclusive("lvds2_gate", "lvds2_sel", base + 0x160, 11, BIT(13));
+
+	clk[IMX6QDL_CLK_LVDS1_IN] = imx_clk_gate_exclusive("lvds1_in", "anaclk1", base + 0x160, 12, BIT(10));
+	clk[IMX6QDL_CLK_LVDS2_IN] = imx_clk_gate_exclusive("lvds2_in", "anaclk2", base + 0x160, 13, BIT(11));
 
 	/*                                            name              parent_name        reg       idx */
 	clk[IMX6QDL_CLK_PLL2_PFD0_352M] = imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",     base + 0x100, 0);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 323e8650f198..e992ce5e05a5 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -220,6 +220,10 @@
 #define IMX6QDL_CLK_LVDS2_GATE			207
 #define IMX6QDL_CLK_ESAI_IPG			208
 #define IMX6QDL_CLK_ESAI_MEM			209
-#define IMX6QDL_CLK_END				210
+#define IMX6QDL_CLK_LVDS1_IN			210
+#define IMX6QDL_CLK_LVDS2_IN			211
+#define IMX6QDL_CLK_ANACLK1			212
+#define IMX6QDL_CLK_ANACLK2			213
+#define IMX6QDL_CLK_END				214
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
1.9.1
