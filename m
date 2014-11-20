From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 20 Nov 2014 20:38:52 +0100
Subject: [PATCH v2 3/4] clk: rockchip: add optional sync to pll rate parameters
In-Reply-To: <1416512333-15438-1-git-send-email-heiko@sntech.de>
References: <1416512333-15438-1-git-send-email-heiko@sntech.de>
Message-ID: <1416512333-15438-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases firmware brings up plls with different parameters than the ones
noted in the rate table for the specific frequency. These firmware-selected
parameters are worse than the tested ones in the pll rate tables but cannot
be changed by a simple clk_set_rate call when the rate stays the same.

Therefore add a ROCKCHIP_PLL_SYNC_RATE flag and implement an init callback
that checks the runtime-parameters against the matching rate table entry
and adjusts them to the table-ones if necessary.

If no rate table is set or the current rate does not match any rate-table
entry no changes are made.

Being able to limit this adjustment to specific plls is necessary to not
touch the ones supplying core components like the apll and dpll supplying
the armcores and dram.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-pll.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.h     |  6 +++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 1bb6891..f8d3baf 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -258,6 +258,55 @@ static int rockchip_rk3066_pll_is_enabled(struct clk_hw *hw)
 	return !(pllcon & RK3066_PLLCON3_PWRDOWN);
 }
 
+static void rockchip_rk3066_pll_init(struct clk_hw *hw)
+{
+	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
+	const struct rockchip_pll_rate_table *rate;
+	unsigned int nf, nr, no, bwadj;
+	unsigned long drate;
+	u32 pllcon;
+
+	if (!(pll->flags & ROCKCHIP_PLL_SYNC_RATE))
+		return;
+
+	drate = __clk_get_rate(hw->clk);
+	rate = rockchip_get_pll_settings(pll, drate);
+
+	/* when no rate setting for the current rate, rely on clk_set_rate */
+	if (!rate)
+		return;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(0));
+	nr = ((pllcon >> RK3066_PLLCON0_NR_SHIFT) & RK3066_PLLCON0_NR_MASK) + 1;
+	no = ((pllcon >> RK3066_PLLCON0_OD_SHIFT) & RK3066_PLLCON0_OD_MASK) + 1;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(1));
+	nf = ((pllcon >> RK3066_PLLCON1_NF_SHIFT) & RK3066_PLLCON1_NF_MASK) + 1;
+
+	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(2));
+	bwadj = (pllcon >> RK3066_PLLCON2_BWADJ_SHIFT) & RK3066_PLLCON2_BWADJ_MASK;
+
+	pr_debug("%s: pll %s@%lu: nr (%d:%d); no (%d:%d); nf(%d:%d), bwadj(%d:%d)\n",
+		 __func__, __clk_get_name(hw->clk), drate, rate->nr, nr,
+		rate->no, no, rate->nf, nf, rate->bwadj, bwadj);
+	if (rate->nr != nr || rate->no != no || rate->nf != nf
+					     || rate->bwadj != bwadj) {
+		struct clk *parent = __clk_get_parent(hw->clk);
+		unsigned long prate;
+
+		if (!parent) {
+			pr_warn("%s: parent of %s not available\n",
+				__func__, __clk_get_name(hw->clk));
+			return;
+		}
+
+		pr_debug("%s: pll %s: rate params do not match rate table, adjusting\n",
+			 __func__, __clk_get_name(hw->clk));
+		prate = __clk_get_rate(parent);
+		rockchip_rk3066_pll_set_rate(hw, drate, prate);
+	}
+}
+
 static const struct clk_ops rockchip_rk3066_pll_clk_norate_ops = {
 	.recalc_rate = rockchip_rk3066_pll_recalc_rate,
 	.enable = rockchip_rk3066_pll_enable,
@@ -272,6 +321,7 @@ static const struct clk_ops rockchip_rk3066_pll_clk_ops = {
 	.enable = rockchip_rk3066_pll_enable,
 	.disable = rockchip_rk3066_pll_disable,
 	.is_enabled = rockchip_rk3066_pll_is_enabled,
+	.init = rockchip_rk3066_pll_init,
 };
 
 /*
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index eefd39a..dc94681 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -92,6 +92,10 @@ struct rockchip_pll_rate_table {
  * @type: Type of PLL to be registered.
  * @pll_flags: hardware-specific flags
  * @rate_table: Table of usable pll rates
+ *
+ * Flags:
+ * ROCKCHIP_PLL_SYNC_RATE - check rate parameters to match against the
+ *	rate_table parameters and ajust them if necessary.
  */
 struct rockchip_pll_clock {
 	unsigned int		id;
@@ -108,6 +112,8 @@ struct rockchip_pll_clock {
 	struct rockchip_pll_rate_table *rate_table;
 };
 
+#define ROCKCHIP_PLL_SYNC_RATE		BIT(0)
+
 #define PLL(_type, _id, _name, _pnames, _flags, _con, _mode, _mshift,	\
 		_lshift, _pflags, _rtable)				\
 	{								\
-- 
2.1.1
