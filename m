From: tushar.b@samsung.com (Tushar Behera)
Date: Fri, 11 Jul 2014 17:30:34 +0530
Subject: [PATCH V2 2/3] clk: samsung: Add API to unregister clocks
In-Reply-To: <1405080036-6651-1-git-send-email-tushar.b@samsung.com>
References: <1405080036-6651-1-git-send-email-tushar.b@samsung.com>
Message-ID: <1405080036-6651-3-git-send-email-tushar.b@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added an API to unregister all the clocks defined within a context. This
is helpful in case where the clock is registered through a platform
driver and we want to unregister the clocks during remove callback.

Signed-off-by: Tushar Behera <tushar.b@samsung.com>
---
Changelog:
This is new patch required because of changes to patch 3/3.

 drivers/clk/samsung/clk.c |   19 +++++++++++++++++++
 drivers/clk/samsung/clk.h |    2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 49629c7..b9310b9 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -83,6 +83,25 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
 	return ctx;
 }
 
+/* API to remove a clock provider */
+void samsung_clk_exit(struct device_node *np, struct samsung_clk_provider *ctx)
+{
+	int i;
+
+	if (np)
+		of_clk_del_provider(np);
+
+	if (!ctx)
+		return;
+
+	for (i = 0; i < ctx->clk_data.clk_num; i++)
+		if (!IS_ERR(ctx->clk_data.clks[i]))
+			clk_unregister(ctx->clk_data.clks[i]);
+
+	kfree(ctx->clk_data.clks);
+	kfree(ctx);
+}
+
 /* add a clock instance to the clock lookup table used for dt based lookup */
 void samsung_clk_add_lookup(struct samsung_clk_provider *ctx, struct clk *clk,
 				unsigned int id)
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 9693b80..8ecc85a 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -327,6 +327,8 @@ struct samsung_pll_clock {
 extern struct samsung_clk_provider *__init samsung_clk_init(
 			struct device_node *np, void __iomem *base,
 			unsigned long nr_clks);
+extern void samsung_clk_exit(struct device_node *np,
+			struct samsung_clk_provider *ctx);
 extern void __init samsung_clk_of_register_fixed_ext(
 			struct samsung_clk_provider *ctx,
 			struct samsung_fixed_rate_clock *fixed_rate_clk,
-- 
1.7.9.5
