From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Apr 2011 21:08:12 +0200
Subject: [PATCH 07/10] ARM i.MX: Support for clock building blocks.
In-Reply-To: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1302894495-6879-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds generic code to handle different common patterns
in i.MX clock code.

* gates         clk_[en|dis]able
* groups        Group together clocks which should be enabled at once.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/clock.c              |  182 ++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/clock.h |  126 +++++++++++++++++++++-
 2 files changed, 305 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 2ed3ab1..e881ab2 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -44,6 +44,8 @@
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
+#ifndef CONFIG_USE_COMMON_STRUCT_CLK
+
 /*-------------------------------------------------------------------------
  * Standard clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
@@ -199,6 +201,7 @@ struct clk *clk_get_parent(struct clk *clk)
 	return clk->parent;
 }
 EXPORT_SYMBOL(clk_get_parent);
+#endif
 
 /*
  * Get the resulting clock rate from a PLL register value and the input
@@ -244,3 +247,182 @@ unsigned long mxc_decode_pll(unsigned int reg_val, u32 freq)
 
 	return ll;
 }
+
+#ifdef CONFIG_USE_COMMON_STRUCT_CLK
+
+DEFINE_SPINLOCK(imx_ccm_lock);
+
+/* clk gate support */
+
+#define to_clk_gate(clk) (container_of(clk, struct clk_gate, clk))
+
+static int clk_gate_enable(struct clk *clk)
+{
+	struct clk_gate *gate = to_clk_gate(clk);
+	u32 val;
+	int ret;
+	unsigned long flags;
+
+	if (gate->parent) {
+		ret = clk_parent_enable(gate->parent);
+		if (ret)
+			return ret;
+	}
+
+	spin_lock_irqsave(&imx_ccm_lock, flags);
+
+	val = readl(gate->reg);
+
+	if (gate->flags & CLK_GATE_TWO_BITS) {
+		if (gate->flags & CLK_GATE_ENABLE_WAIT) {
+			val &= ~(3 << (gate->shift * 2));
+			val |= 1 << (gate->shift * 2);
+		} else {
+			val |= 3 << (gate->shift * 2);
+		}
+	} else {
+		val |= 1 << (gate->shift);
+	}
+
+	writel(val, gate->reg);
+
+	spin_unlock_irqrestore(&imx_ccm_lock, flags);
+
+	return 0;
+}
+
+static void clk_gate_disable(struct clk *clk)
+{
+	struct clk_gate *gate = to_clk_gate(clk);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&imx_ccm_lock, flags);
+
+	val = readl(gate->reg);
+
+	if (gate->flags & CLK_GATE_TWO_BITS) {
+		if (gate->flags & CLK_GATE_DISABLE_WAIT) {
+			val &= ~(3 << (gate->shift * 2));
+			val |= 1 << (gate->shift * 2);
+		} else {
+			val &= ~(3 << (gate->shift * 2));
+		}
+	} else {
+		val &= ~(1 << (gate->shift));
+	}
+
+	writel(val, gate->reg);
+
+	spin_unlock_irqrestore(&imx_ccm_lock, flags);
+
+	if (gate->parent)
+		clk_parent_disable(gate->parent);
+}
+
+static struct clk *clk_gate_get_parent(struct clk *clk)
+{
+	struct clk_gate *gate = to_clk_gate(clk);
+
+	return gate->parent;
+}
+
+struct clk_ops clk_gate_ops = {
+	.prepare = clk_parent_prepare,
+	.unprepare = clk_parent_unprepare,
+	.enable = clk_gate_enable,
+	.disable = clk_gate_disable,
+	.get_rate = clk_parent_get_rate,
+	.round_rate = clk_parent_round_rate,
+	.set_rate = clk_parent_set_rate,
+	.get_parent = clk_gate_get_parent,
+};
+EXPORT_SYMBOL_GPL(clk_gate_ops);
+
+#define to_clk_group(clk) (container_of(clk, struct clk_group, clk))
+
+static int clk_group_prepare(struct clk *clk)
+{
+	struct clk_group *group = to_clk_group(clk);
+	int i, ret;
+
+	for (i = 0; i < group->num_clks; i++) {
+		ret = clk_prepare(group->clks[i]);
+			if (ret)
+				goto out;
+	}
+
+	return 0;
+out:
+	while (i-- > 0)
+		clk_disable(group->clks[i]);
+	return ret;
+}
+
+static void clk_group_unprepare(struct clk *clk)
+{
+	struct clk_group *group = to_clk_group(clk);
+	int i;
+
+	for (i = 0; i < group->num_clks; i++)
+		clk_disable(group->clks[i]);
+}
+
+static int clk_group_enable(struct clk *clk)
+{
+	struct clk_group *group = to_clk_group(clk);
+	int i, ret;
+
+	for (i = 0; i < group->num_clks; i++) {
+		ret = clk_enable(group->clks[i]);
+			if (ret)
+				goto out;
+	}
+
+	return 0;
+out:
+	while (i-- > 0)
+		clk_disable(group->clks[i]);
+	return ret;
+}
+
+static void clk_group_disable(struct clk *clk)
+{
+	struct clk_group *group = to_clk_group(clk);
+	int i;
+
+	for (i = 0; i < group->num_clks; i++)
+		clk_disable(group->clks[i]);
+}
+
+static unsigned long clk_group_get_rate(struct clk *clk)
+{
+	struct clk_group *group = to_clk_group(clk);
+
+	return clk_get_rate(group->clks[0]);
+}
+
+static long clk_group_round_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk_group *group = to_clk_group(clk);
+
+	return clk_round_rate(group->clks[0], rate);
+}
+
+static int clk_group_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk_group *group = to_clk_group(clk);
+
+	return clk_set_rate(group->clks[0], rate);
+}
+
+struct clk_ops clk_group_ops = {
+	.prepare = clk_group_prepare,
+	.unprepare = clk_group_unprepare,
+	.enable = clk_group_enable,
+	.disable = clk_group_disable,
+	.get_rate = clk_group_get_rate,
+	.round_rate = clk_group_round_rate,
+	.set_rate = clk_group_set_rate,
+};
+#endif /* CONFIG_USE_COMMON_STRUCT_CLK */
diff --git a/arch/arm/plat-mxc/include/mach/clock.h b/arch/arm/plat-mxc/include/mach/clock.h
index 753a598..73a72af 100644
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ b/arch/arm/plat-mxc/include/mach/clock.h
@@ -57,10 +57,130 @@ struct clk {
 	int (*set_parent) (struct clk *, struct clk *);
 };
 
-int clk_register(struct clk *clk);
-void clk_unregister(struct clk *clk);
-
 unsigned long mxc_decode_pll(unsigned int pll, u32 f_ref);
 
+/**
+ * clock gate
+ *
+ * @clk		clock source
+ * @reg		register containing the gate
+ * @shift	shift to the gate
+ * @parent	parent clock
+ * @flags	flags
+ *
+ * This clock implements clk_enable/clk_disable. The rate functions are passed
+ * through to the parent.
+ * When CLK_GATE_TWO_BITS is given each gate is two bits wide. Used on i.MX51.
+ */
+struct clk_gate {
+	struct clk	clk;
+	void __iomem	*reg;
+	unsigned	shift;
+	struct clk	*parent;
+	unsigned long	flags;
+};
+
+extern struct clk_ops clk_gate_ops;
+
+#define DEFINE_CLK_GATE_FLAGS(name, _parent, _reg, _shift, _flags) \
+	struct clk_gate name = { \
+		.clk = INIT_CLK(name.clk, clk_gate_ops), \
+		.parent = (_parent), \
+		.reg = (_reg), \
+		.shift = (_shift), \
+		.flags = (_flags), \
+	}
+
+#define CLK_GATE_TWO_BITS	(1 << 0)
+#define CLK_GATE_ENABLE_WAIT	(1 << 1)
+#define CLK_GATE_DISABLE_WAIT	(1 << 2)
+
+#define DEFINE_CLK_GATE(name, _parent, _reg, _shift) \
+	DEFINE_CLK_GATE_FLAGS(name, _parent, _reg, _shift, 0)
+#define DEFINE_CLK_GATE_2(name, _parent, _reg, _shift) \
+	DEFINE_CLK_GATE_FLAGS(name, _parent, _reg, _shift, CLK_GATE_TWO_BITS)
+#define DEFINE_CLK_GATE_ENABLE_WAIT(name, _parent, _reg, _shift) \
+	DEFINE_CLK_GATE_FLAGS(name, _parent, _reg, _shift, CLK_GATE_TWO_BITS | CLK_GATE_ENABLE_WAIT)
+#define DEFINE_CLK_GATE_DISABLE_WAIT(name, _parent, _reg, _shift) \
+	DEFINE_CLK_GATE_FLAGS(name, _parent, _reg, _shift, CLK_GATE_TWO_BITS | CLK_GATE_DISABLE_WAIT)
+
+extern spinlock_t imx_ccm_lock;
+
+#define DEFINE_CLK_DIVIDER(name, _parent, _reg, _shift, _width) \
+	struct clk_divider name = { \
+		.clk = INIT_CLK(name.clk, clk_divider_ops), \
+		.parent = (_parent), \
+		.reg = (_reg), \
+		.shift = (_shift), \
+		.width = (_width), \
+		.lock = &imx_ccm_lock, \
+	}
+
+/**
+ * fixed clock divider
+ *
+ * @clk		clock source
+ * @mult	fixed multiplier value
+ * @div		fixed divider value
+ * @parent	parent clock
+ *
+ * This clock implements a fixed divider with an additional multiplier to
+ * specify fractional values. clk_enable/clk_disable are passed through
+ * to the parent. Note that the divider is applied before the multiplier
+ * to prevent overflows. This may result in a less accurat result.
+ */
+struct clk_divider_fixed {
+	struct clk	clk;
+	unsigned int	mult;
+	unsigned int	div;
+	struct clk	*parent;
+};
+
+#define DEFINE_CLK_DIVIDER_FIXED(name, _parent, _mult, _div) \
+	struct clk_divider name = { \
+		.clk = INIT_CLK(name.clk, clk_divider_ops), \
+		.parent = (_parent), \
+		.mult = (_mult), \
+		.div = (_div), \
+	}
+
+#define DEFINE_CLK_MUX(name, _reg, _shift, _width, _clks) \
+	struct clk_mux name = { \
+		.clk = INIT_CLK(name.clk, clk_mux_ops), \
+		.reg = (_reg), \
+		.shift = (_shift), \
+		.width = (_width), \
+		.clks = (_clks), \
+		.num_clks = ARRAY_SIZE(_clks), \
+		.lock = &imx_ccm_lock, \
+	}
+
+/**
+ * clock group
+ *
+ * @clk		clock source
+ * @num_clks	number of parent clocks to enable
+ * @clks	array of parents to enable/disable
+ *
+ * This clock is a groups of clocks useful for specifying clocks for
+ * drivers which consist of multiple clocks. it enables/disables
+ * all clocks in @clks, clk_get_rate/clk_set_rate are passed through
+ * to the first member of @clks.
+ */
+struct clk_group {
+	struct clk	clk;
+	unsigned char	num_clks;
+	struct clk	**clks;
+};
+
+extern struct clk_ops clk_group_ops;
+
+#define DEFINE_CLK_GROUP(name, _clks) \
+	struct clk_group name = { \
+		.clk = INIT_CLK(name.clk, clk_group_ops), \
+		.clks = (_clks), \
+		.num_clks = ARRAY_SIZE(_clks), \
+	}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_MXC_CLOCK_H__ */
-- 
1.7.4.1
