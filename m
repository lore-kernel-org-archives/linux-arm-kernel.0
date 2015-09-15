From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Sep 2015 05:37:08 +0000
Subject: [PATCH 2/3] drivers:remoteproc:support always on remote processor
In-Reply-To: <1442295429-19137-1-git-send-email-21cnbao@gmail.com>
References: <1442295429-19137-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1442295429-19137-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

In current rproc use scenarios, the Linux side controls
the lifecycle of the remote processors, just like boot,
start, shutdown.

But in some scenarios, we require the remote processors
to be powered and booted before Linux bring up. In
additional, we might have require the remote processors
could not be shutdown, if it would be shutdown, the Linux
should be shutdown too.

In above scenarios, we have make remoteproc to support
always on remote processor. This kind of remote processor
control its lifecycle by itself.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/remoteproc/remoteproc_core.c   | 5 +++++
 drivers/remoteproc/remoteproc_virtio.c | 8 ++++++++
 include/linux/remoteproc.h             | 4 +++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8f82417..2307a26 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -917,6 +917,10 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
 
 	rproc->table_csum = crc32(0, table, tablesz);
 
+	if (rproc->state == RPROC_ALWAYS_ON) {
+		rproc->table_ptr = table;
+		goto handl_res;
+	}
 	/*
 	 * Create a copy of the resource table. When a virtio device starts
 	 * and calls vring_new_virtqueue() the address of the allocated vring
@@ -929,6 +933,7 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
 
 	rproc->table_ptr = rproc->cached_table;
 
+handl_res:
 	/* count the number of notify-ids */
 	rproc->max_notifyid = -1;
 	ret = rproc_handle_resources(rproc, tablesz,
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index e1a1023..2eba600 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -138,9 +138,13 @@ static void rproc_virtio_del_vqs(struct virtio_device *vdev)
 {
 	struct rproc *rproc = vdev_to_rproc(vdev);
 
+	if (rproc->state == RPROC_ALWAYS_ON)
+		goto del_vqs;
+
 	/* power down the remote processor before deleting vqs */
 	rproc_shutdown(rproc);
 
+del_vqs:
 	__rproc_virtio_del_vqs(vdev);
 }
 
@@ -160,6 +164,10 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		}
 	}
 
+	/* always on rproc */
+	if (rproc->state == RPROC_ALWAYS_ON)
+		return 0;
+
 	/* now that the vqs are all set, boot the remote processor */
 	ret = rproc_boot(rproc);
 	if (ret) {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 9c4e138..9d783eb 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -346,6 +346,7 @@ struct rproc_ops {
  *			a message.
  * @RPROC_RUNNING:	device is up and running
  * @RPROC_CRASHED:	device has crashed; need to start recovery
+ * @RPROC_ALWAYS_ON:	device is always on, doesn't need to power on/off.
  * @RPROC_LAST:		just keep this one at the end
  *
  * Please note that the values of these states are used as indices
@@ -359,7 +360,8 @@ enum rproc_state {
 	RPROC_SUSPENDED	= 1,
 	RPROC_RUNNING	= 2,
 	RPROC_CRASHED	= 3,
-	RPROC_LAST	= 4,
+	RPROC_ALWAYS_ON = 4,
+	RPROC_LAST	= 5,
 };
 
 /**
-- 
1.9.1
