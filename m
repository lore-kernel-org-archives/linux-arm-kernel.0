From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 02 Sep 2014 21:05:39 +0530
Subject: [PATCH v2 3/7] clk: samsung: Add fixed_factor_clocks field to struct
 exynos_cmu_info
In-Reply-To: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1409672143-8574-4-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the fields "fixed_factor_clks" and "nr_fixed_factor_clks" to
"struct exynos_cmu_info" to allow registering of fixed factor
clocks as well with exynos_cmu_register_one().

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/samsung/clk.c |    3 +++
 drivers/clk/samsung/clk.h |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index a043654..4b31267 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -402,6 +402,9 @@ void __init exynos_cmu_register_one(struct device_node *np,
 	if (cmu->fixed_clks)
 		samsung_clk_register_fixed_rate(ctx, cmu->fixed_clks,
 			cmu->nr_fixed_clks);
+	if (cmu->fixed_factor_clks)
+		samsung_clk_register_fixed_factor(ctx, cmu->fixed_factor_clks,
+			cmu->nr_fixed_factor_clks);
 	if (cmu->clk_regs)
 		exynos_clk_sleep_init(reg_base, cmu->clk_regs,
 			cmu->nr_clk_regs);
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 552d155..993b51c 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -347,6 +347,9 @@ struct exynos_cmu_info {
 	/* list of fixed clocks and respective count */
 	struct samsung_fixed_rate_clock *fixed_clks;
 	unsigned int nr_fixed_clks;
+	/* list of fixed factor clocks and respective count */
+	struct samsung_fixed_factor_clock *fixed_factor_clks;
+	unsigned int nr_fixed_factor_clks;
 	/* total number of clocks with IDs assigned*/
 	unsigned int nr_clk_ids;
 
-- 
1.7.9.5
