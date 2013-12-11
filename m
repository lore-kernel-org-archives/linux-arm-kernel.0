From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 11 Dec 2013 09:29:07 +0800
Subject: [PATCH] clk: divider: read before write for HIWORD mask
Message-ID: <1386725347-14480-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When multiple dividers share one register, we need to read & mask
register fist. Then we set the right value.

For example, there're two mmc clock dividers shared in one registers.
The clock register is HIWORD type.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/clk/clk-divider.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8d3009e..e1ea289 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -227,12 +227,10 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->lock)
 		spin_lock_irqsave(divider->lock, flags);
 
-	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
-		val = div_mask(divider) << (divider->shift + 16);
-	} else {
-		val = clk_readl(divider->reg);
-		val &= ~(div_mask(divider) << divider->shift);
-	}
+	val = clk_readl(divider->reg);
+	val &= ~(div_mask(divider) << divider->shift);
+	if (divider->flags & CLK_DIVIDER_HIWORD_MASK)
+		val |= div_mask(divider) << (divider->shift + 16);
 	val |= value << divider->shift;
 	clk_writel(val, divider->reg);
 
-- 
1.8.3.2
