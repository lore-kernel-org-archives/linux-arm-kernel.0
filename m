From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Tue, 24 Jan 2017 15:13:01 -0800
Subject: [PATCH 2/2] remoteproc: Modify the function names
In-Reply-To: <1485299581-30476-1-git-send-email-spjoshi@codeaurora.org>
References: <1485299581-30476-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1485299581-30476-2-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The functions rproc_add_virtio_devices() and
rproc_fw_config_virtio() are reduced to trigger auto-boot
only. Modify these function names and related comments to
reflect their current state.

This patch does not add any functional change.

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 16242b0..c6b1d4a 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -959,14 +959,14 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 }
 
 /*
- * take a firmware and look for virtio devices to register.
+ * take a firmware and boot it up.
  *
  * Note: this function is called asynchronously upon registration of the
  * remote processor (so we must wait until it completes before we try
  * to unregister the device. one other option is just to use kref here,
  * that might be cleaner).
  */
-static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
+static void rproc_auto_boot_callback(const struct firmware *fw, void *context)
 {
 	struct rproc *rproc = context;
 
@@ -975,21 +975,17 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
 	release_firmware(fw);
 }
 
-static int rproc_add_virtio_devices(struct rproc *rproc)
+static int rproc_trigger_auto_boot(struct rproc *rproc)
 {
 	int ret;
 
 	/*
-	 * We must retrieve early virtio configuration info from
-	 * the firmware (e.g. whether to register a virtio device,
-	 * what virtio features does it support, ...).
-	 *
 	 * We're initiating an asynchronous firmware loading, so we can
 	 * be built-in kernel code, without hanging the boot process.
 	 */
 	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
 				      rproc->firmware, &rproc->dev, GFP_KERNEL,
-				      rproc, rproc_fw_config_virtio);
+				      rproc, rproc_auto_boot_callback);
 	if (ret < 0)
 		dev_err(&rproc->dev, "request_firmware_nowait err: %d\n", ret);
 
@@ -1287,7 +1283,7 @@ int rproc_add(struct rproc *rproc)
 
 	/* if rproc is marked always-on, request it to boot */
 	if (rproc->auto_boot) {
-		ret = rproc_add_virtio_devices(rproc);
+		ret = rproc_trigger_auto_boot(rproc);
 		if (ret < 0)
 			return ret;
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
