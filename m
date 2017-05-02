From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Tue,  2 May 2017 13:59:01 -0700
Subject: [PATCH 1/2] remoteproc: Introduce rproc_{start,stop}() functions
Message-ID: <1493758742-26148-1-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the context of recovering from crash,
rproc_trigger_recovery() does rproc_shutdown() followed
by rproc_boot(). The remoteproc resources are cleaned up
in rproc_shutdown() and immediately reallocated in
rproc_boot() which is an unnecessary overhead.

Furthermore, we want the memory regions to be accessible
after stopping the remote processor, to be able to extract
the memory content for a coredump.

The current patch factors out the code in rproc_boot() and
rproc_shutdown() path and introduces rproc_{start,stop}()
in order to avoid resource allocation overhead.

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---

I had forgot to send the second patch (2/2) in this series earlier.
Hence resending both patches as a series.

 drivers/remoteproc/remoteproc_core.c | 118 ++++++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 9fd9ca5..169abb3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -851,6 +851,61 @@ static void rproc_resource_cleanup(struct rproc *rproc)
 		kref_put(&rvdev->refcount, rproc_vdev_release);
 }
 
+static int rproc_start(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = &rproc->dev;
+	struct resource_table *table, *loaded_table;
+	int ret, tablesz;
+
+	/* look for the resource table */
+	table = rproc_find_rsc_table(rproc, fw, &tablesz);
+	if (!table) {
+		dev_err(dev, "Resouce table look up failed\n");
+		return -EINVAL;
+	}
+
+	/* load the ELF segments to memory */
+	ret = rproc_load_segments(rproc, fw);
+	if (ret) {
+		dev_err(dev, "Failed to load program segments: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * The starting device has been given the rproc->table_ptr as the
+	 * resource table. The address of the vring along with the other
+	 * allocated resources (carveouts etc) is stored in table_ptr.
+	 * In order to pass this information to the remote device we must copy
+	 * this information to device memory. We also update the table_ptr so
+	 * that any subsequent changes will be applied to the loaded version.
+	 */
+	loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
+	if (loaded_table)
+		memcpy(loaded_table, rproc->table_ptr, tablesz);
+
+	/* power up the remote processor */
+	ret = rproc->ops->start(rproc);
+	if (ret) {
+		dev_err(dev, "can't start rproc %s: %d\n", rproc->name, ret);
+		return ret;
+	}
+
+	/* probe any subdevices for the remote processor */
+	ret = rproc_probe_subdevices(rproc);
+	if (ret) {
+		dev_err(dev, "failed to probe subdevices for %s: %d\n",
+			rproc->name, ret);
+		rproc->ops->stop(rproc);
+		return ret;
+	}
+
+	rproc->state = RPROC_RUNNING;
+
+	dev_info(dev, "remote processor %s is now up\n", rproc->name);
+
+	return 0;
+}
+
 /*
  * take a firmware and boot a remote processor with it.
  */
@@ -993,6 +1048,32 @@ static int rproc_trigger_auto_boot(struct rproc *rproc)
 	return ret;
 }
 
+static int rproc_stop(struct rproc *rproc)
+{
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	/* remove any subdevices for the remote processor */
+	rproc_remove_subdevices(rproc);
+
+	/* power off the remote processor */
+	ret = rproc->ops->stop(rproc);
+	if (ret) {
+		dev_err(dev, "can't stop rproc: %d\n", ret);
+		return ret;
+	}
+
+	/* if in crash state, unlock crash handler */
+	if (rproc->state == RPROC_CRASHED)
+		complete_all(&rproc->crash_comp);
+
+	rproc->state = RPROC_OFFLINE;
+
+	dev_info(dev, "stopped remote processor %s\n", rproc->name);
+
+	return 0;
+}
+
 /**
  * rproc_trigger_recovery() - recover a remoteproc
  * @rproc: the remote processor
@@ -1005,23 +1086,44 @@ static int rproc_trigger_auto_boot(struct rproc *rproc)
  */
 int rproc_trigger_recovery(struct rproc *rproc)
 {
+	const struct firmware *firmware_p;
+	struct device *dev;
+	int ret;
+
 	dev_err(&rproc->dev, "recovering %s\n", rproc->name);
 
 	init_completion(&rproc->crash_comp);
 
-	/* shut down the remote */
-	/* TODO: make sure this works with rproc->power > 1 */
-	rproc_shutdown(rproc);
+	dev = &rproc->dev;
+
+	ret = mutex_lock_interruptible(&rproc->lock);
+	if (ret)
+		return ret;
+
+	ret = rproc_stop(rproc);
+	if (ret)
+		goto unlock_mutex;
 
 	/* wait until there is no more rproc users */
 	wait_for_completion(&rproc->crash_comp);
 
-	/*
-	 * boot the remote processor up again
-	 */
-	rproc_boot(rproc);
+	/* load firmware */
+	ret = request_firmware(&firmware_p, rproc->firmware, dev);
+	if (ret < 0) {
+		dev_err(dev, "request_firmware failed: %d\n", ret);
+		goto unlock_mutex;
+	}
 
-	return 0;
+	/* boot the remote processor up again */
+	ret = rproc_start(rproc, firmware_p);
+	if (ret)
+		goto unlock_mutex;
+
+	release_firmware(firmware_p);
+
+unlock_mutex:
+	mutex_unlock(&rproc->lock);
+	return ret;
 }
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
