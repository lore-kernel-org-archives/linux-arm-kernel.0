From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 12:03:28 +0800
Subject: [RFC PATCH 2/3] clk: add managed version of clk_bulk_get
In-Reply-To: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1491969809-20154-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the managed version of clk_bulk_get.

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
 drivers/clk/clk-devres.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 22 +++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 3a218c3..c7fb31d 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -34,6 +34,42 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(devm_clk_get);
 
+struct clk_bulk_devres {
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+static void devm_clk_bulk_release(struct device *dev, void *res)
+{
+	struct clk_bulk_devres *devres = res;
+
+	clk_bulk_put(devres->num_clks, devres->clks);
+}
+
+int devm_clk_bulk_get(struct device *dev, int num_clks,
+		      struct clk_bulk_data *clks)
+{
+	struct clk_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_clk_bulk_release,
+			      sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = clk_bulk_get(dev, num_clks, clks);
+	if (!ret) {
+		devres->clks = clks;
+		devres->num_clks = num_clks;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get);
+
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
 	struct clk **c = res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1d05b66..3fc6010 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -278,11 +278,25 @@ struct clk *clk_get(struct device *dev, const char *id);
  *
  * clk_bulk_get should not be called from within interrupt context.
  */
-
 int __must_check clk_bulk_get(struct device *dev, int num_clks,
 			      struct clk_bulk_data *clks);
 
 /**
+ * devm_clk_bulk_get - managed get multiple clk consumers
+ * @dev: device for clock "consumer"
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table of consumer
+ *
+ * Return 0 on success, an errno on failure.
+ *
+ * This helper function allows drivers to get several regulator
+ * consumers in one operation with management, the clks will
+ * automatically be freed when the device is unbound.
+ */
+int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
+				   struct clk_bulk_data *clks);
+
+/**
  * devm_clk_get - lookup and obtain a managed reference to a clock producer.
  * @dev: device for clock "consumer"
  * @id: clock consumer ID
@@ -554,6 +568,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline int devm_clk_bulk_get(struct device *dev, int num_clks,
+				    struct clk_bulk_data *clks)
+{
+	return NULL;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
-- 
2.7.4
