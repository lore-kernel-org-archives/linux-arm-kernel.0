From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:26 +0100
Subject: [RFC 08/15] clk: add restrack support
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-9-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clocks supports different methods of lookup.
The patch adds restrack support only to DT based clocks.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/clk/clk.c        |  6 ++++
 drivers/clk/clkdev.c     | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      |  3 ++
 include/linux/restrack.h |  1 +
 4 files changed, 84 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 4896ae9..2c50204 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/err.h>
 #include <linux/list.h>
+#include <linux/restrack.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/device.h>
@@ -2476,6 +2477,9 @@ int of_clk_add_provider(struct device_node *np,
 	ret = of_clk_set_defaults(np, true);
 	if (ret < 0)
 		of_clk_del_provider(np);
+	else
+		restrack_up(RESTRACK_TYPE_CLOCK, cp->node, cp);
+
 
 	return ret;
 }
@@ -2489,6 +2493,8 @@ void of_clk_del_provider(struct device_node *np)
 {
 	struct of_clk_provider *cp;
 
+	restrack_down(RESTRACK_TYPE_CLOCK, np, NULL);
+
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(cp, &of_clk_providers, link) {
 		if (cp->node == np) {
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index bd22750..2532ea1 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/of.h>
+#include <linux/restrack.h>
 
 #include "clk.h"
 
@@ -143,6 +144,79 @@ static int of_get_clock_spec(struct device *dev, const char *name,
 
 	return -ENOENT;
 }
+
+struct clk_restrack_desc {
+	struct clk **ptr;
+	const char *name;
+	struct of_phandle_args spec;
+	struct restrack_desc desc;
+};
+
+static int clk_restrack_init(struct device *dev,
+		struct restrack_desc *desc)
+{
+	struct clk_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+	int ret;
+
+	ret = of_get_clock_spec(dev, rd->name, &rd->spec);
+	if (!ret)
+		desc->if_id = rd->spec.np;
+	return ret;
+}
+
+static void clk_restrack_destroy(struct device *dev,
+		struct restrack_desc *desc)
+{
+	struct clk_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	of_node_put(desc->if_id);
+	kfree(rd);
+}
+
+static int clk_restrack_ifup(struct device *dev,
+		struct restrack_desc *desc, void *data)
+{
+	struct clk_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	*rd->ptr = of_clk_get_by_clkspec(&rd->spec);
+	return PTR_ERR_OR_ZERO(*rd->ptr);
+}
+
+static void clk_restrack_ifdown(struct device *dev,
+		struct restrack_desc *desc, void *data)
+{
+	struct clk_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	clk_put(*rd->ptr);
+	*rd->ptr = ERR_PTR(-EPROBE_DEFER);
+}
+
+static const struct restrack_ops clk_restrack_ops = {
+	.if_type = RESTRACK_TYPE_CLOCK,
+	.init = clk_restrack_init,
+	.destroy = clk_restrack_destroy,
+	.if_up = clk_restrack_ifup,
+	.if_down = clk_restrack_ifdown,
+};
+
+/**
+ * clk_restrack_desc - clock resource descriptor allocator
+ * @clk: pointer to variable which will be set to clock handle
+ * @name: name of clock
+ *
+ * The function creates resource description for clock, which shall be used
+ * by *restrack_register functions.
+ */
+struct restrack_desc *clk_restrack_desc(struct clk **clock, const char *name)
+{
+	struct clk_restrack_desc *rd;
+
+	RESTRACK_DESC_ALLOC(rd, clk_restrack_ops, clock, name);
+
+	return rd ? &rd->desc : ERR_PTR(-ENOMEM);
+}
+EXPORT_SYMBOL_GPL(clk_restrack_desc);
+
 #endif
 
 /*
diff --git a/include/linux/clk.h b/include/linux/clk.h
index c7f258a..28bad95 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -428,6 +428,9 @@ struct of_phandle_args;
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
+
+struct restrack_desc;
+struct restrack_desc *clk_restrack_desc(struct clk **clock, const char *name);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)
 {
diff --git a/include/linux/restrack.h b/include/linux/restrack.h
index e1aded0..6707dce 100644
--- a/include/linux/restrack.h
+++ b/include/linux/restrack.h
@@ -6,6 +6,7 @@
 #define RESTRACK_TYPE_DRM_PANEL 1
 #define RESTRACK_TYPE_REGULATOR 2
 #define RESTRACK_TYPE_GPIO 3
+#define RESTRACK_TYPE_CLOCK 4
 
 struct device;
 struct restrack_ctx;
-- 
1.9.1
