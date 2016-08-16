From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:19 -0700
Subject: [PATCH 13/14] rpmsg: Allow callback to return errors
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-14-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some rpmsg backends support holding on to and redelivering messages upon
failed handling of them, so provide a way for the callback to report and
error and allow the backends to handle this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++----
 include/linux/rpmsg.h            |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index d39e381bc596..9d681d68f7f3 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -785,8 +785,8 @@ static void rpmsg_xmit_done(struct virtqueue *svq)
 }
 
 /* invoked when a name service announcement arrives */
-static void rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
-			void *priv, u32 src)
+static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
+		       void *priv, u32 src)
 {
 	struct rpmsg_ns_msg *msg = data;
 	struct rpmsg_device *newch;
@@ -802,7 +802,7 @@ static void rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 
 	if (len != sizeof(*msg)) {
 		dev_err(dev, "malformed ns msg (%d)\n", len);
-		return;
+		return -EINVAL;
 	}
 
 	/*
@@ -813,7 +813,7 @@ static void rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 	 */
 	if (rpdev) {
 		dev_err(dev, "anomaly: ns ept has an rpdev handle\n");
-		return;
+		return -EINVAL;
 	}
 
 	/* don't trust the remote processor for null terminating the name */
@@ -836,6 +836,8 @@ static void rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 		if (!newch)
 			dev_err(dev, "rpmsg_create_channel failed\n");
 	}
+
+	return 0;
 }
 
 static int rpmsg_probe(struct virtio_device *vdev)
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index bdd1a2285733..19213e660a9b 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -46,7 +46,7 @@
 struct rpmsg_device;
 struct rpmsg_endpoint;
 
-typedef void (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
+typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
 
 /**
  * struct rpmsg_channel_info - internal channel info representation
@@ -123,7 +123,7 @@ struct rpmsg_driver {
 	const struct rpmsg_device_id *id_table;
 	int (*probe)(struct rpmsg_device *dev);
 	void (*remove)(struct rpmsg_device *dev);
-	void (*callback)(struct rpmsg_device *, void *, int, void *, u32);
+	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
 };
 
 int register_rpmsg_device(struct rpmsg_device *dev);
-- 
2.5.0
