From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 15 Sep 2010 11:40:14 +0800
Subject: [PATCH 2/3] clk: Generic support for fixed-rate clocks
In-Reply-To: <1284522014.516876.675872472687.0.gpush@pororo>
Message-ID: <1284522014.517644.745790554539.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since most platforms will need a fixed-rate clock, add one. This will
also serve as a basic example of an implementation of struct clk.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 include/linux/clk.h |   13 +++++++++++++
 kernel/clk.c        |   14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index a95cc82..85e1d44 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -90,6 +90,19 @@ static inline void clk_common_init(struct clk *clk)
 	clk->enable_count = 0;
 }
 
+/* Simple fixed-rate clock */
+struct clk_fixed {
+	struct clk	clk;
+	unsigned long	rate;
+};
+
+extern struct clk_ops clk_fixed_ops;
+
+#define INIT_CLK_FIXED(r) { \
+	.clk = INIT_CLK(clk_fixed_ops), \
+	.rate = (r) \
+}
+
 #else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 
 /*
diff --git a/kernel/clk.c b/kernel/clk.c
index cdea25f..32f25ef 100644
--- a/kernel/clk.c
+++ b/kernel/clk.c
@@ -99,3 +99,17 @@ struct clk *clk_get_parent(struct clk *clk)
 	return ERR_PTR(-ENOSYS);
 }
 EXPORT_SYMBOL_GPL(clk_get_parent);
+
+/* clk_fixed support */
+
+#define to_clk_fixed(clk) (container_of(clk, struct clk_fixed, clk))
+
+static unsigned long clk_fixed_get_rate(struct clk *clk)
+{
+	return to_clk_fixed(clk)->rate;
+}
+
+struct clk_ops clk_fixed_ops = {
+	.get_rate = clk_fixed_get_rate,
+};
+EXPORT_SYMBOL_GPL(clk_fixed_ops);
