From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 17 Mar 2012 17:07:44 +0100
Subject: [RFC/PATCH 4/4] pxa: convert to common clock framework
In-Reply-To: <CA+gwMcdzHpGhLXXh5QTYid+rBtj8cGqFS9Te4QB3rpR9B8hXUw@mail.gmail.com>
References: <1331919483.31118.23.camel@flow>
 <CAJOA=zN2dxgjQ8EZYAwE=OLO1GLdArqy1Xf18F82en9QvFi4cw@mail.gmail.com>
 <CA+gwMcdzHpGhLXXh5QTYid+rBtj8cGqFS9Te4QB3rpR9B8hXUw@mail.gmail.com>
Message-ID: <20120317160744.GE29317@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2012 at 11:24:25AM +0100, Philipp Zabel wrote:
> Hi Mike,
> 
> On Fri, Mar 16, 2012 at 11:03 PM, Turquette, Mike <mturquette@ti.com> wrote:
> > On Fri, Mar 16, 2012 at 10:38 AM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> >> ?#define DEFINE_CK(_name, _cken, _ops) ? ? ? ? ? ? ? ? ?\
> >> -struct clk clk_##_name = { ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> >> - ? ? ? ? ? ? ? .ops ? ?= _ops, ? ? ? ? ? ? ? ? ? ? ? ? \
> >> + ? ? ? struct clk clk_##_name; ? ? ? ? ? ? ? ? ? ? ? ? \
> >> + ? ? ? static struct clk_pxa clk_pxa_##_name = { ? ? ? \
> >> + ? ? ? ? ? ? ? .hw = { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> >> + ? ? ? ? ? ? ? ? ? ? ? .clk = &clk_##_name, ? ? ? ? ? ?\
> >> + ? ? ? ? ? ? ? }, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> >> ? ? ? ? ? ? ? ?.cken ? = CKEN_##_cken, ? ? ? ? ? ? ? ? \
> >> + ? ? ? }; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> >> + ? ? ? static struct clk clk_##_name = { ? ? ? ? ? ? ? \
> >> + ? ? ? ? ? ? ? .name ? = #_name, ? ? ? ? ? ? ? ? ? ? ? \
> >> + ? ? ? ? ? ? ? .ops ? ?= _ops, ? ? ? ? ? ? ? ? ? ? ? ? \
> >> + ? ? ? ? ? ? ? .hw ? ? = &clk_pxa_##_name.hw, ? ? ? ? ?\
> >> ? ? ? ?}
> >
> > Hi Philipp,
> >
> > It looks like your macros do not initialize the .parent_names,
> > .num_parents or .flags members of struct clk. ?__clk_init expects
> > those to be initialized before being called. ?The kerneldoc for
> > __clk_init states this:
> > http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=include/linux/clk-private.h;h=e2cce6fa604686ea3bca0496998322bacaed854d;hb=c5836d8acd9846ec1675b269d994d96a8ee44df4#l49
> 
> Yes, thank you! That was the problem.
> 
> > You can use the macros for the basic clocks types as templates. ?The
> > gate and mux macros are good to look at since those show how to handle
> > a single-parent and multi-parent clock, respectively:
> > http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=include/linux/clk-private.h;h=5e4312b6f5ccb1072273ce94e235874c74dd852d;hb=2508b44cd5c134691dc5d679f728bbf82af2abe0#l83
> > and
> > http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=include/linux/clk-private.h;h=5e4312b6f5ccb1072273ce94e235874c74dd852d;hb=2508b44cd5c134691dc5d679f728bbf82af2abe0#l148
> 
> If there was a fixed fractional divider clk element, a lot of the
> peripheral clocks could be derived from a fixed clk representing the
> 312 MHz PPLL on PXA27x (fixed -> divider -> gate), using just the
> basic clock templates.

You could try the following. It is not thoroughly tested but may be a
starting point. I need this aswell for i.MX so I will continue to work
on it soon.

Sascha

8<-------------------------------------------------------

clk: add a fixed factor clock

Having fixed factors/dividers in hardware is a common pattern, so
add a clock doing this. Currently no rate propagation is supported.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/Makefile           |    2 +-
 drivers/clk/clk-fixed-factor.c |   97 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h   |    4 ++
 3 files changed, 102 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clk/clk-fixed-factor.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index ba9a779..54f6f5b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -1,4 +1,4 @@
 
 obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
 obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
-				   clk-mux.o clk-divider.o clk-test.o
+				   clk-mux.o clk-divider.o clk-fixed-factor.o clk-test.o
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
new file mode 100644
index 0000000..7c5e1fc
--- /dev/null
+++ b/drivers/clk/clk-fixed-factor.c
@@ -0,0 +1,97 @@
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
+struct clk_fixed_factor {
+	struct clk_hw	hw;
+	unsigned int	mult;
+	unsigned int	div;
+	char		*parent[1];
+};
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
+		return (__clk_get_rate(__clk_get_parent(hw->clk)) / fix->div) * fix->mult;
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
+	fix = kmalloc(sizeof(struct clk_gate), GFP_KERNEL);
+
+	if (!fix) {
+		pr_err("%s: could not allocate gated clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* struct clk_gate assignments */
+	fix->mult = mult;
+	fix->div = div;
+
+	if (parent_name) {
+		fix->parent[0] = kstrdup(parent_name, GFP_KERNEL);
+		if (!fix->parent[0])
+			goto out;
+	}
+
+	clk = clk_register(dev, name,
+			&clk_fixed_factor_ops, &fix->hw,
+			fix->parent,
+			(parent_name ? 1 : 0),
+			flags);
+	if (clk)
+		return clk;
+
+out:
+	kfree(fix->parent[0]);
+	kfree(fix);
+
+	return NULL;
+}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5508897..21ca2f8 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -257,6 +257,10 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock);
 
+struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		unsigned int mult, unsigned int div);
+
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
-- 
1.7.9.1

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
