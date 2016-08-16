From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 15:34:59 +0200
Subject: [RFC 02/17] clk: Add clock controller to fine-grain the prepare lock
In-Reply-To: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471354514-24224-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new entity - clock controller - so the global clock prepare lock
could be fine-grained per controller.  The controller is an abstract way
of representing a hardware block.  It overlaps a little with clock
provider so there is a potential of merging them.

The clock hierarchy might span between many controllers so add necessary
locking primitives for locking children, parents or everything.

Add a global controller for drivers not converted to new API.  This will
be removed once everything uses per-device/per-driver clock controller.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk.c            | 300 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h |  25 +++-
 include/linux/clk.h          |   1 +
 3 files changed, 310 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 238b989bf778..ee1cedfbaa29 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -35,6 +35,7 @@ static struct task_struct *enable_owner;
 static int prepare_refcnt;
 static int enable_refcnt;
 
+static LIST_HEAD(clk_ctrl_list);
 static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
@@ -46,6 +47,7 @@ struct clk_core {
 	const struct clk_ops	*ops;
 	struct clk_hw		*hw;
 	struct module		*owner;
+	struct clk_ctrl		*ctrl;
 	struct clk_core		*parent;
 	const char		**parent_names;
 	struct clk_core		**parents;
@@ -87,6 +89,24 @@ struct clk {
 	struct hlist_node clks_node;
 };
 
+struct clk_ctrl {
+	struct device *dev; /* Needed? */
+	struct mutex prepare_lock;
+	struct task_struct *prepare_owner;
+	int prepare_refcnt;
+	struct list_head node;
+};
+
+/*
+ * As a temporary solution, register all clocks which pass NULL as clock
+ * controller under this one.  This should be removed after converting
+ * all users to new clock controller aware API.
+ */
+static struct clk_ctrl global_ctrl = {
+	.prepare_lock = __MUTEX_INITIALIZER(global_ctrl.prepare_lock),
+	.node = LIST_HEAD_INIT(global_ctrl.node),
+};
+
 /***           locking             ***/
 static void clk_prepare_lock(void)
 {
@@ -148,6 +168,228 @@ static void clk_enable_unlock(unsigned long flags)
 	spin_unlock_irqrestore(&enable_lock, flags);
 }
 
+static void clk_ctrl_prepare_lock(struct clk_ctrl *ctrl)
+{
+	if (!ctrl)
+		return;
+
+	if (!mutex_trylock(&ctrl->prepare_lock)) {
+		if (ctrl->prepare_owner == current) {
+			ctrl->prepare_refcnt++;
+			return;
+		}
+		mutex_lock(&ctrl->prepare_lock);
+	}
+	WARN_ON_ONCE(ctrl->prepare_owner != NULL);
+	WARN_ON_ONCE(ctrl->prepare_refcnt != 0);
+	ctrl->prepare_owner = current;
+	ctrl->prepare_refcnt = 1;
+}
+
+static void clk_ctrl_prepare_unlock(struct clk_ctrl *ctrl)
+{
+	if (!ctrl)
+		return;
+
+	WARN_ON_ONCE(ctrl->prepare_owner != current);
+	WARN_ON_ONCE(ctrl->prepare_refcnt == 0);
+
+	if (--ctrl->prepare_refcnt)
+		return;
+	ctrl->prepare_owner = NULL;
+	mutex_unlock(&ctrl->prepare_lock);
+}
+
+static void clk_prepare_lock_ctrl(struct clk_core *core)
+{
+	if (!core)
+		return;
+
+	clk_ctrl_prepare_lock(core->ctrl);
+}
+
+static void clk_prepare_unlock_ctrl(struct clk_core *core)
+{
+	if (!core)
+		return;
+
+	clk_ctrl_prepare_unlock(core->ctrl);
+}
+
+static void clk_prepare_lock_parents_locked(struct clk_core *core)
+{
+	struct clk_ctrl *prev = NULL;
+
+	// lockdep_assert_held(&prepare_lock); // tmp comment?
+
+	if (!core)
+		return;
+
+	do {
+		if (core->ctrl != prev) {
+			clk_ctrl_prepare_lock(core->ctrl);
+			prev = core->ctrl;
+		}
+	} while ((core = core->parent));
+}
+
+static void clk_prepare_lock_parents(struct clk_core *core)
+{
+	if (!core)
+		return;
+
+	clk_prepare_lock();
+	clk_prepare_lock_parents_locked(core);
+	clk_prepare_unlock();
+}
+
+static void clk_prepare_unlock_parents_recur(struct clk_core *core,
+					     struct clk_ctrl *prev)
+{
+	if (!core)
+		return;
+
+	clk_prepare_unlock_parents_recur(core->parent, core->ctrl);
+	if (core->ctrl != prev)
+		clk_ctrl_prepare_unlock(core->ctrl);
+}
+
+static void clk_prepare_unlock_parents(struct clk_core *core)
+{
+	if (!core)
+		return;
+
+	clk_prepare_unlock_parents_recur(core, NULL);
+}
+
+// FIXME: important note - will skip first lock
+static void clk_prepare_lock_children_locked(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	lockdep_assert_held(&prepare_lock);
+
+	if (!core)
+		return;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		clk_prepare_lock_children_locked(child);
+
+		/* No need to double lock the same controller */
+		if (child->ctrl != core->ctrl)
+			clk_ctrl_prepare_lock(child->ctrl);
+	}
+}
+
+static void clk_prepare_lock_children(struct clk_core *core)
+{
+	if (!core)
+		return;
+
+	clk_prepare_lock();
+	clk_prepare_lock_children_locked(core);
+	/* Initial lock because children recurrency skiped first one */
+	clk_ctrl_prepare_lock(core->ctrl);
+}
+
+static void clk_prepare_unlock_children_locked(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	if (!core)
+		return;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		/* No need to double unlock the same controller */
+		if (child->ctrl != core->ctrl)
+			clk_ctrl_prepare_unlock(child->ctrl);
+
+		clk_prepare_unlock_children_locked(child);
+	}
+}
+
+static void clk_prepare_unlock_children(struct clk_core *core)
+{
+	if (!core)
+		return;
+
+	/* Unlock the initial controller, skipped in children recurrency */
+	clk_ctrl_prepare_unlock(core->ctrl);
+	clk_prepare_unlock_children_locked(core);
+	clk_prepare_unlock();
+}
+
+/* Locks prepare lock, children and parents */
+static void clk_prepare_lock_tree(struct clk_core *core)
+{
+	if (!core)
+		return;
+
+	clk_prepare_lock();
+	clk_prepare_lock_children_locked(core);
+	/* Children recurrency skiped locking first one */
+	clk_ctrl_prepare_lock(core->ctrl);
+	clk_prepare_lock_parents_locked(core);
+}
+
+static void clk_prepare_unlock_tree(struct clk_core *core)
+{
+	if (!core)
+		return;
+
+	clk_prepare_unlock_parents(core);
+	/* Unlock the initial controller, skipped in children recurrency */
+	clk_ctrl_prepare_unlock(core->ctrl);
+	clk_prepare_unlock_children_locked(core);
+	clk_prepare_unlock();
+}
+
+/*
+ * Unlocks the controller hierarchy (children and parents) but going from
+ * old parent.  Used in case of reparenting.
+ * If (core->parent == old_parent), this is equal to clk_prepare_unlock_tree().
+ */
+static void clk_prepare_unlock_oldtree(struct clk_core *core,
+				       struct clk_core *old_parent)
+{
+	if (!core)
+		return;
+
+	clk_prepare_unlock_parents(old_parent);
+	/*
+	 * Lock parents was called on 'core', but we unlock starting from
+	 * 'old_parent'. In the same time locking did not lock the same
+	 * controller twice but this check will be skipped for 'core'.
+	 */
+	if (old_parent->ctrl != core->ctrl)
+		clk_ctrl_prepare_unlock(core->ctrl);
+
+	/* Unlock the initial controller, skipped in children recurrency */
+	clk_ctrl_prepare_unlock(core->ctrl);
+	clk_prepare_unlock_children_locked(core);
+	clk_prepare_unlock();
+}
+
+/* Locks everything */
+/* FIXME: order of locking, it does not follow child-parent */
+static void clk_prepare_lock_all(void)
+{
+	struct clk_ctrl *ctrl;
+
+	clk_prepare_lock();
+	list_for_each_entry(ctrl, &clk_ctrl_list, node)
+		clk_ctrl_prepare_lock(ctrl);
+}
+
+static void clk_prepare_unlock_all(void)
+{
+	struct clk_ctrl *ctrl;
+
+	list_for_each_entry(ctrl, &clk_ctrl_list, node)
+		clk_ctrl_prepare_unlock(ctrl);
+	clk_prepare_unlock();
+}
+
 static bool clk_core_is_prepared(struct clk_core *core)
 {
 	/*
@@ -2526,6 +2768,34 @@ void __clk_free_clk(struct clk *clk)
 	kfree(clk);
 }
 
+struct clk_ctrl *clk_ctrl_register(struct device *dev)
+{
+	struct clk_ctrl *ctrl;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&ctrl->prepare_lock);
+
+	clk_prepare_lock();
+	list_add(&ctrl->node, &clk_ctrl_list);
+	clk_prepare_unlock();
+
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(clk_ctrl_register);
+
+void clk_ctrl_unregister(struct clk_ctrl *ctrl)
+{
+	clk_prepare_lock();
+	list_del(&ctrl->node);
+	clk_prepare_unlock();
+
+	kfree(ctrl);
+}
+EXPORT_SYMBOL_GPL(clk_ctrl_unregister);
+
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
@@ -2537,7 +2807,8 @@ void __clk_free_clk(struct clk *clk)
  * rest of the clock API.  In the event of an error clk_register will return an
  * error code; drivers must test for an error code after calling clk_register.
  */
-struct clk *clk_register(struct device *dev, struct clk_hw *hw)
+struct clk *clk_register_with_ctrl(struct device *dev, struct clk_ctrl *ctrl,
+				   struct clk_hw *hw)
 {
 	int i, ret;
 	struct clk_core *core;
@@ -2561,6 +2832,10 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	core->num_parents = hw->init->num_parents;
 	core->min_rate = 0;
 	core->max_rate = ULONG_MAX;
+	if (ctrl)
+		core->ctrl = ctrl;
+	else
+		core->ctrl = &global_ctrl;
 	hw->core = core;
 
 	/* allocate local copy in case parent_names is __initdata */
@@ -2619,7 +2894,7 @@ fail_name:
 fail_out:
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(clk_register);
+EXPORT_SYMBOL_GPL(clk_register_with_ctrl);
 
 /**
  * clk_hw_register - register a clk_hw and return an error code
@@ -2631,11 +2906,12 @@ EXPORT_SYMBOL_GPL(clk_register);
  * less than zero indicating failure. Drivers must test for an error code after
  * calling clk_hw_register().
  */
-int clk_hw_register(struct device *dev, struct clk_hw *hw)
+int clk_hw_register_with_ctrl(struct device *dev, struct clk_ctrl *ctrl,
+			      struct clk_hw *hw)
 {
-	return PTR_ERR_OR_ZERO(clk_register(dev, hw));
+	return PTR_ERR_OR_ZERO(clk_register_with_ctrl(dev, ctrl, hw));
 }
-EXPORT_SYMBOL_GPL(clk_hw_register);
+EXPORT_SYMBOL_GPL(clk_hw_register_with_ctrl);
 
 /* Free memory allocated for a clock. */
 static void __clk_release(struct kref *ref)
@@ -2644,6 +2920,7 @@ static void __clk_release(struct kref *ref)
 	int i = core->num_parents;
 
 	lockdep_assert_held(&prepare_lock);
+	// lockdep_assert_not_held(&core->ctrl->prepare_lock); // TODO?
 
 	kfree(core->parents);
 	while (--i >= 0)
@@ -2767,7 +3044,7 @@ static void devm_clk_hw_release(struct device *dev, void *res)
  * automatically clk_unregister()ed on driver detach. See clk_register() for
  * more information.
  */
-struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw)
+struct clk *devm_clk_register_with_ctrl(struct device *dev, struct clk_ctrl *ctrl, struct clk_hw *hw)
 {
 	struct clk *clk;
 	struct clk **clkp;
@@ -2776,7 +3053,7 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw)
 	if (!clkp)
 		return ERR_PTR(-ENOMEM);
 
-	clk = clk_register(dev, hw);
+	clk = clk_register_with_ctrl(dev, ctrl, hw);
 	if (!IS_ERR(clk)) {
 		*clkp = clk;
 		devres_add(dev, clkp);
@@ -2786,7 +3063,7 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw)
 
 	return clk;
 }
-EXPORT_SYMBOL_GPL(devm_clk_register);
+EXPORT_SYMBOL_GPL(devm_clk_register_with_ctrl);
 
 /**
  * devm_clk_hw_register - resource managed clk_hw_register()
@@ -2797,7 +3074,8 @@ EXPORT_SYMBOL_GPL(devm_clk_register);
  * automatically clk_hw_unregister()ed on driver detach. See clk_hw_register()
  * for more information.
  */
-int devm_clk_hw_register(struct device *dev, struct clk_hw *hw)
+int devm_clk_hw_register_with_ctrl(struct device *dev, struct clk_ctrl *ctrl,
+				   struct clk_hw *hw)
 {
 	struct clk_hw **hwp;
 	int ret;
@@ -2806,7 +3084,7 @@ int devm_clk_hw_register(struct device *dev, struct clk_hw *hw)
 	if (!hwp)
 		return -ENOMEM;
 
-	ret = clk_hw_register(dev, hw);
+	ret = clk_hw_register_with_ctrl(dev, ctrl, hw);
 	if (!ret) {
 		*hwp = hw;
 		devres_add(dev, hwp);
@@ -2816,7 +3094,7 @@ int devm_clk_hw_register(struct device *dev, struct clk_hw *hw)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(devm_clk_hw_register);
+EXPORT_SYMBOL_GPL(devm_clk_hw_register_with_ctrl);
 
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a39c0c530778..3589f164ff94 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -39,6 +39,7 @@
 struct clk;
 struct clk_hw;
 struct clk_core;
+struct clk_ctrl;
 struct dentry;
 
 /**
@@ -703,6 +704,8 @@ struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 		bool active_low, unsigned long flags);
 void clk_hw_unregister_gpio_mux(struct clk_hw *hw);
 
+struct clk_ctrl *clk_ctrl_register(struct device *dev);
+void clk_ctrl_unregister(struct clk_ctrl *ctrl);
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
@@ -714,11 +717,23 @@ void clk_hw_unregister_gpio_mux(struct clk_hw *hw);
  * rest of the clock API.  In the event of an error clk_register will return an
  * error code; drivers must test for an error code after calling clk_register.
  */
-struct clk *clk_register(struct device *dev, struct clk_hw *hw);
-struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
-
-int __must_check clk_hw_register(struct device *dev, struct clk_hw *hw);
-int __must_check devm_clk_hw_register(struct device *dev, struct clk_hw *hw);
+struct clk *clk_register_with_ctrl(struct device *dev, struct clk_ctrl *ctrl,
+				   struct clk_hw *hw);
+struct clk *devm_clk_register_with_ctrl(struct device *dev, struct clk_ctrl *ctrl,
+					struct clk_hw *hw);
+
+#define clk_register(dev, hw)		clk_register_with_ctrl(dev, NULL, hw)
+#define devm_clk_register(dev, hw)	devm_clk_register_with_ctrl(dev, NULL, hw)
+
+int __must_check clk_hw_register_with_ctrl(struct device *dev,
+					   struct clk_ctrl *ctrl,
+					   struct clk_hw *hw);
+int __must_check devm_clk_hw_register_with_ctrl(struct device *dev,
+						struct clk_ctrl *ctrl,
+						struct clk_hw *hw);
+
+#define clk_hw_register(dev, hw) clk_hw_register_with_ctrl(dev, NULL, hw)
+#define devm_clk_hw_register(dev, hw) devm_clk_hw_register_with_ctrl(dev, NULL, hw)
 
 void clk_unregister(struct clk *clk);
 void devm_clk_unregister(struct device *dev, struct clk *clk);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 123c02788807..8f751d1eb1df 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -19,6 +19,7 @@
 struct device;
 
 struct clk;
+struct clk_ctrl;
 
 /**
  * DOC: clk notifier callback types
-- 
1.9.1
