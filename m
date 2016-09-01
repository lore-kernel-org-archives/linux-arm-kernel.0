From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu,  1 Sep 2016 15:28:08 -0700
Subject: [PATCH v2 16/17] rpmsg: Allow callback to return errors
In-Reply-To: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1472768889-3906-17-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some rpmsg backends support holding on to and redelivering messages upon
failed handling of them, so provide a way for the callback to report and
error and allow the backends to handle this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/rpmsg/virtio_rpmsg_bus.c    | 10 ++++++----
 include/linux/rpmsg.h               |  4 ++--
 samples/rpmsg/rpmsg_client_sample.c |  6 ++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 671cb1803431..3090b0d3072f 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -791,8 +791,8 @@ static void rpmsg_xmit_done(struct virtqueue *svq)
 }
 
 /* invoked when a name service announcement arrives */
-static void rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
-			void *priv, u32 src)
+static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
+		       void *priv, u32 src)
 {
 	struct rpmsg_ns_msg *msg = data;
 	struct rpmsg_device *newch;
@@ -808,7 +808,7 @@ static void rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 
 	if (len != sizeof(*msg)) {
 		dev_err(dev, "malformed ns msg (%d)\n", len);
-		return;
+		return -EINVAL;
 	}
 
 	/*
@@ -819,7 +819,7 @@ static void rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 	 */
 	if (rpdev) {
 		dev_err(dev, "anomaly: ns ept has an rpdev handle\n");
-		return;
+		return -EINVAL;
 	}
 
 	/* don't trust the remote processor for null terminating the name */
@@ -842,6 +842,8 @@ static void rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 		if (!newch)
 			dev_err(dev, "rpmsg_create_channel failed\n");
 	}
+
+	return 0;
 }
 
 static int rpmsg_probe(struct virtio_device *vdev)
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 71b16d37503a..452d393cc8dd 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -80,7 +80,7 @@ struct rpmsg_device {
 	const struct rpmsg_device_ops *ops;
 };
 
-typedef void (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
+typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
 
 /**
  * struct rpmsg_endpoint - binds a local rpmsg address to its user
@@ -129,7 +129,7 @@ struct rpmsg_driver {
 	const struct rpmsg_device_id *id_table;
 	int (*probe)(struct rpmsg_device *dev);
 	void (*remove)(struct rpmsg_device *dev);
-	void (*callback)(struct rpmsg_device *, void *, int, void *, u32);
+	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
 };
 
 int register_rpmsg_device(struct rpmsg_device *dev);
diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index 4fcd7ee13fb9..f161dfd3e70a 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -28,7 +28,7 @@ struct instance_data {
 	int rx_count;
 };
 
-static void rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
+static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 						void *priv, u32 src)
 {
 	int ret;
@@ -43,13 +43,15 @@ static void rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 	/* samples should not live forever */
 	if (idata->rx_count >= MSG_LIMIT) {
 		dev_info(&rpdev->dev, "goodbye!\n");
-		return;
+		return 0;
 	}
 
 	/* send a new message now */
 	ret = rpmsg_send(rpdev->ept, MSG, strlen(MSG));
 	if (ret)
 		dev_err(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
+
+	return 0;
 }
 
 static int rpmsg_sample_probe(struct rpmsg_device *rpdev)
-- 
2.5.0
