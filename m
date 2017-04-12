From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 12:03:27 +0800
Subject: [RFC PATCH 1/3] clk: add clk_bulk_get accessories
In-Reply-To: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1491969809-20154-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These helper function allows drivers to get several clk consumers in
one operation.  If any of the clk cannot be acquired then any clks
that were got will be put before returning to the caller.

This can relieve the driver owners' life who needs to handle many clocks,
as well as each clock error reporting.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Anson Huang <anson.huang@nxp.com>
Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Octavian Purdila <octavian.purdila@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk.c    |  99 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clkdev.c |  42 +++++++++++++++++++
 include/linux/clk.h  | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cddddbe..622f8069 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -520,6 +520,23 @@ void clk_unprepare(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_unprepare);
 
+/**
+ * clk_bulk_unprepare - undo preparation of a bulk of clock sources
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table being ungated
+ *
+ * clk_bulk_unprepare may sleep, which differentiates it from clk_bulk_disable.
+ * Returns 0 on success, -EERROR otherwise.
+ */
+void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
+{
+	int i;
+
+	for (i = 0; i < num_clks; i++)
+		clk_unprepare(clks[i].clk);
+}
+EXPORT_SYMBOL_GPL(clk_bulk_unprepare);
+
 static int clk_core_prepare(struct clk_core *core)
 {
 	int ret = 0;
@@ -584,6 +601,38 @@ int clk_prepare(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_prepare);
 
+/**
+ * clk_bulk_prepare - prepare a bulk of clocks
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table being ungated
+ *
+ * clk_bulk_prepare may sleep, which differentiates it from clk_bulk_enable.
+ * Returns 0 on success, -EERROR otherwise.
+ */
+
+int __must_check clk_bulk_prepare(int num_clks, struct clk_bulk_data *clks)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < num_clks; i++) {
+		ret = clk_prepare(clks[i].clk);
+		if (ret) {
+			pr_err("Failed to prepare clk '%s': %d\n",
+				clks[i].id, ret);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	while (--i >= 0)
+		clk_unprepare(clks[i].clk);
+
+	return  ret;
+}
+
 static void clk_core_disable(struct clk_core *core)
 {
 	lockdep_assert_held(&enable_lock);
@@ -640,6 +689,24 @@ void clk_disable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
+/**
+ * clk_bulk_disable - gate a bulk of clocks
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table being ungated
+ *
+ * clk_bulk_disable must not sleep, which differentiates it from
+ * clk_bulk_unprepare. clk_bulk_disable must be called before
+ * clk_bulk_unprepare.
+ */
+void clk_bulk_disable(int num_clks, struct clk_bulk_data *clks)
+{
+	int i;
+
+	for (i = 0; i < num_clks; i++)
+		clk_disable(clks[i].clk);
+}
+EXPORT_SYMBOL_GPL(clk_bulk_disable);
+
 static int clk_core_enable(struct clk_core *core)
 {
 	int ret = 0;
@@ -709,6 +776,38 @@ int clk_enable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_enable);
 
+/**
+ * clk_bulk_enable - ungate a bulk of clocks
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table being ungated
+ *
+ * clk_bulk_enable must not sleep
+ * Returns 0 on success, -EERROR otherwise.
+ */
+int clk_bulk_enable(int num_clks, struct clk_bulk_data *clks)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < num_clks; i++) {
+		ret = clk_enable(clks[i].clk);
+		if (ret) {
+			pr_err("Failed to enable clk '%s': %d\n",
+				clks[i].id, ret);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	while (--i >= 0)
+		clk_put(clks[i].clk);
+
+	return  ret;
+}
+EXPORT_SYMBOL_GPL(clk_bulk_enable);
+
 static int clk_core_prepare_enable(struct clk_core *core)
 {
 	int ret;
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index bb8a77a..141f2e6 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -209,12 +209,54 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL(clk_get);
 
+int clk_bulk_get(struct device *dev, int num_clks,
+		 struct clk_bulk_data *clks)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < num_clks; i++)
+		clks[i].clk = NULL;
+
+	for (i = 0; i < num_clks; i++) {
+		clks[i].clk = clk_get(dev, clks[i].id);
+		if (IS_ERR(clks[i].clk)) {
+			ret = PTR_ERR(clks[i].clk);
+			dev_err(dev, "Failed to get clk '%s': %d\n",
+				clks[i].id, ret);
+			clks[i].clk = NULL;
+			goto err;
+		}
+
+	}
+
+	return 0;
+
+err:
+	while (--i >= 0)
+		clk_put(clks[i].clk);
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_bulk_get);
+
 void clk_put(struct clk *clk)
 {
 	__clk_put(clk);
 }
 EXPORT_SYMBOL(clk_put);
 
+void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
+{
+	int i;
+
+	for (i = 0; i < num_clks; i++) {
+		clk_put(clks[i].clk);
+		clks[i].clk = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(clk_bulk_put);
+
 static void __clkdev_add(struct clk_lookup *cl)
 {
 	mutex_lock(&clocks_mutex);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index e9d36b3..1d05b66 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -77,6 +77,21 @@ struct clk_notifier_data {
 	unsigned long		new_rate;
 };
 
+/**
+ * struct clk_bulk_data - Data used for bulk clk operations.
+ *
+ * @id: clock consumer ID
+ * @clk: struct clk * to store the associated clock
+ *
+ * The CLK APIs provide a series of clk_bulk_() API calls as
+ * a convenience to consumers which require multiple clks.  This
+ * structure is used to manage data for these calls.
+ */
+struct clk_bulk_data {
+	const char		*id;
+	struct clk		*clk;
+};
+
 #ifdef CONFIG_COMMON_CLK
 
 /**
@@ -185,12 +200,19 @@ static inline bool clk_is_match(const struct clk *p, const struct clk *q)
  */
 #ifdef CONFIG_HAVE_CLK_PREPARE
 int clk_prepare(struct clk *clk);
+int __must_check clk_bulk_prepare(int num_clks, struct clk_bulk_data *clks);
 #else
 static inline int clk_prepare(struct clk *clk)
 {
 	might_sleep();
 	return 0;
 }
+
+static inline int clk_bulk_prepare(int num_clks, struct clk_bulk_data *clks)
+{
+	might_sleep();
+	return 0;
+}
 #endif
 
 /**
@@ -204,11 +226,16 @@ static inline int clk_prepare(struct clk *clk)
  */
 #ifdef CONFIG_HAVE_CLK_PREPARE
 void clk_unprepare(struct clk *clk);
+void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks);
 #else
 static inline void clk_unprepare(struct clk *clk)
 {
 	might_sleep();
 }
+static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
+{
+	might_sleep();
+}
 #endif
 
 #ifdef CONFIG_HAVE_CLK
@@ -230,6 +257,32 @@ static inline void clk_unprepare(struct clk *clk)
 struct clk *clk_get(struct device *dev, const char *id);
 
 /**
+ * clk_bulk_get - lookup and obtain a number of references to clock producer.
+ * @dev: device for clock "consumer"
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table of consumer
+ *
+ * This helper function allows drivers to get several clk consumers in one
+ * operation. If any of the clk cannot be acquired then any clks
+ * that were obtained will be freed before returning to the caller.
+ *
+ * Returns 0 if all clocks specified in clk_bulk_data table are obtained
+ * successfully, or valid IS_ERR() condition containing errno.
+ * The implementation uses @dev and @clk_bulk_data.id to determine the
+ * clock consumer, and thereby the clock producer.
+ * (IOW, @id may be identical strings, but clk_get may return different
+ * clock producers depending on @dev.) The clock returned is stored in
+ * each @clk_bulk_data.clk field.
+ *
+ * Drivers must assume that the clock source is not enabled.
+ *
+ * clk_bulk_get should not be called from within interrupt context.
+ */
+
+int __must_check clk_bulk_get(struct device *dev, int num_clks,
+			      struct clk_bulk_data *clks);
+
+/**
  * devm_clk_get - lookup and obtain a managed reference to a clock producer.
  * @dev: device for clock "consumer"
  * @id: clock consumer ID
@@ -279,6 +332,20 @@ struct clk *devm_get_clk_from_child(struct device *dev,
 int clk_enable(struct clk *clk);
 
 /**
+ * clk_bulk_enable - inform the system when the bulk of clock source should
+ *		     be running.
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table of consumer
+ *
+ * If the clock can not be enabled/disabled all, this should return success.
+ *
+ * May be called from atomic contexts.
+ *
+ * Returns success (0) or negative errno.
+ */
+int __must_check clk_bulk_enable(int num_clks, struct clk_bulk_data *clks);
+
+/**
  * clk_disable - inform the system when the clock source is no longer required.
  * @clk: clock source
  *
@@ -295,6 +362,24 @@ int clk_enable(struct clk *clk);
 void clk_disable(struct clk *clk);
 
 /**
+ * clk_bulk_disable - inform the system when the bulk of clock source is no
+ *		      longer required.
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table of consumer
+ *
+ * Inform the system that a bulk of clock source is no longer required by
+ * a driver and may be shut down.
+ *
+ * May be called from atomic contexts.
+ *
+ * Implementation detail: if the bulk of clock source is shared between
+ * multiple drivers, clk_bulk_enable() calls must be balanced by the
+ * same number of clk_bulk_disable() calls for the clock source to be
+ * disabled.
+ */
+void clk_bulk_disable(int num_clks, struct clk_bulk_data *clks);
+
+/**
  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
  *		  This is only valid once the clock source has been enabled.
  * @clk: clock source
@@ -314,6 +399,19 @@ unsigned long clk_get_rate(struct clk *clk);
 void clk_put(struct clk *clk);
 
 /**
+ * clk_bulk_put	- "free" the clock source
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table of consumer
+ *
+ * Note: drivers must ensure that all clk_bulk_enable calls made on this
+ * clock source are balanced by clk_bulk_disable calls prior to calling
+ * this function.
+ *
+ * clk_bulk_put should not be called from within interrupt context.
+ */
+void clk_bulk_put(int num_clks, struct clk_bulk_data *clks);
+
+/**
  * devm_clk_put	- "free" a managed clock source
  * @dev: device used to acquire the clock
  * @clk: clock source acquired with devm_clk_get()
@@ -445,6 +543,12 @@ static inline struct clk *clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline int clk_bulk_get(struct device *dev, int num_clks,
+			       struct clk_bulk_data *clks)
+{
+	return NULL;
+}
+
 static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 {
 	return NULL;
@@ -458,6 +562,8 @@ static inline struct clk *devm_get_clk_from_child(struct device *dev,
 
 static inline void clk_put(struct clk *clk) {}
 
+static inline void clk_bulk_put(int num_clks, struct clk_bulk_data *clks) {}
+
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
 
 static inline int clk_enable(struct clk *clk)
@@ -465,8 +571,17 @@ static inline int clk_enable(struct clk *clk)
 	return 0;
 }
 
+static inline int clk_bulk_enable(int num_clks, struct clk_bulk_data *clks)
+{
+	return 0;
+}
+
 static inline void clk_disable(struct clk *clk) {}
 
+
+static inline void clk_bulk_disable(int num_clks,
+				    struct clk_bulk_data *clks) {}
+
 static inline unsigned long clk_get_rate(struct clk *clk)
 {
 	return 0;
-- 
2.7.4
