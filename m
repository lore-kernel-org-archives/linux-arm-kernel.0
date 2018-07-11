From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 11 Jul 2018 13:40:30 -0600
Subject: [PATCH 20/25] coresight: Add helper device type
In-Reply-To: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1531338035-11729-21-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add a new coresight device type, which do not belong to any
of the existing types, i.e, source, sink, link etc. A helper
device could be connected to a coresight device, which could
augment the functionality of the coresight device.

This is intended to cover Coresight Address Translation Unit (CATU)
devices, which provide improved Scatter Gather mechanism for TMC
ETR. The idea is that the helper device could be controlled by
the driver of the device it is attached to (in this case ETR),
transparent to the generic coresight driver (and paths).

The operations include enable(), disable(), both of which could
accept a device specific "data" which the driving device and
the helper device could share. Since they don't appear in the
coresight "path" tracked by software, we have to ensure that
they are powered up/down whenever the master device is turned
on.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 43 +++++++++++++++++++++++++++++++--
 include/linux/coresight.h               | 24 ++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 7f2b478a048f..3e07fd335f8c 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -425,6 +425,42 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
+/*
+ * coresight_grab_device - Power up this device and any of the helper
+ * devices connected to it for trace operation. Since the helper devices
+ * don't appear on the trace path, they should be handled along with the
+ * the master device.
+ */
+static void coresight_grab_device(struct coresight_device *csdev)
+{
+	int i;
+
+	for (i = 0; i < csdev->nr_outport; i++) {
+		struct coresight_device *child = csdev->conns[i].child_dev;
+
+		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
+			pm_runtime_get_sync(child->dev.parent);
+	}
+	pm_runtime_get_sync(csdev->dev.parent);
+}
+
+/*
+ * coresight_drop_device - Release this device and any of the helper
+ * devices connected to it.
+ */
+static void coresight_drop_device(struct coresight_device *csdev)
+{
+	int i;
+
+	pm_runtime_put(csdev->dev.parent);
+	for (i = 0; i < csdev->nr_outport; i++) {
+		struct coresight_device *child = csdev->conns[i].child_dev;
+
+		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
+			pm_runtime_put(child->dev.parent);
+	}
+}
+
 /**
  * _coresight_build_path - recursively build a path from a @csdev to a sink.
  * @csdev:	The device to start from.
@@ -473,9 +509,9 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	if (!node)
 		return -ENOMEM;
 
+	coresight_grab_device(csdev);
 	node->csdev = csdev;
 	list_add(&node->link, path);
-	pm_runtime_get_sync(csdev->dev.parent);
 
 	return 0;
 }
@@ -519,7 +555,7 @@ void coresight_release_path(struct list_head *path)
 	list_for_each_entry_safe(nd, next, path, link) {
 		csdev = nd->csdev;
 
-		pm_runtime_put_sync(csdev->dev.parent);
+		coresight_drop_device(csdev);
 		list_del(&nd->link);
 		kfree(nd);
 	}
@@ -770,6 +806,9 @@ static struct device_type coresight_dev_type[] = {
 		.name = "source",
 		.groups = coresight_source_groups,
 	},
+	{
+		.name = "helper",
+	},
 };
 
 static void coresight_device_release(struct device *dev)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 7c188c2a5b3c..3d40a2b135f1 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -40,6 +40,7 @@ enum coresight_dev_type {
 	CORESIGHT_DEV_TYPE_LINK,
 	CORESIGHT_DEV_TYPE_LINKSINK,
 	CORESIGHT_DEV_TYPE_SOURCE,
+	CORESIGHT_DEV_TYPE_HELPER,
 };
 
 enum coresight_dev_subtype_sink {
@@ -62,6 +63,10 @@ enum coresight_dev_subtype_source {
 	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
 };
 
+enum coresight_dev_subtype_helper {
+	CORESIGHT_DEV_SUBTYPE_HELPER_NONE,
+};
+
 /**
  * union coresight_dev_subtype - further characterisation of a type
  * @sink_subtype:	type of sink this component is, as defined
@@ -70,6 +75,8 @@ enum coresight_dev_subtype_source {
  *			by @coresight_dev_subtype_link.
  * @source_subtype:	type of source this component is, as defined
  *			by @coresight_dev_subtype_source.
+ * @helper_subtype:	type of helper this component is, as defined
+ *			by @coresight_dev_subtype_helper.
  */
 union coresight_dev_subtype {
 	/* We have some devices which acts as LINK and SINK */
@@ -78,6 +85,7 @@ union coresight_dev_subtype {
 		enum coresight_dev_subtype_link link_subtype;
 	};
 	enum coresight_dev_subtype_source source_subtype;
+	enum coresight_dev_subtype_helper helper_subtype;
 };
 
 /**
@@ -172,6 +180,7 @@ struct coresight_device {
 #define source_ops(csdev)	csdev->ops->source_ops
 #define sink_ops(csdev)		csdev->ops->sink_ops
 #define link_ops(csdev)		csdev->ops->link_ops
+#define helper_ops(csdev)	csdev->ops->helper_ops
 
 /**
  * struct coresight_ops_sink - basic operations for a sink
@@ -231,10 +240,25 @@ struct coresight_ops_source {
 			struct perf_event *event);
 };
 
+/**
+ * struct coresight_ops_helper - Operations for a helper device.
+ *
+ * All operations could pass in a device specific data, which could
+ * help the helper device to determine what to do.
+ *
+ * @enable	: Enable the device
+ * @disable	: Disable the device
+ */
+struct coresight_ops_helper {
+	int (*enable)(struct coresight_device *csdev, void *data);
+	int (*disable)(struct coresight_device *csdev, void *data);
+};
+
 struct coresight_ops {
 	const struct coresight_ops_sink *sink_ops;
 	const struct coresight_ops_link *link_ops;
 	const struct coresight_ops_source *source_ops;
+	const struct coresight_ops_helper *helper_ops;
 };
 
 #ifdef CONFIG_CORESIGHT
-- 
2.7.4
