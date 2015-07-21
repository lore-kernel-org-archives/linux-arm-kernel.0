From: dianders@chromium.org (Douglas Anderson)
Date: Tue, 21 Jul 2015 13:41:23 -0700
Subject: [PATCH] clk: rockchip: Fix PLL bandwidth
Message-ID: <1437511283-14216-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the TRM we see that BWADJ is "a 12-bit bus that selects the values
1-4096 for the bandwidth divider (NB)":
 NB = BWADJ[11:0] + 1
The recommended setting of NB: NB = NF / 2.

So:
  NB = NF / 2
  BWADJ[11:0] + 1 = NF / 2
  BWADJ[11:0] = NF / 2 - 1

Right now, we have:

{                                               \
        .rate   = _rate##U,                     \
        .nr = _nr,                              \
        .nf = _nf,                              \
        .no = _no,                              \
        .bwadj = (_nf >> 1),                    \
}

That means we set bwadj to NF / 2, not NF / 2 - 1

All of this is a bit confusing because we specify "NR" (the 1-based
value), "NF" (the 1-based value), "NO" (the 1-based value), but
"BWADJ" (the 0-based value) instead of "NB" (the 1-based value).

Let's change to working with "NB" and fix the off by one error.  This
may affect PLL jitter in a small way (hopefully for the better).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/clk/rockchip/clk-pll.c    | 18 +++++++++---------
 drivers/clk/rockchip/clk-rk3188.c |  2 +-
 drivers/clk/rockchip/clk-rk3288.c |  2 +-
 drivers/clk/rockchip/clk.h        |  8 ++++----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 1f88dd1..96903ae 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -120,8 +120,8 @@ static int rockchip_pll_wait_lock(struct rockchip_clk_pll *pll)
 #define RK3066_PLLCON0_NR_SHIFT		8
 #define RK3066_PLLCON1_NF_MASK		0x1fff
 #define RK3066_PLLCON1_NF_SHIFT		0
-#define RK3066_PLLCON2_BWADJ_MASK	0xfff
-#define RK3066_PLLCON2_BWADJ_SHIFT	0
+#define RK3066_PLLCON2_NB_MASK		0xfff
+#define RK3066_PLLCON2_NB_SHIFT		0
 #define RK3066_PLLCON3_RESET		(1 << 5)
 #define RK3066_PLLCON3_PWRDOWN		(1 << 1)
 #define RK3066_PLLCON3_BYPASS		(1 << 0)
@@ -207,8 +207,8 @@ static int rockchip_rk3066_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 	writel_relaxed(HIWORD_UPDATE(rate->nf - 1, RK3066_PLLCON1_NF_MASK,
 						   RK3066_PLLCON1_NF_SHIFT),
 		       pll->reg_base + RK3066_PLLCON(1));
-	writel_relaxed(HIWORD_UPDATE(rate->bwadj, RK3066_PLLCON2_BWADJ_MASK,
-						  RK3066_PLLCON2_BWADJ_SHIFT),
+	writel_relaxed(HIWORD_UPDATE(rate->nb - 1, RK3066_PLLCON2_NB_MASK,
+						   RK3066_PLLCON2_NB_SHIFT),
 		       pll->reg_base + RK3066_PLLCON(2));
 
 	/* leave reset and wait the reset_delay */
@@ -261,7 +261,7 @@ static void rockchip_rk3066_pll_init(struct clk_hw *hw)
 {
 	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
 	const struct rockchip_pll_rate_table *rate;
-	unsigned int nf, nr, no, bwadj;
+	unsigned int nf, nr, no, nb;
 	unsigned long drate;
 	u32 pllcon;
 
@@ -283,13 +283,13 @@ static void rockchip_rk3066_pll_init(struct clk_hw *hw)
 	nf = ((pllcon >> RK3066_PLLCON1_NF_SHIFT) & RK3066_PLLCON1_NF_MASK) + 1;
 
 	pllcon = readl_relaxed(pll->reg_base + RK3066_PLLCON(2));
-	bwadj = (pllcon >> RK3066_PLLCON2_BWADJ_SHIFT) & RK3066_PLLCON2_BWADJ_MASK;
+	nb = ((pllcon >> RK3066_PLLCON2_NB_SHIFT) & RK3066_PLLCON2_NB_MASK) + 1;
 
-	pr_debug("%s: pll %s@%lu: nr (%d:%d); no (%d:%d); nf(%d:%d), bwadj(%d:%d)\n",
+	pr_debug("%s: pll %s@%lu: nr (%d:%d); no (%d:%d); nf(%d:%d), nb(%d:%d)\n",
 		 __func__, __clk_get_name(hw->clk), drate, rate->nr, nr,
-		rate->no, no, rate->nf, nf, rate->bwadj, bwadj);
+		rate->no, no, rate->nf, nf, rate->nb, nb);
 	if (rate->nr != nr || rate->no != no || rate->nf != nf
-					     || rate->bwadj != bwadj) {
+					     || rate->nb != nb) {
 		struct clk *parent = __clk_get_parent(hw->clk);
 		unsigned long prate;
 
diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index edbafbc..0abf22d 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -817,7 +817,7 @@ static void __init rk3188_clk_init(struct device_node *np)
 
 		rate = pll->rate_table;
 		while (rate->rate > 0) {
-			rate->bwadj = 0;
+			rate->nb = 1;
 			rate++;
 		}
 	}
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index a8bad7d..0df5bae 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -84,7 +84,7 @@ static struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	RK3066_PLL_RATE( 742500000, 8, 495, 2),
 	RK3066_PLL_RATE( 696000000, 1, 58, 2),
 	RK3066_PLL_RATE( 600000000, 1, 50, 2),
-	RK3066_PLL_RATE_BWADJ(594000000, 1, 198, 8, 1),
+	RK3066_PLL_RATE_NB(594000000, 1, 198, 8, 1),
 	RK3066_PLL_RATE( 552000000, 1, 46, 2),
 	RK3066_PLL_RATE( 504000000, 1, 84, 4),
 	RK3066_PLL_RATE( 500000000, 3, 125, 2),
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 93ea335..dc8ecb2 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -83,16 +83,16 @@ enum rockchip_pll_type {
 	.nr = _nr,				\
 	.nf = _nf,				\
 	.no = _no,				\
-	.bwadj = ((_nf) >> 1),			\
+	.nb = ((_nf) < 2) ? 1 : (_nf) >> 1,	\
 }
 
-#define RK3066_PLL_RATE_BWADJ(_rate, _nr, _nf, _no, _bw)	\
+#define RK3066_PLL_RATE_NB(_rate, _nr, _nf, _no, _nb)		\
 {								\
 	.rate	= _rate##U,					\
 	.nr = _nr,						\
 	.nf = _nf,						\
 	.no = _no,						\
-	.bwadj = _bw,						\
+	.nb = _nb,						\
 }
 
 struct rockchip_pll_rate_table {
@@ -100,7 +100,7 @@ struct rockchip_pll_rate_table {
 	unsigned int nr;
 	unsigned int nf;
 	unsigned int no;
-	unsigned int bwadj;
+	unsigned int nb;
 };
 
 /**
-- 
2.4.3.573.g4eafbef
