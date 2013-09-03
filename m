From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue,  3 Sep 2013 17:04:29 +0530
Subject: [RFC Patch v2 1/3] clk: add support for temporary parent clock
 migration
In-Reply-To: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
References: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1378208072-10173-2-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms use to migrate temporarily to another parent during cpu frequency
scaling, e.g. Exynos and Tegra. Once the frequency is changed the latch on to
original parent.

The generic cpufreq-cpu0 driver use clk_set_rate API to scale cpu frequency.
This patch is an attempt to address the above mentioned requirement.

This is achieved as follows:

Add a clk flag "CLK_SET_RATE_TEMP_PARENT" for clocks which need to migrate to
another parent during set_rate operation on them.

Add "temp_parent_name" and "tmp_parent" fields to clk structure i.e the name of
temp_parent_clock and reference to temp_parent_clock.

Hence in clk_set_rate API check for the "CLK_SET_RATE_TEMP_PARENT" flag, then
latch on to alternate parent clock temporarily. Once the requested rate is set
on the clk, re-parent back to original parent clock.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 drivers/clk/clk-mux.c        |   13 +++++++------
 drivers/clk/clk.c            |   43 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/clk-private.h  |   19 +++++++++++--------
 include/linux/clk-provider.h |   10 ++++++----
 4 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 4f96ff3..854b3ac 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -115,8 +115,8 @@ EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		const char *temp_parent_name, void __iomem *reg, u8 shift,
+		u32 mask, u8 clk_mux_flags, u32 *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
 	struct clk *clk;
@@ -146,6 +146,7 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 	init.flags = flags | CLK_IS_BASIC;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
+	init.temp_parent_name = temp_parent_name;
 
 	/* struct clk_mux assignments */
 	mux->reg = reg;
@@ -167,13 +168,13 @@ EXPORT_SYMBOL_GPL(clk_register_mux_table);
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_mux_flags, spinlock_t *lock)
+		const char *temp_parent_name, void __iomem *reg, u8 shift,
+		u8 width, u8 clk_mux_flags, spinlock_t *lock)
 {
 	u32 mask = BIT(width) - 1;
 
 	return clk_register_mux_table(dev, name, parent_names, num_parents,
-				      flags, reg, shift, mask, clk_mux_flags,
-				      NULL, lock);
+				      flags, temp_parent_name, reg, shift,
+				      mask, clk_mux_flags, NULL, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_mux);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2db08c0..0e29a5b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1425,8 +1425,8 @@ static void clk_change_rate(struct clk *clk)
  */
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	struct clk *top, *fail_clk;
-	int ret = 0;
+	struct clk *top, *fail_clk, *parent = NULL;
+	int ret = 0, index;
 
 	if (!clk)
 		return 0;
@@ -1450,6 +1450,35 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		goto out;
 	}
 
+	/* Latch on to alternate parent temporarily if needed */
+	if ((clk->flags & CLK_SET_RATE_TEMP_PARENT) && clk->temp_parent_name) {
+		/* Save current parent before latching on to alternate parent */
+		parent = clk->parent;
+
+		if (!clk->temp_parent) {
+			for (index = 0; index < clk->num_parents; index++) {
+				if (!strcmp(clk->parent_names[index],
+						clk->temp_parent_name))
+					clk->temp_parent =
+					__clk_lookup(clk->temp_parent_name);
+			}
+
+			if (!clk->temp_parent) {
+				pr_warn("%s: wrong temp_parent_name %s",
+					__func__, clk->temp_parent_name);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+
+		ret = clk_set_parent(clk, clk->temp_parent);
+		if (ret) {
+			pr_warn("%s: failed to set %s parent\n",
+				__func__, clk->temp_parent->name);
+			goto out;
+		}
+	}
+
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
 	if (fail_clk) {
@@ -1464,6 +1493,14 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	clk_change_rate(top);
 
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
@@ -1803,6 +1840,7 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
 	clk->flags = hw->init->flags;
 	clk->parent_names = hw->init->parent_names;
 	clk->num_parents = hw->init->num_parents;
+	clk->temp_parent_name = hw->init->temp_parent_name;
 
 	ret = __clk_init(dev, clk);
 	if (ret)
@@ -1826,6 +1864,7 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 	clk->hw = hw;
 	clk->flags = hw->init->flags;
 	clk->num_parents = hw->init->num_parents;
+	clk->temp_parent_name = hw->init->temp_parent_name;
 	hw->clk = clk;
 
 	/* allocate local copy in case parent_names is __initdata */
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index 8138c94..b70ba4d 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -47,6 +47,8 @@ struct clk {
 #ifdef CONFIG_COMMON_CLK_DEBUG
 	struct dentry		*dentry;
 #endif
+	const char		*temp_parent_name;
+	struct clk		*temp_parent;
 };
 
 /*
@@ -59,7 +61,7 @@ struct clk {
  */
 
 #define DEFINE_CLK(_name, _ops, _flags, _parent_names,		\
-		_parents)					\
+		_parents, _temp_parent_name)			\
 	static struct clk _name = {				\
 		.name = #_name,					\
 		.ops = &_ops,					\
@@ -68,6 +70,7 @@ struct clk {
 		.num_parents = ARRAY_SIZE(_parent_names),	\
 		.parents = _parents,				\
 		.flags = _flags | CLK_IS_BASIC,			\
+		.temp_parent_name = _temp_parent_name,		\
 	}
 
 #define DEFINE_CLK_FIXED_RATE(_name, _flags, _rate,		\
@@ -82,7 +85,7 @@ struct clk {
 		.flags = _fixed_rate_flags,			\
 	};							\
 	DEFINE_CLK(_name, clk_fixed_rate_ops, _flags,		\
-			_name##_parent_names, NULL);
+			_name##_parent_names, NULL, NULL);
 
 #define DEFINE_CLK_GATE(_name, _parent_name, _parent_ptr,	\
 				_flags, _reg, _bit_idx,		\
@@ -104,7 +107,7 @@ struct clk {
 		.lock = _lock,					\
 	};							\
 	DEFINE_CLK(_name, clk_gate_ops, _flags,			\
-			_name##_parent_names, _name##_parents);
+			_name##_parent_names, _name##_parents, NULL);
 
 #define _DEFINE_CLK_DIVIDER(_name, _parent_name, _parent_ptr,	\
 				_flags, _reg, _shift, _width,	\
@@ -128,7 +131,7 @@ struct clk {
 		.lock = _lock,					\
 	};							\
 	DEFINE_CLK(_name, clk_divider_ops, _flags,		\
-			_name##_parent_names, _name##_parents);
+			_name##_parent_names, _name##_parents, NULL);
 
 #define DEFINE_CLK_DIVIDER(_name, _parent_name, _parent_ptr,	\
 				_flags, _reg, _shift, _width,	\
@@ -146,8 +149,8 @@ struct clk {
 				_divider_flags, _table, _lock)	\
 
 #define DEFINE_CLK_MUX(_name, _parent_names, _parents, _flags,	\
-				_reg, _shift, _width,		\
-				_mux_flags, _lock)		\
+				_temp_parent_name, _reg, _shift,\
+				_width,	_mux_flags, _lock)	\
 	static struct clk _name;				\
 	static struct clk_mux _name##_hw = {			\
 		.hw = {						\
@@ -160,7 +163,7 @@ struct clk {
 		.lock = _lock,					\
 	};							\
 	DEFINE_CLK(_name, clk_mux_ops, _flags, _parent_names,	\
-			_parents);
+			_parents, _temp_parent_name);
 
 #define DEFINE_CLK_FIXED_FACTOR(_name, _parent_name,		\
 				_parent_ptr, _flags,		\
@@ -180,7 +183,7 @@ struct clk {
 		.div = _div,					\
 	};							\
 	DEFINE_CLK(_name, clk_fixed_factor_ops, _flags,		\
-			_name##_parent_names, _name##_parents);
+			_name##_parent_names, _name##_parents, NULL);
 
 /**
  * __clk_init - initialize the data structures in a struct clk
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 73bdb69..6d7e2aa 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -29,6 +29,7 @@
 #define CLK_IS_BASIC		BIT(5) /* Basic clk, can't do a to_clk_foo() */
 #define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
+#define CLK_SET_RATE_TEMP_PARENT BIT(8) /* migrate to alternate parent */
 
 struct clk_hw;
 
@@ -158,6 +159,7 @@ struct clk_init_data {
 	const char		**parent_names;
 	u8			num_parents;
 	unsigned long		flags;
+	const char		*temp_parent_name;
 };
 
 /**
@@ -343,13 +345,13 @@ extern const struct clk_ops clk_mux_ro_ops;
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_mux_flags, spinlock_t *lock);
+		const char *temp_parent_name, void __iomem *reg, u8 shift,
+		u8 width, u8 clk_mux_flags, spinlock_t *lock);
 
 struct clk *clk_register_mux_table(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+		const char *temp_parent_name, void __iomem *reg, u8 shift,
+		u32 mask, u8 clk_mux_flags, u32 *table, spinlock_t *lock);
 
 void of_fixed_factor_clk_setup(struct device_node *node);
 
-- 
1.7.9.5
