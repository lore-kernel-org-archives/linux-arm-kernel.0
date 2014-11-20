From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 20 Nov 2014 20:38:50 +0100
Subject: [PATCH v2 1/4] clk: rockchip: add ability to specify pll-specific
 flags
In-Reply-To: <1416512333-15438-1-git-send-email-heiko@sntech.de>
References: <1416512333-15438-1-git-send-email-heiko@sntech.de>
Message-ID: <1416512333-15438-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a flag parameter to plls that allows us to create
special flags to tweak the behaviour of the plls if necessary.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-pll.c    |  4 +++-
 drivers/clk/rockchip/clk-rk3188.c |  8 ++++----
 drivers/clk/rockchip/clk-rk3288.c | 10 +++++-----
 drivers/clk/rockchip/clk.c        |  3 ++-
 drivers/clk/rockchip/clk.h        |  7 +++++--
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index a3e886a..feb9cad 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -39,6 +39,7 @@ struct rockchip_clk_pll {
 	int			lock_offset;
 	unsigned int		lock_shift;
 	enum rockchip_pll_type	type;
+	u8			flags;
 	const struct rockchip_pll_rate_table *rate_table;
 	unsigned int		rate_count;
 	spinlock_t		*lock;
@@ -282,7 +283,7 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 		void __iomem *base, int con_offset, int grf_lock_offset,
 		int lock_shift, int mode_offset, int mode_shift,
 		struct rockchip_pll_rate_table *rate_table,
-		spinlock_t *lock)
+		u8 clk_pll_flags, spinlock_t *lock)
 {
 	const char *pll_parents[3];
 	struct clk_init_data init;
@@ -345,6 +346,7 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	pll->reg_base = base + con_offset;
 	pll->lock_offset = grf_lock_offset;
 	pll->lock_shift = lock_shift;
+	pll->flags = clk_pll_flags;
 	pll->lock = lock;
 
 	pll_clk = clk_register(NULL, &pll->hw);
diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index e6cd483..6af5d7f 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -212,13 +212,13 @@ PNAME(mux_sclk_macref_p)	= { "mac_src", "ext_rmii" };
 
 static struct rockchip_pll_clock rk3188_pll_clks[] __initdata = {
 	[apll] = PLL(pll_rk3066, PLL_APLL, "apll", mux_pll_p, 0, RK2928_PLL_CON(0),
-		     RK2928_MODE_CON, 0, 6, rk3188_pll_rates),
+		     RK2928_MODE_CON, 0, 6, 0, rk3188_pll_rates),
 	[dpll] = PLL(pll_rk3066, PLL_DPLL, "dpll", mux_pll_p, 0, RK2928_PLL_CON(4),
-		     RK2928_MODE_CON, 4, 5, NULL),
+		     RK2928_MODE_CON, 4, 5, 0, NULL),
 	[cpll] = PLL(pll_rk3066, PLL_CPLL, "cpll", mux_pll_p, 0, RK2928_PLL_CON(8),
-		     RK2928_MODE_CON, 8, 7, rk3188_pll_rates),
+		     RK2928_MODE_CON, 8, 7, 0, rk3188_pll_rates),
 	[gpll] = PLL(pll_rk3066, PLL_GPLL, "gpll", mux_pll_p, 0, RK2928_PLL_CON(12),
-		     RK2928_MODE_CON, 12, 8, rk3188_pll_rates),
+		     RK2928_MODE_CON, 12, 8, 0, rk3188_pll_rates),
 };
 
 #define MFLAGS CLK_MUX_HIWORD_MASK
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 174589c..2d31a22 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -202,15 +202,15 @@ PNAME(mux_hsicphy12m_p)		= { "hsicphy12m_xin12m", "hsicphy12m_usbphy" };
 
 static struct rockchip_pll_clock rk3288_pll_clks[] __initdata = {
 	[apll] = PLL(pll_rk3066, PLL_APLL, "apll", mux_pll_p, 0, RK3288_PLL_CON(0),
-		     RK3288_MODE_CON, 0, 6, rk3288_pll_rates),
+		     RK3288_MODE_CON, 0, 6, 0, rk3288_pll_rates),
 	[dpll] = PLL(pll_rk3066, PLL_DPLL, "dpll", mux_pll_p, 0, RK3288_PLL_CON(4),
-		     RK3288_MODE_CON, 4, 5, NULL),
+		     RK3288_MODE_CON, 4, 5, 0, NULL),
 	[cpll] = PLL(pll_rk3066, PLL_CPLL, "cpll", mux_pll_p, 0, RK3288_PLL_CON(8),
-		     RK3288_MODE_CON, 8, 7, rk3288_pll_rates),
+		     RK3288_MODE_CON, 8, 7, 0, rk3288_pll_rates),
 	[gpll] = PLL(pll_rk3066, PLL_GPLL, "gpll", mux_pll_p, 0, RK3288_PLL_CON(12),
-		     RK3288_MODE_CON, 12, 8, rk3288_pll_rates),
+		     RK3288_MODE_CON, 12, 8, 0, rk3288_pll_rates),
 	[npll] = PLL(pll_rk3066, PLL_NPLL, "npll",  mux_pll_p, 0, RK3288_PLL_CON(16),
-		     RK3288_MODE_CON, 14, 9, rk3288_pll_rates),
+		     RK3288_MODE_CON, 14, 9, 0, rk3288_pll_rates),
 };
 
 static struct clk_div_table div_hclk_cpu_t[] = {
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index dec6f8d6..3b8f26e 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -199,7 +199,8 @@ void __init rockchip_clk_register_plls(struct rockchip_pll_clock *list,
 				list->parent_names, list->num_parents,
 				reg_base, list->con_offset, grf_lock_offset,
 				list->lock_shift, list->mode_offset,
-				list->mode_shift, list->rate_table, &clk_lock);
+				list->mode_shift, list->rate_table,
+				list->pll_flags, &clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 6baf665..eefd39a 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -90,6 +90,7 @@ struct rockchip_pll_rate_table {
  * @mode_shift: offset inside the mode-register for the mode of this pll.
  * @lock_shift: offset inside the lock register for the lock status.
  * @type: Type of PLL to be registered.
+ * @pll_flags: hardware-specific flags
  * @rate_table: Table of usable pll rates
  */
 struct rockchip_pll_clock {
@@ -103,11 +104,12 @@ struct rockchip_pll_clock {
 	int			mode_shift;
 	int			lock_shift;
 	enum rockchip_pll_type	type;
+	u8			pll_flags;
 	struct rockchip_pll_rate_table *rate_table;
 };
 
 #define PLL(_type, _id, _name, _pnames, _flags, _con, _mode, _mshift,	\
-		_lshift, _rtable)					\
+		_lshift, _pflags, _rtable)				\
 	{								\
 		.id		= _id,					\
 		.type		= _type,				\
@@ -119,6 +121,7 @@ struct rockchip_pll_clock {
 		.mode_offset	= _mode,				\
 		.mode_shift	= _mshift,				\
 		.lock_shift	= _lshift,				\
+		.pll_flags	= _pflags,				\
 		.rate_table	= _rtable,				\
 	}
 
@@ -127,7 +130,7 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 		void __iomem *base, int con_offset, int grf_lock_offset,
 		int lock_shift, int reg_mode, int mode_shift,
 		struct rockchip_pll_rate_table *rate_table,
-		spinlock_t *lock);
+		u8 clk_pll_flags, spinlock_t *lock);
 
 struct rockchip_cpuclk_clksel {
 	int reg;
-- 
2.1.1
