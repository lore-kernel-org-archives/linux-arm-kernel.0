From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Tue, 11 Jun 2013 15:01:07 +0530
Subject: [PATCH v7 02/11] clk: samsung: Define a common
 samsung_clk_register_pll()
In-Reply-To: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
References: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370943076-13461-3-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines a common samsung_clk_register_pll()
Since pll2550 & pll35xx and pll2650 & pll36xx have exactly same clk ops
implementation, added pll2550 and pll2650 also.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 drivers/clk/samsung/clk-pll.c |   70 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-pll.h |    7 ++++
 drivers/clk/samsung/clk.h     |   48 ++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 8224bde..f20af69 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -17,6 +17,7 @@ struct samsung_clk_pll {
 	struct clk_hw		hw;
 	void __iomem		*lock_reg;
 	void __iomem		*con_reg;
+	enum samsung_pll_type	type;
 };
 
 #define to_clk_pll(_hw) container_of(_hw, struct samsung_clk_pll, hw)
@@ -411,3 +412,72 @@ struct clk * __init samsung_clk_register_pll2550x(const char *name,
 
 	return clk;
 }
+
+static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
+						void __iomem *base)
+{
+	struct samsung_clk_pll *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll) {
+		pr_err("%s: could not allocate pll clk %s\n",
+			__func__, pll_clk->name);
+		return;
+	}
+
+	init.name = pll_clk->name;
+	init.flags = pll_clk->flags;
+	init.parent_names = &pll_clk->parent_name;
+	init.num_parents = 1;
+
+	switch (pll_clk->type) {
+	/* clk_ops for 35xx and 2550 are similar */
+	case pll_35xx:
+	case pll_2550:
+		init.ops = &samsung_pll35xx_clk_ops;
+		break;
+	/* clk_ops for 36xx and 2650 are similar */
+	case pll_36xx:
+	case pll_2650:
+		init.ops = &samsung_pll36xx_clk_ops;
+		break;
+	default:
+		pr_warn("%s: Unknown pll type for pll clk %s\n",
+			__func__, pll_clk->name);
+	}
+
+	pll->hw.init = &init;
+	pll->type = pll_clk->type;
+	pll->lock_reg = base + pll_clk->lock_offset;
+	pll->con_reg = base + pll_clk->con_offset;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register pll clock %s : %ld\n",
+			__func__, pll_clk->name, PTR_ERR(clk));
+		kfree(pll);
+		return;
+	}
+
+	samsung_clk_add_lookup(clk, pll_clk->id);
+
+	if (!pll_clk->alias)
+		return;
+
+	ret = clk_register_clkdev(clk, pll_clk->alias, pll_clk->dev_name);
+	if (ret)
+		pr_err("%s: failed to register lookup for %s : %d",
+			__func__, pll_clk->name, ret);
+}
+
+void __init samsung_clk_register_pll(struct samsung_pll_clock *pll_list,
+				unsigned int nr_pll, void __iomem *base)
+{
+	int cnt;
+
+	for (cnt = 0; cnt < nr_pll; cnt++)
+		_samsung_clk_register_pll(&pll_list[cnt], base);
+}
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index f33786e..0d86bf0 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -12,6 +12,13 @@
 #ifndef __SAMSUNG_CLK_PLL_H
 #define __SAMSUNG_CLK_PLL_H
 
+enum samsung_pll_type {
+	pll_35xx,
+	pll_36xx,
+	pll_2550,
+	pll_2650,
+};
+
 enum pll45xx_type {
 	pll_4500,
 	pll_4502,
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index e4ad6ea..d834395 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -19,6 +19,7 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include "clk-pll.h"
 
 /**
  * struct samsung_clock_alias: information about mux clock
@@ -258,6 +259,51 @@ struct samsung_clk_reg_dump {
 	u32	value;
 };
 
+/**
+ * struct samsung_pll_clock: information about pll clock
+ * @id: platform specific id of the clock.
+ * @dev_name: name of the device to which this clock belongs.
+ * @name: name of this pll clock.
+ * @parent_name: name of the parent clock.
+ * @flags: optional flags for basic clock.
+ * @con_offset: offset of the register for configuring the PLL.
+ * @lock_offset: offset of the register for locking the PLL.
+ * @type: Type of PLL to be registered.
+ * @alias: optional clock alias name to be assigned to this clock.
+ */
+struct samsung_pll_clock {
+	unsigned int		id;
+	const char		*dev_name;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	int			con_offset;
+	int			lock_offset;
+	enum samsung_pll_type	type;
+	const char              *alias;
+};
+
+#define __PLL(_typ, _id, _dname, _name, _pname, _flags, _lock, _con, _alias) \
+	{								\
+		.id		= _id,					\
+		.type		= _typ,					\
+		.dev_name	= _dname,				\
+		.name		= _name,				\
+		.parent_name	= _pname,				\
+		.flags		= CLK_GET_RATE_NOCACHE,			\
+		.con_offset	= _con,					\
+		.lock_offset	= _lock,				\
+		.alias		= _alias,				\
+	}
+
+#define PLL(_typ, _id, _name, _pname, _lock, _con)			\
+	__PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE,	\
+		_lock, _con, NULL)
+
+#define PLL_A(_typ, _id, _name, _pname, _lock, _con, _alias)		\
+	__PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE,	\
+		_lock, _con, _alias)
+
 extern void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 		unsigned long nr_clks, unsigned long *rdump,
 		unsigned long nr_rdump, unsigned long *soc_rdump,
@@ -281,6 +327,8 @@ extern void __init samsung_clk_register_div(struct samsung_div_clock *clk_list,
 		unsigned int nr_clk);
 extern void __init samsung_clk_register_gate(
 		struct samsung_gate_clock *clk_list, unsigned int nr_clk);
+extern void __init samsung_clk_register_pll(struct samsung_pll_clock *pll_list,
+		unsigned int nr_clk, void __iomem *base);
 
 extern unsigned long _get_rate(const char *clk_name);
 
-- 
1.7.0.4
