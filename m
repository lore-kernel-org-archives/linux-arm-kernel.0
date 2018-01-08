From: jolly.shah@xilinx.com (Jolly Shah)
Date: Mon, 8 Jan 2018 14:16:36 -0800
Subject: [RFC PATCH 1/2] drivers: clk: Add clk_get_children support
In-Reply-To: <1515449797-5629-1-git-send-email-jollys@xilinx.com>
References: <1515449797-5629-1-git-send-email-jollys@xilinx.com>
Message-ID: <1515449797-5629-2-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This API helps to determine the users for any clock.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Tejas Patel <tejasp@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/clk.c            | 28 ++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b56c11f..7488787 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -258,6 +258,34 @@ struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_parent);
 
+static unsigned int sibling;
+
+static void clk_show_subtree(struct clk_core *c,
+			     int level)
+{
+	struct clk_core *child;
+
+	if (!c)
+		return;
+
+	if (level == 1)
+		sibling++;
+
+	hlist_for_each_entry(child, &c->children, child_node)
+		clk_show_subtree(child, level + 1);
+}
+
+unsigned int clk_get_children(char *name)
+{
+	struct clk_core *core;
+	struct clk *pclk = __clk_lookup(name);
+
+	sibling = 0;
+	core = pclk->core;
+	clk_show_subtree(core, 0);
+	return sibling;
+}
+
 static struct clk_core *__clk_lookup_subtree(const char *name,
 					     struct clk_core *core)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7c925e6..8191a32a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -743,6 +743,7 @@ unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long __clk_get_flags(struct clk *clk);
 unsigned long clk_hw_get_flags(const struct clk_hw *hw);
+unsigned int clk_get_children(char *name);
 bool clk_hw_is_prepared(const struct clk_hw *hw);
 bool clk_hw_is_enabled(const struct clk_hw *hw);
 bool __clk_is_enabled(struct clk *clk);
-- 
2.7.4
