From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:01:57 +0200
Subject: [PATCH 01/18] clk: samsung: Constify clock init data with clock arrays
Message-ID: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

samsung_cmu_register_one() can accept pointer to const initialization
data: struct samsung_cmu_info. The members of the latter can also be
pointers to const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk.c |  2 +-
 drivers/clk/samsung/clk.h | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index f38a6c49f744..e4d14589cc4a 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -381,7 +381,7 @@ static void samsung_clk_sleep_init(void __iomem *reg_base,
  */
 struct samsung_clk_provider * __init samsung_cmu_register_one(
 			struct device_node *np,
-			struct samsung_cmu_info *cmu)
+			const struct samsung_cmu_info *cmu)
 {
 	void __iomem *reg_base;
 	struct samsung_clk_provider *ctx;
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index aa872d2c5105..61db98dd01a2 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -330,28 +330,28 @@ struct samsung_clock_reg_cache {
 
 struct samsung_cmu_info {
 	/* list of pll clocks and respective count */
-	struct samsung_pll_clock *pll_clks;
+	const struct samsung_pll_clock *pll_clks;
 	unsigned int nr_pll_clks;
 	/* list of mux clocks and respective count */
-	struct samsung_mux_clock *mux_clks;
+	const struct samsung_mux_clock *mux_clks;
 	unsigned int nr_mux_clks;
 	/* list of div clocks and respective count */
-	struct samsung_div_clock *div_clks;
+	const struct samsung_div_clock *div_clks;
 	unsigned int nr_div_clks;
 	/* list of gate clocks and respective count */
-	struct samsung_gate_clock *gate_clks;
+	const struct samsung_gate_clock *gate_clks;
 	unsigned int nr_gate_clks;
 	/* list of fixed clocks and respective count */
-	struct samsung_fixed_rate_clock *fixed_clks;
+	const struct samsung_fixed_rate_clock *fixed_clks;
 	unsigned int nr_fixed_clks;
 	/* list of fixed factor clocks and respective count */
-	struct samsung_fixed_factor_clock *fixed_factor_clks;
+	const struct samsung_fixed_factor_clock *fixed_factor_clks;
 	unsigned int nr_fixed_factor_clks;
 	/* total number of clocks with IDs assigned*/
 	unsigned int nr_clk_ids;
 
 	/* list and number of clocks registers */
-	unsigned long *clk_regs;
+	const unsigned long *clk_regs;
 	unsigned int nr_clk_regs;
 };
 
@@ -395,7 +395,7 @@ extern void __init samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 
 extern struct samsung_clk_provider __init *samsung_cmu_register_one(
 			struct device_node *,
-			struct samsung_cmu_info *);
+			const struct samsung_cmu_info *);
 
 extern unsigned long _get_rate(const char *clk_name);
 
-- 
1.9.1
