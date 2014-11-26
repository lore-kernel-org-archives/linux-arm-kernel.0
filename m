From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 26 Nov 2014 16:47:49 +0530
Subject: [PATCH 2/4] clk: samsung: retrieve the clock provider information from
 samsung_cmu_register_one
In-Reply-To: <1417000671-11996-1-git-send-email-a.kesavan@samsung.com>
References: <1417000671-11996-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1417000671-11996-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of SoCs with multiple CMUs like Exynos7 and Exynos5260 we are
making use of a common samsung_cmu_register_one function for pll, div,
mux registration. To register the cpu domain clock (for cpufreq) we need
a reference to this clock provider information in the cpu cmu block. Make
this information accessible by returning it from samsung_cmu_register_one().

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk.c |    6 ++++--
 drivers/clk/samsung/clk.h |    4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index dd1f7c9..4a653fe 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -374,8 +374,8 @@ static void samsung_clk_sleep_init(void __iomem *reg_base,
  * Common function which registers plls, muxes, dividers and gates
  * for each CMU. It also add CMU register list to register cache.
  */
-void __init samsung_cmu_register_one(struct device_node *np,
-			struct samsung_cmu_info *cmu)
+struct samsung_clk_provider * __init samsung_cmu_register_one(
+		struct device_node *np, struct samsung_cmu_info *cmu)
 {
 	void __iomem *reg_base;
 	struct samsung_clk_provider *ctx;
@@ -410,4 +410,6 @@ void __init samsung_cmu_register_one(struct device_node *np,
 			cmu->nr_clk_regs);
 
 	samsung_clk_of_add_provider(np, ctx);
+
+	return ctx;
 }
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 3f471e9..24ae23c 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -396,8 +396,8 @@ extern void __init samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 			struct samsung_pll_clock *pll_list,
 			unsigned int nr_clk, void __iomem *base);
 
-extern void __init samsung_cmu_register_one(struct device_node *,
-			struct samsung_cmu_info *);
+extern struct samsung_clk_provider * __init
+samsung_cmu_register_one(struct device_node *, struct samsung_cmu_info *);
 
 extern unsigned long _get_rate(const char *clk_name);
 
-- 
1.7.9.5
