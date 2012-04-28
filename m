From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Apr 2012 12:06:35 +0100
Subject: [PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add
 clkdevs for given struct clk *
In-Reply-To: <20120428110108.GD20478@pengutronix.de>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0fb69ddb87f9a5e6a6afec2f833c6341e45763c7.1335249846.git.viresh.kumar@st.com>
 <20120426074746.GD24211@n2100.arm.linux.org.uk> <4F992369.2020308@st.com>
 <20120428095222.GP24211@n2100.arm.linux.org.uk>
 <20120428110108.GD20478@pengutronix.de>
Message-ID: <20120428110635.GQ24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 01:01:08PM +0200, Sascha Hauer wrote:
> On Sat, Apr 28, 2012 at 10:52:22AM +0100, Russell King - ARM Linux wrote:
> > +
> > +/**
> > + * clk_register_clkdev - register one clock lookup for a struct clk
> > + * @clk: struct clk to associate with all clk_lookups
> > + * @con_id: connection ID string on device
> > + * @dev_id: format string describing device name
> > + *
> > + * con_id or dev_id may be NULL as a wildcard, just as in the rest of
> > + * clkdev.
> > + *
> > + * To make things easier for mass registration, we detect the NULL clk
> > + * from a previous clk_register() call, and generate an error code for
> > + * that.  This is to permit this function to be called immediately after
> > + * clk_register().
> > + */
> > +int clk_register_clkdev(struct clk *clk, const char *con_id,
> > +	const char *dev_fmt, ...)
> > +{
> > +	struct clk_lookup *cl;
> > +	va_list ap;
> > +
> > +	if (!clk)
> > +		return -ENOMEM;
> 
> clk_register was recently changed to return ERR_PTR in Mikes branch.

That's something I was thinking about suggesting, so that the rules for
passing in 'struct clk' are the same as that for clk_get(), which makes
everything nicely symetrical.

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6db161f..2000c6b 100644
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
+ * To make things easier for mass registration, we detect error clks
+ * from a previous clk_register() call, and return the error code for
+ * those.  This is to permit this function to be called immediately after
+ * clk_register().
+ */
+int clk_register_clkdev(struct clk *clk, const char *con_id,
+	const char *dev_fmt, ...)
+{
+	struct clk_lookup *cl;
+	va_list ap;
+
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
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
+ * To make things easier for mass registration, we detect error clks
+ * from a previous clk_register() call, and return the error code for
+ * those.  This is to permit this function to be called immediately after
+ * clk_register().
+ */
+int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num)
+{
+	unsigned i;
+
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
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
