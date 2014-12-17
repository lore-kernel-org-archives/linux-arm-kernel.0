From: tony.kn@samsung.com (Tony K Nadackal)
Date: Wed, 17 Dec 2014 13:03:37 +0530
Subject: [PATCH] clk: samsung: exynos7: Add clocks for MSCL block
Message-ID: <1418801617-7593-1-git-send-email-tony.kn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock support for the MSCL block for Exynos7.

Signed-off-by: Tony K Nadackal <tony.kn@samsung.com>
---
 .../devicetree/bindings/clock/exynos7-clock.txt    |   1 +
 drivers/clk/samsung/clk-exynos7.c                  | 124 +++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |  40 ++++++-
 3 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
index 6d3d5f8..d0e048c 100644
--- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
@@ -34,6 +34,7 @@ Required Properties for Clock Controller:
 	- "samsung,exynos7-clock-peris"
 	- "samsung,exynos7-clock-fsys0"
 	- "samsung,exynos7-clock-fsys1"
+	- "samsung,exynos7-clock-mscl"
 
  - reg: physical base address of the controller and the length of
 	memory mapped region.
diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index a79bf23..95c1160 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -34,6 +34,7 @@
 #define DIV_TOPC0		0x0600
 #define DIV_TOPC1		0x0604
 #define DIV_TOPC3		0x060C
+#define	ENABLE_ACLK_TOPC1	0x0804
 
 static struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initdata = {
 	FFACTOR(0, "ffac_topc_bus0_pll_div2", "mout_bus0_pll_ctrl", 1, 2, 0),
@@ -107,6 +108,7 @@ static struct samsung_mux_clock topc_mux_clks[] __initdata = {
 
 	MUX(0, "mout_aclk_ccore_133", mout_topc_group2,	MUX_SEL_TOPC2, 4, 2),
 
+	MUX(0, "mout_aclk_mscl_532", mout_topc_group2, MUX_SEL_TOPC3, 20, 2),
 	MUX(0, "mout_aclk_peris_66", mout_topc_group2, MUX_SEL_TOPC3, 24, 2),
 };
 
@@ -114,6 +116,8 @@ static struct samsung_div_clock topc_div_clks[] __initdata = {
 	DIV(DOUT_ACLK_CCORE_133, "dout_aclk_ccore_133", "mout_aclk_ccore_133",
 		DIV_TOPC0, 4, 4),
 
+	DIV(DOUT_ACLK_MSCL_532, "dout_aclk_mscl_532", "mout_aclk_mscl_532",
+		DIV_TOPC1, 20, 4),
 	DIV(DOUT_ACLK_PERIS, "dout_aclk_peris_66", "mout_aclk_peris_66",
 		DIV_TOPC1, 24, 4),
 
@@ -127,6 +131,11 @@ static struct samsung_div_clock topc_div_clks[] __initdata = {
 		DIV_TOPC3, 16, 3),
 };
 
+static struct samsung_gate_clock topc_gate_clks[] __initdata = {
+	GATE(ACLK_MSCL_532, "aclk_mscl_532", "dout_aclk_mscl_532",
+		ENABLE_ACLK_TOPC1, 20, 0, 0),
+};
+
 static struct samsung_pll_clock topc_pll_clks[] __initdata = {
 	PLL(pll_1451x, 0, "fout_bus0_pll", "fin_pll", BUS0_PLL_LOCK,
 		BUS0_PLL_CON0, NULL),
@@ -147,6 +156,8 @@ static struct samsung_cmu_info topc_cmu_info __initdata = {
 	.nr_mux_clks		= ARRAY_SIZE(topc_mux_clks),
 	.div_clks		= topc_div_clks,
 	.nr_div_clks		= ARRAY_SIZE(topc_div_clks),
+	.gate_clks		= topc_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(topc_gate_clks),
 	.fixed_factor_clks	= topc_fixed_factor_clks,
 	.nr_fixed_factor_clks	= ARRAY_SIZE(topc_fixed_factor_clks),
 	.nr_clk_ids		= TOPC_NR_CLK,
@@ -743,3 +754,116 @@ static void __init exynos7_clk_fsys1_init(struct device_node *np)
 
 CLK_OF_DECLARE(exynos7_clk_fsys1, "samsung,exynos7-clock-fsys1",
 	exynos7_clk_fsys1_init);
+
+#define MUX_SEL_MSCL			0x0200
+#define DIV_MSCL			0x0600
+#define ENABLE_ACLK_MSCL		0x0800
+#define ENABLE_PCLK_MSCL		0x0900
+
+/* List of parent clocks for Muxes in CMU_MSCL */
+PNAME(mout_aclk_mscl_532_user_p)	= { "fin_pll", "aclk_mscl_532" };
+
+static unsigned long mscl_clk_regs[] __initdata = {
+	MUX_SEL_MSCL,
+	DIV_MSCL,
+	ENABLE_ACLK_MSCL,
+	ENABLE_PCLK_MSCL,
+};
+
+static struct samsung_mux_clock mscl_mux_clks[] __initdata = {
+	MUX(USERMUX_ACLK_MSCL_532, "usermux_aclk_mscl_532",
+		mout_aclk_mscl_532_user_p, MUX_SEL_MSCL, 0, 1),
+};
+static struct samsung_div_clock mscl_div_clks[] __initdata = {
+	DIV(DOUT_PCLK_MSCL, "dout_pclk_mscl", "usermux_aclk_mscl_532",
+			DIV_MSCL, 0, 3),
+};
+static struct samsung_gate_clock mscl_gate_clks[] __initdata = {
+
+	GATE(ACLK_MSCL_0, "aclk_mscl_0", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 31, 0, 0),
+	GATE(ACLK_MSCL_1, "aclk_mscl_1", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 30, 0, 0),
+	GATE(ACLK_JPEG, "aclk_jpeg", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 29, 0, 0),
+	GATE(ACLK_G2D, "aclk_g2d", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 28, 0, 0),
+	GATE(ACLK_LH_ASYNC_SI_MSCL_0, "aclk_lh_async_si_mscl_0",
+			"usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 27, 0, 0),
+	GATE(ACLK_LH_ASYNC_SI_MSCL_1, "aclk_lh_async_si_mscl_1",
+			"usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 26, 0, 0),
+	GATE(ACLK_XIU_MSCLX_0, "aclk_xiu_msclx_0", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 25, 0, 0),
+	GATE(ACLK_XIU_MSCLX_1, "aclk_xiu_msclx_1", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 24, 0, 0),
+	GATE(ACLK_AXI2ACEL_BRIDGE, "aclk_axi2acel_bridge",
+			"usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 23, 0, 0),
+	GATE(ACLK_QE_MSCL_0, "aclk_qe_mscl_0", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 22, 0, 0),
+	GATE(ACLK_QE_MSCL_1, "aclk_qe_mscl_1", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 21, 0, 0),
+	GATE(ACLK_QE_JPEG, "aclk_qe_jpeg", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 20, 0, 0),
+	GATE(ACLK_QE_G2D, "aclk_qe_g2d", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 19, 0, 0),
+	GATE(ACLK_PPMU_MSCL_0, "aclk_ppmu_mscl_0", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 18, 0, 0),
+	GATE(ACLK_PPMU_MSCL_1, "aclk_ppmu_mscl_1", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 17, 0, 0),
+	GATE(ACLK_MSCLNP_133, "aclk_msclnp_133", "usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 16, 0, 0),
+	GATE(ACLK_AHB2APB_MSCL0P, "aclk_ahb2apb_mscl0p",
+			"usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 15, 0, 0),
+	GATE(ACLK_AHB2APB_MSCL1P, "aclk_ahb2apb_mscl1p",
+			"usermux_aclk_mscl_532",
+			ENABLE_ACLK_MSCL, 14, 0, 0),
+
+	GATE(PCLK_MSCL_0, "pclk_mscl_0", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 31, 0, 0),
+	GATE(PCLK_MSCL_1, "pclk_mscl_1", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 30, 0, 0),
+	GATE(PCLK_JPEG, "pclk_jpeg", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 29, 0, 0),
+	GATE(PCLK_G2D, "pclk_g2d", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 28, 0, 0),
+	GATE(PCLK_QE_MSCL_0, "pclk_qe_mscl_0", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 27, 0, 0),
+	GATE(PCLK_QE_MSCL_1, "pclk_qe_mscl_1", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 26, 0, 0),
+	GATE(PCLK_QE_JPEG, "pclk_qe_jpeg", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 25, 0, 0),
+	GATE(PCLK_QE_G2D, "pclk_qe_g2d", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 24, 0, 0),
+	GATE(PCLK_PPMU_MSCL_0, "pclk_ppmu_mscl_0", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 23, 0, 0),
+	GATE(PCLK_PPMU_MSCL_1, "pclk_ppmu_mscl_1", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 22, 0, 0),
+	GATE(PCLK_AXI2ACEL_BRIDGE, "pclk_axi2acel_bridge", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 21, 0, 0),
+	GATE(PCLK_PMU_MSCL, "pclk_pmu_mscl", "dout_pclk_mscl",
+			ENABLE_PCLK_MSCL, 20, 0, 0),
+};
+
+static struct samsung_cmu_info mscl_cmu_info __initdata = {
+	.mux_clks		= mscl_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(mscl_mux_clks),
+	.div_clks		= mscl_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(mscl_div_clks),
+	.gate_clks		= mscl_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(mscl_gate_clks),
+	.nr_clk_ids		= MSCL_NR_CLK,
+	.clk_regs		= mscl_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(mscl_clk_regs),
+};
+
+static void __init exynos7_clk_mscl_init(struct device_node *np)
+{
+	samsung_cmu_register_one(np, &mscl_cmu_info);
+}
+
+CLK_OF_DECLARE(exynos7_clk_mscl, "samsung,exynos7-clock-mscl",
+		exynos7_clk_mscl_init);
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index e0bad38..dff504a 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -17,7 +17,9 @@
 #define DOUT_SCLK_CC_PLL		4
 #define DOUT_SCLK_MFC_PLL		5
 #define DOUT_ACLK_CCORE_133		6
-#define TOPC_NR_CLK			7
+#define DOUT_ACLK_MSCL_532		7
+#define ACLK_MSCL_532			8
+#define TOPC_NR_CLK			9
 
 /* TOP0 */
 #define DOUT_ACLK_PERIC1		1
@@ -90,4 +92,40 @@
 #define ACLK_MMC0			2
 #define FSYS1_NR_CLK			3
 
+/* MSCL */
+#define USERMUX_ACLK_MSCL_532		1
+#define DOUT_PCLK_MSCL			2
+#define ACLK_MSCL_0			3
+#define ACLK_MSCL_1			4
+#define ACLK_JPEG			5
+#define ACLK_G2D			6
+#define ACLK_LH_ASYNC_SI_MSCL_0		7
+#define ACLK_LH_ASYNC_SI_MSCL_1		8
+#define ACLK_AXI2ACEL_BRIDGE		9
+#define ACLK_XIU_MSCLX_0		10
+#define ACLK_XIU_MSCLX_1		11
+#define ACLK_QE_MSCL_0			12
+#define ACLK_QE_MSCL_1			13
+#define ACLK_QE_JPEG			14
+#define ACLK_QE_G2D			15
+#define ACLK_PPMU_MSCL_0		16
+#define ACLK_PPMU_MSCL_1		17
+#define ACLK_MSCLNP_133			18
+#define ACLK_AHB2APB_MSCL0P		19
+#define ACLK_AHB2APB_MSCL1P		20
+
+#define PCLK_MSCL_0			21
+#define PCLK_MSCL_1			22
+#define PCLK_JPEG			23
+#define PCLK_G2D			24
+#define PCLK_QE_MSCL_0			25
+#define PCLK_QE_MSCL_1			26
+#define PCLK_QE_JPEG			27
+#define PCLK_QE_G2D			28
+#define PCLK_PPMU_MSCL_0		29
+#define PCLK_PPMU_MSCL_1		30
+#define PCLK_AXI2ACEL_BRIDGE		31
+#define PCLK_PMU_MSCL			32
+#define MSCL_NR_CLK			33
+
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS7_H */
-- 
2.2.0
