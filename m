From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Wed, 17 Jan 2018 21:14:10 +0100
Subject: [PATCH v3 01/12] clk: sunxi-ng: Mask nkmp factors when setting
 register
In-Reply-To: <20180117201421.25954-1-jernej.skrabec@siol.net>
References: <20180117201421.25954-1-jernej.skrabec@siol.net>
Message-ID: <20180117201421.25954-2-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, if one of the factors isn't present, bit 0 gets always set to
1. For example, A83T has NMP PLLs modelled as NKMP PLL without K. Since
K is not specified, it's offset, width and shift is 0. Driver assumes
that lowest value possible is 1, otherwise we would get division by 0.
That situation causes that bit 0 is always set, which may change wanted
clock rate.

Fix that by masking every factor according to it's specified width.
Factors with width set to 0 won't have any influence to final register
value.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nkmp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index e58c95787f94..a99068a08315 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -134,6 +134,7 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 			   unsigned long parent_rate)
 {
 	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
+	u32 n_mask, k_mask, m_mask, p_mask;
 	struct _ccu_nkmp _nkmp;
 	unsigned long flags;
 	u32 reg;
@@ -149,18 +150,20 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	ccu_nkmp_find_best(parent_rate, rate, &_nkmp);
 
+	n_mask = GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
+	k_mask = GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
+	m_mask = GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
+	p_mask = GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
+
 	spin_lock_irqsave(nkmp->common.lock, flags);
 
 	reg = readl(nkmp->common.base + nkmp->common.reg);
-	reg &= ~GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
-	reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
-	reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
-	reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
-
-	reg |= (_nkmp.n - nkmp->n.offset) << nkmp->n.shift;
-	reg |= (_nkmp.k - nkmp->k.offset) << nkmp->k.shift;
-	reg |= (_nkmp.m - nkmp->m.offset) << nkmp->m.shift;
-	reg |= ilog2(_nkmp.p) << nkmp->p.shift;
+	reg &= ~(n_mask | k_mask | m_mask | p_mask);
+
+	reg |= ((_nkmp.n - nkmp->n.offset) << nkmp->n.shift) & n_mask;
+	reg |= ((_nkmp.k - nkmp->k.offset) << nkmp->k.shift) & k_mask;
+	reg |= ((_nkmp.m - nkmp->m.offset) << nkmp->m.shift) & m_mask;
+	reg |= (ilog2(_nkmp.p) << nkmp->p.shift) & p_mask;
 
 	writel(reg, nkmp->common.base + nkmp->common.reg);
 
-- 
2.15.1
