From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 05 Jan 2011 11:51:02 +0800
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <1294199462.347935.472473715866.0.gpush@pororo>
Message-ID: <1294199462.348743.574566157747.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since most platforms will need a fixed-rate clock, add one. This will
also serve as a basic example of an implementation of struct clk.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 include/linux/clk.h |   16 ++++++++++++++++
 kernel/clk.c        |   14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 95c49b1..6cef9fe 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -164,6 +164,22 @@ static inline void clk_common_init(struct clk *clk)
 		mutex_init(&clk->lock.mutex);
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
diff --git a/kernel/clk.c b/kernel/clk.c
index 8de8fe3..6c38cc0 100644
--- a/kernel/clk.c
+++ b/kernel/clk.c
@@ -100,3 +100,17 @@ struct clk *clk_get_parent(struct clk *clk)
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
