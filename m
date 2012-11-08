From: horms@verge.net.au (Simon Horman)
Date: Thu,  8 Nov 2012 10:27:33 +0900
Subject: [PATCH 4/7] sh: clkfwk: add sh_clk_fsidiv_register()
In-Reply-To: <1352338056-21107-1-git-send-email-horms@verge.net.au>
References: <1352338056-21107-1-git-send-email-horms@verge.net.au>
Message-ID: <1352338056-21107-5-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds sh_clk_fsidiv_register() to share FSI-DIV clock code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/sh/clk/cpg.c   |   86 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sh_clk.h |    9 +++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 07e9fb4..b3dc441 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -361,3 +361,89 @@ int __init sh_clk_div4_reparent_register(struct clk *clks, int nr,
 	return sh_clk_div_register_ops(clks, nr, table,
 				       &sh_clk_div4_reparent_clk_ops);
 }
+
+/* FSI-DIV */
+static unsigned long fsidiv_recalc(struct clk *clk)
+{
+	u32 value;
+
+	value = __raw_readl(clk->mapping->base);
+
+	value >>= 16;
+	if (value < 2)
+		return clk->parent->rate;
+
+	return clk->parent->rate / value;
+}
+
+static long fsidiv_round_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_rate_div_range_round(clk, 1, 0xffff, rate);
+}
+
+static void fsidiv_disable(struct clk *clk)
+{
+	__raw_writel(0, clk->mapping->base);
+}
+
+static int fsidiv_enable(struct clk *clk)
+{
+	u32 value;
+
+	value  = __raw_readl(clk->mapping->base) >> 16;
+	if (value < 2)
+		return 0;
+
+	__raw_writel((value << 16) | 0x3, clk->mapping->base);
+
+	return 0;
+}
+
+static int fsidiv_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 val;
+	int idx;
+
+	idx = (clk->parent->rate / rate) & 0xffff;
+	if (idx < 2)
+		__raw_writel(0, clk->mapping->base);
+	else
+		__raw_writel(idx << 16, clk->mapping->base);
+
+	return 0;
+}
+
+static struct sh_clk_ops fsidiv_clk_ops = {
+	.recalc		= fsidiv_recalc,
+	.round_rate	= fsidiv_round_rate,
+	.set_rate	= fsidiv_set_rate,
+	.enable		= fsidiv_enable,
+	.disable	= fsidiv_disable,
+};
+
+int __init sh_clk_fsidiv_register(struct clk *clks, int nr)
+{
+	struct clk_mapping *map;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+
+		map = kzalloc(sizeof(struct clk_mapping), GFP_KERNEL);
+		if (!map) {
+			pr_err("%s: unable to alloc memory\n", __func__);
+			return -ENOMEM;
+		}
+
+		/* clks[i].enable_reg came from SH_CLK_FSIDIV() */
+		map->phys		= (phys_addr_t)clks[i].enable_reg;
+		map->len		= 8;
+
+		clks[i].enable_reg	= 0; /* remove .enable_reg */
+		clks[i].ops		= &fsidiv_clk_ops;
+		clks[i].mapping		= map;
+
+		clk_register(&clks[i]);
+	}
+
+	return 0;
+}
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 5091091..60c7239 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -199,4 +199,13 @@ int sh_clk_div6_reparent_register(struct clk *clks, int nr);
 #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
 #define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
 
+/* .enable_reg will be updated to .mapping on sh_clk_fsidiv_register() */
+#define SH_CLK_FSIDIV(_reg, _parent)		\
+{						\
+	.enable_reg = (void __iomem *)_reg,	\
+	.parent		= _parent,		\
+}
+
+int sh_clk_fsidiv_register(struct clk *clks, int nr);
+
 #endif /* __SH_CLOCK_H */
-- 
1.7.10.4
