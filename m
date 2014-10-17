From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 17 Oct 2014 21:41:50 +0530
Subject: [PATCH 2/7] clk: samsung: exynos7: add clocks for MMC block
In-Reply-To: <1413562315-12283-1-git-send-email-a.kesavan@samsung.com>
References: <1413562315-12283-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1413562315-12283-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>

Exynos7 supports 3 MMC channels, add the MMC gate clocks to
support them.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../devicetree/bindings/clock/exynos7-clock.txt    |    3 +
 drivers/clk/samsung/clk-exynos7.c                  |  224 ++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |   20 ++
 3 files changed, 247 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
index 789f761..4c69b66 100644
--- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
@@ -27,9 +27,12 @@ Required Properties for Clock Controller:
 
 	- "samsung,exynos7-clock-topc"
 	- "samsung,exynos7-clock-top0"
+	- "samsung,exynos7-clock-top1"
 	- "samsung,exynos7-clock-peric0"
 	- "samsung,exynos7-clock-peric1"
 	- "samsung,exynos7-clock-peris"
+	- "samsung,exynos7-clock-fsys0"
+	- "samsung,exynos7-clock-fsys1"
 
  - reg: physical base address of the controller and the length of
 	memory mapped region.
diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index c700f65..f5e43fa 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -267,6 +267,132 @@ static void __init exynos7_clk_top0_init(struct device_node *np)
 CLK_OF_DECLARE(exynos7_clk_top0, "samsung,exynos7-clock-top0",
 	exynos7_clk_top0_init);
 
+/* Register Offset definitions for CMU_TOP1 (0x105E0000) */
+#define MUX_SEL_TOP10			0x0200
+#define MUX_SEL_TOP11			0x0204
+#define MUX_SEL_TOP13			0x020C
+#define MUX_SEL_TOP1_FSYS0		0x0224
+#define MUX_SEL_TOP1_FSYS1		0x0228
+#define DIV_TOP13			0x060C
+#define DIV_TOP1_FSYS0			0x0624
+#define DIV_TOP1_FSYS1			0x0628
+#define ENABLE_ACLK_TOP13		0x080C
+#define ENABLE_SCLK_TOP1_FSYS0		0x0A24
+#define ENABLE_SCLK_TOP1_FSYS1		0x0A28
+
+/* List of parent clocks for Muxes in CMU_TOP1 */
+PNAME(mout_top1_bus0_pll_p)	= { "fin_pll", "dout_sclk_bus0_pll" };
+PNAME(mout_top1_bus1_pll_p)	= { "fin_pll", "dout_sclk_bus1_pll_b" };
+PNAME(mout_top1_cc_pll_p)	= { "fin_pll", "dout_sclk_cc_pll_b" };
+PNAME(mout_top1_mfc_pll_p)	= { "fin_pll", "dout_sclk_mfc_pll_b" };
+
+PNAME(mout_top1_half_bus0_pll_p) = {"mout_top1_bus0_pll",
+	"ffac_top1_bus0_pll_div2"};
+PNAME(mout_top1_half_bus1_pll_p) = {"mout_top1_bus1_pll",
+	"ffac_top1_bus1_pll_div2"};
+PNAME(mout_top1_half_cc_pll_p) = {"mout_top1_cc_pll",
+	"ffac_top1_cc_pll_div2"};
+PNAME(mout_top1_half_mfc_pll_p) = {"mout_top1_mfc_pll",
+	"ffac_top1_mfc_pll_div2"};
+
+PNAME(mout_top1_group1) = {"mout_top1_half_bus0_pll",
+	"mout_top1_half_bus1_pll", "mout_top1_half_cc_pll",
+	"mout_top1_half_mfc_pll"};
+
+static unsigned long top1_clk_regs[] __initdata = {
+	MUX_SEL_TOP10,
+	MUX_SEL_TOP11,
+	MUX_SEL_TOP13,
+	MUX_SEL_TOP1_FSYS0,
+	MUX_SEL_TOP1_FSYS1,
+	DIV_TOP13,
+	DIV_TOP1_FSYS0,
+	DIV_TOP1_FSYS1,
+	ENABLE_ACLK_TOP13,
+	ENABLE_SCLK_TOP1_FSYS0,
+	ENABLE_SCLK_TOP1_FSYS1,
+};
+
+static struct samsung_mux_clock top1_mux_clks[] __initdata = {
+	MUX(0, "mout_top1_mfc_pll", mout_top1_mfc_pll_p, MUX_SEL_TOP10, 4, 1),
+	MUX(0, "mout_top1_cc_pll", mout_top1_cc_pll_p, MUX_SEL_TOP10, 8, 1),
+	MUX(0, "mout_top1_bus1_pll", mout_top1_bus1_pll_p,
+		MUX_SEL_TOP10, 12, 1),
+	MUX(0, "mout_top1_bus0_pll", mout_top1_bus0_pll_p,
+		MUX_SEL_TOP10, 16, 1),
+
+	MUX(0, "mout_top1_half_mfc_pll", mout_top1_half_mfc_pll_p,
+		MUX_SEL_TOP11, 4, 1),
+	MUX(0, "mout_top1_half_cc_pll", mout_top1_half_cc_pll_p,
+		MUX_SEL_TOP11, 8, 1),
+	MUX(0, "mout_top1_half_bus1_pll", mout_top1_half_bus1_pll_p,
+		MUX_SEL_TOP11, 12, 1),
+	MUX(0, "mout_top1_half_bus0_pll", mout_top1_half_bus0_pll_p,
+		MUX_SEL_TOP11, 16, 1),
+
+	MUX(0, "mout_aclk_fsys1_200", mout_top1_group1, MUX_SEL_TOP13, 24, 2),
+	MUX(0, "mout_aclk_fsys0_200", mout_top1_group1, MUX_SEL_TOP13, 28, 2),
+
+	MUX(0, "mout_sclk_mmc2", mout_top1_group1, MUX_SEL_TOP1_FSYS0, 24, 2),
+
+	MUX(0, "mout_sclk_mmc1", mout_top1_group1, MUX_SEL_TOP1_FSYS1, 24, 2),
+	MUX(0, "mout_sclk_mmc0", mout_top1_group1, MUX_SEL_TOP1_FSYS1, 28, 2),
+};
+
+static struct samsung_div_clock top1_div_clks[] __initdata = {
+	DIV(DOUT_ACLK_FSYS1_200, "dout_aclk_fsys1_200", "mout_aclk_fsys1_200",
+		DIV_TOP13, 24, 4),
+	DIV(DOUT_ACLK_FSYS0_200, "dout_aclk_fsys0_200", "mout_aclk_fsys0_200",
+		DIV_TOP13, 28, 4),
+
+	DIV(DOUT_SCLK_MMC2, "dout_sclk_mmc2", "mout_sclk_mmc2",
+		DIV_TOP1_FSYS0, 24, 4),
+
+	DIV(DOUT_SCLK_MMC1, "dout_sclk_mmc1", "mout_sclk_mmc1",
+		DIV_TOP1_FSYS1, 24, 4),
+	DIV(DOUT_SCLK_MMC0, "dout_sclk_mmc0", "mout_sclk_mmc0",
+		DIV_TOP1_FSYS1, 28, 4),
+};
+
+static struct samsung_gate_clock top1_gate_clks[] __initdata = {
+	GATE(CLK_SCLK_MMC2, "sclk_mmc2", "dout_sclk_mmc2",
+		ENABLE_SCLK_TOP1_FSYS0, 24, CLK_SET_RATE_PARENT, 0),
+
+	GATE(CLK_SCLK_MMC1, "sclk_mmc1", "dout_sclk_mmc1",
+		ENABLE_SCLK_TOP1_FSYS1, 24, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SCLK_MMC0, "sclk_mmc0", "dout_sclk_mmc0",
+		ENABLE_SCLK_TOP1_FSYS1, 28, CLK_SET_RATE_PARENT, 0),
+};
+
+static struct samsung_fixed_factor_clock top1_fixed_factor_clks[] __initdata = {
+	FFACTOR(0, "ffac_top1_bus0_pll_div2", "mout_top1_bus0_pll", 1, 2, 0),
+	FFACTOR(0, "ffac_top1_bus1_pll_div2", "mout_top1_bus1_pll", 1, 2, 0),
+	FFACTOR(0, "ffac_top1_cc_pll_div2", "mout_top1_cc_pll", 1, 2, 0),
+	FFACTOR(0, "ffac_top1_mfc_pll_div2", "mout_top1_mfc_pll", 1, 2, 0),
+};
+
+static struct samsung_cmu_info top1_cmu_info __initdata = {
+	.mux_clks		= top1_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(top1_mux_clks),
+	.div_clks		= top1_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(top1_div_clks),
+	.gate_clks		= top1_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(top1_gate_clks),
+	.fixed_factor_clks	= top1_fixed_factor_clks,
+	.nr_fixed_factor_clks	= ARRAY_SIZE(top1_fixed_factor_clks),
+	.nr_clk_ids		= TOP1_NR_CLK,
+	.clk_regs		= top1_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(top1_clk_regs),
+};
+
+static void __init exynos7_clk_top1_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &top1_cmu_info);
+}
+
+CLK_OF_DECLARE(exynos7_clk_top1, "samsung,exynos7-clock-top1",
+	exynos7_clk_top1_init);
+
 /* Register Offset definitions for CMU_PERIC0 (0x13610000) */
 #define MUX_SEL_PERIC0			0x0200
 #define ENABLE_PCLK_PERIC0		0x0900
@@ -447,3 +573,101 @@ static void __init exynos7_clk_peris_init(struct device_node *np)
 
 CLK_OF_DECLARE(exynos7_clk_peris, "samsung,exynos7-clock-peris",
 	exynos7_clk_peris_init);
+
+/* Register Offset definitions for CMU_FSYS0 (0x10E90000) */
+#define MUX_SEL_FSYS00			0x0200
+#define MUX_SEL_FSYS01			0x0204
+#define ENABLE_ACLK_FSYS01		0x0804
+
+/*
+ * List of parent clocks for Muxes in CMU_FSYS0
+ */
+PNAME(mout_aclk_fsys0_200_p)	= { "fin_pll", "dout_aclk_fsys0_200" };
+PNAME(mout_sclk_mmc2_p)		= { "fin_pll", "sclk_mmc2" };
+
+static unsigned long fsys0_clk_regs[] __initdata = {
+	MUX_SEL_FSYS00,
+	MUX_SEL_FSYS01,
+	ENABLE_ACLK_FSYS01,
+};
+
+static struct samsung_mux_clock fsys0_mux_clks[] __initdata = {
+	MUX(0, "mout_aclk_fsys0_200_user", mout_aclk_fsys0_200_p,
+		MUX_SEL_FSYS00, 24, 1),
+
+	MUX(0, "mout_sclk_mmc2_user", mout_sclk_mmc2_p, MUX_SEL_FSYS01, 24, 1),
+};
+
+static struct samsung_gate_clock fsys0_gate_clks[] __initdata = {
+	GATE(ACLK_MMC2, "aclk_mmc2", "mout_aclk_fsys0_200_user",
+		ENABLE_ACLK_FSYS01, 31, 0, 0),
+};
+
+static struct samsung_cmu_info fsys0_cmu_info __initdata = {
+	.mux_clks		= fsys0_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(fsys0_mux_clks),
+	.gate_clks		= fsys0_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(fsys0_gate_clks),
+	.nr_clk_ids		= TOP1_NR_CLK,
+	.clk_regs		= fsys0_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(fsys0_clk_regs),
+};
+
+static void __init exynos7_clk_fsys0_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &fsys0_cmu_info);
+}
+
+CLK_OF_DECLARE(exynos7_clk_fsys0, "samsung,exynos7-clock-fsys0",
+	exynos7_clk_fsys0_init);
+
+/* Register Offset definitions for CMU_FSYS1 (0x156E0000) */
+#define MUX_SEL_FSYS10			0x0200
+#define MUX_SEL_FSYS11			0x0204
+#define ENABLE_ACLK_FSYS1		0x0800
+
+/*
+ * List of parent clocks for Muxes in CMU_FSYS1
+ */
+PNAME(mout_aclk_fsys1_200_p)	= { "fin_pll",  "dout_aclk_fsys1_200" };
+PNAME(mout_sclk_mmc0_p)		= { "fin_pll", "sclk_mmc0" };
+PNAME(mout_sclk_mmc1_p)		= { "fin_pll", "sclk_mmc1" };
+
+static unsigned long fsys1_clk_regs[] __initdata = {
+	MUX_SEL_FSYS10,
+	MUX_SEL_FSYS11,
+	ENABLE_ACLK_FSYS1,
+};
+
+static struct samsung_mux_clock fsys1_mux_clks[] __initdata = {
+	MUX(0, "mout_aclk_fsys1_200_user", mout_aclk_fsys1_200_p,
+		MUX_SEL_FSYS10, 28, 1),
+
+	MUX(0, "mout_sclk_mmc1_user", mout_sclk_mmc1_p, MUX_SEL_FSYS11, 24, 1),
+	MUX(0, "mout_sclk_mmc0_user", mout_sclk_mmc0_p, MUX_SEL_FSYS11, 28, 1),
+};
+
+static struct samsung_gate_clock fsys1_gate_clks[] __initdata = {
+	GATE(ACLK_MMC1, "aclk_mmc1", "mout_aclk_fsys1_200_user",
+		ENABLE_ACLK_FSYS1, 29, 0, 0),
+	GATE(ACLK_MMC0, "aclk_mmc0", "mout_aclk_fsys1_200_user",
+		ENABLE_ACLK_FSYS1, 30, 0, 0),
+};
+
+static struct samsung_cmu_info fsys1_cmu_info __initdata = {
+	.mux_clks		= fsys1_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(fsys1_mux_clks),
+	.gate_clks		= fsys1_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(fsys1_gate_clks),
+	.nr_clk_ids		= TOP1_NR_CLK,
+	.clk_regs		= fsys1_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(fsys1_clk_regs),
+};
+
+static void __init exynos7_clk_fsys1_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &fsys1_cmu_info);
+}
+
+CLK_OF_DECLARE(exynos7_clk_fsys1, "samsung,exynos7-clock-fsys1",
+	exynos7_clk_fsys1_init);
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 6d07b6f..ff63c4e 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -27,6 +27,17 @@
 #define CLK_SCLK_UART3			6
 #define TOP0_NR_CLK			7
 
+/* TOP1 */
+#define DOUT_ACLK_FSYS1_200		1
+#define DOUT_ACLK_FSYS0_200		2
+#define DOUT_SCLK_MMC2			3
+#define DOUT_SCLK_MMC1			4
+#define DOUT_SCLK_MMC0			5
+#define CLK_SCLK_MMC2			6
+#define CLK_SCLK_MMC1			7
+#define CLK_SCLK_MMC0			8
+#define TOP1_NR_CLK			9
+
 /* PERIC0 */
 #define PCLK_UART0			1
 #define SCLK_UART0			2
@@ -58,4 +69,13 @@
 #define SCLK_CHIPID			2
 #define PERIS_NR_CLK			3
 
+/* FSYS0 */
+#define ACLK_MMC2			1
+#define FSYS0_NR_CLK			2
+
+/* FSYS1 */
+#define ACLK_MMC1			1
+#define ACLK_MMC0			2
+#define FSYS1_NR_CLK			3
+
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS7_H */
-- 
1.7.9.5
