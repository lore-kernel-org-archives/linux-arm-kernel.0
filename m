From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue,  6 Aug 2013 14:04:23 +0530
Subject: [RFC PATCH 1/3] clk: add support for temporary parent clock migration
In-Reply-To: <1375778065-21808-1-git-send-email-chander.kashyap@linaro.org>
References: <1375778065-21808-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1375778065-21808-2-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms use to migrate temporarily to another parent during cpu frequency
scaling, e.g. Exynos and Tegra. Once the frequency is changed the latch on to
original parent.

The generic cpufreq-cpu0 driver use CCF to scale cpu frequency. This patch is an
attempt to address the above mentioned requirement.

This is achieved as follows:

Add a clk flag "CLK_SET_RATE_ALTERNATE" for clocks which need to migrate to
another parent during set_rate operation on them.

Add "alternate_parent_name" and "alternate_parent" fields to clk structure
i.e the name of alternate_parent_clock and reference to alternate_parent_clock.

Hence in clk_set_rate API check for the "CLK_SET_RATE_ALTERNATE" flag, then
latch on to alternate parent clock temporarily. Once the requested rate is set
on the clk, re-parent back to original parent clock.

This property is applicable only for mux-clocks, where it is guaranteed that
set_rate will actually execute on parent clock.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 drivers/clk/clk-mux.c        |   13 ++++++------
 drivers/clk/clk.c            |   45 +++++++++++++++++++++++++++++++++++++++---
 include/linux/clk-private.h  |   17 +++++++++-------
 include/linux/clk-provider.h |   10 ++++++----
 4 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 614444c..47cb77f 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -109,8 +109,8 @@ EXPORT_SYMBOL_GPL(clk_mux_ops);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		const char *alternate_parent_name, void __iomem *reg, u8 shift,
+		u32 mask, u8 clk_mux_flags, u32 *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
 	struct clk *clk;
@@ -137,6 +137,7 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 	init.flags = flags | CLK_IS_BASIC;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
+	init.alternate_parent_name = alternate_parent_name;
 
 	/* struct clk_mux assignments */
 	mux->reg = reg;
@@ -157,12 +158,12 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_mux_flags, spinlock_t *lock)
+		const char *alternate_parent_name, void __iomem *reg, u8 shift,
+		u8 width, u8 clk_mux_flags, spinlock_t *lock)
 {
 	u32 mask = BIT(width) - 1;
 
 	return clk_register_mux_table(dev, name, parent_names, num_parents,
-				      flags, reg, shift, mask, clk_mux_flags,
-				      NULL, lock);
+				      flags, alternate_parent_name, reg, shift,
+				      mask, clk_mux_flags, NULL, lock);
 }
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 54a191c..0f18a45 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1209,8 +1209,8 @@ static void clk_change_rate(struct clk *clk)
  */
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	struct clk *top, *fail_clk;
-	int ret = 0;
+	struct clk *top, *fail_clk, *parent = NULL;
+	int ret = 0, index;
 
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
@@ -1231,6 +1231,36 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		goto out;
 	}
 
+	/* Latch on to alternate parent temporarily if needed */
+	if ((clk->flags & CLK_SET_RATE_ALTERNATE)
+				&& clk->alternate_parent_name) {
+		/* Save current parent before latching on to alternate parent */
+		parent = clk->parent;
+
+		if (!clk->alternate_parent) {
+			for (index = 0; index < clk->num_parents; index++) {
+				if (!strcmp(clk->parent_names[index],
+						clk->alternate_parent_name))
+					clk->alternate_parent =
+					__clk_lookup(clk->alternate_parent_name);
+			}
+
+			if (!clk->alternate_parent) {
+				pr_warn("%s: wrong alternate_parent_name %s",
+					__func__, clk->alternate_parent_name);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+
+		ret = clk_set_parent(clk, clk->alternate_parent);
+		if (ret) {
+			pr_warn("%s: failed to set %s parent\n",
+				__func__, clk->alternate_parent->name);
+			goto out;
+		}
+	}
+
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
 	if (fail_clk) {
@@ -1243,8 +1273,15 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 
 	/* change the rates */
 	clk_change_rate(top);
-
 out:
+	/* Reparent back to original parent */
+	if (parent) {
+		ret = clk_set_parent(clk, parent);
+		if (ret)
+			pr_warn("%s: failed to set %s parent\n",
+					__func__, parent->name);
+	}
+
 	clk_prepare_unlock();
 
 	return ret;
@@ -1690,6 +1727,7 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
 	clk->flags = hw->init->flags;
 	clk->parent_names = hw->init->parent_names;
 	clk->num_parents = hw->init->num_parents;
+	clk->alternate_parent_name = hw->init->alternate_parent_name;
 
 	ret = __clk_init(dev, clk);
 	if (ret)
@@ -1713,6 +1751,7 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 	clk->hw = hw;
 	clk->flags = hw->init->flags;
 	clk->num_parents = hw->init->num_parents;
+	clk->alternate_parent_name = hw->init->alternate_parent_name;
 	hw->clk = clk;
 
 	/* allocate local copy in case parent_names is __initdata */
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index dd7adff..f295af0 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -44,6 +44,8 @@ struct clk {
 #ifdef CONFIG_COMMON_CLK_DEBUG
 	struct dentry		*dentry;
 #endif
+	const char		*alternate_parent_name;
+	struct clk		*alternate_parent;
 };
 
 /*
@@ -56,7 +58,7 @@ struct clk {
  */
 
 #define DEFINE_CLK(_name, _ops, _flags, _parent_names,		\
-		_parents)					\
+		_parents, _alternate_parent_name)		\
 	static struct clk _name = {				\
 		.name = #_name,					\
 		.ops = &_ops,					\
@@ -65,6 +67,7 @@ struct clk {
 		.num_parents = ARRAY_SIZE(_parent_names),	\
 		.parents = _parents,				\
 		.flags = _flags | CLK_IS_BASIC,			\
+		.alternate_parent_name = _alternate_parent_name	\
 	}
 
 #define DEFINE_CLK_FIXED_RATE(_name, _flags, _rate,		\
@@ -79,7 +82,7 @@ struct clk {
 		.flags = _fixed_rate_flags,			\
 	};							\
 	DEFINE_CLK(_name, clk_fixed_rate_ops, _flags,		\
-			_name##_parent_names, NULL);
+			_name##_parent_names, NULL, NULL);
 
 #define DEFINE_CLK_GATE(_name, _parent_name, _parent_ptr,	\
 				_flags, _reg, _bit_idx,		\
@@ -101,7 +104,7 @@ struct clk {
 		.lock = _lock,					\
 	};							\
 	DEFINE_CLK(_name, clk_gate_ops, _flags,			\
-			_name##_parent_names, _name##_parents);
+			_name##_parent_names, _name##_parents, NULL);
 
 #define _DEFINE_CLK_DIVIDER(_name, _parent_name, _parent_ptr,	\
 				_flags, _reg, _shift, _width,	\
@@ -125,7 +128,7 @@ struct clk {
 		.lock = _lock,					\
 	};							\
 	DEFINE_CLK(_name, clk_divider_ops, _flags,		\
-			_name##_parent_names, _name##_parents);
+			_name##_parent_names, _name##_parents, NULL);
 
 #define DEFINE_CLK_DIVIDER(_name, _parent_name, _parent_ptr,	\
 				_flags, _reg, _shift, _width,	\
@@ -143,8 +146,8 @@ struct clk {
 				_divider_flags, _table, _lock)	\
 
 #define DEFINE_CLK_MUX(_name, _parent_names, _parents, _flags,	\
-				_reg, _shift, _width,		\
-				_mux_flags, _lock)		\
+				_alternate_parent_name, _reg,	\
+				_shift, _width,	_mux_flags, _lock) \
 	static struct clk _name;				\
 	static struct clk_mux _name##_hw = {			\
 		.hw = {						\
@@ -157,7 +160,7 @@ struct clk {
 		.lock = _lock,					\
 	};							\
 	DEFINE_CLK(_name, clk_mux_ops, _flags, _parent_names,	\
-			_parents);
+			_parents, _alternate_parentn_name);
 
 #define DEFINE_CLK_FIXED_FACTOR(_name, _parent_name,		\
 				_parent_ptr, _flags,		\
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1ec14a7..25071b5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -27,6 +27,7 @@
 #define CLK_IS_ROOT		BIT(4) /* root clk, has no parent */
 #define CLK_IS_BASIC		BIT(5) /* Basic clk, can't do a to_clk_foo() */
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
+#define CLK_SET_RATE_ALTERNATE	BIT(7) /* migrate to alternate parent */
 
 struct clk_hw;
 
@@ -149,6 +150,7 @@ struct clk_init_data {
 	const char		**parent_names;
 	u8			num_parents;
 	unsigned long		flags;
+	const char		*alternate_parent_name;
 };
 
 /**
@@ -332,13 +334,13 @@ extern const struct clk_ops clk_mux_ops;
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_mux_flags, spinlock_t *lock);
+		const char *alternate_parent_name, void __iomem *reg, u8 shift,
+		u8 width, u8 clk_mux_flags, spinlock_t *lock);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+		const char *alternate_parent_name, void __iomem *reg, u8 shift,
+		u32 mask, u8 clk_mux_flags, u32 *table, spinlock_t *lock);
 
 void of_fixed_factor_clk_setup(struct device_node *node);
 
-- 
1.7.9.5
