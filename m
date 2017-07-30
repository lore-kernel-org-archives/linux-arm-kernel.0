From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun, 30 Jul 2017 18:41:47 +0200
Subject: [PATCH 1/4] clk: sunxi-ng: Fix fractional mode for N-M clocks
In-Reply-To: <20170730164150.26302-1-jernej.skrabec@siol.net>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
Message-ID: <20170730164150.26302-2-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

N-M factor clock driver is missing a call to ccu_frac_helper_enable()
when fractional mode is used. Additionally, most SoCs require that M
factor must be set to 0 when fractional mode is used.

Without this patch, clock keeps the old value and clk_set_rate() returns
without error.

Fixes: 6174a1e24b0d ("clk: sunxi-ng: Add N-M-factor clock support")
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index 5e5e90a4a50c..c6ba866b99d3 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -117,10 +117,22 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags;
 	u32 reg;
 
-	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate))
+	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate)) {
+		spin_lock_irqsave(nm->common.lock, flags);
+
+		/* most SoCs require M to be 0 if fractional mode is used */
+		reg = readl(nm->common.base + nm->common.reg);
+		reg &= ~GENMASK(nm->m.width + nm->m.shift - 1, nm->m.shift);
+		writel(reg, nm->common.base + nm->common.reg);
+
+		spin_unlock_irqrestore(nm->common.lock, flags);
+
+		ccu_frac_helper_enable(&nm->common, &nm->frac);
+
 		return ccu_frac_helper_set_rate(&nm->common, &nm->frac, rate);
-	else
+	} else {
 		ccu_frac_helper_disable(&nm->common, &nm->frac);
+	}
 
 	_nm.min_n = nm->n.min ?: 1;
 	_nm.max_n = nm->n.max ?: 1 << nm->n.width;
-- 
2.13.3
