From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 19 May 2015 00:35:56 +0200
Subject: [PATCH v3 3/6] clk: add function to retrieve clk id from dt
In-Reply-To: <1431988559-23338-1-git-send-email-manabian@gmail.com>
References: <1431988559-23338-1-git-send-email-manabian@gmail.com>
Message-ID: <1431988559-23338-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_clk_get_index can be used to retrieve the clock index/id
from the device tree. This can be used in drivers to setup
routing between different clock devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/clk/clk.c            | 18 ++++++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 459ce9da13e0..39d4cfc98811 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3060,6 +3060,24 @@ const char *of_clk_get_parent_name(struct device_node *np, int index)
 }
 EXPORT_SYMBOL_GPL(of_clk_get_parent_name);
 
+int of_clk_get_index(struct device_node *np, int index)
+{
+	struct of_phandle_args clkspec;
+	int rc;
+
+	if (index < 0)
+		return -EINVAL;
+
+	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
+					&clkspec);
+	if (rc)
+		return -EINVAL;
+
+	of_node_put(clkspec.np);
+	return clkspec.args_count ? clkspec.args[0] : -EINVAL;
+}
+EXPORT_SYMBOL_GPL(of_clk_get_index);
+
 struct clock_provider {
 	of_clk_init_cb_t clk_init_cb;
 	struct device_node *np;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index df695313f975..70eed561319e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -625,6 +625,7 @@ struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
 int of_clk_get_parent_count(struct device_node *np);
 const char *of_clk_get_parent_name(struct device_node *np, int index);
+int of_clk_get_index(struct device_node *np, int index);
 
 void of_clk_init(const struct of_device_id *matches);
 
-- 
1.8.0
