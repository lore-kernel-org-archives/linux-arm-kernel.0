From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  8 Mar 2012 22:42:28 +0100
Subject: [PATCH 1/2] clk: Add helper to get/put arrays of clocks
In-Reply-To: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
References: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1331242949-22780-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/clkdev.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/clk.h  |    3 +++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6db161f..c661395 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -89,6 +89,42 @@ void clk_put(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_put);
 
+int clk_get_array(struct device *dev, struct clk **clks, const char **names,
+		int numclks, bool msg)
+{
+	int i, ret;
+
+	for (i = 0; i < numclks; i++) {
+		clks[i] = clk_get(dev, names[i]);
+		if (IS_ERR(clks[i])) {
+			if (msg)
+				dev_err(dev, "getting clock \"%s\" failed with %d\n",
+						names[i] ? names[i] : "",
+						PTR_ERR(clks[i]));
+			ret = PTR_ERR(clks[i]);
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	while (i > 0) {
+		i--;
+		clk_put(clks[i]);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(clk_get_array);
+
+void clk_put_array(struct clk **clks, int numclks)
+{
+	int i;
+
+	for (i = 0; i < numclks; i++)
+		clk_put(clks[i]);
+}
+EXPORT_SYMBOL(clk_put_array);
+
 void clkdev_add(struct clk_lookup *cl)
 {
 	mutex_lock(&clocks_mutex);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index b9d46fa..1584cbd 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -148,6 +148,9 @@ unsigned long clk_get_rate(struct clk *clk);
  */
 void clk_put(struct clk *clk);
 
+int clk_get_array(struct device *dev, struct clk **clks, const char **names,
+		int numclks, bool msg);
+void clk_put_array(struct clk **clks, int numclks);
 
 /*
  * The remaining APIs are optional for machine class support.
-- 
1.7.9.1
