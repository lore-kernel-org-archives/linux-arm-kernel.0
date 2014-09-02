From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  2 Sep 2014 09:50:16 +0200
Subject: [PATCH 3/5] clk: at91: fix recalc_rate implementation of PLL driver
In-Reply-To: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1409644218-13677-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the cached values to calculate PLL rate instead of the register values.
This is required to prevent erroneous PLL rate return when the PLL rate
has been configured but the PLL is not prepared yet.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Reported-by: Ga?l PORTAY <gael.portay@gmail.com>
---
 drivers/clk/at91/clk-pll.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index a1adcf1..6ec79db 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -151,16 +151,11 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 					 unsigned long parent_rate)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
-	const struct clk_pll_layout *layout = pll->layout;
-	struct at91_pmc *pmc = pll->pmc;
-	int offset = PLL_REG(pll->id);
-	u32 tmp = pmc_read(pmc, offset) & layout->pllr_mask;
-	u8 div = PLL_DIV(tmp);
-	u16 mul = PLL_MUL(tmp, layout);
-	if (!div || !mul)
+
+	if (!pll->div || !pll->mul)
 		return 0;
 
-	return (parent_rate * (mul + 1)) / div;
+	return (parent_rate / pll->div) * (pll->mul + 1);
 }
 
 static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
-- 
1.9.1
