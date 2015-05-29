From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 May 2015 11:25:48 +0200
Subject: [PATCH 4/5] [RFC] clk: Provide dummy of_clk_get_parent_count() for
 !OF/!CCF
In-Reply-To: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1432891549-23295-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide dummy implementations of of_clk_get_parent_count() for the
cases where CONFIG_OF or CONFIG_COMMON_CLK are not set.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is an RFC, as
  1. Dummies are needed in two places,
  2. We don't have any dummies yet for the !CCF case.
---
 include/linux/clk-provider.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5378c2aba4d2eaec..d56bb0c6dd982c32 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -651,6 +651,10 @@ static inline struct clk *of_clk_src_onecell_get(
 {
 	return ERR_PTR(-ENOENT);
 }
+static inline int of_clk_get_parent_count(struct device_node *np)
+{
+	return -ENOENT;
+}
 static inline const char *of_clk_get_parent_name(struct device_node *np,
 						 int index)
 {
@@ -696,5 +700,10 @@ struct dentry *clk_debugfs_add_file(struct clk_hw *hw, char *name, umode_t mode,
 				void *data, const struct file_operations *fops);
 #endif
 
-#endif /* CONFIG_COMMON_CLK */
+#else /* !CONFIG_COMMON_CLK */
+static inline int of_clk_get_parent_count(struct device_node *np)
+{
+	return -ENOENT;
+}
+#endif /* !CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
-- 
1.9.1
