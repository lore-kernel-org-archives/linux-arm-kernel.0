From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:22 +0100
Subject: [RFC 04/15] regulator: add restrack support
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-5-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regulators supports various methods of lookup.
The patch adds restrack support only to DT based regulators.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/regulator/core.c           | 77 ++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h | 10 +++++
 include/linux/restrack.h           |  1 +
 3 files changed, 88 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index cd87c0c..5641e85 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -32,6 +32,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/module.h>
+#include <linux/restrack.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/regulator.h>
@@ -3733,6 +3734,10 @@ add_dev:
 	rdev_init_debugfs(rdev);
 out:
 	mutex_unlock(&regulator_list_mutex);
+
+	if (rdev->dev.of_node)
+		restrack_up(RESTRACK_TYPE_REGULATOR, rdev->dev.of_node, rdev);
+
 	return rdev;
 
 unset_supplies:
@@ -3767,6 +3772,9 @@ void regulator_unregister(struct regulator_dev *rdev)
 	if (rdev == NULL)
 		return;
 
+	if (rdev->dev.of_node)
+		restrack_down(RESTRACK_TYPE_REGULATOR, rdev->dev.of_node, rdev);
+
 	if (rdev->supply) {
 		while (rdev->use_count--)
 			regulator_disable(rdev->supply);
@@ -3971,6 +3979,75 @@ static const struct file_operations supply_map_fops = {
 #endif
 };
 
+struct regulator_restrack_desc {
+	struct regulator **ptr;
+	const char *name;
+	struct restrack_desc desc;
+};
+
+static int regulator_restrack_init(struct device *dev,
+		struct restrack_desc *desc)
+{
+	struct regulator_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	desc->if_id = of_get_regulator(dev, rd->name);
+	return PTR_ERR_OR_ZERO(desc->if_id);
+}
+
+static void regulator_restrack_destroy(struct device *dev,
+		struct restrack_desc *desc)
+{
+	struct regulator_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	of_node_put(desc->if_id);
+	kfree(rd);
+}
+
+static int regulator_restrack_ifup(struct device *dev,
+		struct restrack_desc *desc, void *data)
+{
+	struct regulator_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	*rd->ptr = regulator_get(dev, rd->name);
+	return PTR_ERR_OR_ZERO(*rd->ptr);
+}
+
+static void regulator_restrack_ifdown(struct device *dev,
+		struct restrack_desc *desc, void *data)
+{
+	struct regulator_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	regulator_put(*rd->ptr);
+	*rd->ptr = ERR_PTR(-EPROBE_DEFER);
+}
+
+static const struct restrack_ops regulator_restrack_ops = {
+	.if_type = RESTRACK_TYPE_REGULATOR,
+	.init = regulator_restrack_init,
+	.destroy = regulator_restrack_destroy,
+	.if_up = regulator_restrack_ifup,
+	.if_down = regulator_restrack_ifdown,
+};
+
+/**
+ * regulator_restrack_desc - regulator resource descriptor allocator
+ * @regulator: pointer to variable which will be set to regulator handle
+ * @name: name of regulator
+ *
+ * The function creates resource description for regulator, which shall be used
+ * by *restrack_register functions.
+ */
+struct restrack_desc *regulator_restrack_desc(struct regulator **regulator,
+		const char *name)
+{
+	struct regulator_restrack_desc *rd;
+
+	RESTRACK_DESC_ALLOC(rd, regulator_restrack_ops, regulator, name);
+
+	return rd ? &rd->desc : ERR_PTR(-ENOMEM);
+}
+EXPORT_SYMBOL_GPL(regulator_restrack_desc);
+
 static int __init regulator_init(void)
 {
 	int ret;
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index f540b14..69e71ebb 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -551,4 +551,14 @@ static inline int regulator_is_supported_voltage_tol(struct regulator *regulator
 					      target_uV + tol_uV);
 }
 
+struct restrack_desc;
+struct restrack_desc *regulator_restrack_desc(struct regulator **regulator,
+		const char *supply);
+
+static inline struct restrack_desc *
+regulator_bulk_restrack_desc(struct regulator_bulk_data *data)
+{
+	return regulator_restrack_desc(&data->consumer, data->supply);
+}
+
 #endif
diff --git a/include/linux/restrack.h b/include/linux/restrack.h
index af5b617..4e4eec6 100644
--- a/include/linux/restrack.h
+++ b/include/linux/restrack.h
@@ -4,6 +4,7 @@
 #include <linux/track.h>
 
 #define RESTRACK_TYPE_DRM_PANEL 1
+#define RESTRACK_TYPE_REGULATOR 2
 
 struct device;
 struct restrack_ctx;
-- 
1.9.1
