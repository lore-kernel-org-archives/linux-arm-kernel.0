From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 21 Mar 2017 11:45:20 +0530
Subject: [PATCH 2/5] clk: Add clk_hw_get_clk() helper API to be used by clk
 providers
In-Reply-To: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
References: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1490076923-20194-3-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we move towards a cleaner split to have clock providers use clk_hw
for all clock operations, while consumers operate on the (per-user)
struct clk handles, we still have cases where in a clock provider
might want to call into high level clk apis which only operate on a
struct clk handle.
To facilitate such needs, have a clk_hw_get_clk() api which can be
used from within clock providers to get access to struct clk handles.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/clk.c            | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  5 +++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0fb39fe..a6ba77c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -186,6 +186,45 @@ const char *clk_hw_get_name(const struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_name);
 
+struct clk *clk_hw_get_clk(struct clk_hw *hw, const char *dev_id,
+			   const char *con_id)
+{
+	return __clk_create_clk(hw, dev_id, con_id);
+}
+EXPORT_SYMBOL_GPL(clk_hw_get_clk);
+
+void clk_hw_put_clk(struct clk *clk)
+{
+	__clk_free_clk(clk);
+}
+EXPORT_SYMBOL_GPL(clk_hw_put_clk);
+
+static void devm_clk_hw_put(struct device *dev, void *res)
+{
+	clk_hw_put_clk(*(struct clk **)res);
+}
+
+struct clk *devm_clk_hw_get_clk(struct device *dev, struct clk_hw *hw,
+				const char *con_id)
+{
+	struct clk **ptr, *clk;
+
+	ptr = devres_alloc(devm_clk_hw_put, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	clk = clk_hw_get_clk(hw, dev_name(dev), con_id);
+	if (!IS_ERR(clk)) {
+		*ptr = clk;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(devm_clk_hw_get_clk);
+
 struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return !clk ? NULL : clk->core->hw;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a428aec..feddf95 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -729,6 +729,11 @@ struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 /* helper functions */
 const char *__clk_get_name(const struct clk *clk);
 const char *clk_hw_get_name(const struct clk_hw *hw);
+struct clk *clk_hw_get_clk(struct clk_hw *hw, const char *dev_id,
+			   const char *con_id);
+void clk_hw_put_clk(struct clk *clk);
+struct clk *devm_clk_hw_get_clk(struct device *dev, struct clk_hw *hw,
+				const char *con_id);
 struct clk_hw *__clk_get_hw(struct clk *clk);
 unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
