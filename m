From: david@lechnology.com (David Lechner)
Date: Thu,  4 Jan 2018 18:38:06 -0600
Subject: [PATCH 1/7] clk: add helper functions for managing clk_onecell_data
In-Reply-To: <1515112695-3160-1-git-send-email-david@lechnology.com>
References: <1515112695-3160-1-git-send-email-david@lechnology.com>
Message-ID: <1515112695-3160-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds helper functions for allocating and freeing struct
clk_onecell_data.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/clk.c            | 49 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  3 +++
 2 files changed, 52 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e24968f..83c8df7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3551,6 +3551,55 @@ struct clk_hw *of_clk_hw_simple_get(struct of_phandle_args *clkspec, void *data)
 }
 EXPORT_SYMBOL_GPL(of_clk_hw_simple_get);
 
+/**
+ * clk_alloc_onecell_data - allocate new struct clk_onecell_data
+ * @num_clks: Number of clock pointers to allocate
+ *
+ * An array of clock pointers is allocated and each clock pointer is
+ * initialized to ERR_PTR(-ENOENT).
+ *
+ * Returns: Pointer to struct clk_onecell_data or NULL on failure.
+ */
+struct clk_onecell_data *clk_alloc_onecell_data(size_t num_clks)
+{
+	struct clk_onecell_data *clk_data;
+	int i;
+
+	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return NULL;
+
+	clk_data->clks = kcalloc(num_clks, sizeof(*clk_data->clks), GFP_KERNEL);
+	if (!clk_data->clks) {
+		kfree(clk_data);
+		return NULL;
+	}
+
+	for (i = 0; i < num_clks; i++)
+		clk_data->clks[i] = ERR_PTR(-ENOENT);
+
+	clk_data->clk_num = num_clks;
+
+	return clk_data;
+}
+EXPORT_SYMBOL_GPL(clk_alloc_onecell_data);
+
+/**
+ * clk_free_onecell_data - frees @clk_data and associated resources
+ * @clk_data: Pointer to struct clk_onecelldata that was allocated with
+ *            clk_alloc_onecell_data()
+ *
+ * It is safe to call this function even if @clk_data is NULL or an error value.
+ */
+void clk_free_onecell_data(struct clk_onecell_data *clk_data)
+{
+	if (IS_ERR_OR_NULL(clk_data))
+		return;
+
+	kfree(clk_data->clks);
+	kfree(clk_data);
+}
+
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct clk_onecell_data *clk_data = data;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 175a62a..b1f51f7 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -786,6 +786,9 @@ struct clk_onecell_data {
 	unsigned int clk_num;
 };
 
+struct clk_onecell_data *clk_alloc_onecell_data(size_t num_clks);
+void clk_free_onecell_data(struct clk_onecell_data *clk_data);
+
 struct clk_hw_onecell_data {
 	unsigned int num;
 	struct clk_hw *hws[];
-- 
2.7.4
