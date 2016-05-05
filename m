From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 May 2016 14:29:39 +0100
Subject: [PATCH 1/5] remoteproc: core: Task sync during rproc_fw_boot()
In-Reply-To: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1462454983-13168-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, rproc_fw_boot() needs to wait for rproc to be configured,
but a race may occur when using rpmsg/virtio.  In this case, it can
be called locally in a safe manor.

This patch represents two usecases:

 - External call (via exported rproc_boot()), which waits
 - Internal call can use 'nowait' version of rproc_boot()

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c     | 29 +++++++++++++++++++++++++++--
 drivers/remoteproc/remoteproc_internal.h |  1 +
 drivers/remoteproc/remoteproc_virtio.c   |  2 +-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ee44df5..7db2818 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1033,8 +1033,9 @@ static void rproc_crash_handler_work(struct work_struct *work)
 }
 
 /**
- * rproc_boot() - boot a remote processor
+ * __rproc_boot() - boot a remote processor
  * @rproc: handle of a remote processor
+ * @wait: wait for rproc registration completion
  *
  * Boot a remote processor (i.e. load its firmware, power it on, ...).
  *
@@ -1043,7 +1044,7 @@ static void rproc_crash_handler_work(struct work_struct *work)
  *
  * Returns 0 on success, and an appropriate error value otherwise.
  */
-int rproc_boot(struct rproc *rproc)
+static int __rproc_boot(struct rproc *rproc, bool wait)
 {
 	const struct firmware *firmware_p;
 	struct device *dev;
@@ -1091,6 +1092,10 @@ int rproc_boot(struct rproc *rproc)
 		goto downref_rproc;
 	}
 
+	/* if rproc virtio is not yet configured, wait */
+	if (wait)
+		wait_for_completion(&rproc->firmware_loading_complete);
+
 	ret = rproc_fw_boot(rproc, firmware_p);
 
 	release_firmware(firmware_p);
@@ -1104,9 +1109,29 @@ unlock_mutex:
 	mutex_unlock(&rproc->lock);
 	return ret;
 }
+
+/**
+ * rproc_boot() - boot a remote processor
+ * @rproc: handle of a remote processor
+ */
+int rproc_boot(struct rproc *rproc)
+{
+	return __rproc_boot(rproc, true);
+}
 EXPORT_SYMBOL(rproc_boot);
 
 /**
+ * rproc_boot_nowait() - boot a remote processor
+ * @rproc: handle of a remote processor
+ *
+ * Same as rproc_boot() but don't wait for rproc registration completion
+ */
+int rproc_boot_nowait(struct rproc *rproc)
+{
+	return __rproc_boot(rproc, false);
+}
+
+/**
  * rproc_shutdown() - power off the remote processor
  * @rproc: the remote processor
  *
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 8041b95..57e1de5 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -48,6 +48,7 @@ struct rproc_fw_ops {
 /* from remoteproc_core.c */
 void rproc_release(struct kref *kref);
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
+int rproc_boot_nowait(struct rproc *rproc);
 
 /* from remoteproc_virtio.c */
 int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index ff30684..106d9e4 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -175,7 +175,7 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	}
 
 	/* now that the vqs are all set, boot the remote processor */
-	ret = rproc_boot(rproc);
+	ret = rproc_boot_nowait(rproc);
 	if (ret) {
 		dev_err(&rproc->dev, "rproc_boot() failed %d\n", ret);
 		goto error;
-- 
2.8.0
