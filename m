From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 26 Apr 2012 15:58:57 +0530
Subject: [PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add
 clkdevs for given struct clk *
In-Reply-To: <20120426074746.GD24211@n2100.arm.linux.org.uk>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0fb69ddb87f9a5e6a6afec2f833c6341e45763c7.1335249846.git.viresh.kumar@st.com>
 <20120426074746.GD24211@n2100.arm.linux.org.uk>
Message-ID: <4F992369.2020308@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/26/2012 1:17 PM, Russell King - ARM Linux wrote:
> This still causes additional warnings.  Having managed to get the build
> for various platforms down to zero warnings, we now have:
> 
> drivers/clk/clkdev.c: In function 'clkdev_alloc':
> drivers/clk/clkdev.c:209: warning: 'ap' may be used uninitialized in this function
> drivers/clk/clkdev.c: In function 'clk_register_clkdev':
> drivers/clk/clkdev.c:251: warning: 'ap' may be used uninitialized in this function

My compiler hasn't thrown any warnings :(
Please apply following patch. This should compile without errors.

From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Mon, 16 Apr 2012 10:43:17 +0530
Subject: [PATCH V4] CLKDEV: Add helper routines to allocate and add clkdevs for
 given struct clk *

With common clock framework, clks are allocated at runtime. Some of them require
clkdevs to be allocated and added in global clkdev list.

This patch introduces helper routines to:

 - allocate and add single clkdev for a single clk structure.
 - add multiple clkdevs for a single clk structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
V3->V4:
- Move code that filled dev_id to clkdev_alloc_valist macro.

 drivers/clk/clkdev.c   |   75 +++++++++++++++++++++++++++++++++++++++++------
 include/linux/clkdev.h |    3 ++
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index d4a5993..c890214 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -166,8 +166,8 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
-struct clk_lookup * __init_refok
-clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
+static struct clk_lookup_alloc * __init_refok
+__clkdev_alloc_set_conid(struct clk *clk, const char *con_id)
 {
 	struct clk_lookup_alloc *cla;
 
@@ -181,16 +181,40 @@ clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
 		cla->cl.con_id = cla->con_id;
 	}
 
-	if (dev_fmt) {
-		va_list ap;
+	return cla;
+}
 
-		va_start(ap, dev_fmt);
-		vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
-		cla->cl.dev_id = cla->dev_id;
-		va_end(ap);
-	}
+#define clkdev_alloc_valist(_cl, _clk, _con_id, _dev_fmt)		\
+	do {								\
+		struct clk_lookup_alloc *_cla;				\
+									\
+		_cla = __clkdev_alloc_set_conid(_clk, _con_id);		\
+		if (!_cla) {						\
+			_cl = NULL;					\
+			break;						\
+		}							\
+									\
+		_cl = &_cla->cl;					\
+									\
+		if (_dev_fmt) {						\
+			va_list _ap;					\
+									\
+			va_start(_ap, _dev_fmt);			\
+			vscnprintf(_cla->dev_id, sizeof(_cla->dev_id),	\
+					_dev_fmt, _ap);			\
+			_cl->dev_id = _cla->dev_id;			\
+			va_end(_ap);					\
+		}							\
+	} while (0);
+
+struct clk_lookup * __init_refok
+clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
+{
+	struct clk_lookup *cl;
 
-	return &cla->cl;
+	clkdev_alloc_valist(cl, clk, con_id, dev_fmt);
+
+	return cl;
 }
 EXPORT_SYMBOL(clkdev_alloc);
 
@@ -223,3 +247,34 @@ void clkdev_drop(struct clk_lookup *cl)
 	kfree(cl);
 }
 EXPORT_SYMBOL(clkdev_drop);
+
+int clk_register_clkdev(struct clk *clk, const char *con_id,
+		const char *dev_fmt, ...)
+{
+	struct clk_lookup *cl;
+
+	clkdev_alloc_valist(cl, clk, con_id, dev_fmt);
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



-- 
viresh
