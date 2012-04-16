From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 10:49:37 +0530
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs for
 given struct clk *
Message-ID: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
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
 drivers/clk/clkdev.c   |   33 +++++++++++++++++++++++++++++++++
 include/linux/clkdev.h |    3 +++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6db161f..6a98177 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -173,3 +173,36 @@ void clkdev_drop(struct clk_lookup *cl)
 	kfree(cl);
 }
 EXPORT_SYMBOL(clkdev_drop);
+
+int clk_register_single_clkdev(struct clk *clk, const char *dev_id,
+		const char *con_id)
+{
+	struct clk_lookup *cl;
+
+	if (!clk || (!dev_id && !con_id))
+		return -ENOMEM;
+
+	cl = clkdev_alloc(clk, con_id, "%s", dev_id);
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
+	if (!clk || !cl || !num)
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
index d9a4fd0..3579e0a 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -39,5 +39,8 @@ void clkdev_drop(struct clk_lookup *cl);
 
 void clkdev_add_table(struct clk_lookup *, size_t);
 int clk_add_alias(const char *, const char *, char *, struct device *);
+int clk_register_single_clkdev(struct clk *clk, const char *dev_id,
+		const char *con_id);
+int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num);
 
 #endif
-- 
1.7.9
