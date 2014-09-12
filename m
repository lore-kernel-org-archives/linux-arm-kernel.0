From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Sep 2014 00:30:30 +0200
Subject: [PATCH v2 7/7] clk: rockchip: switch to using the new cpuclk type for
 armclk
In-Reply-To: <1410561030-19127-1-git-send-email-heiko@sntech.de>
References: <1410561030-19127-1-git-send-email-heiko@sntech.de>
Message-ID: <1410561030-19127-8-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the necessary soc-specific divider values and switches the armclk
to use the newly introduced cpuclk type.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3188.c | 104 ++++++++++++++++++++++++++++++++++++--
 drivers/clk/rockchip/clk-rk3288.c |  71 +++++++++++++++++++++++++-
 2 files changed, 169 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index adfbfef..db1a815 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -101,6 +101,100 @@ struct rockchip_pll_rate_table rk3188_pll_rates[] = {
 	{ /* sentinel */ },
 };
 
+#define RK3066_DIV_CORE_PERIPH_MASK	0x3
+#define RK3066_DIV_CORE_PERIPH_SHIFT	6
+#define RK3066_DIV_ACLK_CORE_MASK	0x7
+#define RK3066_DIV_ACLK_CORE_SHIFT	0
+#define RK3066_DIV_ACLK_HCLK_MASK	0x3
+#define RK3066_DIV_ACLK_HCLK_SHIFT	8
+#define RK3066_DIV_ACLK_PCLK_MASK	0x3
+#define RK3066_DIV_ACLK_PCLK_SHIFT	12
+#define RK3066_DIV_AHB2APB_MASK		0x3
+#define RK3066_DIV_AHB2APB_SHIFT	14
+
+#define RK3066_CLKSEL0(_core_peri)					\
+	{								\
+		.reg = RK2928_CLKSEL_CON(0),				\
+		.val = HIWORD_UPDATE(_core_peri, RK3066_DIV_CORE_PERIPH_MASK, \
+				RK3066_DIV_CORE_PERIPH_SHIFT)		\
+	}
+#define RK3066_CLKSEL1(_aclk_core, _aclk_hclk, _aclk_pclk, _ahb2apb)	\
+	{								\
+		.reg = RK2928_CLKSEL_CON(1),				\
+		.val = HIWORD_UPDATE(_aclk_core, RK3066_DIV_ACLK_CORE_MASK, \
+				RK3066_DIV_ACLK_CORE_SHIFT) |		\
+		       HIWORD_UPDATE(_aclk_hclk, RK3066_DIV_ACLK_HCLK_MASK, \
+				RK3066_DIV_ACLK_HCLK_SHIFT) |		\
+		       HIWORD_UPDATE(_aclk_pclk, RK3066_DIV_ACLK_PCLK_MASK, \
+				RK3066_DIV_ACLK_PCLK_SHIFT) |		\
+		       HIWORD_UPDATE(_ahb2apb, RK3066_DIV_AHB2APB_MASK,	\
+				RK3066_DIV_AHB2APB_SHIFT),		\
+	}
+
+#define RK3066_CPUCLK_RATE(_prate, _core_peri, _acore, _ahclk, _apclk, _h2p) \
+	{								\
+		.prate = _prate,					\
+		.divs = {						\
+			RK3066_CLKSEL0(_core_peri),			\
+			RK3066_CLKSEL1(_acore, _ahclk, _apclk, _h2p),	\
+		},							\
+	}
+
+static struct rockchip_cpuclk_rate_table rk3066_cpuclk_rates[] = {
+	RK3066_CPUCLK_RATE(1416000000, 2, 3, 1, 2, 1),
+	RK3066_CPUCLK_RATE(1200000000, 2, 3, 1, 2, 1),
+	RK3066_CPUCLK_RATE(1008000000, 2, 2, 1, 2, 1),
+	RK3066_CPUCLK_RATE( 816000000, 2, 2, 1, 2, 1),
+	RK3066_CPUCLK_RATE( 600000000, 1, 2, 1, 2, 1),
+	RK3066_CPUCLK_RATE( 504000000, 1, 1, 1, 2, 1),
+	RK3066_CPUCLK_RATE( 312000000, 0, 1, 1, 1, 0),
+	{ /* sentinel */ },
+};
+
+static const struct rockchip_cpuclk_reg_data rk3066_cpuclk_data = {
+	.core_reg = RK2928_CLKSEL_CON(0),
+	.div_core_shift = 0,
+	.div_core_mask = 0x1f,
+	.mux_core_shift = 8,
+};
+
+#define RK3188_DIV_ACLK_CORE_MASK	0x7
+#define RK3188_DIV_ACLK_CORE_SHIFT	3
+
+#define RK3188_CLKSEL1(_aclk_core)		\
+	{					\
+		.reg = RK2928_CLKSEL_CON(1),	\
+		.val = HIWORD_UPDATE(_aclk_core, RK3188_DIV_ACLK_CORE_MASK,\
+				 RK3188_DIV_ACLK_CORE_SHIFT) \
+	}
+#define RK3188_CPUCLK_RATE(_prate, _core_peri, _aclk_core)	\
+	{							\
+		.prate = _prate,				\
+		.divs = {					\
+			RK3066_CLKSEL0(_core_peri),		\
+			RK3188_CLKSEL1(_aclk_core),		\
+		},						\
+	}
+
+static struct rockchip_cpuclk_rate_table rk3188_cpuclk_rates[] = {
+	RK3188_CPUCLK_RATE(1608000000, 2, 3),
+	RK3188_CPUCLK_RATE(1416000000, 2, 3),
+	RK3188_CPUCLK_RATE(1200000000, 2, 3),
+	RK3188_CPUCLK_RATE(1008000000, 2, 3),
+	RK3188_CPUCLK_RATE( 816000000, 2, 3),
+	RK3188_CPUCLK_RATE( 600000000, 1, 3),
+	RK3188_CPUCLK_RATE( 504000000, 1, 3),
+	RK3188_CPUCLK_RATE( 312000000, 0, 1),
+	{ /* sentinel */ },
+};
+
+static const struct rockchip_cpuclk_reg_data rk3188_cpuclk_data = {
+	.core_reg = RK2928_CLKSEL_CON(0),
+	.div_core_shift = 9,
+	.div_core_mask = 0x1f,
+	.mux_core_shift = 8,
+};
+
 PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
 PNAME(mux_armclk_p)		= { "apll", "gpll_armclk" };
 PNAME(mux_ddrphy_p)		= { "dpll", "gpll_ddr" };
@@ -406,8 +500,6 @@ static struct clk_div_table div_aclk_cpu_t[] = {
 };
 
 static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
-	COMPOSITE_NOGATE(0, "armclk", mux_armclk_p, 0,
-			RK2928_CLKSEL_CON(0), 8, 1, MFLAGS, 0, 5, DFLAGS),
 	DIVTBL(0, "aclk_cpu_pre", "armclk", 0,
 			RK2928_CLKSEL_CON(1), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY, div_aclk_cpu_t),
 	DIV(0, "pclk_cpu_pre", "aclk_cpu_pre", 0,
@@ -528,8 +620,6 @@ PNAME(mux_hsicphy_p)		= { "sclk_otgphy0", "sclk_otgphy1",
 				    "gpll", "cpll" };
 
 static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
-	COMPOSITE_NOGATE(0, "armclk", mux_armclk_p, 0,
-			RK2928_CLKSEL_CON(0), 8, 1, MFLAGS, 9, 5, DFLAGS),
 	COMPOSITE_NOMUX_DIVTBL(0, "aclk_core", "armclk", 0,
 			RK2928_CLKSEL_CON(1), 3, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
 			div_rk3188_aclk_core_t, RK2928_CLKGATE_CON(0), 7, GFLAGS),
@@ -657,6 +747,9 @@ static void __init rk3066a_clk_init(struct device_node *np)
 				   RK3066_GRF_SOC_STATUS);
 	rockchip_clk_register_branches(rk3066a_clk_branches,
 				  ARRAY_SIZE(rk3066a_clk_branches));
+	rockchip_clk_register_armclk(ARMCLK, "armclk",
+			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+			&rk3066_cpuclk_data, rk3066_cpuclk_rates);
 }
 CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
 
@@ -672,6 +765,9 @@ static void __init rk3188a_clk_init(struct device_node *np)
 				   RK3188_GRF_SOC_STATUS);
 	rockchip_clk_register_branches(rk3188_clk_branches,
 				  ARRAY_SIZE(rk3188_clk_branches));
+	rockchip_clk_register_armclk(ARMCLK, "armclk",
+				  mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+				  &rk3188_cpuclk_data, rk3188_cpuclk_rates);
 
 	/* reparent aclk_cpu_pre from apll */
 	clk1 = __clk_lookup("aclk_cpu_pre");
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 2b23719..b019b3b 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -101,6 +101,71 @@ struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	{ /* sentinel */ },
 };
 
+#define RK3288_DIV_ACLK_CORE_M0_MASK	0xf
+#define RK3288_DIV_ACLK_CORE_M0_SHIFT	0
+#define RK3288_DIV_ACLK_CORE_MP_MASK	0xf
+#define RK3288_DIV_ACLK_CORE_MP_SHIFT	4
+#define RK3288_DIV_L2RAM_MASK		0x7
+#define RK3288_DIV_L2RAM_SHIFT		0
+#define RK3288_DIV_ATCLK_MASK		0x1f
+#define RK3288_DIV_ATCLK_SHIFT		4
+#define RK3288_DIV_PCLK_DBGPRE_MASK	0x1f
+#define RK3288_DIV_PCLK_DBGPRE_SHIFT	9
+
+#define RK3288_CLKSEL0(_core_m0, _core_mp)				\
+	{								\
+		.reg = RK3288_CLKSEL_CON(0),				\
+		.val = HIWORD_UPDATE(_core_m0, RK3288_DIV_ACLK_CORE_M0_MASK, \
+				RK3288_DIV_ACLK_CORE_M0_SHIFT) |	\
+		       HIWORD_UPDATE(_core_mp, RK3288_DIV_ACLK_CORE_MP_MASK, \
+				RK3288_DIV_ACLK_CORE_MP_SHIFT),		\
+	}
+#define RK3288_CLKSEL37(_l2ram, _atclk, _pclk_dbg_pre)			\
+	{								\
+		.reg = RK3288_CLKSEL_CON(37),				\
+		.val = HIWORD_UPDATE(_l2ram, RK3288_DIV_L2RAM_MASK,	\
+				RK3288_DIV_L2RAM_SHIFT) |		\
+		       HIWORD_UPDATE(_atclk, RK3288_DIV_ATCLK_MASK,	\
+				RK3288_DIV_ATCLK_SHIFT) |		\
+		       HIWORD_UPDATE(_pclk_dbg_pre,			\
+				RK3288_DIV_PCLK_DBGPRE_MASK,		\
+				RK3288_DIV_PCLK_DBGPRE_SHIFT),		\
+	}
+
+#define RK3288_CPUCLK_RATE(_prate, _core_m0, _core_mp, _l2ram, _atclk, _pdbg) \
+	{								\
+		.prate = _prate,					\
+		.divs = {						\
+			RK3288_CLKSEL0(_core_m0, _core_mp),		\
+			RK3288_CLKSEL37(_l2ram, _atclk, _pdbg),		\
+		},							\
+	}
+
+static struct rockchip_cpuclk_rate_table rk3288_cpuclk_rates[] = {
+	RK3288_CPUCLK_RATE(1800000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE(1704000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE(1608000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE(1512000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE(1416000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE(1200000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE(1008000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE( 816000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE( 696000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE( 600000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE( 408000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE( 312000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE( 216000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE( 126000000, 2, 4, 2, 4, 4),
+	{ /* sentinel */ },
+};
+
+static const struct rockchip_cpuclk_reg_data rk3288_cpuclk_data = {
+	.core_reg = RK3288_CLKSEL_CON(0),
+	.div_core_shift = 8,
+	.div_core_mask = 0x1f,
+	.mux_core_shift = 15,
+};
+
 PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
 PNAME(mux_armclk_p)		= { "apll_core", "gpll_core" };
 PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr" };
@@ -166,8 +231,6 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 			RK3288_CLKGATE_CON(0), 1, GFLAGS),
 	GATE(0, "gpll_core", "gpll", 0,
 			RK3288_CLKGATE_CON(0), 2, GFLAGS),
-	COMPOSITE_NOGATE(0, "armclk", mux_armclk_p, 0,
-			RK3288_CLKSEL_CON(0), 15, 1, MFLAGS, 8, 5, DFLAGS),
 
 	COMPOSITE_NOMUX(0, "armcore0", "armclk", 0,
 			RK3288_CLKSEL_CON(36), 0, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
@@ -719,6 +782,10 @@ static void __init rk3288_clk_init(struct device_node *np)
 	rockchip_clk_protect_critical(rk3288_critical_clocks,
 				      ARRAY_SIZE(rk3288_critical_clocks));
 
+	rockchip_clk_register_armclk(ARMCLK, "armclk",
+			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
+			&rk3288_cpuclk_data, rk3288_cpuclk_rates);
+
 	rockchip_register_softrst(np, 9, reg_base + RK3288_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 }
-- 
2.0.1
