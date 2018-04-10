From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 10 Apr 2018 14:51:37 +0200
Subject: [PATCH v2 1/5] clk: Extract OF clock helpers in <linux/of_clk.h>
In-Reply-To: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1523364701-15383-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of of_clk_get_parent_{count,name}() and of_clk_init() is not
limited to clock providers.

Hence move these helpers into their own header file, so callers that are
not clock providers no longer have to include <linux/clk-provider.h>.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.

I have't added an SPDX-License-Identifier line, as
<linux/clk-provider.h> also doesn't have one yet.

Other candidates to be moved here later?
  - of_clk_get(),
  - of_clk_get_by_name(),
  - of_clk_get_from_provider().
---
 include/linux/clk-provider.h | 14 +-------------
 include/linux/of_clk.h       | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/of_clk.h

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 210a890008f9e129..61cb4729f22acd6b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -13,6 +13,7 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 
 #ifdef CONFIG_COMMON_CLK
 
@@ -890,13 +891,10 @@ struct clk_hw *of_clk_hw_simple_get(struct of_phandle_args *clkspec,
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
 struct clk_hw *of_clk_hw_onecell_get(struct of_phandle_args *clkspec,
 				     void *data);
-unsigned int of_clk_get_parent_count(struct device_node *np);
 int of_clk_parent_fill(struct device_node *np, const char **parents,
 		       unsigned int size);
-const char *of_clk_get_parent_name(struct device_node *np, int index);
 int of_clk_detect_critical(struct device_node *np, int index,
 			    unsigned long *flags);
-void of_clk_init(const struct of_device_id *matches);
 
 #else /* !CONFIG_OF */
 
@@ -943,26 +941,16 @@ of_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
 {
 	return ERR_PTR(-ENOENT);
 }
-static inline unsigned int of_clk_get_parent_count(struct device_node *np)
-{
-	return 0;
-}
 static inline int of_clk_parent_fill(struct device_node *np,
 				     const char **parents, unsigned int size)
 {
 	return 0;
 }
-static inline const char *of_clk_get_parent_name(struct device_node *np,
-						 int index)
-{
-	return NULL;
-}
 static inline int of_clk_detect_critical(struct device_node *np, int index,
 					  unsigned long *flags)
 {
 	return 0;
 }
-static inline void of_clk_init(const struct of_device_id *matches) {}
 #endif /* CONFIG_OF */
 
 /*
diff --git a/include/linux/of_clk.h b/include/linux/of_clk.h
new file mode 100644
index 0000000000000000..ba3c0e6983ec1543
--- /dev/null
+++ b/include/linux/of_clk.h
@@ -0,0 +1,29 @@
+/*
+ * OF clock helpers
+ */
+
+#ifndef __LINUX_OF_CLK_H
+#define __LINUX_OF_CLK_H
+
+#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_OF)
+
+unsigned int of_clk_get_parent_count(struct device_node *np);
+const char *of_clk_get_parent_name(struct device_node *np, int index);
+void of_clk_init(const struct of_device_id *matches);
+
+#else /* !CONFIG_COMMON_CLK || !CONFIG_OF */
+
+static inline unsigned int of_clk_get_parent_count(struct device_node *np)
+{
+	return 0;
+}
+static inline const char *of_clk_get_parent_name(struct device_node *np,
+						 int index)
+{
+	return NULL;
+}
+static inline void of_clk_init(const struct of_device_id *matches) {}
+
+#endif /* !CONFIG_COMMON_CLK || !CONFIG_OF */
+
+#endif /* __LINUX_OF_CLK_H */
-- 
2.7.4
