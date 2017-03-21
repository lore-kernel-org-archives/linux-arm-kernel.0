From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Mar 2017 16:38:22 +0800
Subject: [PATCH 2/3] zte: clk: pd_bit is not 0 on zx296718
In-Reply-To: <1490085503-15713-1-git-send-email-shawnguo@kernel.org>
References: <1490085503-15713-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1490085503-15713-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The bit 0 of PLL_CFG0 register is not powerdown on zx296718, but part of
of postdiv2 field.  The consequence is that functions like hw_to_idx()
and zx_pll_enable() will end up tampering the postdiv2 of the PLL.

Let's fix it by defining pd_bit 0xff which is obviously invalid for a
bit position and having PLL driver check the validity before operating
on the bit.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/zte/clk.c | 12 +++++++++++-
 drivers/clk/zte/clk.h |  6 +++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/zte/clk.c b/drivers/clk/zte/clk.c
index 878d879b23ff..b82031766ffa 100644
--- a/drivers/clk/zte/clk.c
+++ b/drivers/clk/zte/clk.c
@@ -52,7 +52,10 @@ static int hw_to_idx(struct clk_zx_pll *zx_pll)
 
 	/* For matching the value in lookup table */
 	hw_cfg0 &= ~BIT(zx_pll->lock_bit);
-	hw_cfg0 |= BIT(zx_pll->pd_bit);
+
+	/* Check availability of pd_bit */
+	if (zx_pll->pd_bit < 32)
+		hw_cfg0 |= BIT(zx_pll->pd_bit);
 
 	for (i = 0; i < zx_pll->count; i++) {
 		if (hw_cfg0 == config[i].cfg0 && hw_cfg1 == config[i].cfg1)
@@ -108,6 +111,10 @@ static int zx_pll_enable(struct clk_hw *hw)
 	struct clk_zx_pll *zx_pll = to_clk_zx_pll(hw);
 	u32 reg;
 
+	/* If pd_bit is not available, simply return success. */
+	if (zx_pll->pd_bit > 31)
+		return 0;
+
 	reg = readl_relaxed(zx_pll->reg_base);
 	writel_relaxed(reg & ~BIT(zx_pll->pd_bit), zx_pll->reg_base);
 
@@ -120,6 +127,9 @@ static void zx_pll_disable(struct clk_hw *hw)
 	struct clk_zx_pll *zx_pll = to_clk_zx_pll(hw);
 	u32 reg;
 
+	if (zx_pll->pd_bit > 31)
+		return;
+
 	reg = readl_relaxed(zx_pll->reg_base);
 	writel_relaxed(reg | BIT(zx_pll->pd_bit), zx_pll->reg_base);
 }
diff --git a/drivers/clk/zte/clk.h b/drivers/clk/zte/clk.h
index 84a55a3e2bd4..4df0f121b56d 100644
--- a/drivers/clk/zte/clk.h
+++ b/drivers/clk/zte/clk.h
@@ -66,8 +66,12 @@ struct clk_zx_pll {
 				CLK_GET_RATE_NOCACHE),			\
 }
 
+/*
+ * The pd_bit is not available on ZX296718, so let's pass something
+ * bigger than 31, e.g. 0xff, to indicate that.
+ */
 #define ZX296718_PLL(_name, _parent, _reg, _table)			\
-ZX_PLL(_name, _parent, _reg, _table, 0, 30)
+ZX_PLL(_name, _parent, _reg, _table, 0xff, 30)
 
 struct zx_clk_gate {
 	struct clk_gate gate;
-- 
1.9.1
