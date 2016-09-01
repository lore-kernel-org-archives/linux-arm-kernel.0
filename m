From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu,  1 Sep 2016 15:28:06 -0700
Subject: [PATCH v2 14/17] rpmsg: virtio: Hide vrp pointer from the public API
In-Reply-To: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1472768889-3906-15-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a container struct virtio_rpmsg_channel around the rpmsg_channel
to keep virtio backend information separate from the rpmsg and public
API. This makes the public structures independant of virtio.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Reduced complexity from the move of ops to the public structs

 drivers/rpmsg/virtio_rpmsg_bus.c | 43 ++++++++++++++++++++++++++++++++--------
 include/linux/rpmsg.h            |  3 ---
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 31cd526f690d..ac2241242188 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -75,6 +75,18 @@ struct virtproc_info {
 	struct rpmsg_endpoint *ns_ept;
 };
 
+/**
+ * @vrp: the remote processor this channel belongs to
+ */
+struct virtio_rpmsg_channel {
+	struct rpmsg_device rpdev;
+
+	struct virtproc_info *vrp;
+};
+
+#define to_virtio_rpmsg_channel(_rpdev) \
+	container_of(_rpdev, struct virtio_rpmsg_channel, rpdev)
+
 /*
  * We're allocating buffers of 512 bytes each for communications. The
  * number of buffers will be computed from the number of buffers supported
@@ -204,7 +216,9 @@ static struct rpmsg_endpoint *virtio_rpmsg_create_ept(struct rpmsg_device *rpdev
 						      void *priv,
 						      struct rpmsg_channel_info chinfo)
 {
-	return __rpmsg_create_ept(rpdev->vrp, rpdev, cb, priv, chinfo.src);
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+
+	return __rpmsg_create_ept(vch->vrp, rpdev, cb, priv, chinfo.src);
 }
 
 /**
@@ -235,12 +249,15 @@ __rpmsg_destroy_ept(struct virtproc_info *vrp, struct rpmsg_endpoint *ept)
 
 static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
 {
-	__rpmsg_destroy_ept(ept->rpdev->vrp, ept);
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(ept->rpdev);
+
+	__rpmsg_destroy_ept(vch->vrp, ept);
 }
 
 static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 {
-	struct virtproc_info *vrp = rpdev->vrp;
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
 	struct device *dev = &rpdev->dev;
 	int err = 0;
 
@@ -263,7 +280,8 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 
 static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 {
-	struct virtproc_info *vrp = rpdev->vrp;
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
 	struct device *dev = &rpdev->dev;
 	int err = 0;
 
@@ -298,6 +316,7 @@ static const struct rpmsg_device_ops virtio_rpmsg_ops = {
 static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 						 struct rpmsg_channel_info *chinfo)
 {
+	struct virtio_rpmsg_channel *vch;
 	struct rpmsg_device *rpdev;
 	struct device *tmp, *dev = &vrp->vdev->dev;
 	int ret;
@@ -312,11 +331,18 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 		return NULL;
 	}
 
-	rpdev = kzalloc(sizeof(*rpdev), GFP_KERNEL);
-	if (!rpdev)
+	vch = kzalloc(sizeof(*vch), GFP_KERNEL);
+	if (!vch)
 		return NULL;
 
-	rpdev->vrp = vrp;
+	/* Link the channel to our vrp */
+	vch->vrp = vrp;
+
+	/* Assign callbacks for rpmsg_channel */
+	vch->rpdev.ops = &virtio_rpmsg_ops;
+
+	/* Assign public information to the rpmsg_device */
+	rpdev = &vch->rpdev;
 	rpdev->src = chinfo->src;
 	rpdev->dst = chinfo->dst;
 	rpdev->ops = &virtio_rpmsg_ops;
@@ -455,7 +481,8 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
 				     u32 src, u32 dst,
 				     void *data, int len, bool wait)
 {
-	struct virtproc_info *vrp = rpdev->vrp;
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
 	struct device *dev = &rpdev->dev;
 	struct scatterlist sg;
 	struct rpmsg_hdr *msg;
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 4f9445f71f2f..b4b56b010f71 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -95,7 +95,6 @@ enum rpmsg_ns_flags {
 
 #define RPMSG_ADDR_ANY		0xFFFFFFFF
 
-struct virtproc_info;
 struct rpmsg_device;
 struct rpmsg_endpoint;
 struct rpmsg_device_ops;
@@ -115,7 +114,6 @@ struct rpmsg_channel_info {
 
 /**
  * rpmsg_device - device that belong to the rpmsg bus
- * @vrp: the remote processor this channel belongs to
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
  * @src: local address
@@ -124,7 +122,6 @@ struct rpmsg_channel_info {
  * @announce: if set, rpmsg will announce the creation/removal of this channel
  */
 struct rpmsg_device {
-	struct virtproc_info *vrp;
 	struct device dev;
 	struct rpmsg_device_id id;
 	u32 src;
-- 
2.5.0
