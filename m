From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 12:20:30 +0530
Subject: [PATCH V3 2/8] clk: add a fixed factor clock
In-Reply-To: <cover.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
Message-ID: <a8f9558e0709b63673e88912d25f2173b6b410e5.1335249846.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Having fixed factors/dividers in hardware is a common pattern, so
add a basic clock type doing this. It basically describes a fixed
factor clock using a nominator and a denominator.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Sascha,

I have this patch in my set, because i need this to get SPEAr stuff pushed by
Mike. I have updated your original patch, with all the review comments you got
on it. Please check see if i have corrupted something.

 drivers/clk/Makefile           |    2 +-
 drivers/clk/clk-fixed-factor.c |   94 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-private.h    |   20 ++++++++
 include/linux/clk-provider.h   |   23 ++++++++++
 4 files changed, 138 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clk/clk-fixed-factor.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 1f736bc..24aa714 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -1,4 +1,4 @@
 
 obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
 obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
-				   clk-mux.o clk-divider.o
+				   clk-mux.o clk-divider.o clk-fixed-factor.o
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
new file mode 100644
index 0000000..7453efe
--- /dev/null
+++ b/drivers/clk/clk-fixed-factor.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Standard functionality for the common clock API.
+ */
+#include <linux/module.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+
+/*
+ * DOC: basic fixed multiplier and divider clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is fixed.  clk->rate = parent->rate / div * mult
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define to_clk_fixed_factor(_hw) container_of(_hw, struct clk_fixed_factor, hw)
+
+static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
+
+	return (parent_rate / fix->div) * fix->mult;
+}
+
+static long clk_factor_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
+
+	if (prate) {
+		unsigned long best_parent;
+		best_parent = (rate / fix->mult) * fix->div;
+		*prate = __clk_round_rate(__clk_get_parent(hw->clk),
+				best_parent);
+		return (*prate / fix->div) * fix->mult;
+	} else {
+		return (__clk_get_rate(__clk_get_parent(hw->clk)) / fix->div) *
+			fix->mult;
+	}
+}
+
+static int clk_factor_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	return 0;
+}
+
+struct clk_ops clk_fixed_factor_ops = {
+	.round_rate = clk_factor_round_rate,
+	.set_rate = clk_factor_set_rate,
+	.recalc_rate = clk_factor_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
+
+struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div)
+{
+	struct clk_fixed_factor *fix;
+	struct clk *clk;
+
+	fix = kmalloc(sizeof(*fix), GFP_KERNEL);
+
+	if (!fix) {
+		pr_err("%s: could not allocate fixed factor clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* struct clk_fixed_factor assignments */
+	fix->mult = mult;
+	fix->div = div;
+
+	clk = clk_register(dev, name,
+			&clk_fixed_factor_ops, &fix->hw,
+			&parent_name,
+			(parent_name ? 1 : 0),
+			flags);
+
+	if (clk)
+		return clk;
+
+	kfree(fix);
+
+	return NULL;
+}
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index eeae7a3..1e0fa93 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -143,6 +143,26 @@ struct clk {
 	DEFINE_CLK(_name, clk_mux_ops, _flags, _parent_names,	\
 			_parents);
 
+#define DEFINE_CLK_FIXED_FACTOR(_name, _parent_name,		\
+				_parent_ptr, _flags,		\
+				_mult, _div)			\
+	static struct clk _name;				\
+	static char *_name##_parent_names[] = {			\
+		_parent_name,					\
+	};							\
+	static struct clk *_name##_parents[] = {		\
+		_parent_ptr,					\
+	};							\
+	static struct clk_fixed_factor _name##_hw = {		\
+		.hw = {						\
+			.clk = &_name,				\
+		},						\
+		.mult = _mult,					\
+		.div = _div,					\
+	};							\
+	DEFINE_CLK(_name, clk_fixed_factor_ops, _flags,		\
+			_name##_parent_names, _parents);
+
 /**
  * __clk_init - initialize the data structures in a struct clk
  * @dev:	device initializing this clk, placeholder for now
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 8e85a9d..067b04d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -260,6 +260,29 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 		u8 clk_mux_flags, spinlock_t *lock);
 
 /**
+ * struct clk_fixed_factor - fixed multiplier and divider clock
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @mult:	multiplier
+ * @div:	divider
+ *
+ * Clock with a fixed multiplier and divider. The output frequency is the
+ * parent clock rate divided by div and multiplied by mult.
+ * Implements .recalc_rate, .set_rate and .round_rate
+ */
+
+struct clk_fixed_factor {
+	struct clk_hw	hw;
+	unsigned int	mult;
+	unsigned int	div;
+};
+
+extern struct clk_ops clk_fixed_factor_ops;
+struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div);
+
+/**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
  * @name: clock name
-- 
1.7.9
