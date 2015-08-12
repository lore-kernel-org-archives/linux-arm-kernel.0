From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Aug 2015 16:12:40 -0700
Subject: [PATCH 1/2] clk: Constify clk_hw argument to provider APIs
Message-ID: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't modify the clk_hw argument in these functions, so it's
safe to mark it as const.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk.c            | 15 ++++++++-------
 include/linux/clk-provider.h | 14 +++++++-------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 128ad748b682..8e6688d1ecbd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -278,7 +278,7 @@ const char *__clk_get_name(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_get_name);
 
-const char *clk_hw_get_name(struct clk_hw *hw)
+const char *clk_hw_get_name(const struct clk_hw *hw)
 {
 	return hw->core->name;
 }
@@ -290,13 +290,13 @@ struct clk_hw *__clk_get_hw(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_get_hw);
 
-unsigned int clk_hw_get_num_parents(struct clk_hw *hw)
+unsigned int clk_hw_get_num_parents(const struct clk_hw *hw)
 {
 	return hw->core->num_parents;
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_num_parents);
 
-struct clk_hw *clk_hw_get_parent(struct clk_hw *hw)
+struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw)
 {
 	return hw->core->parent ? hw->core->parent->hw : NULL;
 }
@@ -359,7 +359,8 @@ static struct clk_core *clk_core_get_parent_by_index(struct clk_core *core,
 		return core->parents[index];
 }
 
-struct clk_hw *clk_hw_get_parent_by_index(struct clk_hw *hw, unsigned int index)
+struct clk_hw *
+clk_hw_get_parent_by_index(const struct clk_hw *hw, unsigned int index)
 {
 	struct clk_core *parent;
 
@@ -395,7 +396,7 @@ out:
 	return ret;
 }
 
-unsigned long clk_hw_get_rate(struct clk_hw *hw)
+unsigned long clk_hw_get_rate(const struct clk_hw *hw)
 {
 	return clk_core_get_rate_nolock(hw->core);
 }
@@ -415,13 +416,13 @@ unsigned long __clk_get_flags(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_get_flags);
 
-unsigned long clk_hw_get_flags(struct clk_hw *hw)
+unsigned long clk_hw_get_flags(const struct clk_hw *hw)
 {
 	return hw->core->flags;
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_flags);
 
-bool clk_hw_is_prepared(struct clk_hw *hw)
+bool clk_hw_is_prepared(const struct clk_hw *hw)
 {
 	return clk_core_is_prepared(hw->core);
 }
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0d3128fbc14e..3ecc07d0da77 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -607,17 +607,17 @@ void devm_clk_unregister(struct device *dev, struct clk *clk);
 
 /* helper functions */
 const char *__clk_get_name(struct clk *clk);
-const char *clk_hw_get_name(struct clk_hw *hw);
+const char *clk_hw_get_name(const struct clk_hw *hw);
 struct clk_hw *__clk_get_hw(struct clk *clk);
-unsigned int clk_hw_get_num_parents(struct clk_hw *hw);
-struct clk_hw *clk_hw_get_parent(struct clk_hw *hw);
-struct clk_hw *clk_hw_get_parent_by_index(struct clk_hw *hw,
+unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
+struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
+struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
 					  unsigned int index);
 unsigned int __clk_get_enable_count(struct clk *clk);
-unsigned long clk_hw_get_rate(struct clk_hw *hw);
+unsigned long clk_hw_get_rate(const struct clk_hw *hw);
 unsigned long __clk_get_flags(struct clk *clk);
-unsigned long clk_hw_get_flags(struct clk_hw *hw);
-bool clk_hw_is_prepared(struct clk_hw *hw);
+unsigned long clk_hw_get_flags(const struct clk_hw *hw);
+bool clk_hw_is_prepared(const struct clk_hw *hw);
 bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
 int __clk_mux_determine_rate(struct clk_hw *hw,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
