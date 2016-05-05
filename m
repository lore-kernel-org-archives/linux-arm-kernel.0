From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 May 2016 14:29:41 +0100
Subject: [PATCH 3/5] remoteproc: core: Add ability to select a firmware from
 the client
In-Reply-To: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1462454983-13168-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST Co-Processors can be loaded with different firmwares to execute
specific tasks without the need for unloading the rproc module.

This patch provides a function which can update the firmware name.

NB: This can only happen if the rproc is offline.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 63 ++++++++++++++++++++++++++++++++++++
 include/linux/remoteproc.h           | 13 ++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 85e5fd8..03720c0 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1004,6 +1004,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
 
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
+	rproc->cached_table = NULL;
 
 	return rproc_add_virtio_devices(rproc);
 }
@@ -1329,6 +1330,66 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 EXPORT_SYMBOL(rproc_get_by_phandle);
 
 /**
+ * rproc_set_fw_name() - change rproc fw name
+ * @rproc: rproc handle
+ * @firmware: name of firmware file to load
+ *
+ * set a new firmware name for rproc handle
+ * firmware name can be updated only if the rproc is offline
+ * if firmware name is NULL the fw name is set on default name
+ *
+ * this function can wait, if the old fw config virtio is not yet finish
+ * (fw config request is asynchronous)
+ *
+ * Returns 0 on success and an appropriate error code otherwise.
+ */
+int rproc_set_fw_name(struct rproc *rproc, const char *firmware)
+{
+	struct rproc_vdev *rvdev, *rvtmp;
+
+	if (!rproc)
+		return -EINVAL;
+
+	/* if rproc is just being registered, wait */
+	wait_for_completion(&rproc->firmware_loading_complete);
+
+	mutex_lock(&rproc->lock);
+
+	if (rproc->state != RPROC_OFFLINE) {
+		mutex_unlock(&rproc->lock);
+		return -EBUSY;
+	}
+
+	if (rproc->firmware && rproc->firmware != rproc->orig_firmware)
+		kfree(rproc->firmware);
+
+	/* restore original fw name */
+	if (!firmware) {
+		rproc->firmware = rproc->orig_firmware;
+	} else {
+		rproc->firmware = kstrdup(firmware, GFP_KERNEL);
+		if (!rproc->firmware)
+			rproc->firmware = rproc->orig_firmware;
+	}
+
+	dev_info(&rproc->dev, "%s, fw name updated with:%s\n",
+		 rproc->name, rproc->firmware);
+
+	mutex_unlock(&rproc->lock);
+
+	/* clean up remote vdev entries */
+	list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node)
+		rproc_remove_virtio_dev(rvdev);
+
+	/* Free the copy of the resource table */
+	kfree(rproc->cached_table);
+	rproc->cached_table = NULL;
+
+	return rproc_add_virtio_devices(rproc);
+}
+EXPORT_SYMBOL(rproc_set_fw_name);
+
+/**
  * rproc_add() - register a remote processor
  * @rproc: the remote processor handle to register
  *
@@ -1467,6 +1528,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	}
 
 	rproc->firmware = p;
+	rproc->orig_firmware = p;
 	rproc->name = name;
 	rproc->ops = ops;
 	rproc->priv = &rproc[1];
@@ -1554,6 +1616,7 @@ int rproc_del(struct rproc *rproc)
 
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
+	rproc->cached_table = NULL;
 
 	/* the rproc is downref'ed as soon as it's removed from the klist */
 	mutex_lock(&rproc_list_mutex);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 4c96e78..978e866 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -414,6 +414,7 @@ struct rproc {
 	struct iommu_domain *domain;
 	const char *name;
 	const char *firmware;
+	const char *orig_firmware;
 	void *priv;
 	const struct rproc_ops *ops;
 	struct device dev;
@@ -484,6 +485,18 @@ struct rproc_vdev {
 	u32 rsc_offset;
 };
 
+struct rproc_subdev {
+	struct device dev;
+	struct rproc *rproc;
+	struct resource *res;
+};
+
+#define to_subdevice(d) container_of(d, struct rproc_subdev, dev)
+struct rproc_subdev *rproc_subdev_add(struct rproc *rproc,
+				      struct resource *res);
+void rproc_subdev_del(struct rproc_subdev *subdev);
+struct device *rproc_subdev_lookup(struct rproc *rproc, const char *name);
+int rproc_set_fw_name(struct rproc *rproc, const char *firmware);
 struct rproc *rproc_get_by_phandle(phandle phandle);
 struct rproc *rproc_alloc(struct device *dev, const char *name,
 				const struct rproc_ops *ops,
-- 
2.8.0
