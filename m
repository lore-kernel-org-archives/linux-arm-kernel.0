From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Dec 2010 11:25:38 +0100
Subject: [RFC] i.MX clock support
Message-ID: <20101213102538.GB6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I played around with Jeremys common struct clk patches and I think they
offer a great potential for cleaning up the i.MX51 (and i.MX in general)
clock support.

Currently on i.MX we have clocks implementing varying sets of the clk
functions and most of the time the functions are reimplemented for
each clock. The i.MX51 clock support shows that this becomes
unmaintainable. The following patch allows for a different approach.
Instead of making each clock a full featured clock we split the clocks
into their basic building blocks. Currently we have:

* multiplexer   Choose from a set of parent clocks (clk_[get|set]_parent)
* divider       clock divider (clk_[get|set|round]_rate)
* gates         clk_[en|dis]able
* groups        Group together clocks which should be enabled at once.

Of course these are the building blocks on other architectures aswell,
so we may move parts of the patch to a more generic place.

I made a experimental implementation for i.MX27 and i.MX51, find the
patches here:

git://git.pengutronix.de/git/imx/linux-2.6.git clk-common-imx

The i.MX27 patches are boot tested, the i.MX51 patches are compile tested
only and probably contain bugs preventing the tree from booting on an
i.MX51.

I am not willing to accept patches for adding i.MX50 support in the mess
we currently have. These patches offer a way to cleanup the clock support
and the i.MX50 may be a good test bed for an implementation without
old cruft to worry about. That said the following patch is not set in
stone, it's a request for comments and I'm of course open to other
suggestions, but it's clear that we have to do something.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/clock-common.c       |  406 ++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/clock.h |  234 ++++++++++++++++++-
 2 files changed, 637 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/clock-common.c b/arch/arm/plat-mxc/clock-common.c
index fbe1873..6f83c17 100644
--- a/arch/arm/plat-mxc/clock-common.c
+++ b/arch/arm/plat-mxc/clock-common.c
@@ -166,6 +166,412 @@ struct clk_ops clk_mxc_ops = {
 	.set_parent	= clk_mxc_set_parent,
 };
 
+static int clk_parent_enable(struct clk *clk)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return -ENOSYS;
+
+	return clk_enable(parent);
+}
+
+static void clk_parent_disable(struct clk *clk)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return;
+
+	clk_disable(parent);
+}
+
+static unsigned long clk_parent_get_rate(struct clk *clk)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return 0;
+
+	return clk_get_rate(parent);
+}
+
+static long clk_parent_round_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return -ENOSYS;
+
+	return clk_round_rate(parent, rate);
+}
+
+static int clk_parent_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return -ENOSYS;
+
+	return clk_set_rate(parent, rate);
+}
+
+/* clk gate support */
+
+#define to_clk_gate(clk) (container_of(clk, struct clk_gate, clk))
+
+static int clk_gate_enable(struct clk *clk)
+{
+	struct clk_gate *gate = to_clk_gate(clk);
+	u32 val, mask;
+
+	if (gate->flags & CLK_GATE_TWO_BITS)
+		mask = 3 << (gate->shift * 2);
+	else
+		mask = 1 << (gate->shift);
+
+	val = readl(gate->reg);
+	val |= mask;
+	writel(val, gate->reg);
+
+	return 0;
+}
+
+static void clk_gate_disable(struct clk *clk)
+{
+	struct clk_gate *gate = to_clk_gate(clk);
+	u32 val, mask;
+
+	if (gate->flags & CLK_GATE_TWO_BITS)
+		mask = 3 << (gate->shift * 2);
+	else
+		mask = 1 << (gate->shift);
+
+	val = readl(gate->reg);
+	val &= ~(mask);
+	writel(val, gate->reg);
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
+	.enable = clk_gate_enable,
+	.disable = clk_gate_disable,
+	.get_rate = clk_parent_get_rate,
+	.round_rate = clk_parent_round_rate,
+	.set_rate = clk_parent_set_rate,
+	.get_parent = clk_gate_get_parent,
+};
+EXPORT_SYMBOL_GPL(clk_gate_ops);
+
+#define to_clk_divider(clk) (container_of(clk, struct clk_divider, clk))
+
+static unsigned long clk_divider_get_rate(struct clk *clk)
+{
+	struct clk_divider *divider = to_clk_divider(clk);
+
+	unsigned long rate = clk_get_rate(divider->parent);
+	unsigned int div = 1;
+
+	if (divider->reg) {
+		div = readl(divider->reg) >> divider->shift;
+		div &= (1 << divider->width) - 1;
+		div++;
+	}
+
+	return rate / div / divider->div * divider->mult;
+}
+
+static long clk_divider_round_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk_divider *divider = to_clk_divider(clk);
+	unsigned long parent_rate = clk_get_rate(divider->parent);
+	unsigned int max_div, div;
+
+	if (rate > parent_rate)
+		return parent_rate;
+
+	max_div = 1 << divider->width;
+
+	div = parent_rate / rate;
+	div = max(div, max_div);
+
+	return parent_rate / div / divider->div * divider->mult;
+}
+
+static int clk_divider_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk_divider *divider = to_clk_divider(clk);
+	unsigned long parent_rate = clk_get_rate(divider->parent);
+	unsigned int max_div, div;
+	u32 val;
+
+	parent_rate /= divider->div;
+	parent_rate *= divider->mult;
+
+	if (rate > parent_rate)
+		rate = parent_rate;
+
+	max_div = 1 << divider->width;
+
+	div = parent_rate / rate;
+
+	div = max(div, max_div);
+	div--;
+
+	val = readl(divider->reg);
+	val &= ~(((1 << divider->width) - 1) << divider->shift);
+	val |= div << divider->shift;
+	writel(val, divider->reg);
+
+	return 0;
+}
+
+static struct clk *clk_divider_get_parent(struct clk *clk)
+{
+	struct clk_divider *divider = to_clk_divider(clk);
+
+	return divider->parent;
+}
+
+struct clk_ops clk_divider_ops = {
+	.enable = clk_parent_enable,
+	.disable = clk_parent_disable,
+	.get_rate = clk_divider_get_rate,
+	.round_rate = clk_divider_round_rate,
+	.set_rate = clk_divider_set_rate,
+	.get_parent = clk_divider_get_parent,
+};
+EXPORT_SYMBOL_GPL(clk_divider_ops);
+
+#define to_clk_multiplexer(clk) (container_of(clk, struct clk_multiplexer, clk))
+
+static struct clk *clk_multiplexer_get_parent(struct clk *clk)
+{
+	struct clk_multiplexer *multiplexer = to_clk_multiplexer(clk);
+	u32 val;
+
+	val = readl(multiplexer->reg) >> multiplexer->shift;
+	val &= (1 << multiplexer->width) - 1;
+
+	if (val >= multiplexer->num_clks)
+		return ERR_PTR(-EINVAL);
+
+	return multiplexer->clks[val];
+}
+
+static int clk_multiplexer_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_multiplexer *multiplexer = to_clk_multiplexer(clk);
+	u32 val;
+	int i;
+
+	for (i = 0; i < multiplexer->num_clks; i++)
+		if (multiplexer->clks[i] == parent)
+			break;
+
+	if (i == multiplexer->num_clks)
+		return -EINVAL;
+
+	val = readl(multiplexer->reg);
+	val &= ((1 << multiplexer->width) - 1) << multiplexer->shift;
+	val |= i << multiplexer->shift;
+	writel(val, multiplexer->reg);
+
+	return 0;
+}
+
+struct clk_ops clk_multiplexer_ops = {
+	.enable = clk_parent_enable,
+	.disable = clk_parent_disable,
+	.get_rate = clk_parent_get_rate,
+	.round_rate = clk_parent_round_rate,
+	.set_rate = clk_parent_set_rate,
+	.get_parent = clk_multiplexer_get_parent,
+	.set_parent = clk_multiplexer_set_parent,
+};
+EXPORT_SYMBOL_GPL(clk_multiplexer_ops);
+
+#define to_clk_group(clk) (container_of(clk, struct clk_group, clk))
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
+	.enable = clk_group_enable,
+	.disable = clk_group_disable,
+	.get_rate = clk_group_get_rate,
+	.round_rate = clk_group_round_rate,
+	.set_rate = clk_group_set_rate,
+};
+
+#define to_clk_divider_pre_post(clk) (container_of(clk, struct clk_divider_pre_post, clk))
+
+static unsigned long clk_divider_pre_post_get_rate(struct clk *clk)
+{
+	struct clk_divider_pre_post *divider = to_clk_divider_pre_post(clk);
+	struct clk *parent = divider->parent;
+	unsigned long parent_rate = clk_get_rate(parent);
+	unsigned int div1, div2;
+
+	div1 = ((readl(divider->reg1) >> divider->shift1) & divider->width1) + 1;
+	div2 = ((readl(divider->reg2) >> divider->shift2) & divider->width2) + 1;
+
+	return parent_rate / (div1 + 1) / (div2 + 1);
+}
+
+/* calculate best pre and post dividers to get the required divider */
+static void calc_two_dividers(u32 div, unsigned int *div1, unsigned int *div2,
+	unsigned int max_pre, unsigned int max_post)
+{
+	if (div >= max_pre * max_post) {
+		*div1 = max_pre;
+		*div2 = max_post;
+	} else if (div >= max_pre) {
+		u32 min_pre, temp_pre, old_err, err;
+		min_pre = DIV_ROUND_UP(div, max_post);
+		old_err = max_pre;
+		for (temp_pre = max_pre; temp_pre >= min_pre; temp_pre--) {
+			err = div % temp_pre;
+			if (err == 0) {
+				*div1 = temp_pre;
+				break;
+			}
+			err = temp_pre - err;
+			if (err < old_err) {
+				old_err = err;
+				*div1 = temp_pre;
+			}
+		}
+		*div2 = DIV_ROUND_UP(div, *div1);
+	} else {
+		*div1 = div;
+		*div2 = 1;
+	}
+}
+
+static long clk_divider_pre_post_round_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk_divider_pre_post *divider = to_clk_divider_pre_post(clk);
+	struct clk *parent = divider->parent;
+	unsigned long parent_rate = clk_get_rate(parent);
+	unsigned int div, div1, div2;
+
+	div = parent_rate / rate;
+
+	calc_two_dividers(div, &div1, &div2, 1 << divider->width1,
+			1 << divider->width2);
+
+	return parent_rate / (div1 + 1) / (div2 + 1);
+}
+
+static int clk_divider_pre_post_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk_divider_pre_post *divider = to_clk_divider_pre_post(clk);
+	struct clk *parent = divider->parent;
+	unsigned long parent_rate = clk_get_rate(parent);
+	unsigned int div, div1, div2;
+	u32 val;
+
+	div = parent_rate / rate;
+
+	calc_two_dividers(div, &div1, &div2, 1 << divider->width1,
+			1 << divider->width2);
+
+	val = readl(divider->reg1);
+	val &= ~(((1 << divider->width1) - 1 ) << divider->shift1);
+	val &= ~(((1 << divider->width2) - 1 ) << divider->shift2);
+	val |= div1 << divider->shift1;
+	val |= div2 << divider->shift2;
+	writel(val, divider->reg1);
+
+	return 0;
+}
+
+struct clk_ops clk_divider_pre_post_ops = {
+	.enable = clk_parent_enable,
+	.disable = clk_parent_disable,
+	.get_rate = clk_divider_pre_post_get_rate,
+	.round_rate = clk_divider_pre_post_round_rate,
+	.set_rate = clk_divider_pre_post_set_rate,
+};
+
+#define to_clk_parent(clk) (container_of(clk, struct clk_parent, clk))
+
+static struct clk *clk_parent_get_parent(struct clk *clk)
+{
+	struct clk_parent *parent = to_clk_parent(clk);
+
+	return parent->parent;
+}
+
+static int clk_parent_set_parent(struct clk *clk, struct clk *parentclk)
+{
+	struct clk_parent *parent = to_clk_parent(clk);
+
+	return clk_set_parent(parent->parent, parentclk);
+}
+
+struct clk_ops clk_parent_ops = {
+	.enable = clk_parent_enable,
+	.disable = clk_parent_disable,
+	.get_rate = clk_parent_get_rate,
+	.round_rate = clk_parent_round_rate,
+	.set_rate = clk_parent_set_rate,
+	.get_parent = clk_parent_get_parent,
+	.set_parent = clk_parent_set_parent,
+};
+
 /*
  * Get the resulting clock rate from a PLL register value and the input
  * frequency. PLLs with this register layout can at least be found on
diff --git a/arch/arm/plat-mxc/include/mach/clock.h b/arch/arm/plat-mxc/include/mach/clock.h
index 9331dbb..b432727 100644
--- a/arch/arm/plat-mxc/include/mach/clock.h
+++ b/arch/arm/plat-mxc/include/mach/clock.h
@@ -62,12 +62,240 @@ struct clk_mxc {
 	int (*set_parent) (struct clk_mxc *, struct clk *);
 };
 
-int clk_register(struct clk *clk);
-void clk_unregister(struct clk *clk);
-
 unsigned long mxc_decode_pll(unsigned int pll, u32 f_ref);
 
 extern struct clk_ops clk_mxc_ops;
 
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
+
+#define DEFINE_CLK_GATE(name, _parent, _reg, _shift) \
+	DEFINE_CLK_GATE_FLAGS(name, _parent, _reg, _shift, 0)
+#define DEFINE_CLK_GATE_2(name, _parent, _reg, _shift) \
+	DEFINE_CLK_GATE_FLAGS(name, _parent, _reg, _shift, CLK_GATE_TWO_BITS)
+
+/**
+ * clock divider
+ *
+ * @clk		clock source
+ * @reg		register containing the divider
+ * @shift	shift to the divider
+ * @width	width of the divider
+ * @parent	parent clock
+ *
+ * This clock implements get_rate/set_rate/round_rate. clk_enable/clk_disable
+ * are passed through to the parent.
+ *
+ * The divider is calculated as div = reg_val + 1
+ */
+struct clk_divider {
+	struct clk	clk;
+	void __iomem	*reg;
+	unsigned char	shift;
+	unsigned char	width;
+	unsigned int	mult;
+	unsigned int	div;
+	struct clk	*parent;
+};
+
+extern struct clk_ops clk_divider_ops;
+
+#define DEFINE_CLK_DIVIDER(name, _parent, _reg, _shift, _width) \
+	struct clk_divider name = { \
+		.clk = INIT_CLK(name.clk, clk_divider_ops), \
+		.parent = (_parent), \
+		.reg = (_reg), \
+		.shift = (_shift), \
+		.width = (_width), \
+		.mult = 1, \
+		.div = 1, \
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
+/**
+ * Two cascaded dividers
+ *
+ * @clk		clock source
+ * @reg1	register containing the first divider
+ * @reg2	register containing the second divider
+ * @shift1	shift to the first divider
+ * @shift2	shift to the second divider
+ * @width1	width of the first divider
+ * @width2	width of the second divider
+ * @parent	parent clock
+ *
+ * This clock implements get_rate/set_rate/round_rate. clk_enable/clk_disable
+ * are passed through to the parent.
+ *
+ * The resulting divider is calculated as div = (reg_val1 + 1) * (reg_val2 + 1)
+ */
+struct clk_divider_pre_post {
+	struct clk	clk;
+	void __iomem	*reg1, *reg2;
+	unsigned char	shift1, shift2;
+	unsigned char	width1, width2;
+	struct clk	*parent;
+};
+
+extern struct clk_ops clk_divider_pre_post_ops;
+
+#define DEFINE_CLK_DIVIDER_PRE_POST(name, _parent, _reg1, _shift1, _width1, _reg2, _shift2, _width2) \
+	struct clk_divider_pre_post name = { \
+		.clk = INIT_CLK(name.clk, clk_divider_pre_post_ops), \
+		.parent = (_parent), \
+		.reg1 = (_reg2), \
+		.shift1 = (_shift2), \
+		.width1 = (_width2), \
+		.reg2 = (_reg2), \
+		.shift2 = (_shift2), \
+		.width2 = (_width2), \
+	}
+
+/**
+ * clock multiplexer
+ *
+ * @clk		clock source
+ * @reg		the register this multiplexer can be configured with
+ * @shift	the shift to the start bit of this multiplexer
+ * @width	the width in bits of this multiplexer
+ * @num_clks	number of parent clocks
+ * @clks	array of possible parents for this multiplexer. Can contain
+ *		holes with NULL in it for invalid register settings
+ *
+ * This clock implements get_parent/set_parent. All other clock
+ * operations are passed through to the parent.
+ */
+struct clk_multiplexer {
+	struct clk	clk;
+	void __iomem	*reg;
+	unsigned char	shift;
+	unsigned char	width;
+	unsigned char	num_clks;
+	struct clk	**clks;
+};
+
+extern struct clk_ops clk_multiplexer_ops;
+
+#define DEFINE_CLK_MULTIPLEXER(name, _reg, _shift, _width, _clks) \
+	struct clk_multiplexer name = { \
+		.clk = INIT_CLK(name.clk, clk_multiplexer_ops), \
+		.reg = (_reg), \
+		.shift = (_shift), \
+		.width = (_width), \
+		.clks = (_clks), \
+		.num_clks = ARRAY_SIZE(_clks), \
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
+#define DEFINE_CLK_FIXED(name, rate) \
+	struct clk_fixed name = INIT_CLK_FIXED(name, rate)
+
+/**
+ * clock parent
+ *
+ * @clk		clock source
+ * @parent	the parent clock
+ *
+ * This clocks passes all operations to the parent clock. It is
+ * useful as a placeholder for static initialization of a clock
+ * tree.
+ */
+struct clk_parent {
+	struct clk	clk;
+	struct clk	*parent;
+};
+
+extern struct clk_ops clk_parent_ops;
+
+#define DEFINE_CLK_PARENT(name, _parent) \
+	struct clk_parent name = { \
+		.clk = INIT_CLK(name.clk, clk_parent_ops), \
+		.parent = (_parent), \
+	}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_MXC_CLOCK_H__ */
-- 
1.7.2.3


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
