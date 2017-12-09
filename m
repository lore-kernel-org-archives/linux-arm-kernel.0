From: david@lechnology.com (David Lechner)
Date: Fri,  8 Dec 2017 20:15:10 -0600
Subject: [PATCH v3 4/5] ARM: davinci: convert to common clock framework
In-Reply-To: <1512785711-15064-1-git-send-email-david@lechnology.com>
References: <1512785711-15064-1-git-send-email-david@lechnology.com>
Message-ID: <1512785711-15064-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the clocks in mach-davinci to the common clock framework.

Most of the patch just involves renaming struct clk to struct davinci_clk.
There is also a struct clk_hw added to provide the bridge between the
existing clock implementation and the common clock framework.

The clk_get_parent and clk_set_parent callbacks are dropped because all
clocks currently (effectivly) have a single parent, in which case the
common clock framework does not want you to implement these functions
yourself.

clk_unregister() is dropped because it is not used anywhere in
mach-davinci.

EXPORT_SYMBOL() is removed from functions not used outside of mach-davinci.

Fixed checkpatch.pl warning about bare use of unsigned in dump_clock().

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/Kconfig                           |   2 +-
 arch/arm/mach-davinci/clock.c              | 162 ++++++++++++-----------------
 arch/arm/mach-davinci/clock.h              |  40 ++++---
 arch/arm/mach-davinci/da830.c              | 100 +++++++++---------
 arch/arm/mach-davinci/da850.c              | 153 +++++++++++++--------------
 arch/arm/mach-davinci/devices-da8xx.c      |   6 +-
 arch/arm/mach-davinci/dm355.c              |  84 +++++++--------
 arch/arm/mach-davinci/dm365.c              | 112 ++++++++++----------
 arch/arm/mach-davinci/dm644x.c             |  72 ++++++-------
 arch/arm/mach-davinci/dm646x.c             |  78 +++++++-------
 arch/arm/mach-davinci/include/mach/clock.h |   3 -
 arch/arm/mach-davinci/usb-da8xx.c          |  48 +++++----
 12 files changed, 425 insertions(+), 435 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 51c8df5..3a12f9e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -604,7 +604,7 @@ config ARCH_S3C24XX
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select CLKDEV_LOOKUP
+	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index c149b24..0e63d93 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -31,7 +31,7 @@ static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 static DEFINE_SPINLOCK(clockfw_lock);
 
-void davinci_clk_enable(struct clk *clk)
+void davinci_clk_enable(struct davinci_clk *clk)
 {
 	if (clk->parent)
 		davinci_clk_enable(clk->parent);
@@ -44,7 +44,7 @@ void davinci_clk_enable(struct clk *clk)
 	}
 }
 
-void davinci_clk_disable(struct clk *clk)
+void davinci_clk_disable(struct davinci_clk *clk)
 {
 	if (WARN_ON(clk->usecount == 0))
 		return;
@@ -59,7 +59,7 @@ void davinci_clk_disable(struct clk *clk)
 		davinci_clk_disable(clk->parent);
 }
 
-static int davinci_clk_reset(struct clk *clk, bool reset)
+static int davinci_clk_reset(struct davinci_clk *clk, bool reset)
 {
 	unsigned long flags;
 
@@ -76,24 +76,29 @@ static int davinci_clk_reset(struct clk *clk, bool reset)
 
 int davinci_clk_reset_assert(struct clk *clk)
 {
-	if (clk == NULL || IS_ERR(clk) || !clk->reset)
+	struct davinci_clk *dclk = to_davinci_clk(__clk_get_hw(clk));
+
+	if (IS_ERR_OR_NULL(dclk) || !dclk->reset)
 		return -EINVAL;
 
-	return clk->reset(clk, true);
+	return dclk->reset(dclk, true);
 }
 EXPORT_SYMBOL(davinci_clk_reset_assert);
 
 int davinci_clk_reset_deassert(struct clk *clk)
 {
-	if (clk == NULL || IS_ERR(clk) || !clk->reset)
+	struct davinci_clk *dclk = to_davinci_clk(__clk_get_hw(clk));
+
+	if (IS_ERR_OR_NULL(dclk) || !dclk->reset)
 		return -EINVAL;
 
-	return clk->reset(clk, false);
+	return dclk->reset(dclk, false);
 }
 EXPORT_SYMBOL(davinci_clk_reset_deassert);
 
-int clk_enable(struct clk *clk)
+static int _clk_enable(struct clk_hw *hw)
 {
+	struct davinci_clk *clk = to_davinci_clk(hw);
 	unsigned long flags;
 
 	if (!clk)
@@ -107,10 +112,10 @@ int clk_enable(struct clk *clk)
 
 	return 0;
 }
-EXPORT_SYMBOL(clk_enable);
 
-void clk_disable(struct clk *clk)
+static void _clk_disable(struct clk_hw *hw)
 {
+	struct davinci_clk *clk = to_davinci_clk(hw);
 	unsigned long flags;
 
 	if (clk == NULL || IS_ERR(clk))
@@ -120,19 +125,26 @@ void clk_disable(struct clk *clk)
 	davinci_clk_disable(clk);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
-EXPORT_SYMBOL(clk_disable);
 
-unsigned long clk_get_rate(struct clk *clk)
+static unsigned long _clk_recalc_rate(struct clk_hw *hw,
+				      unsigned long parent_rate)
 {
+	struct davinci_clk *clk = to_davinci_clk(hw);
+
 	if (clk == NULL || IS_ERR(clk))
 		return 0;
 
+	if (clk->recalc)
+		return clk->recalc(clk);
+
 	return clk->rate;
 }
-EXPORT_SYMBOL(clk_get_rate);
 
-long clk_round_rate(struct clk *clk, unsigned long rate)
+static long _clk_round_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long *parent_rate)
 {
+	struct davinci_clk *clk = to_davinci_clk(hw);
+
 	if (clk == NULL || IS_ERR(clk))
 		return 0;
 
@@ -141,12 +153,11 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 
 	return clk->rate;
 }
-EXPORT_SYMBOL(clk_round_rate);
 
 /* Propagate rate to children */
-static void propagate_rate(struct clk *root)
+static void propagate_rate(struct davinci_clk *root)
 {
-	struct clk *clk;
+	struct davinci_clk *clk;
 
 	list_for_each_entry(clk, &root->children, childnode) {
 		if (clk->recalc)
@@ -155,8 +166,10 @@ static void propagate_rate(struct clk *root)
 	}
 }
 
-int clk_set_rate(struct clk *clk, unsigned long rate)
+static int _clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
 {
+	struct davinci_clk *clk = to_davinci_clk(hw);
 	unsigned long flags;
 	int ret = -EINVAL;
 
@@ -178,56 +191,20 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 
 	return ret;
 }
-EXPORT_SYMBOL(clk_set_rate);
-
-int clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	unsigned long flags;
-
-	if (!clk)
-		return 0;
-	else if (IS_ERR(clk))
-		return -EINVAL;
-
-	/* Cannot change parent on enabled clock */
-	if (WARN_ON(clk->usecount))
-		return -EINVAL;
-
-	mutex_lock(&clocks_mutex);
-	if (clk->set_parent) {
-		int ret = clk->set_parent(clk, parent);
-
-		if (ret) {
-			mutex_unlock(&clocks_mutex);
-			return ret;
-		}
-	}
-	clk->parent = parent;
-	list_del_init(&clk->childnode);
-	list_add(&clk->childnode, &clk->parent->children);
-	mutex_unlock(&clocks_mutex);
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (clk->recalc)
-		clk->rate = clk->recalc(clk);
-	propagate_rate(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
 
-	return 0;
-}
-EXPORT_SYMBOL(clk_set_parent);
+static const struct clk_ops davinci_clk_ops = {
+	.enable		= _clk_enable,
+	.disable	= _clk_disable,
+	.recalc_rate	= _clk_recalc_rate,
+	.round_rate	= _clk_round_rate,
+	.set_rate	= _clk_set_rate,
+};
 
-struct clk *clk_get_parent(struct clk *clk)
+int davinci_clk_register(struct davinci_clk *clk)
 {
-	if (!clk)
-		return NULL;
-
-	return clk->parent;
-}
-EXPORT_SYMBOL(clk_get_parent);
+	struct clk_init_data init = {};
+	int ret;
 
-int clk_register(struct clk *clk)
-{
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
 
@@ -242,7 +219,7 @@ int clk_register(struct clk *clk)
 	list_add_tail(&clk->node, &clocks);
 	if (clk->parent) {
 		if (clk->set_parent) {
-			int ret = clk->set_parent(clk, clk->parent);
+			ret = clk->set_parent(clk, clk->parent);
 
 			if (ret) {
 				mutex_unlock(&clocks_mutex);
@@ -253,6 +230,18 @@ int clk_register(struct clk *clk)
 	}
 	mutex_unlock(&clocks_mutex);
 
+	init.name = clk->name;
+	init.ops = &davinci_clk_ops;
+	if (clk->parent) {
+		init.parent_names = &clk->parent->name;
+		init.num_parents = 1;
+	}
+	clk->hw.init = &init;
+
+	ret = clk_hw_register(NULL, &clk->hw);
+	if (WARN(ret, "Failed to register clock '%s'\n", clk->name))
+		return ret;
+
 	/* If rate is already set, use it */
 	if (clk->rate)
 		return 0;
@@ -267,19 +256,6 @@ int clk_register(struct clk *clk)
 
 	return 0;
 }
-EXPORT_SYMBOL(clk_register);
-
-void clk_unregister(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return;
-
-	mutex_lock(&clocks_mutex);
-	list_del(&clk->node);
-	list_del(&clk->childnode);
-	mutex_unlock(&clocks_mutex);
-}
-EXPORT_SYMBOL(clk_unregister);
 
 #ifdef CONFIG_DAVINCI_RESET_CLOCKS
 /*
@@ -287,7 +263,7 @@ EXPORT_SYMBOL(clk_unregister);
  */
 int __init davinci_clk_disable_unused(void)
 {
-	struct clk *ck;
+	struct davinci_clk *ck;
 
 	spin_lock_irq(&clockfw_lock);
 	list_for_each_entry(ck, &clocks, node) {
@@ -311,7 +287,7 @@ int __init davinci_clk_disable_unused(void)
 }
 #endif
 
-static unsigned long clk_sysclk_recalc(struct clk *clk)
+static unsigned long clk_sysclk_recalc(struct davinci_clk *clk)
 {
 	u32 v, plldiv;
 	struct pll_data *pll;
@@ -349,7 +325,7 @@ static unsigned long clk_sysclk_recalc(struct clk *clk)
 	return rate;
 }
 
-int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate)
+int davinci_set_sysclk_rate(struct davinci_clk *clk, unsigned long rate)
 {
 	unsigned v;
 	struct pll_data *pll;
@@ -420,9 +396,8 @@ int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate)
 
 	return 0;
 }
-EXPORT_SYMBOL(davinci_set_sysclk_rate);
 
-static unsigned long clk_leafclk_recalc(struct clk *clk)
+static unsigned long clk_leafclk_recalc(struct davinci_clk *clk)
 {
 	if (WARN_ON(!clk->parent))
 		return clk->rate;
@@ -430,13 +405,13 @@ static unsigned long clk_leafclk_recalc(struct clk *clk)
 	return clk->parent->rate;
 }
 
-int davinci_simple_set_rate(struct clk *clk, unsigned long rate)
+int davinci_simple_set_rate(struct davinci_clk *clk, unsigned long rate)
 {
 	clk->rate = rate;
 	return 0;
 }
 
-static unsigned long clk_pllclk_recalc(struct clk *clk)
+static unsigned long clk_pllclk_recalc(struct davinci_clk *clk)
 {
 	u32 ctrl, mult = 1, prediv = 1, postdiv = 1;
 	u8 bypass;
@@ -572,7 +547,6 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 
 	return 0;
 }
-EXPORT_SYMBOL(davinci_set_pllrate);
 
 /**
  * davinci_set_refclk_rate() - Set the reference clock rate
@@ -606,7 +580,7 @@ int davinci_set_refclk_rate(unsigned long rate)
 	return 0;
 }
 
-void __init davinci_clk_init(struct clk *clk, const char *con_id,
+void __init davinci_clk_init(struct davinci_clk *clk, const char *con_id,
 			     const char *dev_id)
 {
 	if (!clk->recalc) {
@@ -645,12 +619,12 @@ void __init davinci_clk_init(struct clk *clk, const char *con_id,
 	if (clk->flags & PSC_LRST)
 		clk->reset = davinci_clk_reset;
 
-	clk_register(clk);
-	clk_register_clkdev(clk, con_id, dev_id);
+	davinci_clk_register(clk);
+	clk_register_clkdev(clk->hw.clk, con_id, dev_id);
 
 	/* Turn on clocks that Linux doesn't otherwise manage */
 	if (clk->flags & ALWAYS_ENABLED)
-		clk_enable(clk);
+		clk_prepare_enable(clk->hw.clk);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -663,11 +637,11 @@ void __init davinci_clk_init(struct clk *clk, const char *con_id,
 #define NEST_MAX	4
 
 static void
-dump_clock(struct seq_file *s, unsigned nest, struct clk *parent)
+dump_clock(struct seq_file *s, unsigned int nest, struct davinci_clk *parent)
 {
 	char		*state;
 	char		buf[CLKNAME_MAX + NEST_DELTA * NEST_MAX];
-	struct clk	*clk;
+	struct davinci_clk *clk;
 	unsigned	i;
 
 	if (parent->flags & CLK_PLL)
@@ -685,7 +659,7 @@ dump_clock(struct seq_file *s, unsigned nest, struct clk *parent)
 			min(i, (unsigned)(sizeof(buf) - 1 - nest)));
 
 	seq_printf(s, "%s users=%2d %-3s %9ld Hz\n",
-		   buf, parent->usecount, state, clk_get_rate(parent));
+		   buf, parent->usecount, state, parent->rate);
 	/* REVISIT show device associations too */
 
 	/* cost is now small, but not linear... */
@@ -696,7 +670,7 @@ dump_clock(struct seq_file *s, unsigned nest, struct clk *parent)
 
 static int davinci_ck_show(struct seq_file *m, void *v)
 {
-	struct clk *clk;
+	struct davinci_clk *clk;
 
 	/*
 	 * Show clock tree; We trust nonzero usecounts equate to PSC enables...
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index bf60cdf..aea4f14 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -68,6 +68,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/list.h>
+#include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 
 #define PLLSTAT_GOSTAT	BIT(0)
@@ -84,7 +85,8 @@ struct pll_data {
 #define PLL_HAS_PREDIV          0x01
 #define PLL_HAS_POSTDIV         0x02
 
-struct clk {
+struct davinci_clk {
+	struct clk_hw		hw;
 	struct list_head	node;
 	struct module		*owner;
 	const char		*name;
@@ -95,18 +97,18 @@ struct clk {
 	u8			gpsc;
 	u8			domain;
 	u32			flags;
-	struct clk              *parent;
+	struct davinci_clk	*parent;
 	struct list_head	children; 	/* list of children */
 	struct list_head	childnode;	/* parent's child list node */
 	struct pll_data         *pll_data;
 	u32                     div_reg;
-	unsigned long (*recalc) (struct clk *);
-	int (*set_rate) (struct clk *clk, unsigned long rate);
-	int (*round_rate) (struct clk *clk, unsigned long rate);
-	int (*reset) (struct clk *clk, bool reset);
-	void (*clk_enable) (struct clk *clk);
-	void (*clk_disable) (struct clk *clk);
-	int (*set_parent) (struct clk *clk, struct clk *parent);
+	unsigned long (*recalc)(struct davinci_clk *clk);
+	int (*set_rate)(struct davinci_clk *clk, unsigned long rate);
+	int (*round_rate)(struct davinci_clk *clk, unsigned long rate);
+	int (*reset)(struct davinci_clk *clk, bool reset);
+	void (*clk_enable)(struct davinci_clk *clk);
+	void (*clk_disable)(struct davinci_clk *clk);
+	int (*set_parent)(struct davinci_clk *clk, struct davinci_clk *parent);
 };
 
 /* Clock flags: SoC-specific flags start at BIT(16) */
@@ -118,18 +120,28 @@ struct clk {
 #define PSC_FORCE		BIT(6) /* Force module state transtition */
 #define PSC_LRST		BIT(8) /* Use local reset on enable/disable */
 
-void davinci_clk_init(struct clk *clk, const char *con_id, const char *dev_id);
+void davinci_clk_init(struct davinci_clk *clk, const char *con_id,
+		      const char *dev_id);
 int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 				unsigned int mult, unsigned int postdiv);
-int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate);
+int davinci_set_sysclk_rate(struct davinci_clk *clk, unsigned long rate);
 int davinci_set_refclk_rate(unsigned long rate);
-int davinci_simple_set_rate(struct clk *clk, unsigned long rate);
-void davinci_clk_enable(struct clk *clk);
-void davinci_clk_disable(struct clk *clk);
+int davinci_simple_set_rate(struct davinci_clk *clk, unsigned long rate);
+void davinci_clk_enable(struct davinci_clk *clk);
+void davinci_clk_disable(struct davinci_clk *clk);
+int davinci_clk_register(struct davinci_clk *clk);
 
 extern struct platform_device davinci_wdt_device;
 extern void davinci_watchdog_reset(struct platform_device *);
 
+static inline struct davinci_clk *to_davinci_clk(struct clk_hw *hw)
+{
+	if (IS_ERR_OR_NULL(hw))
+		return (struct davinci_clk *)hw;
+
+	return container_of(hw, struct davinci_clk, hw);
+}
+
 #endif
 
 #endif
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 1a99d22..7f276a5 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -43,322 +43,322 @@ static struct pll_data pll0_data = {
 	.flags		= PLL_HAS_PREDIV | PLL_HAS_POSTDIV,
 };
 
-static struct clk ref_clk = {
+static struct davinci_clk ref_clk = {
 	.name		= "ref_clk",
 	.rate		= DA830_REF_FREQ,
 };
 
-static struct clk pll0_clk = {
+static struct davinci_clk pll0_clk = {
 	.name		= "pll0",
 	.parent		= &ref_clk,
 	.pll_data	= &pll0_data,
 	.flags		= CLK_PLL,
 };
 
-static struct clk pll0_aux_clk = {
+static struct davinci_clk pll0_aux_clk = {
 	.name		= "pll0_aux_clk",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL | PRE_PLL,
 };
 
-static struct clk pll0_sysclk2 = {
+static struct davinci_clk pll0_sysclk2 = {
 	.name		= "pll0_sysclk2",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV2,
 };
 
-static struct clk pll0_sysclk3 = {
+static struct davinci_clk pll0_sysclk3 = {
 	.name		= "pll0_sysclk3",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV3,
 };
 
-static struct clk pll0_sysclk4 = {
+static struct davinci_clk pll0_sysclk4 = {
 	.name		= "pll0_sysclk4",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV4,
 };
 
-static struct clk pll0_sysclk5 = {
+static struct davinci_clk pll0_sysclk5 = {
 	.name		= "pll0_sysclk5",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV5,
 };
 
-static struct clk pll0_sysclk6 = {
+static struct davinci_clk pll0_sysclk6 = {
 	.name		= "pll0_sysclk6",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV6,
 };
 
-static struct clk pll0_sysclk7 = {
+static struct davinci_clk pll0_sysclk7 = {
 	.name		= "pll0_sysclk7",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV7,
 };
 
-static struct clk i2c0_clk = {
+static struct davinci_clk i2c0_clk = {
 	.name		= "i2c0",
 	.parent		= &pll0_aux_clk,
 };
 
-static struct clk timerp64_0_clk = {
+static struct davinci_clk timerp64_0_clk = {
 	.name		= "timer0",
 	.parent		= &pll0_aux_clk,
 };
 
-static struct clk timerp64_1_clk = {
+static struct davinci_clk timerp64_1_clk = {
 	.name		= "timer1",
 	.parent		= &pll0_aux_clk,
 };
 
-static struct clk arm_rom_clk = {
+static struct davinci_clk arm_rom_clk = {
 	.name		= "arm_rom",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_ARM_RAM_ROM,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk scr0_ss_clk = {
+static struct davinci_clk scr0_ss_clk = {
 	.name		= "scr0_ss",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_SCR0_SS,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk scr1_ss_clk = {
+static struct davinci_clk scr1_ss_clk = {
 	.name		= "scr1_ss",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_SCR1_SS,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk scr2_ss_clk = {
+static struct davinci_clk scr2_ss_clk = {
 	.name		= "scr2_ss",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_SCR2_SS,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk dmax_clk = {
+static struct davinci_clk dmax_clk = {
 	.name		= "dmax",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_PRUSS,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk tpcc_clk = {
+static struct davinci_clk tpcc_clk = {
 	.name		= "tpcc",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_TPCC,
 	.flags		= ALWAYS_ENABLED | CLK_PSC,
 };
 
-static struct clk tptc0_clk = {
+static struct davinci_clk tptc0_clk = {
 	.name		= "tptc0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_TPTC0,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk tptc1_clk = {
+static struct davinci_clk tptc1_clk = {
 	.name		= "tptc1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_TPTC1,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk mmcsd_clk = {
+static struct davinci_clk mmcsd_clk = {
 	.name		= "mmcsd",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_MMC_SD,
 };
 
-static struct clk uart0_clk = {
+static struct davinci_clk uart0_clk = {
 	.name		= "uart0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_UART0,
 };
 
-static struct clk uart1_clk = {
+static struct davinci_clk uart1_clk = {
 	.name		= "uart1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_UART1,
 	.gpsc		= 1,
 };
 
-static struct clk uart2_clk = {
+static struct davinci_clk uart2_clk = {
 	.name		= "uart2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_UART2,
 	.gpsc		= 1,
 };
 
-static struct clk spi0_clk = {
+static struct davinci_clk spi0_clk = {
 	.name		= "spi0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_SPI0,
 };
 
-static struct clk spi1_clk = {
+static struct davinci_clk spi1_clk = {
 	.name		= "spi1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_SPI1,
 	.gpsc		= 1,
 };
 
-static struct clk ecap0_clk = {
+static struct davinci_clk ecap0_clk = {
 	.name		= "ecap0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_ECAP,
 	.gpsc		= 1,
 };
 
-static struct clk ecap1_clk = {
+static struct davinci_clk ecap1_clk = {
 	.name		= "ecap1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_ECAP,
 	.gpsc		= 1,
 };
 
-static struct clk ecap2_clk = {
+static struct davinci_clk ecap2_clk = {
 	.name		= "ecap2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_ECAP,
 	.gpsc		= 1,
 };
 
-static struct clk pwm0_clk = {
+static struct davinci_clk pwm0_clk = {
 	.name		= "pwm0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_PWM,
 	.gpsc		= 1,
 };
 
-static struct clk pwm1_clk = {
+static struct davinci_clk pwm1_clk = {
 	.name		= "pwm1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_PWM,
 	.gpsc		= 1,
 };
 
-static struct clk pwm2_clk = {
+static struct davinci_clk pwm2_clk = {
 	.name		= "pwm2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_PWM,
 	.gpsc		= 1,
 };
 
-static struct clk eqep0_clk = {
+static struct davinci_clk eqep0_clk = {
 	.name		= "eqep0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA830_LPSC1_EQEP,
 	.gpsc		= 1,
 };
 
-static struct clk eqep1_clk = {
+static struct davinci_clk eqep1_clk = {
 	.name		= "eqep1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA830_LPSC1_EQEP,
 	.gpsc		= 1,
 };
 
-static struct clk lcdc_clk = {
+static struct davinci_clk lcdc_clk = {
 	.name		= "lcdc",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_LCDC,
 	.gpsc		= 1,
 };
 
-static struct clk mcasp0_clk = {
+static struct davinci_clk mcasp0_clk = {
 	.name		= "mcasp0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_McASP0,
 	.gpsc		= 1,
 };
 
-static struct clk mcasp1_clk = {
+static struct davinci_clk mcasp1_clk = {
 	.name		= "mcasp1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA830_LPSC1_McASP1,
 	.gpsc		= 1,
 };
 
-static struct clk mcasp2_clk = {
+static struct davinci_clk mcasp2_clk = {
 	.name		= "mcasp2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA830_LPSC1_McASP2,
 	.gpsc		= 1,
 };
 
-static struct clk usb20_clk = {
+static struct davinci_clk usb20_clk = {
 	.name		= "usb20",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_USB20,
 	.gpsc		= 1,
 };
 
-static struct clk cppi41_clk = {
+static struct davinci_clk cppi41_clk = {
 	.name		= "cppi41",
 	.parent		= &usb20_clk,
 };
 
-static struct clk aemif_clk = {
+static struct davinci_clk aemif_clk = {
 	.name		= "aemif",
 	.parent		= &pll0_sysclk3,
 	.lpsc		= DA8XX_LPSC0_EMIF25,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk aintc_clk = {
+static struct davinci_clk aintc_clk = {
 	.name		= "aintc",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC0_AINTC,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk secu_mgr_clk = {
+static struct davinci_clk secu_mgr_clk = {
 	.name		= "secu_mgr",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC0_SECU_MGR,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk emac_clk = {
+static struct davinci_clk emac_clk = {
 	.name		= "emac",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_CPGMAC,
 	.gpsc		= 1,
 };
 
-static struct clk gpio_clk = {
+static struct davinci_clk gpio_clk = {
 	.name		= "gpio",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_GPIO,
 	.gpsc		= 1,
 };
 
-static struct clk i2c1_clk = {
+static struct davinci_clk i2c1_clk = {
 	.name		= "i2c1",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_I2C,
 	.gpsc		= 1,
 };
 
-static struct clk usb11_clk = {
+static struct davinci_clk usb11_clk = {
 	.name		= "usb11",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_USB11,
 	.gpsc		= 1,
 };
 
-static struct clk emif3_clk = {
+static struct davinci_clk emif3_clk = {
 	.name		= "emif3",
 	.parent		= &pll0_sysclk5,
 	.lpsc		= DA8XX_LPSC1_EMIF3C,
@@ -366,14 +366,14 @@ static struct clk emif3_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk arm_clk = {
+static struct davinci_clk arm_clk = {
 	.name		= "arm",
 	.parent		= &pll0_sysclk6,
 	.lpsc		= DA8XX_LPSC0_ARM,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk rmii_clk = {
+static struct davinci_clk rmii_clk = {
 	.name		= "rmii",
 	.parent		= &pll0_sysclk7,
 };
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index ab287d4..8a29aef 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -44,9 +44,9 @@
 #define CFGCHIP3_PLL1_MASTER_LOCK	BIT(5)
 #define CFGCHIP0_PLL_MASTER_LOCK	BIT(4)
 
-static int da850_set_armrate(struct clk *clk, unsigned long rate);
-static int da850_round_armrate(struct clk *clk, unsigned long rate);
-static int da850_set_pll0rate(struct clk *clk, unsigned long armrate);
+static int da850_set_armrate(struct davinci_clk *clk, unsigned long rate);
+static int da850_round_armrate(struct davinci_clk *clk, unsigned long rate);
+static int da850_set_pll0rate(struct davinci_clk *clk, unsigned long armrate);
 
 static struct pll_data pll0_data = {
 	.num		= 1,
@@ -54,13 +54,13 @@ static struct pll_data pll0_data = {
 	.flags		= PLL_HAS_PREDIV | PLL_HAS_POSTDIV,
 };
 
-static struct clk ref_clk = {
+static struct davinci_clk ref_clk = {
 	.name		= "ref_clk",
 	.rate		= DA850_REF_FREQ,
 	.set_rate	= davinci_simple_set_rate,
 };
 
-static struct clk pll0_clk = {
+static struct davinci_clk pll0_clk = {
 	.name		= "pll0",
 	.parent		= &ref_clk,
 	.pll_data	= &pll0_data,
@@ -68,27 +68,27 @@ static struct clk pll0_clk = {
 	.set_rate	= da850_set_pll0rate,
 };
 
-static struct clk pll0_aux_clk = {
+static struct davinci_clk pll0_aux_clk = {
 	.name		= "pll0_aux_clk",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL | PRE_PLL,
 };
 
-static struct clk pll0_sysclk1 = {
+static struct davinci_clk pll0_sysclk1 = {
 	.name		= "pll0_sysclk1",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV1,
 };
 
-static struct clk pll0_sysclk2 = {
+static struct davinci_clk pll0_sysclk2 = {
 	.name		= "pll0_sysclk2",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV2,
 };
 
-static struct clk pll0_sysclk3 = {
+static struct davinci_clk pll0_sysclk3 = {
 	.name		= "pll0_sysclk3",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
@@ -97,28 +97,28 @@ static struct clk pll0_sysclk3 = {
 	.maxrate	= 100000000,
 };
 
-static struct clk pll0_sysclk4 = {
+static struct davinci_clk pll0_sysclk4 = {
 	.name		= "pll0_sysclk4",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV4,
 };
 
-static struct clk pll0_sysclk5 = {
+static struct davinci_clk pll0_sysclk5 = {
 	.name		= "pll0_sysclk5",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV5,
 };
 
-static struct clk pll0_sysclk6 = {
+static struct davinci_clk pll0_sysclk6 = {
 	.name		= "pll0_sysclk6",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV6,
 };
 
-static struct clk pll0_sysclk7 = {
+static struct davinci_clk pll0_sysclk7 = {
 	.name		= "pll0_sysclk7",
 	.parent		= &pll0_clk,
 	.flags		= CLK_PLL,
@@ -131,34 +131,35 @@ static struct pll_data pll1_data = {
 	.flags		= PLL_HAS_POSTDIV,
 };
 
-static struct clk pll1_clk = {
+static struct davinci_clk pll1_clk = {
 	.name		= "pll1",
 	.parent		= &ref_clk,
 	.pll_data	= &pll1_data,
 	.flags		= CLK_PLL,
 };
 
-static struct clk pll1_aux_clk = {
+static struct davinci_clk pll1_aux_clk = {
 	.name		= "pll1_aux_clk",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL | PRE_PLL,
 };
 
-static struct clk pll1_sysclk2 = {
+static struct davinci_clk pll1_sysclk2 = {
 	.name		= "pll1_sysclk2",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV2,
 };
 
-static struct clk pll1_sysclk3 = {
+static struct davinci_clk pll1_sysclk3 = {
 	.name		= "pll1_sysclk3",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV3,
 };
 
-static int da850_async3_set_parent(struct clk *clk, struct clk *parent)
+static int da850_async3_set_parent(struct davinci_clk *clk,
+				   struct davinci_clk *parent)
 {
 	u32 val;
 
@@ -178,56 +179,56 @@ static int da850_async3_set_parent(struct clk *clk, struct clk *parent)
 	return 0;
 }
 
-static struct clk async3_clk = {
+static struct davinci_clk async3_clk = {
 	.name		= "async3",
 	.parent		= &pll1_sysclk2,
 	.set_parent	= da850_async3_set_parent,
 };
 
-static struct clk i2c0_clk = {
+static struct davinci_clk i2c0_clk = {
 	.name		= "i2c0",
 	.parent		= &pll0_aux_clk,
 };
 
-static struct clk timerp64_0_clk = {
+static struct davinci_clk timerp64_0_clk = {
 	.name		= "timer0",
 	.parent		= &pll0_aux_clk,
 };
 
-static struct clk timerp64_1_clk = {
+static struct davinci_clk timerp64_1_clk = {
 	.name		= "timer1",
 	.parent		= &pll0_aux_clk,
 };
 
-static struct clk arm_rom_clk = {
+static struct davinci_clk arm_rom_clk = {
 	.name		= "arm_rom",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_ARM_RAM_ROM,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk tpcc0_clk = {
+static struct davinci_clk tpcc0_clk = {
 	.name		= "tpcc0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_TPCC,
 	.flags		= ALWAYS_ENABLED | CLK_PSC,
 };
 
-static struct clk tptc0_clk = {
+static struct davinci_clk tptc0_clk = {
 	.name		= "tptc0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_TPTC0,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk tptc1_clk = {
+static struct davinci_clk tptc1_clk = {
 	.name		= "tptc1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_TPTC1,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk tpcc1_clk = {
+static struct davinci_clk tpcc1_clk = {
 	.name		= "tpcc1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA850_LPSC1_TPCC1,
@@ -235,7 +236,7 @@ static struct clk tpcc1_clk = {
 	.flags		= CLK_PSC | ALWAYS_ENABLED,
 };
 
-static struct clk tptc2_clk = {
+static struct davinci_clk tptc2_clk = {
 	.name		= "tptc2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA850_LPSC1_TPTC2,
@@ -243,54 +244,54 @@ static struct clk tptc2_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk pruss_clk = {
+static struct davinci_clk pruss_clk = {
 	.name		= "pruss",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_PRUSS,
 };
 
-static struct clk uart0_clk = {
+static struct davinci_clk uart0_clk = {
 	.name		= "uart0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_UART0,
 };
 
-static struct clk uart1_clk = {
+static struct davinci_clk uart1_clk = {
 	.name		= "uart1",
 	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_UART1,
 	.gpsc		= 1,
 };
 
-static struct clk uart2_clk = {
+static struct davinci_clk uart2_clk = {
 	.name		= "uart2",
 	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_UART2,
 	.gpsc		= 1,
 };
 
-static struct clk aintc_clk = {
+static struct davinci_clk aintc_clk = {
 	.name		= "aintc",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC0_AINTC,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk gpio_clk = {
+static struct davinci_clk gpio_clk = {
 	.name		= "gpio",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_GPIO,
 	.gpsc		= 1,
 };
 
-static struct clk i2c1_clk = {
+static struct davinci_clk i2c1_clk = {
 	.name		= "i2c1",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_I2C,
 	.gpsc		= 1,
 };
 
-static struct clk emif3_clk = {
+static struct davinci_clk emif3_clk = {
 	.name		= "emif3",
 	.parent		= &pll0_sysclk5,
 	.lpsc		= DA8XX_LPSC1_EMIF3C,
@@ -298,7 +299,7 @@ static struct clk emif3_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk arm_clk = {
+static struct davinci_clk arm_clk = {
 	.name		= "arm",
 	.parent		= &pll0_sysclk6,
 	.lpsc		= DA8XX_LPSC0_ARM,
@@ -307,12 +308,12 @@ static struct clk arm_clk = {
 	.round_rate	= da850_round_armrate,
 };
 
-static struct clk rmii_clk = {
+static struct davinci_clk rmii_clk = {
 	.name		= "rmii",
 	.parent		= &pll0_sysclk7,
 };
 
-static struct clk emac_clk = {
+static struct davinci_clk emac_clk = {
 	.name		= "emac",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_CPGMAC,
@@ -324,53 +325,53 @@ static struct clk emac_clk = {
  * screwing up the linked list in the process) create a separate clock for
  * mdio inheriting the rate from emac_clk.
  */
-static struct clk mdio_clk = {
+static struct davinci_clk mdio_clk = {
 	.name		= "mdio",
 	.parent		= &emac_clk,
 };
 
-static struct clk mcasp_clk = {
+static struct davinci_clk mcasp_clk = {
 	.name		= "mcasp",
 	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_McASP0,
 	.gpsc		= 1,
 };
 
-static struct clk mcbsp0_clk = {
+static struct davinci_clk mcbsp0_clk = {
 	.name		= "mcbsp0",
 	.parent		= &async3_clk,
 	.lpsc		= DA850_LPSC1_McBSP0,
 	.gpsc		= 1,
 };
 
-static struct clk mcbsp1_clk = {
+static struct davinci_clk mcbsp1_clk = {
 	.name		= "mcbsp1",
 	.parent		= &async3_clk,
 	.lpsc		= DA850_LPSC1_McBSP1,
 	.gpsc		= 1,
 };
 
-static struct clk lcdc_clk = {
+static struct davinci_clk lcdc_clk = {
 	.name		= "lcdc",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_LCDC,
 	.gpsc		= 1,
 };
 
-static struct clk mmcsd0_clk = {
+static struct davinci_clk mmcsd0_clk = {
 	.name		= "mmcsd0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_MMC_SD,
 };
 
-static struct clk mmcsd1_clk = {
+static struct davinci_clk mmcsd1_clk = {
 	.name		= "mmcsd1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA850_LPSC1_MMC_SD1,
 	.gpsc		= 1,
 };
 
-static struct clk aemif_clk = {
+static struct davinci_clk aemif_clk = {
 	.name		= "aemif",
 	.parent		= &pll0_sysclk3,
 	.lpsc		= DA8XX_LPSC0_EMIF25,
@@ -382,51 +383,51 @@ static struct clk aemif_clk = {
  * screwing up the linked list in the process) create a separate clock for
  * nand inheriting the rate from aemif_clk.
  */
-static struct clk aemif_nand_clk = {
+static struct davinci_clk aemif_nand_clk = {
 	.name		= "nand",
 	.parent		= &aemif_clk,
 };
 
-static struct clk usb11_clk = {
+static struct davinci_clk usb11_clk = {
 	.name		= "usb11",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_USB11,
 	.gpsc		= 1,
 };
 
-static struct clk usb20_clk = {
+static struct davinci_clk usb20_clk = {
 	.name		= "usb20",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_USB20,
 	.gpsc		= 1,
 };
 
-static struct clk cppi41_clk = {
+static struct davinci_clk cppi41_clk = {
 	.name		= "cppi41",
 	.parent		= &usb20_clk,
 };
 
-static struct clk spi0_clk = {
+static struct davinci_clk spi0_clk = {
 	.name		= "spi0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC0_SPI0,
 };
 
-static struct clk spi1_clk = {
+static struct davinci_clk spi1_clk = {
 	.name		= "spi1",
 	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_SPI1,
 	.gpsc		= 1,
 };
 
-static struct clk vpif_clk = {
+static struct davinci_clk vpif_clk = {
 	.name		= "vpif",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA850_LPSC1_VPIF,
 	.gpsc		= 1,
 };
 
-static struct clk sata_clk = {
+static struct davinci_clk sata_clk = {
 	.name		= "sata",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA850_LPSC1_SATA,
@@ -434,7 +435,7 @@ static struct clk sata_clk = {
 	.flags		= PSC_FORCE,
 };
 
-static struct clk dsp_clk = {
+static struct davinci_clk dsp_clk = {
 	.name		= "dsp",
 	.parent		= &pll0_sysclk1,
 	.domain		= DAVINCI_GPSC_DSPDOMAIN,
@@ -442,26 +443,26 @@ static struct clk dsp_clk = {
 	.flags		= PSC_LRST | PSC_FORCE,
 };
 
-static struct clk ehrpwm_clk = {
+static struct davinci_clk ehrpwm_clk = {
 	.name		= "ehrpwm",
 	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_PWM,
 	.gpsc		= 1,
 };
 
-static struct clk ehrpwm0_clk = {
+static struct davinci_clk ehrpwm0_clk = {
 	.name		= "ehrpwm0",
 	.parent		= &ehrpwm_clk,
 };
 
-static struct clk ehrpwm1_clk = {
+static struct davinci_clk ehrpwm1_clk = {
 	.name		= "ehrpwm1",
 	.parent		= &ehrpwm_clk,
 };
 
 #define DA8XX_EHRPWM_TBCLKSYNC	BIT(12)
 
-static void ehrpwm_tblck_enable(struct clk *clk)
+static void ehrpwm_tblck_enable(struct davinci_clk *clk)
 {
 	u32 val;
 
@@ -470,7 +471,7 @@ static void ehrpwm_tblck_enable(struct clk *clk)
 	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP1_REG));
 }
 
-static void ehrpwm_tblck_disable(struct clk *clk)
+static void ehrpwm_tblck_disable(struct davinci_clk *clk)
 {
 	u32 val;
 
@@ -479,41 +480,41 @@ static void ehrpwm_tblck_disable(struct clk *clk)
 	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP1_REG));
 }
 
-static struct clk ehrpwm_tbclk = {
+static struct davinci_clk ehrpwm_tbclk = {
 	.name		= "ehrpwm_tbclk",
 	.parent		= &ehrpwm_clk,
 	.clk_enable	= ehrpwm_tblck_enable,
 	.clk_disable	= ehrpwm_tblck_disable,
 };
 
-static struct clk ehrpwm0_tbclk = {
+static struct davinci_clk ehrpwm0_tbclk = {
 	.name		= "ehrpwm0_tbclk",
 	.parent		= &ehrpwm_tbclk,
 };
 
-static struct clk ehrpwm1_tbclk = {
+static struct davinci_clk ehrpwm1_tbclk = {
 	.name		= "ehrpwm1_tbclk",
 	.parent		= &ehrpwm_tbclk,
 };
 
-static struct clk ecap_clk = {
+static struct davinci_clk ecap_clk = {
 	.name		= "ecap",
 	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_ECAP,
 	.gpsc		= 1,
 };
 
-static struct clk ecap0_clk = {
+static struct davinci_clk ecap0_clk = {
 	.name		= "ecap0_clk",
 	.parent		= &ecap_clk,
 };
 
-static struct clk ecap1_clk = {
+static struct davinci_clk ecap1_clk = {
 	.name		= "ecap1_clk",
 	.parent		= &ecap_clk,
 };
 
-static struct clk ecap2_clk = {
+static struct davinci_clk ecap2_clk = {
 	.name		= "ecap2_clk",
 	.parent		= &ecap_clk,
 };
@@ -1170,7 +1171,7 @@ int da850_register_cpufreq(char *async_clk)
 	return platform_device_register(&da850_cpufreq_device);
 }
 
-static int da850_round_armrate(struct clk *clk, unsigned long rate)
+static int da850_round_armrate(struct davinci_clk *clk, unsigned long rate)
 {
 	int ret = 0, diff;
 	unsigned int best = (unsigned int) -1;
@@ -1193,14 +1194,14 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 	return ret * 1000;
 }
 
-static int da850_set_armrate(struct clk *clk, unsigned long index)
+static int da850_set_armrate(struct davinci_clk *clk, unsigned long index)
 {
-	struct clk *pllclk = &pll0_clk;
+	struct davinci_clk *pllclk = &pll0_clk;
 
-	return clk_set_rate(pllclk, index);
+	return clk_set_rate(pllclk->hw.clk, index);
 }
 
-static int da850_set_pll0rate(struct clk *clk, unsigned long rate)
+static int da850_set_pll0rate(struct davinci_clk *clk, unsigned long rate)
 {
 	struct pll_data *pll = clk->pll_data;
 	struct cpufreq_frequency_table *freq;
@@ -1238,17 +1239,17 @@ int __init da850_register_cpufreq(char *async_clk)
 	return 0;
 }
 
-static int da850_set_armrate(struct clk *clk, unsigned long rate)
+static int da850_set_armrate(struct davinci_clk *clk, unsigned long rate)
 {
 	return -EINVAL;
 }
 
-static int da850_set_pll0rate(struct clk *clk, unsigned long armrate)
+static int da850_set_pll0rate(struct davinci_clk *clk, unsigned long armrate)
 {
 	return -EINVAL;
 }
 
-static int da850_round_armrate(struct clk *clk, unsigned long rate)
+static int da850_round_armrate(struct davinci_clk *clk, unsigned long rate)
 {
 	return clk->rate;
 }
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index cc497f4..8d6deee 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1054,7 +1054,7 @@ int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
 }
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
-static struct clk sata_refclk = {
+static struct davinci_clk sata_refclk = {
 	.name		= "sata_refclk",
 	.set_rate	= davinci_simple_set_rate,
 };
@@ -1064,11 +1064,11 @@ int __init da850_register_sata_refclk(int rate)
 	int ret;
 
 	sata_refclk.rate = rate;
-	ret = clk_register(&sata_refclk);
+	ret = davinci_clk_register(&sata_refclk);
 	if (ret)
 		return ret;
 
-	clk_register_clkdev(&sata_refclk, "refclk", "ahci_da850");
+	clk_register_clkdev(sata_refclk.hw.clk, "refclk", "ahci_da850");
 
 	return 0;
 }
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 5d8a986..90d0e65 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -55,118 +55,118 @@ static struct pll_data pll2_data = {
 	.flags     = PLL_HAS_PREDIV,
 };
 
-static struct clk ref_clk = {
+static struct davinci_clk ref_clk = {
 	.name = "ref_clk",
 	/* FIXME -- crystal rate is board-specific */
 	.rate = DM355_REF_FREQ,
 };
 
-static struct clk pll1_clk = {
+static struct davinci_clk pll1_clk = {
 	.name = "pll1",
 	.parent = &ref_clk,
 	.flags = CLK_PLL,
 	.pll_data = &pll1_data,
 };
 
-static struct clk pll1_aux_clk = {
+static struct davinci_clk pll1_aux_clk = {
 	.name = "pll1_aux_clk",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL | PRE_PLL,
 };
 
-static struct clk pll1_sysclk1 = {
+static struct davinci_clk pll1_sysclk1 = {
 	.name = "pll1_sysclk1",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV1,
 };
 
-static struct clk pll1_sysclk2 = {
+static struct davinci_clk pll1_sysclk2 = {
 	.name = "pll1_sysclk2",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV2,
 };
 
-static struct clk pll1_sysclk3 = {
+static struct davinci_clk pll1_sysclk3 = {
 	.name = "pll1_sysclk3",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV3,
 };
 
-static struct clk pll1_sysclk4 = {
+static struct davinci_clk pll1_sysclk4 = {
 	.name = "pll1_sysclk4",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV4,
 };
 
-static struct clk pll1_sysclkbp = {
+static struct davinci_clk pll1_sysclkbp = {
 	.name = "pll1_sysclkbp",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL | PRE_PLL,
 	.div_reg = BPDIV
 };
 
-static struct clk vpss_dac_clk = {
+static struct davinci_clk vpss_dac_clk = {
 	.name = "vpss_dac",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM355_LPSC_VPSS_DAC,
 };
 
-static struct clk vpss_master_clk = {
+static struct davinci_clk vpss_master_clk = {
 	.name = "vpss_master",
 	.parent = &pll1_sysclk4,
 	.lpsc = DAVINCI_LPSC_VPSSMSTR,
 	.flags = CLK_PSC,
 };
 
-static struct clk vpss_slave_clk = {
+static struct davinci_clk vpss_slave_clk = {
 	.name = "vpss_slave",
 	.parent = &pll1_sysclk4,
 	.lpsc = DAVINCI_LPSC_VPSSSLV,
 };
 
-static struct clk clkout1_clk = {
+static struct davinci_clk clkout1_clk = {
 	.name = "clkout1",
 	.parent = &pll1_aux_clk,
 	/* NOTE:  clkout1 can be externally gated by muxing GPIO-18 */
 };
 
-static struct clk clkout2_clk = {
+static struct davinci_clk clkout2_clk = {
 	.name = "clkout2",
 	.parent = &pll1_sysclkbp,
 };
 
-static struct clk pll2_clk = {
+static struct davinci_clk pll2_clk = {
 	.name = "pll2",
 	.parent = &ref_clk,
 	.flags = CLK_PLL,
 	.pll_data = &pll2_data,
 };
 
-static struct clk pll2_sysclk1 = {
+static struct davinci_clk pll2_sysclk1 = {
 	.name = "pll2_sysclk1",
 	.parent = &pll2_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV1,
 };
 
-static struct clk pll2_sysclkbp = {
+static struct davinci_clk pll2_sysclkbp = {
 	.name = "pll2_sysclkbp",
 	.parent = &pll2_clk,
 	.flags = CLK_PLL | PRE_PLL,
 	.div_reg = BPDIV
 };
 
-static struct clk clkout3_clk = {
+static struct davinci_clk clkout3_clk = {
 	.name = "clkout3",
 	.parent = &pll2_sysclkbp,
 	/* NOTE:  clkout3 can be externally gated by muxing GPIO-16 */
 };
 
-static struct clk arm_clk = {
+static struct davinci_clk arm_clk = {
 	.name = "arm_clk",
 	.parent = &pll1_sysclk1,
 	.lpsc = DAVINCI_LPSC_ARM,
@@ -192,146 +192,146 @@ static struct clk arm_clk = {
  *	.lpsc = DAVINCI_LPSC_CFG5,	// "test"
  */
 
-static struct clk mjcp_clk = {
+static struct davinci_clk mjcp_clk = {
 	.name = "mjcp",
 	.parent = &pll1_sysclk1,
 	.lpsc = DAVINCI_LPSC_IMCOP,
 };
 
-static struct clk uart0_clk = {
+static struct davinci_clk uart0_clk = {
 	.name = "uart0",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_UART0,
 };
 
-static struct clk uart1_clk = {
+static struct davinci_clk uart1_clk = {
 	.name = "uart1",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_UART1,
 };
 
-static struct clk uart2_clk = {
+static struct davinci_clk uart2_clk = {
 	.name = "uart2",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_UART2,
 };
 
-static struct clk i2c_clk = {
+static struct davinci_clk i2c_clk = {
 	.name = "i2c",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_I2C,
 };
 
-static struct clk asp0_clk = {
+static struct davinci_clk asp0_clk = {
 	.name = "asp0",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_McBSP,
 };
 
-static struct clk asp1_clk = {
+static struct davinci_clk asp1_clk = {
 	.name = "asp1",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM355_LPSC_McBSP1,
 };
 
-static struct clk mmcsd0_clk = {
+static struct davinci_clk mmcsd0_clk = {
 	.name = "mmcsd0",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_MMC_SD,
 };
 
-static struct clk mmcsd1_clk = {
+static struct davinci_clk mmcsd1_clk = {
 	.name = "mmcsd1",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM355_LPSC_MMC_SD1,
 };
 
-static struct clk spi0_clk = {
+static struct davinci_clk spi0_clk = {
 	.name = "spi0",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_SPI,
 };
 
-static struct clk spi1_clk = {
+static struct davinci_clk spi1_clk = {
 	.name = "spi1",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM355_LPSC_SPI1,
 };
 
-static struct clk spi2_clk = {
+static struct davinci_clk spi2_clk = {
 	.name = "spi2",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM355_LPSC_SPI2,
 };
 
-static struct clk gpio_clk = {
+static struct davinci_clk gpio_clk = {
 	.name = "gpio",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_GPIO,
 };
 
-static struct clk aemif_clk = {
+static struct davinci_clk aemif_clk = {
 	.name = "aemif",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_AEMIF,
 };
 
-static struct clk pwm0_clk = {
+static struct davinci_clk pwm0_clk = {
 	.name = "pwm0",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_PWM0,
 };
 
-static struct clk pwm1_clk = {
+static struct davinci_clk pwm1_clk = {
 	.name = "pwm1",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_PWM1,
 };
 
-static struct clk pwm2_clk = {
+static struct davinci_clk pwm2_clk = {
 	.name = "pwm2",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_PWM2,
 };
 
-static struct clk pwm3_clk = {
+static struct davinci_clk pwm3_clk = {
 	.name = "pwm3",
 	.parent = &pll1_aux_clk,
 	.lpsc = DM355_LPSC_PWM3,
 };
 
-static struct clk timer0_clk = {
+static struct davinci_clk timer0_clk = {
 	.name = "timer0",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_TIMER0,
 };
 
-static struct clk timer1_clk = {
+static struct davinci_clk timer1_clk = {
 	.name = "timer1",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_TIMER1,
 };
 
-static struct clk timer2_clk = {
+static struct davinci_clk timer2_clk = {
 	.name = "timer2",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_TIMER2,
 	.usecount = 1,              /* REVISIT: why can't this be disabled? */
 };
 
-static struct clk timer3_clk = {
+static struct davinci_clk timer3_clk = {
 	.name = "timer3",
 	.parent = &pll1_aux_clk,
 	.lpsc = DM355_LPSC_TIMER3,
 };
 
-static struct clk rto_clk = {
+static struct davinci_clk rto_clk = {
 	.name = "rto",
 	.parent = &pll1_aux_clk,
 	.lpsc = DM355_LPSC_RTO,
 };
 
-static struct clk usb_clk = {
+static struct davinci_clk usb_clk = {
 	.name = "usb",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_USB,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 74037a6..49b46b5 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -66,360 +66,360 @@ static struct pll_data pll2_data = {
 	.flags		= PLL_HAS_POSTDIV | PLL_HAS_PREDIV,
 };
 
-static struct clk ref_clk = {
+static struct davinci_clk ref_clk = {
 	.name		= "ref_clk",
 	.rate		= DM365_REF_FREQ,
 };
 
-static struct clk pll1_clk = {
+static struct davinci_clk pll1_clk = {
 	.name		= "pll1",
 	.parent		= &ref_clk,
 	.flags		= CLK_PLL,
 	.pll_data	= &pll1_data,
 };
 
-static struct clk pll1_aux_clk = {
+static struct davinci_clk pll1_aux_clk = {
 	.name		= "pll1_aux_clk",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL | PRE_PLL,
 };
 
-static struct clk pll1_sysclkbp = {
+static struct davinci_clk pll1_sysclkbp = {
 	.name		= "pll1_sysclkbp",
 	.parent		= &pll1_clk,
 	.flags 		= CLK_PLL | PRE_PLL,
 	.div_reg	= BPDIV
 };
 
-static struct clk clkout0_clk = {
+static struct davinci_clk clkout0_clk = {
 	.name		= "clkout0",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL | PRE_PLL,
 };
 
-static struct clk pll1_sysclk1 = {
+static struct davinci_clk pll1_sysclk1 = {
 	.name		= "pll1_sysclk1",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV1,
 };
 
-static struct clk pll1_sysclk2 = {
+static struct davinci_clk pll1_sysclk2 = {
 	.name		= "pll1_sysclk2",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV2,
 };
 
-static struct clk pll1_sysclk3 = {
+static struct davinci_clk pll1_sysclk3 = {
 	.name		= "pll1_sysclk3",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV3,
 };
 
-static struct clk pll1_sysclk4 = {
+static struct davinci_clk pll1_sysclk4 = {
 	.name		= "pll1_sysclk4",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV4,
 };
 
-static struct clk pll1_sysclk5 = {
+static struct davinci_clk pll1_sysclk5 = {
 	.name		= "pll1_sysclk5",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV5,
 };
 
-static struct clk pll1_sysclk6 = {
+static struct davinci_clk pll1_sysclk6 = {
 	.name		= "pll1_sysclk6",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV6,
 };
 
-static struct clk pll1_sysclk7 = {
+static struct davinci_clk pll1_sysclk7 = {
 	.name		= "pll1_sysclk7",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV7,
 };
 
-static struct clk pll1_sysclk8 = {
+static struct davinci_clk pll1_sysclk8 = {
 	.name		= "pll1_sysclk8",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV8,
 };
 
-static struct clk pll1_sysclk9 = {
+static struct davinci_clk pll1_sysclk9 = {
 	.name		= "pll1_sysclk9",
 	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV9,
 };
 
-static struct clk pll2_clk = {
+static struct davinci_clk pll2_clk = {
 	.name		= "pll2",
 	.parent		= &ref_clk,
 	.flags		= CLK_PLL,
 	.pll_data	= &pll2_data,
 };
 
-static struct clk pll2_aux_clk = {
+static struct davinci_clk pll2_aux_clk = {
 	.name		= "pll2_aux_clk",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL | PRE_PLL,
 };
 
-static struct clk clkout1_clk = {
+static struct davinci_clk clkout1_clk = {
 	.name		= "clkout1",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL | PRE_PLL,
 };
 
-static struct clk pll2_sysclk1 = {
+static struct davinci_clk pll2_sysclk1 = {
 	.name		= "pll2_sysclk1",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV1,
 };
 
-static struct clk pll2_sysclk2 = {
+static struct davinci_clk pll2_sysclk2 = {
 	.name		= "pll2_sysclk2",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV2,
 };
 
-static struct clk pll2_sysclk3 = {
+static struct davinci_clk pll2_sysclk3 = {
 	.name		= "pll2_sysclk3",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV3,
 };
 
-static struct clk pll2_sysclk4 = {
+static struct davinci_clk pll2_sysclk4 = {
 	.name		= "pll2_sysclk4",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV4,
 };
 
-static struct clk pll2_sysclk5 = {
+static struct davinci_clk pll2_sysclk5 = {
 	.name		= "pll2_sysclk5",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV5,
 };
 
-static struct clk pll2_sysclk6 = {
+static struct davinci_clk pll2_sysclk6 = {
 	.name		= "pll2_sysclk6",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV6,
 };
 
-static struct clk pll2_sysclk7 = {
+static struct davinci_clk pll2_sysclk7 = {
 	.name		= "pll2_sysclk7",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV7,
 };
 
-static struct clk pll2_sysclk8 = {
+static struct davinci_clk pll2_sysclk8 = {
 	.name		= "pll2_sysclk8",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV8,
 };
 
-static struct clk pll2_sysclk9 = {
+static struct davinci_clk pll2_sysclk9 = {
 	.name		= "pll2_sysclk9",
 	.parent		= &pll2_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV9,
 };
 
-static struct clk vpss_dac_clk = {
+static struct davinci_clk vpss_dac_clk = {
 	.name		= "vpss_dac",
 	.parent		= &pll1_sysclk3,
 	.lpsc		= DM365_LPSC_DAC_CLK,
 };
 
-static struct clk vpss_master_clk = {
+static struct davinci_clk vpss_master_clk = {
 	.name		= "vpss_master",
 	.parent		= &pll1_sysclk5,
 	.lpsc		= DM365_LPSC_VPSSMSTR,
 	.flags		= CLK_PSC,
 };
 
-static struct clk vpss_slave_clk = {
+static struct davinci_clk vpss_slave_clk = {
 	.name		= "vpss_slave",
 	.parent		= &pll1_sysclk5,
 	.lpsc		= DAVINCI_LPSC_VPSSSLV,
 };
 
-static struct clk arm_clk = {
+static struct davinci_clk arm_clk = {
 	.name		= "arm_clk",
 	.parent		= &pll2_sysclk2,
 	.lpsc		= DAVINCI_LPSC_ARM,
 	.flags		= ALWAYS_ENABLED,
 };
 
-static struct clk uart0_clk = {
+static struct davinci_clk uart0_clk = {
 	.name		= "uart0",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_UART0,
 };
 
-static struct clk uart1_clk = {
+static struct davinci_clk uart1_clk = {
 	.name		= "uart1",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DAVINCI_LPSC_UART1,
 };
 
-static struct clk i2c_clk = {
+static struct davinci_clk i2c_clk = {
 	.name		= "i2c",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_I2C,
 };
 
-static struct clk mmcsd0_clk = {
+static struct davinci_clk mmcsd0_clk = {
 	.name		= "mmcsd0",
 	.parent		= &pll1_sysclk8,
 	.lpsc		= DAVINCI_LPSC_MMC_SD,
 };
 
-static struct clk mmcsd1_clk = {
+static struct davinci_clk mmcsd1_clk = {
 	.name		= "mmcsd1",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DM365_LPSC_MMC_SD1,
 };
 
-static struct clk spi0_clk = {
+static struct davinci_clk spi0_clk = {
 	.name		= "spi0",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DAVINCI_LPSC_SPI,
 };
 
-static struct clk spi1_clk = {
+static struct davinci_clk spi1_clk = {
 	.name		= "spi1",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DM365_LPSC_SPI1,
 };
 
-static struct clk spi2_clk = {
+static struct davinci_clk spi2_clk = {
 	.name		= "spi2",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DM365_LPSC_SPI2,
 };
 
-static struct clk spi3_clk = {
+static struct davinci_clk spi3_clk = {
 	.name		= "spi3",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DM365_LPSC_SPI3,
 };
 
-static struct clk spi4_clk = {
+static struct davinci_clk spi4_clk = {
 	.name		= "spi4",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DM365_LPSC_SPI4,
 };
 
-static struct clk gpio_clk = {
+static struct davinci_clk gpio_clk = {
 	.name		= "gpio",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DAVINCI_LPSC_GPIO,
 };
 
-static struct clk aemif_clk = {
+static struct davinci_clk aemif_clk = {
 	.name		= "aemif",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DAVINCI_LPSC_AEMIF,
 };
 
-static struct clk pwm0_clk = {
+static struct davinci_clk pwm0_clk = {
 	.name		= "pwm0",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_PWM0,
 };
 
-static struct clk pwm1_clk = {
+static struct davinci_clk pwm1_clk = {
 	.name		= "pwm1",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_PWM1,
 };
 
-static struct clk pwm2_clk = {
+static struct davinci_clk pwm2_clk = {
 	.name		= "pwm2",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_PWM2,
 };
 
-static struct clk pwm3_clk = {
+static struct davinci_clk pwm3_clk = {
 	.name		= "pwm3",
 	.parent		= &ref_clk,
 	.lpsc		= DM365_LPSC_PWM3,
 };
 
-static struct clk timer0_clk = {
+static struct davinci_clk timer0_clk = {
 	.name		= "timer0",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_TIMER0,
 };
 
-static struct clk timer1_clk = {
+static struct davinci_clk timer1_clk = {
 	.name		= "timer1",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_TIMER1,
 };
 
-static struct clk timer2_clk = {
+static struct davinci_clk timer2_clk = {
 	.name		= "timer2",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_TIMER2,
 	.usecount	= 1,
 };
 
-static struct clk timer3_clk = {
+static struct davinci_clk timer3_clk = {
 	.name		= "timer3",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DM365_LPSC_TIMER3,
 };
 
-static struct clk usb_clk = {
+static struct davinci_clk usb_clk = {
 	.name		= "usb",
 	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_USB,
 };
 
-static struct clk emac_clk = {
+static struct davinci_clk emac_clk = {
 	.name		= "emac",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DM365_LPSC_EMAC,
 };
 
-static struct clk voicecodec_clk = {
+static struct davinci_clk voicecodec_clk = {
 	.name		= "voice_codec",
 	.parent		= &pll2_sysclk4,
 	.lpsc		= DM365_LPSC_VOICE_CODEC,
 };
 
-static struct clk asp0_clk = {
+static struct davinci_clk asp0_clk = {
 	.name		= "asp0",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DM365_LPSC_McBSP1,
 };
 
-static struct clk rto_clk = {
+static struct davinci_clk rto_clk = {
 	.name		= "rto",
 	.parent		= &pll1_sysclk4,
 	.lpsc		= DM365_LPSC_RTO,
 };
 
-static struct clk mjcp_clk = {
+static struct davinci_clk mjcp_clk = {
 	.name		= "mjcp",
 	.parent		= &pll1_sysclk3,
 	.lpsc		= DM365_LPSC_MJCP,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 1b27849..af2f767 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -53,88 +53,88 @@ static struct pll_data pll2_data = {
 	.phys_base = DAVINCI_PLL2_BASE,
 };
 
-static struct clk ref_clk = {
+static struct davinci_clk ref_clk = {
 	.name = "ref_clk",
 	.rate = DM644X_REF_FREQ,
 };
 
-static struct clk pll1_clk = {
+static struct davinci_clk pll1_clk = {
 	.name = "pll1",
 	.parent = &ref_clk,
 	.pll_data = &pll1_data,
 	.flags = CLK_PLL,
 };
 
-static struct clk pll1_sysclk1 = {
+static struct davinci_clk pll1_sysclk1 = {
 	.name = "pll1_sysclk1",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV1,
 };
 
-static struct clk pll1_sysclk2 = {
+static struct davinci_clk pll1_sysclk2 = {
 	.name = "pll1_sysclk2",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV2,
 };
 
-static struct clk pll1_sysclk3 = {
+static struct davinci_clk pll1_sysclk3 = {
 	.name = "pll1_sysclk3",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV3,
 };
 
-static struct clk pll1_sysclk5 = {
+static struct davinci_clk pll1_sysclk5 = {
 	.name = "pll1_sysclk5",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV5,
 };
 
-static struct clk pll1_aux_clk = {
+static struct davinci_clk pll1_aux_clk = {
 	.name = "pll1_aux_clk",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL | PRE_PLL,
 };
 
-static struct clk pll1_sysclkbp = {
+static struct davinci_clk pll1_sysclkbp = {
 	.name = "pll1_sysclkbp",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL | PRE_PLL,
 	.div_reg = BPDIV
 };
 
-static struct clk pll2_clk = {
+static struct davinci_clk pll2_clk = {
 	.name = "pll2",
 	.parent = &ref_clk,
 	.pll_data = &pll2_data,
 	.flags = CLK_PLL,
 };
 
-static struct clk pll2_sysclk1 = {
+static struct davinci_clk pll2_sysclk1 = {
 	.name = "pll2_sysclk1",
 	.parent = &pll2_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV1,
 };
 
-static struct clk pll2_sysclk2 = {
+static struct davinci_clk pll2_sysclk2 = {
 	.name = "pll2_sysclk2",
 	.parent = &pll2_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV2,
 };
 
-static struct clk pll2_sysclkbp = {
+static struct davinci_clk pll2_sysclkbp = {
 	.name = "pll2_sysclkbp",
 	.parent = &pll2_clk,
 	.flags = CLK_PLL | PRE_PLL,
 	.div_reg = BPDIV
 };
 
-static struct clk dsp_clk = {
+static struct davinci_clk dsp_clk = {
 	.name = "dsp",
 	.parent = &pll1_sysclk1,
 	.lpsc = DAVINCI_LPSC_GEM,
@@ -142,14 +142,14 @@ static struct clk dsp_clk = {
 	.usecount = 1,			/* REVISIT how to disable? */
 };
 
-static struct clk arm_clk = {
+static struct davinci_clk arm_clk = {
 	.name = "arm",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_ARM,
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk vicp_clk = {
+static struct davinci_clk vicp_clk = {
 	.name = "vicp",
 	.parent = &pll1_sysclk2,
 	.lpsc = DAVINCI_LPSC_IMCOP,
@@ -157,128 +157,128 @@ static struct clk vicp_clk = {
 	.usecount = 1,			/* REVISIT how to disable? */
 };
 
-static struct clk vpss_master_clk = {
+static struct davinci_clk vpss_master_clk = {
 	.name = "vpss_master",
 	.parent = &pll1_sysclk3,
 	.lpsc = DAVINCI_LPSC_VPSSMSTR,
 	.flags = CLK_PSC,
 };
 
-static struct clk vpss_slave_clk = {
+static struct davinci_clk vpss_slave_clk = {
 	.name = "vpss_slave",
 	.parent = &pll1_sysclk3,
 	.lpsc = DAVINCI_LPSC_VPSSSLV,
 };
 
-static struct clk uart0_clk = {
+static struct davinci_clk uart0_clk = {
 	.name = "uart0",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_UART0,
 };
 
-static struct clk uart1_clk = {
+static struct davinci_clk uart1_clk = {
 	.name = "uart1",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_UART1,
 };
 
-static struct clk uart2_clk = {
+static struct davinci_clk uart2_clk = {
 	.name = "uart2",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_UART2,
 };
 
-static struct clk emac_clk = {
+static struct davinci_clk emac_clk = {
 	.name = "emac",
 	.parent = &pll1_sysclk5,
 	.lpsc = DAVINCI_LPSC_EMAC_WRAPPER,
 };
 
-static struct clk i2c_clk = {
+static struct davinci_clk i2c_clk = {
 	.name = "i2c",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_I2C,
 };
 
-static struct clk ide_clk = {
+static struct davinci_clk ide_clk = {
 	.name = "ide",
 	.parent = &pll1_sysclk5,
 	.lpsc = DAVINCI_LPSC_ATA,
 };
 
-static struct clk asp_clk = {
+static struct davinci_clk asp_clk = {
 	.name = "asp0",
 	.parent = &pll1_sysclk5,
 	.lpsc = DAVINCI_LPSC_McBSP,
 };
 
-static struct clk mmcsd_clk = {
+static struct davinci_clk mmcsd_clk = {
 	.name = "mmcsd",
 	.parent = &pll1_sysclk5,
 	.lpsc = DAVINCI_LPSC_MMC_SD,
 };
 
-static struct clk spi_clk = {
+static struct davinci_clk spi_clk = {
 	.name = "spi",
 	.parent = &pll1_sysclk5,
 	.lpsc = DAVINCI_LPSC_SPI,
 };
 
-static struct clk gpio_clk = {
+static struct davinci_clk gpio_clk = {
 	.name = "gpio",
 	.parent = &pll1_sysclk5,
 	.lpsc = DAVINCI_LPSC_GPIO,
 };
 
-static struct clk usb_clk = {
+static struct davinci_clk usb_clk = {
 	.name = "usb",
 	.parent = &pll1_sysclk5,
 	.lpsc = DAVINCI_LPSC_USB,
 };
 
-static struct clk vlynq_clk = {
+static struct davinci_clk vlynq_clk = {
 	.name = "vlynq",
 	.parent = &pll1_sysclk5,
 	.lpsc = DAVINCI_LPSC_VLYNQ,
 };
 
-static struct clk aemif_clk = {
+static struct davinci_clk aemif_clk = {
 	.name = "aemif",
 	.parent = &pll1_sysclk5,
 	.lpsc = DAVINCI_LPSC_AEMIF,
 };
 
-static struct clk pwm0_clk = {
+static struct davinci_clk pwm0_clk = {
 	.name = "pwm0",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_PWM0,
 };
 
-static struct clk pwm1_clk = {
+static struct davinci_clk pwm1_clk = {
 	.name = "pwm1",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_PWM1,
 };
 
-static struct clk pwm2_clk = {
+static struct davinci_clk pwm2_clk = {
 	.name = "pwm2",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_PWM2,
 };
 
-static struct clk timer0_clk = {
+static struct davinci_clk timer0_clk = {
 	.name = "timer0",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_TIMER0,
 };
 
-static struct clk timer1_clk = {
+static struct davinci_clk timer1_clk = {
 	.name = "timer1",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_TIMER1,
 };
 
-static struct clk timer2_clk = {
+static struct davinci_clk timer2_clk = {
 	.name = "timer2",
 	.parent = &pll1_aux_clk,
 	.lpsc = DAVINCI_LPSC_TIMER2,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 1ecca9b..ed55d17 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -62,258 +62,258 @@ static struct pll_data pll2_data = {
 	.phys_base = DAVINCI_PLL2_BASE,
 };
 
-static struct clk ref_clk = {
+static struct davinci_clk ref_clk = {
 	.name = "ref_clk",
 	.rate = DM646X_REF_FREQ,
 	.set_rate = davinci_simple_set_rate,
 };
 
-static struct clk aux_clkin = {
+static struct davinci_clk aux_clkin = {
 	.name = "aux_clkin",
 	.rate = DM646X_AUX_FREQ,
 };
 
-static struct clk pll1_clk = {
+static struct davinci_clk pll1_clk = {
 	.name = "pll1",
 	.parent = &ref_clk,
 	.pll_data = &pll1_data,
 	.flags = CLK_PLL,
 };
 
-static struct clk pll1_sysclk1 = {
+static struct davinci_clk pll1_sysclk1 = {
 	.name = "pll1_sysclk1",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV1,
 };
 
-static struct clk pll1_sysclk2 = {
+static struct davinci_clk pll1_sysclk2 = {
 	.name = "pll1_sysclk2",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV2,
 };
 
-static struct clk pll1_sysclk3 = {
+static struct davinci_clk pll1_sysclk3 = {
 	.name = "pll1_sysclk3",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV3,
 };
 
-static struct clk pll1_sysclk4 = {
+static struct davinci_clk pll1_sysclk4 = {
 	.name = "pll1_sysclk4",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV4,
 };
 
-static struct clk pll1_sysclk5 = {
+static struct davinci_clk pll1_sysclk5 = {
 	.name = "pll1_sysclk5",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV5,
 };
 
-static struct clk pll1_sysclk6 = {
+static struct davinci_clk pll1_sysclk6 = {
 	.name = "pll1_sysclk6",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV6,
 };
 
-static struct clk pll1_sysclk8 = {
+static struct davinci_clk pll1_sysclk8 = {
 	.name = "pll1_sysclk8",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV8,
 };
 
-static struct clk pll1_sysclk9 = {
+static struct davinci_clk pll1_sysclk9 = {
 	.name = "pll1_sysclk9",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV9,
 };
 
-static struct clk pll1_sysclkbp = {
+static struct davinci_clk pll1_sysclkbp = {
 	.name = "pll1_sysclkbp",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL | PRE_PLL,
 	.div_reg = BPDIV,
 };
 
-static struct clk pll1_aux_clk = {
+static struct davinci_clk pll1_aux_clk = {
 	.name = "pll1_aux_clk",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL | PRE_PLL,
 };
 
-static struct clk pll2_clk = {
+static struct davinci_clk pll2_clk = {
 	.name = "pll2_clk",
 	.parent = &ref_clk,
 	.pll_data = &pll2_data,
 	.flags = CLK_PLL,
 };
 
-static struct clk pll2_sysclk1 = {
+static struct davinci_clk pll2_sysclk1 = {
 	.name = "pll2_sysclk1",
 	.parent = &pll2_clk,
 	.flags = CLK_PLL,
 	.div_reg = PLLDIV1,
 };
 
-static struct clk dsp_clk = {
+static struct davinci_clk dsp_clk = {
 	.name = "dsp",
 	.parent = &pll1_sysclk1,
 	.lpsc = DM646X_LPSC_C64X_CPU,
 	.usecount = 1,			/* REVISIT how to disable? */
 };
 
-static struct clk arm_clk = {
+static struct davinci_clk arm_clk = {
 	.name = "arm",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM646X_LPSC_ARM,
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk edma_cc_clk = {
+static struct davinci_clk edma_cc_clk = {
 	.name = "edma_cc",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM646X_LPSC_TPCC,
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk edma_tc0_clk = {
+static struct davinci_clk edma_tc0_clk = {
 	.name = "edma_tc0",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM646X_LPSC_TPTC0,
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk edma_tc1_clk = {
+static struct davinci_clk edma_tc1_clk = {
 	.name = "edma_tc1",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM646X_LPSC_TPTC1,
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk edma_tc2_clk = {
+static struct davinci_clk edma_tc2_clk = {
 	.name = "edma_tc2",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM646X_LPSC_TPTC2,
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk edma_tc3_clk = {
+static struct davinci_clk edma_tc3_clk = {
 	.name = "edma_tc3",
 	.parent = &pll1_sysclk2,
 	.lpsc = DM646X_LPSC_TPTC3,
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk uart0_clk = {
+static struct davinci_clk uart0_clk = {
 	.name = "uart0",
 	.parent = &aux_clkin,
 	.lpsc = DM646X_LPSC_UART0,
 };
 
-static struct clk uart1_clk = {
+static struct davinci_clk uart1_clk = {
 	.name = "uart1",
 	.parent = &aux_clkin,
 	.lpsc = DM646X_LPSC_UART1,
 };
 
-static struct clk uart2_clk = {
+static struct davinci_clk uart2_clk = {
 	.name = "uart2",
 	.parent = &aux_clkin,
 	.lpsc = DM646X_LPSC_UART2,
 };
 
-static struct clk i2c_clk = {
+static struct davinci_clk i2c_clk = {
 	.name = "I2CCLK",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_I2C,
 };
 
-static struct clk gpio_clk = {
+static struct davinci_clk gpio_clk = {
 	.name = "gpio",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_GPIO,
 };
 
-static struct clk mcasp0_clk = {
+static struct davinci_clk mcasp0_clk = {
 	.name = "mcasp0",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_McASP0,
 };
 
-static struct clk mcasp1_clk = {
+static struct davinci_clk mcasp1_clk = {
 	.name = "mcasp1",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_McASP1,
 };
 
-static struct clk aemif_clk = {
+static struct davinci_clk aemif_clk = {
 	.name = "aemif",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_AEMIF,
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk emac_clk = {
+static struct davinci_clk emac_clk = {
 	.name = "emac",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_EMAC,
 };
 
-static struct clk pwm0_clk = {
+static struct davinci_clk pwm0_clk = {
 	.name = "pwm0",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_PWM0,
 	.usecount = 1,            /* REVIST: disabling hangs system */
 };
 
-static struct clk pwm1_clk = {
+static struct davinci_clk pwm1_clk = {
 	.name = "pwm1",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_PWM1,
 	.usecount = 1,            /* REVIST: disabling hangs system */
 };
 
-static struct clk timer0_clk = {
+static struct davinci_clk timer0_clk = {
 	.name = "timer0",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_TIMER0,
 };
 
-static struct clk timer1_clk = {
+static struct davinci_clk timer1_clk = {
 	.name = "timer1",
 	.parent = &pll1_sysclk3,
 	.lpsc = DM646X_LPSC_TIMER1,
 };
 
-static struct clk timer2_clk = {
+static struct davinci_clk timer2_clk = {
 	.name = "timer2",
 	.parent = &pll1_sysclk3,
 	.flags = ALWAYS_ENABLED, /* no LPSC, always enabled; c.f. spruep9a */
 };
 
 
-static struct clk ide_clk = {
+static struct davinci_clk ide_clk = {
 	.name = "ide",
 	.parent = &pll1_sysclk4,
 	.lpsc = DAVINCI_LPSC_ATA,
 };
 
-static struct clk vpif0_clk = {
+static struct davinci_clk vpif0_clk = {
 	.name = "vpif0",
 	.parent = &ref_clk,
 	.lpsc = DM646X_LPSC_VPSSMSTR,
 	.flags = ALWAYS_ENABLED,
 };
 
-static struct clk vpif1_clk = {
+static struct davinci_clk vpif1_clk = {
 	.name = "vpif1",
 	.parent = &ref_clk,
 	.lpsc = DM646X_LPSC_VPSSSLV,
diff --git a/arch/arm/mach-davinci/include/mach/clock.h b/arch/arm/mach-davinci/include/mach/clock.h
index 3e8af6a..42ed4f2 100644
--- a/arch/arm/mach-davinci/include/mach/clock.h
+++ b/arch/arm/mach-davinci/include/mach/clock.h
@@ -15,9 +15,6 @@
 
 struct clk;
 
-extern int clk_register(struct clk *clk);
-extern void clk_unregister(struct clk *clk);
-
 int davinci_clk_reset_assert(struct clk *c);
 int davinci_clk_reset_deassert(struct clk *c);
 
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index a2e575e..7ea1343 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -23,7 +23,7 @@
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
-static struct clk *usb20_clk;
+static struct davinci_clk *usb20_clk;
 
 static struct platform_device da8xx_usb_phy = {
 	.name		= "da8xx-usb-phy",
@@ -128,7 +128,7 @@ int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
 	return platform_device_register(&da8xx_usb11_device);
 }
 
-static struct clk usb_refclkin = {
+static struct davinci_clk usb_refclkin = {
 	.name		= "usb_refclkin",
 	.set_rate	= davinci_simple_set_rate,
 };
@@ -147,16 +147,16 @@ int __init da8xx_register_usb_refclkin(int rate)
 	int ret;
 
 	usb_refclkin.rate = rate;
-	ret = clk_register(&usb_refclkin);
+	ret = davinci_clk_register(&usb_refclkin);
 	if (ret)
 		return ret;
 
-	clk_register_clkdev(&usb_refclkin, "usb_refclkin", NULL);
+	clk_register_clkdev(usb_refclkin.hw.clk, "usb_refclkin", NULL);
 
 	return 0;
 }
 
-static void usb20_phy_clk_enable(struct clk *clk)
+static void usb20_phy_clk_enable(struct davinci_clk *clk)
 {
 	u32 val;
 	u32 timeout = 500000; /* 500 msec */
@@ -187,7 +187,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
 	davinci_clk_disable(usb20_clk);
 }
 
-static void usb20_phy_clk_disable(struct clk *clk)
+static void usb20_phy_clk_disable(struct davinci_clk *clk)
 {
 	u32 val;
 
@@ -196,7 +196,8 @@ static void usb20_phy_clk_disable(struct clk *clk)
 	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 }
 
-static int usb20_phy_clk_set_parent(struct clk *clk, struct clk *parent)
+static int usb20_phy_clk_set_parent(struct davinci_clk *clk,
+				    struct davinci_clk *parent)
 {
 	u32 val;
 
@@ -214,7 +215,7 @@ static int usb20_phy_clk_set_parent(struct clk *clk, struct clk *parent)
 
 	/* reference frequency also comes from parent clock */
 	val &= ~CFGCHIP2_REFFREQ_MASK;
-	switch (clk_get_rate(parent)) {
+	switch (parent->rate) {
 	case 12000000:
 		val |= CFGCHIP2_REFFREQ_12MHZ;
 		break;
@@ -252,7 +253,7 @@ static int usb20_phy_clk_set_parent(struct clk *clk, struct clk *parent)
 	return 0;
 }
 
-static struct clk usb20_phy_clk = {
+static struct davinci_clk usb20_phy_clk = {
 	.name		= "usb20_phy",
 	.clk_enable	= usb20_phy_clk_enable,
 	.clk_disable	= usb20_phy_clk_disable,
@@ -267,32 +268,36 @@ static struct clk usb20_phy_clk = {
  */
 int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
 {
-	struct clk *parent;
+	struct clk *clk, *parent;
 	int ret;
 
-	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
-	ret = PTR_ERR_OR_ZERO(usb20_clk);
+	clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
+	ret = PTR_ERR_OR_ZERO(clk);
 	if (ret)
 		return ret;
 
 	parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" : "pll0_aux");
 	ret = PTR_ERR_OR_ZERO(parent);
 	if (ret) {
-		clk_put(usb20_clk);
+		clk_put(clk);
 		return ret;
 	}
 
-	usb20_phy_clk.parent = parent;
-	ret = clk_register(&usb20_phy_clk);
+	usb20_clk = to_davinci_clk(__clk_get_hw(clk));
+
+	usb20_phy_clk.parent = to_davinci_clk(__clk_get_hw(parent));
+	ret = davinci_clk_register(&usb20_phy_clk);
 	if (!ret)
-		clk_register_clkdev(&usb20_phy_clk, "usb20_phy", "da8xx-usb-phy");
+		clk_register_clkdev(usb20_phy_clk.hw.clk, "usb20_phy",
+				    "da8xx-usb-phy");
 
 	clk_put(parent);
 
 	return ret;
 }
 
-static int usb11_phy_clk_set_parent(struct clk *clk, struct clk *parent)
+static int usb11_phy_clk_set_parent(struct davinci_clk *clk,
+				    struct davinci_clk *parent)
 {
 	u32 val;
 
@@ -313,7 +318,7 @@ static int usb11_phy_clk_set_parent(struct clk *clk, struct clk *parent)
 	return 0;
 }
 
-static struct clk usb11_phy_clk = {
+static struct davinci_clk usb11_phy_clk = {
 	.name		= "usb11_phy",
 	.set_parent	= usb11_phy_clk_set_parent,
 };
@@ -336,10 +341,11 @@ int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
 	if (IS_ERR(parent))
 		return PTR_ERR(parent);
 
-	usb11_phy_clk.parent = parent;
-	ret = clk_register(&usb11_phy_clk);
+	usb11_phy_clk.parent = to_davinci_clk(__clk_get_hw(parent));
+	ret = davinci_clk_register(&usb11_phy_clk);
 	if (!ret)
-		clk_register_clkdev(&usb11_phy_clk, "usb11_phy", "da8xx-usb-phy");
+		clk_register_clkdev(usb11_phy_clk.hw.clk, "usb11_phy",
+				    "da8xx-usb-phy");
 
 	clk_put(parent);
 
-- 
2.7.4
