From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu, 15 Dec 2016 16:03:52 -0800
Subject: [PATCH 2/2] remoteproc: Remove firmware_loading_complete
In-Reply-To: <1481846632-4778-1-git-send-email-spjoshi@codeaurora.org>
References: <1481846632-4778-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1481846632-4778-2-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rproc_del() waits on firmware_loading_complete in order to
make sure rproc_add() completed successfully before calling
rproc_shutdown().  However since rproc_add() will always be
called before rproc_del(), we do not need to wait on
firmware_loading_complete. Drop this completion variable
altogether.

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---

Sending this patch again since I had missed usage of
firmware_loading_complete in drivers/soc/ti/wkup_m3_ipc.c

 drivers/remoteproc/remoteproc_core.c | 12 +-----------
 include/linux/remoteproc.h           |  2 --
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 953ee29..862fa4e 100644
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
@@ -1483,9 +1476,6 @@ int rproc_del(struct rproc *rproc)
 	if (!rproc)
 		return -EINVAL;
 
-	/* if rproc is just being registered, wait */
-	wait_for_completion(&rproc->firmware_loading_complete);
-
 	/* if rproc is marked always-on, rproc_add() booted it */
 	/* TODO: make sure this works with rproc->power > 1 */
 	if (rproc->auto_boot)
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e2f3a32..19d84a0 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -397,7 +397,6 @@ enum rproc_crash_type {
  * @num_traces: number of trace buffers
  * @carveouts: list of physically contiguous memory allocations
  * @mappings: list of iommu mappings we initiated, needed on shutdown
- * @firmware_loading_complete: marks e/o asynchronous firmware loading
  * @bootaddr: address of first instruction to boot rproc with (optional)
  * @rvdevs: list of remote virtio devices
  * @subdevs: list of subdevices, to following the running state
@@ -428,7 +427,6 @@ struct rproc {
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
