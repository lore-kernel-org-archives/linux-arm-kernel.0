From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 08 Dec 2010 10:05:32 +0800
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <1291773932.578726.468741339223.1.gpush@pororo>
Message-ID: <1291773932.579113.476506736919.2.gpush@pororo>
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
index e09e40e..ae7e4ed 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -158,6 +158,19 @@ static inline void clk_common_init(struct clk *clk)
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
 #else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 
 /*
diff --git a/kernel/clk.c b/kernel/clk.c
index 1545e69..2779abb 100644
--- a/kernel/clk.c
+++ b/kernel/clk.c
@@ -98,3 +98,17 @@ struct clk *clk_get_parent(struct clk *clk)
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
