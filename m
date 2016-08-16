From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:15 -0700
Subject: [PATCH 09/14] rpmsg: Internalize rpmsg core ops
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-10-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a container struct rpmsg_channel around the rpmsg_device to
keep rpmsg internal data hidden from the public API.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c       | 42 +++++++++++++++++++++++-----------------
 drivers/rpmsg/rpmsg_internal.h   | 30 ++++++++++++++++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++----
 include/linux/rpmsg.h            | 17 ----------------
 4 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 73bbc5ea5778..6f7cc79f7229 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -80,7 +80,9 @@
 struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
 				rpmsg_rx_cb_t cb, void *priv, u32 addr)
 {
-	return rpdev->create_ept(rpdev, cb, priv, addr);
+	struct rpmsg_channel *rpch = to_rpmsg_channel(&rpdev->dev);
+
+	return rpch->create_ept(rpdev, cb, priv, addr);
 }
 EXPORT_SYMBOL(rpmsg_create_ept);
 
@@ -93,7 +95,9 @@ EXPORT_SYMBOL(rpmsg_create_ept);
  */
 void rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
 {
-	ept->rpdev->destroy_ept(ept);
+	struct rpmsg_channel *rpch = to_rpmsg_channel(&ept->rpdev->dev);
+
+	rpch->destroy_ept(ept);
 }
 EXPORT_SYMBOL(rpmsg_destroy_ept);
 
@@ -117,9 +121,9 @@ EXPORT_SYMBOL(rpmsg_destroy_ept);
  */
 int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
 {
-	struct rpmsg_device *rpdev = ept->rpdev;
+	struct rpmsg_channel *rpch = to_rpmsg_channel(&ept->rpdev->dev);
 
-	return rpdev->send(ept, data, len);
+	return rpch->send(ept, data, len);
 }
 
 /**
@@ -142,9 +146,9 @@ int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
  */
 int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
 {
-	struct rpmsg_device *rpdev = ept->rpdev;
+	struct rpmsg_channel *rpch = to_rpmsg_channel(&ept->rpdev->dev);
 
-	return rpdev->sendto(ept, data, len, dst);
+	return rpch->sendto(ept, data, len, dst);
 }
 EXPORT_SYMBOL(rpmsg_sendto);
 
@@ -171,9 +175,9 @@ EXPORT_SYMBOL(rpmsg_sendto);
 int rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 			  void *data, int len)
 {
-	struct rpmsg_device *rpdev = ept->rpdev;
+	struct rpmsg_channel *rpch = to_rpmsg_channel(&ept->rpdev->dev);
 
-	return rpdev->send_offchannel(ept, src, dst, data, len);
+	return rpch->send_offchannel(ept, src, dst, data, len);
 }
 EXPORT_SYMBOL(rpmsg_send_offchannel);
 
@@ -196,9 +200,9 @@ EXPORT_SYMBOL(rpmsg_send_offchannel);
  */
 int rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
 {
-	struct rpmsg_device *rpdev = ept->rpdev;
+	struct rpmsg_channel *rpch = to_rpmsg_channel(&ept->rpdev->dev);
 
-	return rpdev->trysend(ept, data, len);
+	return rpch->trysend(ept, data, len);
 }
 EXPORT_SYMBOL(rpmsg_trysend);
 
@@ -221,9 +225,9 @@ EXPORT_SYMBOL(rpmsg_trysend);
  */
 int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
 {
-	struct rpmsg_device *rpdev = ept->rpdev;
+	struct rpmsg_channel *rpch = to_rpmsg_channel(&ept->rpdev->dev);
 
-	return rpdev->trysendto(ept, data, len, dst);
+	return rpch->trysendto(ept, data, len, dst);
 }
 EXPORT_SYMBOL(rpmsg_trysendto);
 
@@ -249,9 +253,9 @@ EXPORT_SYMBOL(rpmsg_trysendto);
 int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 			     void *data, int len)
 {
-	struct rpmsg_device *rpdev = ept->rpdev;
+	struct rpmsg_channel *rpch = to_rpmsg_channel(&ept->rpdev->dev);
 
-	return rpdev->trysend_offchannel(ept, src, dst, data, len);
+	return rpch->trysend_offchannel(ept, src, dst, data, len);
 }
 EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 
@@ -330,6 +334,7 @@ static int rpmsg_uevent(struct device *dev, struct kobj_uevent_env *env)
  */
 static int rpmsg_dev_probe(struct device *dev)
 {
+	struct rpmsg_channel *rpch = to_rpmsg_channel(dev);
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
 	struct rpmsg_endpoint *ept;
@@ -352,20 +357,21 @@ static int rpmsg_dev_probe(struct device *dev)
 		goto out;
 	}
 
-	if (rpdev->announce_create)
-		err = rpdev->announce_create(rpdev);
+	if (rpch->announce_create)
+		err = rpch->announce_create(rpdev);
 out:
 	return err;
 }
 
 static int rpmsg_dev_remove(struct device *dev)
 {
+	struct rpmsg_channel *rpch = to_rpmsg_channel(dev);
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
 	int err = 0;
 
-	if (rpdev->announce_destroy)
-		err = rpdev->announce_destroy(rpdev);
+	if (rpch->announce_destroy)
+		err = rpch->announce_destroy(rpdev);
 
 	rpdrv->remove(rpdev);
 
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index fa91075c7956..54083bf54d14 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -35,6 +35,36 @@ struct rpmsg_channel_info {
 	u32 dst;
 };
 
+struct rpmsg_channel {
+	struct rpmsg_device rpdev;
+
+	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
+					     rpmsg_rx_cb_t cb, void *priv,
+					     u32 addr);
+	void (*destroy_ept)(struct rpmsg_endpoint *ept);
+
+	int (*send)(struct rpmsg_endpoint *ept, void *data, int len);
+	int (*sendto)(struct rpmsg_endpoint *ept, void *data, int len, u32 dst);
+	int (*send_offchannel)(struct rpmsg_endpoint *ept, u32 src, u32 dst,
+				  void *data, int len);
+
+	int (*trysend)(struct rpmsg_endpoint *ept, void *data, int len);
+	int (*trysendto)(struct rpmsg_endpoint *ept, void *data, int len,
+			 u32 dst);
+	int (*trysend_offchannel)(struct rpmsg_endpoint *ept, u32 src, u32 dst,
+				  void *data, int len);
+
+	int (*announce_create)(struct rpmsg_device *rpdev);
+	int (*announce_destroy)(struct rpmsg_device *rpdev);
+};
+
+static inline struct rpmsg_channel *to_rpmsg_channel(struct device *d)
+{
+	struct rpmsg_device *rpdev = to_rpmsg_device(d);
+
+	return container_of(rpdev, struct rpmsg_channel, rpdev);
+}
+
 int rpmsg_register_device(struct rpmsg_device *rpdev);
 int rpmsg_unregister_device(struct device *parent,
 			    struct rpmsg_channel_info *chinfo);
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 779c54304774..d08facbcd30a 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -271,7 +271,7 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 	return err;
 }
 
-static const struct rpmsg_device virtio_rpmsg_ops = {
+static const struct rpmsg_channel virtio_rpmsg_ops = {
 	.create_ept = virtio_rpmsg_create_ept,
 	.destroy_ept = virtio_rpmsg_destroy_ept,
 	.send = virtio_rpmsg_send,
@@ -292,6 +292,7 @@ static const struct rpmsg_device virtio_rpmsg_ops = {
 static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 						 struct rpmsg_channel_info *chinfo)
 {
+	struct rpmsg_channel *rpch;
 	struct rpmsg_device *rpdev;
 	struct device *tmp, *dev = &vrp->vdev->dev;
 	int ret;
@@ -306,13 +307,14 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 		return NULL;
 	}
 
-	rpdev = kzalloc(sizeof(*rpdev), GFP_KERNEL);
-	if (!rpdev)
+	rpch = kzalloc(sizeof(*rpch), GFP_KERNEL);
+	if (!rpch)
 		return NULL;
 
 	/* Assign callbacks for rpmsg_channel */
-	*rpdev = virtio_rpmsg_ops;
+	*rpch = virtio_rpmsg_ops;
 
+	rpdev = &rpch->rpdev;
 	rpdev->vrp = vrp;
 	rpdev->src = chinfo->src;
 	rpdev->dst = chinfo->dst;
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 0b290ae18e70..3d0ff950c0d6 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -119,23 +119,6 @@ struct rpmsg_device {
 	u32 dst;
 	struct rpmsg_endpoint *ept;
 	bool announce;
-
-	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
-					    rpmsg_rx_cb_t cb, void *priv, u32 addr);
-	void (*destroy_ept)(struct rpmsg_endpoint *ept);
-
-	int (*send)(struct rpmsg_endpoint *ept, void *data, int len);
-	int (*sendto)(struct rpmsg_endpoint *ept, void *data, int len, u32 dst);
-	int (*send_offchannel)(struct rpmsg_endpoint *ept, u32 src, u32 dst,
-				  void *data, int len);
-
-	int (*trysend)(struct rpmsg_endpoint *ept, void *data, int len);
-	int (*trysendto)(struct rpmsg_endpoint *ept, void *data, int len, u32 dst);
-	int (*trysend_offchannel)(struct rpmsg_endpoint *ept, u32 src, u32 dst,
-			     void *data, int len);
-
-	int (*announce_create)(struct rpmsg_device *ept);
-	int (*announce_destroy)(struct rpmsg_device *ept);
 };
 
 /**
-- 
2.5.0
