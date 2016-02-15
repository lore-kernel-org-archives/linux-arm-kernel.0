From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 15 Feb 2016 17:40:19 +0800
Subject: [PATCH v3] clk: sunxi: Fix sun8i-a23-apb0-clk divider flags
Message-ID: <1455529219-30204-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APB0 clock on A23 is a zero-based divider, not a power-of-two based
divider.

Note that this patch does not apply cleanly to kernels before 4.5-rc1,
which added CLK_OF_DECLARE support to this driver.

Fixes: 57a1fbf28424 ("clk: sunxi: Add A23 APB0 divider clock support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Vishnu pointed out that A23 is in fact a zero-based divider. This
version corrects the whole driver, now that we know this clock is
compatible between A23 and A80.

---
 drivers/clk/sunxi/clk-sun8i-apb0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sun8i-apb0.c b/drivers/clk/sunxi/clk-sun8i-apb0.c
index 7ba61103a6f5..2ea61debffc1 100644
--- a/drivers/clk/sunxi/clk-sun8i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun8i-apb0.c
@@ -36,7 +36,7 @@ static struct clk *sun8i_a23_apb0_register(struct device_node *node,
 
 	/* The A23 APB0 clock is a standard 2 bit wide divider clock */
 	clk = clk_register_divider(NULL, clk_name, clk_parent, 0, reg,
-				   0, 2, CLK_DIVIDER_POWER_OF_TWO, NULL);
+				   0, 2, 0, NULL);
 	if (IS_ERR(clk))
 		return clk;
 
-- 
2.7.0
