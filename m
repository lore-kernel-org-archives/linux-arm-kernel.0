From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 07 Feb 2011 14:07:57 +0800
Subject: [RFC,PATCH 2/3] clk: Generic support for fixed-rate clocks
In-Reply-To: <201102011711.31258.jeremy.kerr@canonical.com>
Message-ID: <1297058877.800455.891273153193.2.gpush@pororo>
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
index 12e0daf..51dbd33 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -132,3 +132,17 @@ struct clk *clk_get_parent(struct clk *clk)
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
diff --git a/include/linux/clk.h b/include/linux/clk.h
index e081ca1..daa2d5a 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -176,6 +176,22 @@ static inline void clk_common_init(struct clk *clk)
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
