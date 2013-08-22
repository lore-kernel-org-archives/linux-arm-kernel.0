From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 21 Aug 2013 22:53:10 -0700
Subject: [PATCH v4 2/5] clk: of: helper for determining number of parent clocks
In-Reply-To: <1377150793-27864-1-git-send-email-mturquette@linaro.org>
References: <1377150793-27864-1-git-send-email-mturquette@linaro.org>
Message-ID: <1377150793-27864-3-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Walks the "clocks" array of parent clock phandles and returns the
number.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
No change since v3

 drivers/clk/clk.c            | 6 ++++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bc02037..2655882 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2189,6 +2189,12 @@ struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 	return clk;
 }
 
+int of_clk_get_parent_count(struct device_node *np)
+{
+	return of_count_phandle_with_args(np, "clocks", "#clock-cells");
+}
+EXPORT_SYMBOL_GPL(of_clk_get_parent_count);
+
 const char *of_clk_get_parent_name(struct device_node *np, int index)
 {
 	struct of_phandle_args clkspec;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 015f18c..5497739 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -471,6 +471,7 @@ void of_clk_del_provider(struct device_node *np);
 struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 				  void *data);
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
+int of_clk_get_parent_count(struct device_node *np);
 const char *of_clk_get_parent_name(struct device_node *np, int index);
 
 void of_clk_init(const struct of_device_id *matches);
-- 
1.8.1.2
