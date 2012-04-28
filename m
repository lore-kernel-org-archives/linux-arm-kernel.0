From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Apr 2012 10:52:22 +0100
Subject: [PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add
 clkdevs for given struct clk *
In-Reply-To: <4F992369.2020308@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0fb69ddb87f9a5e6a6afec2f833c6341e45763c7.1335249846.git.viresh.kumar@st.com>
 <20120426074746.GD24211@n2100.arm.linux.org.uk> <4F992369.2020308@st.com>
Message-ID: <20120428095222.GP24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 03:58:57PM +0530, Viresh Kumar wrote:
> My compiler hasn't thrown any warnings :(
> Please apply following patch. This should compile without errors.
> 
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Date: Mon, 16 Apr 2012 10:43:17 +0530
> Subject: [PATCH V4] CLKDEV: Add helper routines to allocate and add clkdevs for
>  given struct clk *
> 
> With common clock framework, clks are allocated at runtime. Some of them require
> clkdevs to be allocated and added in global clkdev list.
> 
> This patch introduces helper routines to:
> 
>  - allocate and add single clkdev for a single clk structure.
>  - add multiple clkdevs for a single clk structure.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

I don't like that macro in there, I think it's unnecessary.  What about
the below, which I've built here and it builds fine.

As for va_start(ap, dev_fmt) when dev_fmt is NULL, that's perfectly fine
- the requirement for va_start() is that it is called with the argument
preceding the variable list of function arguments signified by '...'.
That's still true when dev_fmt is NULL (hint: the compiler doesn't know
at build time if dev_fmt was passed into this function as a NULL pointer
or a real pointer, so it's going to generate code which works for non-NULL
pointers.  If the pointer _is_ NULL, then we don't touch 'ap' other than
its initialization and finalization via the standard functions.)

Plus, I've added commentry to these two new functions because there's
an important point that needs to be conveyed (the fact that they do the
error handling for clk_register()).

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6db161f..f5db067 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -116,8 +116,9 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
-struct clk_lookup * __init_refok
-clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
+static struct clk_lookup * __init_refok
+vclkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt,
+	va_list ap)
 {
 	struct clk_lookup_alloc *cla;
 
@@ -132,16 +133,25 @@ clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
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
+	struct clk_lookup *cl;
+	va_list ap;
+
+	va_start(ap, dev_fmt);
+	cl = vclkdev_alloc(clk, con_id, dev_fmt, ap);
+	va_end(ap);
+
+	return cl;
+}
 EXPORT_SYMBOL(clkdev_alloc);
 
 int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
@@ -173,3 +183,65 @@ void clkdev_drop(struct clk_lookup *cl)
 	kfree(cl);
 }
 EXPORT_SYMBOL(clkdev_drop);
+
+/**
+ * clk_register_clkdev - register one clock lookup for a struct clk
+ * @clk: struct clk to associate with all clk_lookups
+ * @con_id: connection ID string on device
+ * @dev_id: format string describing device name
+ *
+ * con_id or dev_id may be NULL as a wildcard, just as in the rest of
+ * clkdev.
+ *
+ * To make things easier for mass registration, we detect the NULL clk
+ * from a previous clk_register() call, and generate an error code for
+ * that.  This is to permit this function to be called immediately after
+ * clk_register().
+ */
+int clk_register_clkdev(struct clk *clk, const char *con_id,
+	const char *dev_fmt, ...)
+{
+	struct clk_lookup *cl;
+	va_list ap;
+
+	if (!clk)
+		return -ENOMEM;
+
+	va_start(ap, dev_fmt);
+	cl = vclkdev_alloc(clk, con_id, dev_fmt, ap);
+	va_end(ap);
+
+	if (!cl)
+		return -ENOMEM;
+
+	clkdev_add(cl);
+
+	return 0;
+}
+
+/**
+ * clk_register_clkdevs - register a set of clk_lookup for a struct clk
+ * @clk: struct clk to associate with all clk_lookups
+ * @cl: array of clk_lookup structures with con_id and dev_id pre-initialized
+ * @num: number of clk_lookup structures to register
+ *
+ * To make things easier for mass registration, we detect the NULL clk
+ * from a previous clk_register() call, and generate an error code for
+ * that.  This is to permit this function to be called immediately after
+ * clk_register().
+ */
+int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num)
+{
+	unsigned i;
+
+	if (!clk)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		cl->clk = clk;
+		clkdev_add(cl);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_register_clkdevs);
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index d9a4fd0..a6a6f60 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -40,4 +40,7 @@ void clkdev_drop(struct clk_lookup *cl);
 void clkdev_add_table(struct clk_lookup *, size_t);
 int clk_add_alias(const char *, const char *, char *, struct device *);
 
+int clk_register_clkdev(struct clk *, const char *, const char *, ...);
+int clk_register_clkdevs(struct clk *, struct clk_lookup *, size_t);
+
 #endif
