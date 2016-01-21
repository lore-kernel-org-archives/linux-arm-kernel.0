From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 21 Jan 2016 21:53:09 +0100
Subject: [PATCH v3] clk-divider: make sure read-only dividers do not write to
 their register
Message-ID: <4666170.lmsMJxAogk@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1") removed
the special ops struct for read-only clocks and instead opted to handle
them inside the regular ops.

On the rk3368 this results in breakage as aclkm now gets set a value.
While it is the same divider value, the A53 core still doesn't like it,
which can result in the cpu ending up in a hang.
The reason being that "ACLKENMasserts one clock cycle before the rising
edge of ACLKM" and the clock should only be touched when STANDBYWFIL2
is asserted.

To fix this, reintroduce the read-only ops but do include the round_rate
callback. That way no writes that may be unsafe are done to the divider
register in any case.

The Rockchip use of the clk_divider_ops is adapted to this split again,
as is the nxp, lpc18xx-ccu driver that was included since the original
commit. On lpc18xx-ccu the divider seems to always be read-only
so only uses the new ops now.

Fixes: e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1")
Reported-by: Zhang Qing <zhangqing@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes in v3:
- instead of bailing out of set_rate, reintroduce the _ro_ops
  with added round_rate callback, as requested by Stephen
changes in v2:
- emphasize that even setting the same divider may be unsafe

 drivers/clk/clk-divider.c         | 11 ++++++++++-
 drivers/clk/nxp/clk-lpc18xx-ccu.c |  2 +-
 drivers/clk/rockchip/clk.c        |  4 +++-
 include/linux/clk-provider.h      |  1 +
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index ded3ff4..aa1dacd 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -423,6 +423,12 @@ const struct clk_ops clk_divider_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_divider_ops);
 
+const struct clk_ops clk_divider_ro_ops = {
+	.recalc_rate = clk_divider_recalc_rate,
+	.round_rate = clk_divider_round_rate,
+};
+EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
+
 static struct clk *_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
@@ -446,7 +452,10 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.ops = &clk_divider_ops;
+	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
+		init.ops = &clk_divider_ro_ops;
+	else
+		init.ops = &clk_divider_ops;
 	init.flags = flags | CLK_IS_BASIC;
 	init.parent_names = (parent_name ? &parent_name: NULL);
 	init.num_parents = (parent_name ? 1 : 0);
diff --git a/drivers/clk/nxp/clk-lpc18xx-ccu.c b/drivers/clk/nxp/clk-lpc18xx-ccu.c
index 13aabbb..558da89 100644
--- a/drivers/clk/nxp/clk-lpc18xx-ccu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-ccu.c
@@ -222,7 +222,7 @@ static void lpc18xx_ccu_register_branch_gate_div(struct lpc18xx_clk_branch *bran
 		div->width = 1;
 
 		div_hw = &div->hw;
-		div_ops = &clk_divider_ops;
+		div_ops = &clk_divider_ro_ops;
 	}
 
 	branch->gate.reg = branch->offset + reg_base;
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index d9a0b5d..f7e8693 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -90,7 +90,9 @@ static struct clk *rockchip_clk_register_branch(const char *name,
 		div->width = div_width;
 		div->lock = lock;
 		div->table = div_table;
-		div_ops = &clk_divider_ops;
+		div_ops = (div_flags & CLK_DIVIDER_READ_ONLY)
+						? &clk_divider_ro_ops
+						: &clk_divider_ops;
 	}
 
 	clk = clk_register_composite(NULL, name, parent_names, num_parents,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1143e38..408a60d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -385,6 +385,7 @@ struct clk_divider {
 #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
 
 extern const struct clk_ops clk_divider_ops;
+extern const struct clk_ops clk_divider_ro_ops;
 
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 		unsigned int val, const struct clk_div_table *table,
-- 
2.6.4
