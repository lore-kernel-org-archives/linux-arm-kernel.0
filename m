From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Apr 2016 15:21:55 -0700
Subject: [PATCH v2 04/13] clkdev: Add clk_hw based registration APIs
In-Reply-To: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1461277324-27185-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a clk registration API that doesn't return
struct clks, we need to have some way to hand out struct clks via
the clk_get() APIs that doesn't involve associating struct clk
pointers with a struct clk_lookup. Luckily, clkdev already
operates on struct clk_hw pointers, except for the registration
facing APIs where it converts struct clk pointers into struct
clk_hw pointers almost immediately.

Let's add clk_hw based registration APIs so that we can skip the
conversion step and provide a way for clk provider drivers to
operate exclusively on clk_hw structs. This way we clearly
split the API between consumers and providers.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clkdev.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clkdev.h |  6 +++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index ae8e40a82d34..89cc700fbc37 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -301,6 +301,20 @@ clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
 }
 EXPORT_SYMBOL(clkdev_alloc);
 
+struct clk_lookup *
+clkdev_hw_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt, ...)
+{
+	struct clk_lookup *cl;
+	va_list ap;
+
+	va_start(ap, dev_fmt);
+	cl = vclkdev_alloc(hw, con_id, dev_fmt, ap);
+	va_end(ap);
+
+	return cl;
+}
+EXPORT_SYMBOL(clkdev_hw_alloc);
+
 /**
  * clkdev_create - allocate and add a clkdev lookup structure
  * @clk: struct clk to associate with all clk_lookups
@@ -324,6 +338,29 @@ struct clk_lookup *clkdev_create(struct clk *clk, const char *con_id,
 }
 EXPORT_SYMBOL_GPL(clkdev_create);
 
+/**
+ * clkdev_hw_create - allocate and add a clkdev lookup structure
+ * @hw: struct clk_hw to associate with all clk_lookups
+ * @con_id: connection ID string on device
+ * @dev_fmt: format string describing device name
+ *
+ * Returns a clk_lookup structure, which can be later unregistered and
+ * freed.
+ */
+struct clk_lookup *clkdev_hw_create(struct clk_hw *hw, const char *con_id,
+	const char *dev_fmt, ...)
+{
+	struct clk_lookup *cl;
+	va_list ap;
+
+	va_start(ap, dev_fmt);
+	cl = vclkdev_create(hw, con_id, dev_fmt, ap);
+	va_end(ap);
+
+	return cl;
+}
+EXPORT_SYMBOL_GPL(clkdev_hw_create);
+
 int clk_add_alias(const char *alias, const char *alias_dev_name,
 	const char *con_id, struct device *dev)
 {
@@ -402,3 +439,30 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
 	return cl ? 0 : -ENOMEM;
 }
 EXPORT_SYMBOL(clk_register_clkdev);
+
+/**
+ * clk_hw_register_clkdev - register one clock lookup for a struct clk_hw
+ * @hw: struct clk_hw to associate with all clk_lookups
+ * @con_id: connection ID string on device
+ * @dev_id: format string describing device name
+ *
+ * con_id or dev_id may be NULL as a wildcard, just as in the rest of
+ * clkdev.
+ */
+int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
+	const char *dev_id)
+{
+	struct clk_lookup *cl;
+
+	/*
+	 * Since dev_id can be NULL, and NULL is handled specially, we must
+	 * pass it as either a NULL format string, or with "%s".
+	 */
+	if (dev_id)
+		cl = __clk_register_clkdev(hw, con_id, "%s", dev_id);
+	else
+		cl = __clk_register_clkdev(hw, con_id, NULL);
+
+	return cl ? 0 : -ENOMEM;
+}
+EXPORT_SYMBOL(clk_hw_register_clkdev);
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index e6f8eb1d585f..2eabc862abdb 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -15,6 +15,7 @@
 #include <asm/clkdev.h>
 
 struct clk;
+struct clk_hw;
 struct device;
 
 struct clk_lookup {
@@ -34,17 +35,22 @@ struct clk_lookup {
 
 struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
 	const char *dev_fmt, ...) __printf(3, 4);
+struct clk_lookup *clkdev_hw_alloc(struct clk_hw *hw, const char *con_id,
+	const char *dev_fmt, ...) __printf(3, 4);
 
 void clkdev_add(struct clk_lookup *cl);
 void clkdev_drop(struct clk_lookup *cl);
 
 struct clk_lookup *clkdev_create(struct clk *clk, const char *con_id,
 	const char *dev_fmt, ...) __printf(3, 4);
+struct clk_lookup *clkdev_hw_create(struct clk_hw *hw, const char *con_id,
+	const char *dev_fmt, ...) __printf(3, 4);
 
 void clkdev_add_table(struct clk_lookup *, size_t);
 int clk_add_alias(const char *, const char *, const char *, struct device *);
 
 int clk_register_clkdev(struct clk *, const char *, const char *);
+int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
 
 #ifdef CONFIG_COMMON_CLK
 int __clk_get(struct clk *clk);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
