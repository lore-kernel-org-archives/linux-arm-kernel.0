From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 19 May 2017 21:49:05 +0800
Subject: [PATCH V3 2/3] clk: add managed version of clk_bulk_get
In-Reply-To: <1495201746-31841-1-git-send-email-aisheng.dong@nxp.com>
References: <1495201746-31841-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1495201746-31841-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the managed version of clk_bulk_get.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
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
ChangeLog:
v2->v3: no changes
v1->v2: only one minor comment change
---
 drivers/clk/clk-devres.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 21 +++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 3a218c3..d854e26 100644
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
+int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
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
index 1201944..1ebccf3 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -281,6 +281,21 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 			      struct clk_bulk_data *clks);
 
 /**
+ * devm_clk_bulk_get - managed get multiple clk consumers
+ * @dev: device for clock "consumer"
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table of consumer
+ *
+ * Return 0 on success, an errno on failure.
+ *
+ * This helper function allows drivers to get several clk
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
@@ -550,6 +565,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline int devm_clk_bulk_get(struct device *dev, int num_clks,
+				    struct clk_bulk_data *clks)
+{
+	return 0;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
-- 
2.7.4
