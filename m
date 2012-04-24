From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 12:20:29 +0530
Subject: [PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add
 clkdevs for given struct clk *
In-Reply-To: <cover.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
Message-ID: <0fb69ddb87f9a5e6a6afec2f833c6341e45763c7.1335249846.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

With common clock framework, clks are allocated at runtime. Some of them require
clkdevs to be allocated and added in global clkdev list.

This patch introduces helper routines to:

 - allocate and add single clkdev for a single clk structure.
 - add multiple clkdevs for a single clk structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clkdev.c   |   64 +++++++++++++++++++++++++++++++++++++++++++----
 include/linux/clkdev.h |    3 ++
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index d4a5993..e39d96f 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -166,8 +166,9 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
-struct clk_lookup * __init_refok
-clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
+static struct clk_lookup * __init_refok
+__clkdev_alloc_valist(struct clk *clk, const char *con_id, const char *dev_fmt,
+		va_list ap)
 {
 	struct clk_lookup_alloc *cla;
 
@@ -182,16 +183,35 @@ clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
 	}
 
 	if (dev_fmt) {
-		va_list ap;
-
-		va_start(ap, dev_fmt);
 		vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
 		cla->cl.dev_id = cla->dev_id;
-		va_end(ap);
 	}
 
 	return &cla->cl;
 }
+
+#define clkdev_alloc_valist(_cl, _clk, _con_id, _dev_fmt, _ap)		\
+	do {								\
+		if (_dev_fmt)						\
+			va_start(_ap, _dev_fmt);			\
+									\
+		_cl = __clkdev_alloc_valist(_clk, _con_id, _dev_fmt,	\
+				_ap);					\
+									\
+		if (_dev_fmt)						\
+			va_end(ap);					\
+	} while (0);
+
+struct clk_lookup * __init_refok
+clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
+{
+	struct clk_lookup *cl;
+	va_list ap;
+
+	clkdev_alloc_valist(cl, clk, con_id, dev_fmt, ap);
+
+	return cl;
+}
 EXPORT_SYMBOL(clkdev_alloc);
 
 int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
@@ -223,3 +243,35 @@ void clkdev_drop(struct clk_lookup *cl)
 	kfree(cl);
 }
 EXPORT_SYMBOL(clkdev_drop);
+
+int clk_register_clkdev(struct clk *clk, const char *con_id,
+		const char *dev_fmt, ...)
+{
+	struct clk_lookup *cl;
+	va_list ap;
+
+	clkdev_alloc_valist(cl, clk, con_id, dev_fmt, ap);
+
+	if (!cl)
+		return -ENOMEM;
+
+	clkdev_add(cl);
+	return 0;
+}
+EXPORT_SYMBOL(clk_register_clkdev);
+
+int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num)
+{
+	unsigned i;
+
+	if (!clk)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++, cl++) {
+		cl->clk = clk;
+		clkdev_add(cl);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_register_clkdevs);
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index d9a4fd0..01d8ff6 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -39,5 +39,8 @@ void clkdev_drop(struct clk_lookup *cl);
 
 void clkdev_add_table(struct clk_lookup *, size_t);
 int clk_add_alias(const char *, const char *, char *, struct device *);
+int clk_register_clkdev(struct clk *clk, const char *con_id,
+		const char *dev_fmt, ...);
+int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num);
 
 #endif
-- 
1.7.9
