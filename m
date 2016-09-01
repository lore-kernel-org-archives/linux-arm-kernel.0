From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu,  1 Sep 2016 15:27:56 -0700
Subject: [PATCH v2 04/17] rpmsg: Make rpmsg_create_ept() take channel_info
 struct
In-Reply-To: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1472768889-3906-5-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we introduce support for additional rpmsg backends, some of these
only supports point-to-point "links" represented by a name. By making
rpmsg_create_ept() take a channel_info struct we allow for these
backends to either be passed a source address, a destination address or
a name identifier.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/rpmsg/virtio_rpmsg_bus.c | 26 ++++++++++----------------
 include/linux/rpmsg.h            | 15 ++++++++++++++-
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 345036b485d7..7c7c6a8b21d9 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -73,18 +73,6 @@ struct virtproc_info {
 	struct rpmsg_endpoint *ns_ept;
 };
 
-/**
- * struct rpmsg_channel_info - internal channel info representation
- * @name: name of service
- * @src: local address
- * @dst: destination address
- */
-struct rpmsg_channel_info {
-	char name[RPMSG_NAME_SIZE];
-	u32 src;
-	u32 dst;
-};
-
 #define to_rpmsg_channel(d) container_of(d, struct rpmsg_channel, dev)
 #define to_rpmsg_driver(d) container_of(d, struct rpmsg_driver, drv)
 
@@ -259,7 +247,7 @@ free_ept:
  * @rpdev: rpmsg channel device
  * @cb: rx callback handler
  * @priv: private data for the driver's use
- * @addr: local rpmsg address to bind with @cb
+ * @chinfo: channel_info with the local rpmsg address to bind with @cb
  *
  * Every rpmsg address in the system is bound to an rx callback (so when
  * inbound messages arrive, they are dispatched by the rpmsg bus using the
@@ -295,9 +283,10 @@ free_ept:
  * Returns a pointer to the endpoint on success, or NULL on error.
  */
 struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_channel *rpdev,
-					rpmsg_rx_cb_t cb, void *priv, u32 addr)
+					rpmsg_rx_cb_t cb, void *priv,
+					struct rpmsg_channel_info chinfo)
 {
-	return __rpmsg_create_ept(rpdev->vrp, rpdev, cb, priv, addr);
+	return __rpmsg_create_ept(rpdev->vrp, rpdev, cb, priv, chinfo.src);
 }
 EXPORT_SYMBOL(rpmsg_create_ept);
 
@@ -353,10 +342,15 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);
 	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
 	struct virtproc_info *vrp = rpdev->vrp;
+	struct rpmsg_channel_info chinfo = {};
 	struct rpmsg_endpoint *ept;
 	int err;
 
-	ept = rpmsg_create_ept(rpdev, rpdrv->callback, NULL, rpdev->src);
+	strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
+	chinfo.src = rpdev->src;
+	chinfo.dst = RPMSG_ADDR_ANY;
+
+	ept = rpmsg_create_ept(rpdev, rpdrv->callback, NULL, chinfo);
 	if (!ept) {
 		dev_err(dev, "failed to create endpoint\n");
 		err = -ENOMEM;
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index a901a331a190..f278407fcf48 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -98,6 +98,18 @@ enum rpmsg_ns_flags {
 struct virtproc_info;
 
 /**
+ * struct rpmsg_channel_info - channel info representation
+ * @name: name of service
+ * @src: local address
+ * @dst: destination address
+ */
+struct rpmsg_channel_info {
+	char name[RPMSG_NAME_SIZE];
+	u32 src;
+	u32 dst;
+};
+
+/**
  * rpmsg_channel - devices that belong to the rpmsg bus are called channels
  * @vrp: the remote processor this channel belongs to
  * @dev: the device struct
@@ -171,7 +183,8 @@ int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
 void unregister_rpmsg_driver(struct rpmsg_driver *drv);
 void rpmsg_destroy_ept(struct rpmsg_endpoint *);
 struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_channel *,
-					rpmsg_rx_cb_t cb, void *priv, u32 addr);
+					rpmsg_rx_cb_t cb, void *priv,
+					struct rpmsg_channel_info chinfo);
 int
 rpmsg_send_offchannel_raw(struct rpmsg_channel *, u32, u32, void *, int, bool);
 
-- 
2.5.0
