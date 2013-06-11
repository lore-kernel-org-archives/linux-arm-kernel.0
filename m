From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Tue, 11 Jun 2013 15:01:06 +0530
Subject: [PATCH v7 01/11] clk: samsung: Introduce a common samsung_clk_pll
 struct
In-Reply-To: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
References: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370943076-13461-2-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch unifies clk strutures used for PLL35xx & PLL36xx and
adding an extra member lock_reg, so that common code can be factored out.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 drivers/clk/samsung/clk-pll.c |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 89135f6..8224bde 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -13,6 +13,14 @@
 #include "clk.h"
 #include "clk-pll.h"
 
+struct samsung_clk_pll {
+	struct clk_hw		hw;
+	void __iomem		*lock_reg;
+	void __iomem		*con_reg;
+};
+
+#define to_clk_pll(_hw) container_of(_hw, struct samsung_clk_pll, hw)
+
 /*
  * PLL35xx Clock Type
  */
@@ -24,17 +32,10 @@
 #define PLL35XX_PDIV_SHIFT      (8)
 #define PLL35XX_SDIV_SHIFT      (0)
 
-struct samsung_clk_pll35xx {
-	struct clk_hw		hw;
-	const void __iomem	*con_reg;
-};
-
-#define to_clk_pll35xx(_hw) container_of(_hw, struct samsung_clk_pll35xx, hw)
-
 static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
 {
-	struct samsung_clk_pll35xx *pll = to_clk_pll35xx(hw);
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	u32 mdiv, pdiv, sdiv, pll_con;
 	u64 fvco = parent_rate;
 
@@ -56,7 +57,7 @@ static const struct clk_ops samsung_pll35xx_clk_ops = {
 struct clk * __init samsung_clk_register_pll35xx(const char *name,
 			const char *pname, const void __iomem *con_reg)
 {
-	struct samsung_clk_pll35xx *pll;
+	struct samsung_clk_pll *pll;
 	struct clk *clk;
 	struct clk_init_data init;
 
@@ -100,17 +101,10 @@ struct clk * __init samsung_clk_register_pll35xx(const char *name,
 #define PLL36XX_PDIV_SHIFT	(8)
 #define PLL36XX_SDIV_SHIFT	(0)
 
-struct samsung_clk_pll36xx {
-	struct clk_hw		hw;
-	const void __iomem	*con_reg;
-};
-
-#define to_clk_pll36xx(_hw) container_of(_hw, struct samsung_clk_pll36xx, hw)
-
 static unsigned long samsung_pll36xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
 {
-	struct samsung_clk_pll36xx *pll = to_clk_pll36xx(hw);
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	u32 mdiv, pdiv, sdiv, kdiv, pll_con0, pll_con1;
 	u64 fvco = parent_rate;
 
@@ -135,7 +129,7 @@ static const struct clk_ops samsung_pll36xx_clk_ops = {
 struct clk * __init samsung_clk_register_pll36xx(const char *name,
 			const char *pname, const void __iomem *con_reg)
 {
-	struct samsung_clk_pll36xx *pll;
+	struct samsung_clk_pll *pll;
 	struct clk *clk;
 	struct clk_init_data init;
 
-- 
1.7.0.4
