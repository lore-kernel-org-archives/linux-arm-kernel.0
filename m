From: jlu@pengutronix.de (Jan Luebbe)
Date: Fri, 30 Jun 2017 16:51:05 +0200
Subject: [PATCH 7/8] EDAC: Add devres helpers for
 edac_device_alloc_ctl_info/edac_device_add_device
In-Reply-To: <20170630145106.29820-1-jlu@pengutronix.de>
References: <20170630145106.29820-1-jlu@pengutronix.de>
Message-ID: <20170630145106.29820-8-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These helpers simplify error handling in the _probe functions and
automate deallocation in the _remove functions.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 drivers/edac/edac_device.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/edac_device.h | 29 +++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 65cf2b9355c4..bfc4144840cf 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -232,6 +232,41 @@ void edac_device_free_ctl_info(struct edac_device_ctl_info *ctl_info)
 }
 EXPORT_SYMBOL_GPL(edac_device_free_ctl_info);
 
+/**
+ * devm_edac_device_free_ctl_info() - Internal helper to call
+ *	edac_device_free_ctl_info from a devres action
+ */
+static void devm_edac_device_free_ctl_info(void *ctl_info)
+{
+	edac_device_free_ctl_info((struct edac_device_ctl_info *)ctl_info);
+}
+
+struct edac_device_ctl_info *devm_edac_device_alloc_ctl_info(
+	struct device *dev,
+	unsigned sz_private,
+	char *edac_device_name, unsigned nr_instances,
+	char *edac_block_name, unsigned nr_blocks,
+	unsigned offset_value,
+	struct edac_dev_sysfs_block_attribute *attrib_spec, unsigned nr_attrib,
+	int device_index)
+{
+	struct edac_device_ctl_info *ctl_info;
+	ctl_info = edac_device_alloc_ctl_info(sz_private,
+			edac_device_name, nr_instances,
+			edac_block_name, nr_blocks,
+			offset_value,
+			attrib_spec, nr_attrib,
+			device_index);
+	if (!ctl_info)
+		return ctl_info;
+
+	if (devm_add_action_or_reset(dev, devm_edac_device_free_ctl_info, ctl_info))
+		return NULL;
+
+	return ctl_info;
+}
+EXPORT_SYMBOL_GPL(devm_edac_device_alloc_ctl_info);
+
 /*
  * find_edac_device_by_dev
  *	scans the edac_device list for a specific 'struct device *'
@@ -539,6 +574,30 @@ struct edac_device_ctl_info *edac_device_del_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(edac_device_del_device);
 
+/**
+ * devm_edac_device_del_device() - Internal helper to call
+ *	edac_device_del_device from a devres action
+ */
+static void devm_edac_device_del_device(void *dev)
+{
+	edac_device_del_device((struct device *)dev);
+}
+
+int devm_edac_device_add_device(struct device *dev,
+		struct edac_device_ctl_info *edac_dev)
+{
+	int ret;
+
+	ret = edac_device_add_device(edac_dev);
+	if (ret)
+		return ret;
+
+	if (devm_add_action_or_reset(dev, devm_edac_device_del_device, dev))
+		return 1;
+
+	return 0;
+}
+
 static inline int edac_device_get_log_ce(struct edac_device_ctl_info *edac_dev)
 {
 	return edac_dev->log_ce;
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 1aaba74ae411..73f7b98e8ec0 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -258,6 +258,24 @@ extern struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 extern void edac_device_free_ctl_info(struct edac_device_ctl_info *ctl_info);
 
 /**
+ * devm_edac_device_alloc_ctl_info: Allocate a new managed edac device
+ *	control info structure
+ *
+ *	This function takes the same arguments as edac_device_alloc_ctl_info in
+ *	addition to the owning device. The structure is freed by devres using
+ *	edac_device_free_ctl_info.
+ */
+extern struct edac_device_ctl_info *devm_edac_device_alloc_ctl_info(
+		struct device *dev,
+		unsigned sizeof_private,
+		char *edac_device_name, unsigned nr_instances,
+		char *edac_block_name, unsigned nr_blocks,
+		unsigned offset_value,
+		struct edac_dev_sysfs_block_attribute *block_attributes,
+		unsigned nr_attribs,
+		int device_index);
+
+/**
  * edac_device_add_device: Insert the 'edac_dev' structure into the
  *	 edac_device global list and create sysfs entries associated with
  *	 edac_device structure.
@@ -286,6 +304,17 @@ extern int edac_device_add_device(struct edac_device_ctl_info *edac_dev);
 extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
 
 /**
+ * devm_edac_device_add_device:
+ *	Helper to call edac_device_add_device and register it for cleanup with
+ *	devres.
+ *
+ * Returns:
+ *	0 on Success, or an error code on failure
+ */
+extern int devm_edac_device_add_device(struct device *dev,
+				       struct edac_device_ctl_info *edac_dev);
+
+/**
  * edac_device_handle_ue():
  *	perform a common output and handling of an 'edac_dev' UE event
  *
-- 
2.11.0
