From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 16 Apr 2012 19:09:32 +0530
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416103822.GU24211@n2100.arm.linux.org.uk>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
Message-ID: <CAOh2x=kXeDOeZbAACOjKiwfdEniXkvAuFbrJ+rmgw=rq_gHQAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> Checking for NULL clk (or IS_ERR(clk)) and returning -ENOMEM does make
> sense as I mentioned in my original proposal (it allows you to pass the
> returned value from clk_register() directly to this function without
> further checking, and you get the right error code.

V2:

From: Russell King <rmk+kernel@arm.linux.org.uk>
CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *

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
index 6db161f..0a28374 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -116,8 +116,9 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };

-struct clk_lookup * __init_refok
-clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
+static struct clk_lookup * __init_refok
+clkdev_alloc_valist(struct clk *clk, const char *con_id, const char *dev_fmt,
+		va_list ap)
 {
 	struct clk_lookup_alloc *cla;

@@ -132,16 +133,29 @@ clkdev_alloc(struct clk *clk, const char
*con_id, const char *dev_fmt, ...)
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
+struct clk_lookup * __init_refok
+clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
+{
+	struct clk_lookup * cl;
+	va_list ap = NULL;
+
+	if (dev_fmt)
+		va_start(ap, dev_fmt);
+
+	cl = clkdev_alloc_valist(clk, con_id, dev_fmt, ap);
+
+	if (dev_fmt)
+		va_end(ap);
+
+	return cl;
+}
 EXPORT_SYMBOL(clkdev_alloc);

 int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
@@ -173,3 +187,41 @@ void clkdev_drop(struct clk_lookup *cl)
 	kfree(cl);
 }
 EXPORT_SYMBOL(clkdev_drop);
+
+int clk_register_single_clkdev(struct clk *clk, const char *con_id,
+		const char *dev_fmt, ...)
+{
+	struct clk_lookup * cl;
+	va_list ap = NULL;
+
+	if (dev_fmt)
+		va_start(ap, dev_fmt);
+
+	cl = clkdev_alloc_valist(clk, con_id, dev_fmt, ap);
+
+	if (dev_fmt)
+		va_end(ap);
+
+	if (!cl)
+		return -ENOMEM;
+
+	clkdev_add(cl);
+	return 0;
+}
+EXPORT_SYMBOL(clk_register_single_clkdev);
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
index d9a4fd0..49f8bd4 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -39,5 +39,8 @@ void clkdev_drop(struct clk_lookup *cl);

 void clkdev_add_table(struct clk_lookup *, size_t);
 int clk_add_alias(const char *, const char *, char *, struct device *);
+int clk_register_single_clkdev(struct clk *clk, const char *con_id,
+		const char *dev_fmt, ...);
+int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num);

 #endif
-- 
1.7.9
