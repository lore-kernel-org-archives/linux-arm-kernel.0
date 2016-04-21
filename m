From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Apr 2016 15:21:54 -0700
Subject: [PATCH v2 03/13] clk: Add clk_hw OF clk providers
In-Reply-To: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1461277324-27185-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a clk registration API that doesn't return
struct clks, we need to have some way to hand out struct clks via
the clk_get() APIs that doesn't involve associating struct clk
pointers with an OF node. Currently we ask the OF provider to
give us a struct clk pointer for some clkspec, turn that struct
clk into a struct clk_hw and then allocate a new struct clk to
return to the caller.

Let's add a clk_hw based OF provider hook that returns a struct
clk_hw directly, so that we skip the intermediate step of
converting from struct clk to struct clk_hw. Eventually when
we've converted all OF clk providers to struct clk_hw based APIs
we can remove the struct clk based ones.

It should also be noted that we change the onecell provider to
have a flex array instead of a pointer for the array of clk_hw
pointers. This allows providers to allocate one structure of the
correct length in one step instead of two.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk.c            | 85 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/clk-provider.h | 30 ++++++++++++++++
 2 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0ef919666827..e813b2aabc87 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2941,6 +2941,7 @@ struct of_clk_provider {
 
 	struct device_node *node;
 	struct clk *(*get)(struct of_phandle_args *clkspec, void *data);
+	struct clk_hw *(*get_hw)(struct of_phandle_args *clkspec, void *data);
 	void *data;
 };
 
@@ -2957,6 +2958,12 @@ struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 }
 EXPORT_SYMBOL_GPL(of_clk_src_simple_get);
 
+struct clk_hw *of_clk_hw_simple_get(struct of_phandle_args *clkspec, void *data)
+{
+	return data;
+}
+EXPORT_SYMBOL_GPL(of_clk_hw_simple_get);
+
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct clk_onecell_data *clk_data = data;
@@ -2971,6 +2978,21 @@ struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data)
 }
 EXPORT_SYMBOL_GPL(of_clk_src_onecell_get);
 
+struct clk_hw *
+of_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct clk_hw_onecell_data *hw_data = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= hw_data->num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return hw_data->hws[idx];
+}
+EXPORT_SYMBOL_GPL(of_clk_hw_onecell_get);
+
 /**
  * of_clk_add_provider() - Register a clock provider for a node
  * @np: Device node pointer associated with clock provider
@@ -3007,6 +3029,41 @@ int of_clk_add_provider(struct device_node *np,
 EXPORT_SYMBOL_GPL(of_clk_add_provider);
 
 /**
+ * of_clk_add_hw_provider() - Register a clock provider for a node
+ * @np: Device node pointer associated with clock provider
+ * @get: callback for decoding clk_hw
+ * @data: context pointer for @get callback.
+ */
+int of_clk_add_hw_provider(struct device_node *np,
+			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+						 void *data),
+			   void *data)
+{
+	struct of_clk_provider *cp;
+	int ret;
+
+	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->node = of_node_get(np);
+	cp->data = data;
+	cp->get_hw = get;
+
+	mutex_lock(&of_clk_mutex);
+	list_add(&cp->link, &of_clk_providers);
+	mutex_unlock(&of_clk_mutex);
+	pr_debug("Added clk_hw provider from %s\n", np->full_name);
+
+	ret = of_clk_set_defaults(np, true);
+	if (ret < 0)
+		of_clk_del_provider(np);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_clk_add_hw_provider);
+
+/**
  * of_clk_del_provider() - Remove a previously registered clock provider
  * @np: Device node pointer associated with clock provider
  */
@@ -3027,11 +3084,32 @@ void of_clk_del_provider(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_clk_del_provider);
 
+static struct clk_hw *
+__of_clk_get_hw_from_provider(struct of_clk_provider *provider,
+			      struct of_phandle_args *clkspec)
+{
+	struct clk *clk;
+	struct clk_hw *hw = ERR_PTR(-EPROBE_DEFER);
+
+	if (provider->get_hw) {
+		hw = provider->get_hw(clkspec, provider->data);
+	} else if (provider->get) {
+		clk = provider->get(clkspec, provider->data);
+		if (!IS_ERR(clk))
+			hw = __clk_get_hw(clk);
+		else
+			hw = ERR_CAST(clk);
+	}
+
+	return hw;
+}
+
 struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 				       const char *dev_id, const char *con_id)
 {
 	struct of_clk_provider *provider;
 	struct clk *clk = ERR_PTR(-EPROBE_DEFER);
+	struct clk_hw *hw = ERR_PTR(-EPROBE_DEFER);
 
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
@@ -3040,10 +3118,9 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np)
-			clk = provider->get(clkspec, provider->data);
-		if (!IS_ERR(clk)) {
-			clk = __clk_create_clk(__clk_get_hw(clk), dev_id,
-					       con_id);
+			hw = __of_clk_get_hw_from_provider(provider, clkspec);
+		if (!IS_ERR(hw)) {
+			clk = __clk_create_clk(hw, dev_id, con_id);
 
 			if (!IS_ERR(clk) && !__clk_get(clk)) {
 				__clk_free_clk(clk);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index bc6c8de1fac1..bf8c8bb8c2cb 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -709,6 +709,11 @@ struct clk_onecell_data {
 	unsigned int clk_num;
 };
 
+struct clk_hw_onecell_data {
+	size_t num;
+	struct clk_hw *hws[];
+};
+
 extern struct of_device_id __clk_of_table;
 
 #define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
@@ -718,10 +723,18 @@ int of_clk_add_provider(struct device_node *np,
 			struct clk *(*clk_src_get)(struct of_phandle_args *args,
 						   void *data),
 			void *data);
+int of_clk_add_hw_provider(struct device_node *np,
+			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+						 void *data),
+			   void *data);
 void of_clk_del_provider(struct device_node *np);
 struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 				  void *data);
+struct clk_hw *of_clk_hw_simple_get(struct of_phandle_args *clkspec,
+				    void *data);
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
+struct clk_hw *of_clk_hw_onecell_get(struct of_phandle_args *clkspec,
+				     void *data);
 unsigned int of_clk_get_parent_count(struct device_node *np);
 int of_clk_parent_fill(struct device_node *np, const char **parents,
 		       unsigned int size);
@@ -738,17 +751,34 @@ static inline int of_clk_add_provider(struct device_node *np,
 {
 	return 0;
 }
+static inline int of_clk_add_hw_provider(struct device_node *np,
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+					      void *data),
+			void *data)
+{
+	return 0;
+}
 static inline void of_clk_del_provider(struct device_node *np) {}
 static inline struct clk *of_clk_src_simple_get(
 	struct of_phandle_args *clkspec, void *data)
 {
 	return ERR_PTR(-ENOENT);
 }
+static inline struct clk_hw *
+of_clk_hw_simple_get(struct of_phandle_args *clkspec, void *data)
+{
+	return ERR_PTR(-ENOENT);
+}
 static inline struct clk *of_clk_src_onecell_get(
 	struct of_phandle_args *clkspec, void *data)
 {
 	return ERR_PTR(-ENOENT);
 }
+static inline struct clk_hw *
+of_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
+{
+	return ERR_PTR(-ENOENT);
+}
 static inline int of_clk_get_parent_count(struct device_node *np)
 {
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
