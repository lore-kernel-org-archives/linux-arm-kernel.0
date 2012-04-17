From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 09:18:54 +0530
Subject: [PATCH V3] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416205133.GW3852@pengutronix.de>
References: <20120416205133.GW3852@pengutronix.de>
Message-ID: <71de017a62f9c2032b25d44353df3f9be51e69a2.1334634063.git.viresh.kumar@st.com>
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
Arnd,

If this patch is acceptable to everybody, can you push it for v3.5?

V2->V3:
- Don't initialize ap to NULL, as this gives warnings on some compilers
- Create macro clkdev_alloc_valist() to avoid duplicate code.

 drivers/clk/clkdev.c   |   64 +++++++++++++++++++++++++++++++++++++++++++----
 include/linux/clkdev.h |    3 ++
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6db161f..9d93d27 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -116,8 +116,9 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
-struct clk_lookup * __init_refok
-clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
+static struct clk_lookup * __init_refok
+__clkdev_alloc_valist(struct clk *clk, const char *con_id, const char *dev_fmt,
+		va_list ap)
 {
 	struct clk_lookup_alloc *cla;
 
@@ -132,16 +133,35 @@ clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
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
@@ -173,3 +193,35 @@ void clkdev_drop(struct clk_lookup *cl)
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
