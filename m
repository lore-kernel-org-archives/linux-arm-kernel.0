From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Mon, 23 Jan 2017 17:53:19 -0800
Subject: [PATCH v2 2/2] remoteproc: Drop firmware_loading_complete
In-Reply-To: <1485222799-20769-1-git-send-email-spjoshi@codeaurora.org>
References: <1485222799-20769-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1485222799-20769-2-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

firmware_loading_complete is used to synchronize operations
on rproc while asynchronous firmware loading is in progress.
However, rproc_boot() no longer waits on
firmware_loading_complete. Hence drop this completion
variable altogether and handle the race between rproc_del()
and rproc_boot() using new state RPROC_DELETED.

The request_firmware_nowait() will hold the reference to
rproc device by using a get_device()/put_device(), so the
rproc struct will remain valid even when we return from
rproc_del() before the asynchronous call to
rproc_fw_config_virtio() completes.

CC: Loic Pallardy <loic.pallardy@st.com>
CC: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---

The current patch series is a v2 version of original patch listed at
https://lkml.org/lkml/2016/12/16/534

Changes from v1:

* Add new RPROC_DELETED state
* Use the new state RPROC_DELETED to handle race between rproc_del()
  and rproc_boot()

 drivers/remoteproc/remoteproc_core.c | 22 +++++++++++-----------
 include/linux/remoteproc.h           |  2 --
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 78200a7..f58e634 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -975,17 +975,12 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
 		rproc_boot(rproc);
 
 	release_firmware(fw);
-	/* allow rproc_del() contexts, if any, to proceed */
-	complete_all(&rproc->firmware_loading_complete);
 }
 
 static int rproc_add_virtio_devices(struct rproc *rproc)
 {
 	int ret;
 
-	/* rproc_del() calls must wait until async loader completes */
-	init_completion(&rproc->firmware_loading_complete);
-
 	/*
 	 * We must retrieve early virtio configuration info from
 	 * the firmware (e.g. whether to register a virtio device,
@@ -997,10 +992,8 @@ static int rproc_add_virtio_devices(struct rproc *rproc)
 	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
 				      rproc->firmware, &rproc->dev, GFP_KERNEL,
 				      rproc, rproc_fw_config_virtio);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&rproc->dev, "request_firmware_nowait err: %d\n", ret);
-		complete_all(&rproc->firmware_loading_complete);
-	}
 
 	return ret;
 }
@@ -1097,6 +1090,12 @@ static int __rproc_boot(struct rproc *rproc)
 		return ret;
 	}
 
+	if (rproc->state == RPROC_DELETED) {
+		ret = -ENODEV;
+		dev_err(dev, "can't boot deleted rproc %s\n", rproc->name);
+		goto unlock_mutex;
+	}
+
 	/* skip the boot process if rproc is already powered up */
 	if (atomic_inc_return(&rproc->power) > 1) {
 		ret = 0;
@@ -1481,14 +1480,15 @@ int rproc_del(struct rproc *rproc)
 	if (!rproc)
 		return -EINVAL;
 
-	/* if rproc is just being registered, wait */
-	wait_for_completion(&rproc->firmware_loading_complete);
-
 	/* if rproc is marked always-on, rproc_add() booted it */
 	/* TODO: make sure this works with rproc->power > 1 */
 	if (rproc->auto_boot)
 		rproc_shutdown(rproc);
 
+	mutex_lock(&rproc->lock);
+	rproc->state = RPROC_DELETED;
+	mutex_unlock(&rproc->lock);
+
 	rproc_delete_debug_dir(rproc);
 
 	/* the rproc is downref'ed as soon as it's removed from the klist */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 25a8c37..26328c4 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -399,7 +399,6 @@ enum rproc_crash_type {
  * @num_traces: number of trace buffers
  * @carveouts: list of physically contiguous memory allocations
  * @mappings: list of iommu mappings we initiated, needed on shutdown
- * @firmware_loading_complete: marks e/o asynchronous firmware loading
  * @bootaddr: address of first instruction to boot rproc with (optional)
  * @rvdevs: list of remote virtio devices
  * @subdevs: list of subdevices, to following the running state
@@ -430,7 +429,6 @@ struct rproc {
 	int num_traces;
 	struct list_head carveouts;
 	struct list_head mappings;
-	struct completion firmware_loading_complete;
 	u32 bootaddr;
 	struct list_head rvdevs;
 	struct list_head subdevs;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
