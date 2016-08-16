From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:16 -0700
Subject: [PATCH 10/14] rpmsg: virtio: Internalize vrp pointer
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-11-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a container struct virtio_rpmsg_channel around the rpmsg_channel
to keep virtio backend information separate from the rpmsg and public
API.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 45 ++++++++++++++++++++++++++++++----------
 include/linux/rpmsg.h            |  3 ---
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index d08facbcd30a..6ad4c657aaf4 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -75,6 +75,21 @@ struct virtproc_info {
 	struct rpmsg_endpoint *ns_ept;
 };
 
+/**
+ * @vrp: the remote processor this channel belongs to
+ */
+struct virtio_rpmsg_channel {
+	struct rpmsg_channel rpch;
+
+	struct virtproc_info *vrp;
+};
+
+static inline struct virtio_rpmsg_channel *to_virtio_rpmsg_channel(struct device *d)
+{
+	struct rpmsg_channel *rpch = to_rpmsg_channel(d);
+	return container_of(rpch, struct virtio_rpmsg_channel, rpch);
+}
+
 /*
  * We're allocating buffers of 512 bytes each for communications. The
  * number of buffers will be computed from the number of buffers supported
@@ -191,7 +206,8 @@ static struct rpmsg_endpoint *virtio_rpmsg_create_ept(struct rpmsg_device *rpdev
 						      rpmsg_rx_cb_t cb,
 						      void *priv, u32 addr)
 {
-	return __rpmsg_create_ept(rpdev->vrp, rpdev, cb, priv, addr);
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(&rpdev->dev);
+	return __rpmsg_create_ept(vch->vrp, rpdev, cb, priv, addr);
 }
 
 /**
@@ -222,12 +238,14 @@ __rpmsg_destroy_ept(struct virtproc_info *vrp, struct rpmsg_endpoint *ept)
 
 static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
 {
-	__rpmsg_destroy_ept(ept->rpdev->vrp, ept);
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(&ept->rpdev->dev);
+	__rpmsg_destroy_ept(vch->vrp, ept);
 }
 
 static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 {
-	struct virtproc_info *vrp = rpdev->vrp;
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(&rpdev->dev);
+	struct virtproc_info *vrp = vch->vrp;
 	struct device *dev = &rpdev->dev;
 	int err = 0;
 
@@ -250,7 +268,8 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 
 static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 {
-	struct virtproc_info *vrp = rpdev->vrp;
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(&rpdev->dev);
+	struct virtproc_info *vrp = vch->vrp;
 	struct device *dev = &rpdev->dev;
 	int err = 0;
 
@@ -292,7 +311,7 @@ static const struct rpmsg_channel virtio_rpmsg_ops = {
 static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 						 struct rpmsg_channel_info *chinfo)
 {
-	struct rpmsg_channel *rpch;
+	struct virtio_rpmsg_channel *vch;
 	struct rpmsg_device *rpdev;
 	struct device *tmp, *dev = &vrp->vdev->dev;
 	int ret;
@@ -307,15 +326,18 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 		return NULL;
 	}
 
-	rpch = kzalloc(sizeof(*rpch), GFP_KERNEL);
-	if (!rpch)
+	vch = kzalloc(sizeof(*vch), GFP_KERNEL);
+	if (!vch)
 		return NULL;
 
+	/* Link the channel to our vrp */
+	vch->vrp = vrp;
+
 	/* Assign callbacks for rpmsg_channel */
-	*rpch = virtio_rpmsg_ops;
+	vch->rpch = virtio_rpmsg_ops;
 
-	rpdev = &rpch->rpdev;
-	rpdev->vrp = vrp;
+	/* Assign public information to the rpmsg_device */
+	rpdev = &vch->rpch.rpdev;
 	rpdev->src = chinfo->src;
 	rpdev->dst = chinfo->dst;
 
@@ -453,7 +475,8 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
 				     u32 src, u32 dst,
 				     void *data, int len, bool wait)
 {
-	struct virtproc_info *vrp = rpdev->vrp;
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(&rpdev->dev);
+	struct virtproc_info *vrp = vch->vrp;
 	struct device *dev = &rpdev->dev;
 	struct scatterlist sg;
 	struct rpmsg_hdr *msg;
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 3d0ff950c0d6..a5679b9b6102 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -95,7 +95,6 @@ enum rpmsg_ns_flags {
 
 #define RPMSG_ADDR_ANY		0xFFFFFFFF
 
-struct virtproc_info;
 struct rpmsg_device;
 struct rpmsg_endpoint;
 
@@ -103,7 +102,6 @@ typedef void (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
 
 /**
  * rpmsg_device - device that belong to the rpmsg bus
- * @vrp: the remote processor this channel belongs to
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
  * @src: local address
@@ -112,7 +110,6 @@ typedef void (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
  * @announce: if set, rpmsg will announce the creation/removal of this channel
  */
 struct rpmsg_device {
-	struct virtproc_info *vrp;
 	struct device dev;
 	struct rpmsg_device_id id;
 	u32 src;
-- 
2.5.0
