From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 03 Mar 2011 14:40:29 +0800
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <1299134429.100626.661279191478.0.gpush@pororo>
Message-ID: <1299134429.101464.204953289514.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since most platforms will need a fixed-rate clock, add one. This will
also serve as a basic example of an implementation of struct clk.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 drivers/clk/clk.c   |   14 ++++++++++++++
 include/linux/clk.h |   16 ++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0bc9c6f..0da0bb9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -130,3 +130,17 @@ void __clk_put(struct clk *clk)
 	if (clk->ops->put)
 		clk->ops->put(clk);
 }
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
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 7b406bd..d2f0db0 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -155,6 +155,22 @@ static inline void clk_common_init(struct clk *clk)
 	mutex_init(&clk->prepare_lock);
 }
 
+/* Simple fixed-rate clock */
+struct clk_fixed {
+	struct clk	clk;
+	unsigned long	rate;
+};
+
+extern struct clk_ops clk_fixed_ops;
+
+#define INIT_CLK_FIXED(name, r) { \
+	.clk = INIT_CLK(name.clk, clk_fixed_ops), \
+	.rate = (r) \
+}
+
+#define DEFINE_CLK_FIXED(name, r) \
+	struct clk_fixed name = INIT_CLK_FIXED(name, r)
+
 #else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 
 /*
