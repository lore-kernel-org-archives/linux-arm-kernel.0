From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 17:41:48 +0900
Subject: [PATCH 2/2] clk: samsung: exynos5420: Add clocks for CMU_CDREX domain
In-Reply-To: <1471855308-12791-1-git-send-email-cw00.choi@samsung.com>
References: <1471855308-12791-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471855308-12791-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the mux/divider clocks for CMU_CDREX (DRAM Express
Controller) which generates the clocks for DRAM and NoC (Network on Chip) bus
clock. But, there is differnet source of MUX_MX_MSPLL_CCORE between exynos5420
and exynos5422. So, each MUX_MX_MSPLL_CCORE uses the different parent source
group.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 586a3da515f3..16b7d160fbdf 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -131,6 +131,9 @@
 #define TOP_SPARE2		0x10b08
 #define BPLL_LOCK		0x20010
 #define BPLL_CON0		0x20110
+#define SRC_CDREX		0x20200
+#define DIV_CDREX0		0x20500
+#define DIV_CDREX1		0x20504
 #define KPLL_LOCK		0x28000
 #define KPLL_CON0		0x28100
 #define SRC_KFC			0x28200
@@ -244,6 +247,9 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
 	GATE_TOP_SCLK_FSYS,
 	GATE_TOP_SCLK_PERIC,
 	TOP_SPARE2,
+	SRC_CDREX,
+	DIV_CDREX0,
+	DIV_CDREX1,
 	SRC_KFC,
 	DIV_KFC0,
 };
@@ -447,6 +453,8 @@ PNAME(mout_maudio0_p) = {"fin_pll", "maudio_clk", "mout_sclk_dpll",
 			 "mout_sclk_epll", "mout_sclk_rpll"};
 PNAME(mout_mau_epll_clk_p) = {"mout_sclk_epll", "mout_sclk_dpll",
 				"mout_sclk_mpll", "mout_sclk_spll"};
+PNAME(mout_mclk_cdrex_p) = {"mout_bpll", "mout_mx_mspll_ccore"};
+
 /* List of parents specific to exynos5800 */
 PNAME(mout_epll2_5800_p)	= { "mout_sclk_epll", "ff_dout_epll2" };
 PNAME(mout_group1_5800_p)	= { "mout_sclk_cpll", "mout_sclk_dpll",
@@ -464,6 +472,9 @@ PNAME(mout_group6_5800_p)	= { "mout_sclk_ipll", "mout_sclk_dpll",
 PNAME(mout_group7_5800_p)	= { "mout_sclk_cpll", "mout_sclk_dpll",
 					"mout_sclk_mpll", "mout_sclk_spll",
 					"mout_epll2", "mout_sclk_ipll" };
+PNAME(mout_mx_mspll_ccore_p)	= {"sclk_bpll", "mout_sclk_dpll",
+					"mout_sclk_mpll", "ff_dout_spll2",
+					"mout_sclk_spll", "mout_sclk_epll"};
 PNAME(mout_mau_epll_clk_5800_p)	= { "mout_sclk_epll", "mout_sclk_dpll",
 					"mout_sclk_mpll",
 					"ff_dout_spll2" };
@@ -520,6 +531,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
 	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
 
+	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
+			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
 	MUX(0, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p, SRC_TOP7,
 			20, 2),
 	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
@@ -598,6 +611,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
 	MUX(0, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
 
+	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
+			mout_group5_5800_p, SRC_TOP7, 16, 2),
 	MUX(0, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2),
 
 	MUX(0, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
@@ -741,6 +756,11 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 
 	MUX(0, "mout_fimd1_final", mout_fimd1_final_p, TOP_SPARE2, 8, 1),
 
+	/* CDREX block */
+	MUX(CLK_MOUT_MCLK_CDREX, "mout_mclk_cdrex", mout_mclk_cdrex_p,
+			SRC_CDREX, 4, 1),
+	MUX(CLK_MOUT_BPLL, "mout_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
+
 	/* MAU Block */
 	MUX(CLK_MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3),
 
@@ -833,6 +853,21 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 	DIV(CLK_DOUT_ACLK400_DISP1, "dout_aclk400_disp1",
 			"mout_aclk400_disp1", DIV_TOP2, 4, 3),
 
+	/* CDREX Block */
+	DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
+			DIV_CDREX0, 28, 3),
+	DIV(CLK_DOUT_SCLK_CDREX, "dout_sclk_cdrex", "mout_mclk_cdrex",
+			DIV_CDREX0, 24, 3),
+	DIV(CLK_DOUT_ACLK_CDREX1, "dout_aclk_cdrex1", "dout_clk2x_phy0",
+			DIV_CDREX0, 16, 3),
+	DIV(CLK_DOUT_CCLK_DREX0, "dout_cclk_drex0", "dout_clk2x_phy0",
+			DIV_CDREX0, 8, 3),
+	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
+			DIV_CDREX0, 3, 5),
+
+	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
+			DIV_CDREX1, 8, 3),
+
 	/* Audio Block */
 	DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
 	DIV(0, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
-- 
1.9.1
