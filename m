From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  6 Jul 2016 09:54:36 +0100
Subject: [PATCH v6 18/18] remoteproc: core: Retry rproc_fw_config_virtio() if
 !rproc->table_ptr
In-Reply-To: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
References: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1467795276-21725-19-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When rproc drivers are built-in the async firmware load done by rproc_add()
can fail due to the firmware not being present. Subsqeuent calls to
rproc_fw_boot() then fail, even though by this point firmware has been
successfully obtained.

This patch changes the behaviour to re-execute rproc_fw_config_virtio()
in rproc_fw_boot() if it has previously failed, and we are sure it is
now available.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c     | 25 +++++++++++++++++++------
 drivers/remoteproc/remoteproc_internal.h |  3 +++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index db3958b..749f261 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -801,8 +801,12 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	struct resource_table *table, *loaded_table;
 	int ret, tablesz;
 
+	/*
+	 * This can happen when built-in if initial async fw load fails.
+	 * However we now have firmware available so retry.
+	 */
 	if (!rproc->table_ptr)
-		return -ENOMEM;
+		rproc_fw_config_virtio(fw, rproc);
 
 	ret = rproc_fw_sanity_check(rproc, fw);
 	if (ret)
@@ -895,9 +899,20 @@ clean_up:
  * to unregister the device. one other option is just to use kref here,
  * that might be cleaner).
  */
-static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
+
+static void rproc_fw_config_virtio_cb(const struct firmware *fw, void *context)
 {
 	struct rproc *rproc = context;
+
+	rproc_fw_config_virtio(fw, rproc);
+
+	release_firmware(fw);
+	/* allow rproc_del() contexts, if any, to proceed */
+	complete_all(&rproc->firmware_loading_complete);
+}
+
+static void rproc_fw_config_virtio(const struct firmware *fw, struct rproc *rproc)
+{
 	struct resource_table *table;
 	int ret, tablesz;
 
@@ -934,9 +949,7 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
 	ret = rproc_handle_resources(rproc, tablesz, rproc_vdev_handler);
 
 out:
-	release_firmware(fw);
-	/* allow rproc_del() contexts, if any, to proceed */
-	complete_all(&rproc->firmware_loading_complete);
+	return;
 }
 
 static int rproc_add_virtio_devices(struct rproc *rproc)
@@ -956,7 +969,7 @@ static int rproc_add_virtio_devices(struct rproc *rproc)
 	 */
 	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
 				      rproc->firmware, &rproc->dev, GFP_KERNEL,
-				      rproc, rproc_fw_config_virtio);
+				      rproc, rproc_fw_config_virtio_cb);
 	if (ret < 0) {
 		dev_err(&rproc->dev, "request_firmware_nowait err: %d\n", ret);
 		complete_all(&rproc->firmware_loading_complete);
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 57e1de5..39916c1 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -49,6 +49,9 @@ struct rproc_fw_ops {
 void rproc_release(struct kref *kref);
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
 int rproc_boot_nowait(struct rproc *rproc);
+static void rproc_fw_config_virtio_cb(const struct firmware *fw, void *context);
+static void rproc_fw_config_virtio(const struct firmware *fw, struct rproc *rproc);
+
 
 /* from remoteproc_virtio.c */
 int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id);
-- 
1.9.1
