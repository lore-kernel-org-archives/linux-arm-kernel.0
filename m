From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:18 -0700
Subject: [PATCH 12/14] rpmsg: Make rpmsg_create_ept() take channel_info struct
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-13-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some rpmsg backends does only support point-to-point "links" represented
by a name. By making rpmsg_create_ept() take a channel_info struct we
allow for these backends to either be passed a source address, a
destination address or a name identifier.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c       | 12 +++++++++---
 drivers/rpmsg/rpmsg_internal.h   | 14 +-------------
 drivers/rpmsg/virtio_rpmsg_bus.c |  5 +++--
 include/linux/rpmsg.h            | 15 ++++++++++++++-
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 6f7cc79f7229..54df4f77d72c 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -78,11 +78,12 @@
  * Returns a pointer to the endpoint on success, or NULL on error.
  */
 struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
-				rpmsg_rx_cb_t cb, void *priv, u32 addr)
+				rpmsg_rx_cb_t cb, void *priv,
+				struct rpmsg_channel_info chinfo)
 {
 	struct rpmsg_channel *rpch = to_rpmsg_channel(&rpdev->dev);
 
-	return rpch->create_ept(rpdev, cb, priv, addr);
+	return rpch->create_ept(rpdev, cb, priv, chinfo);
 }
 EXPORT_SYMBOL(rpmsg_create_ept);
 
@@ -337,10 +338,15 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_channel *rpch = to_rpmsg_channel(dev);
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
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
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 54083bf54d14..1ac96d7ac363 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -23,24 +23,12 @@
 #define to_rpmsg_device(d) container_of(d, struct rpmsg_device, dev)
 #define to_rpmsg_driver(d) container_of(d, struct rpmsg_driver, drv)
 
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
 struct rpmsg_channel {
 	struct rpmsg_device rpdev;
 
 	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
 					     rpmsg_rx_cb_t cb, void *priv,
-					     u32 addr);
+					     struct rpmsg_channel_info chinfo);
 	void (*destroy_ept)(struct rpmsg_endpoint *ept);
 
 	int (*send)(struct rpmsg_endpoint *ept, void *data, int len);
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index a284b48285a1..d39e381bc596 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -256,10 +256,11 @@ free_ept:
 
 static struct rpmsg_endpoint *virtio_rpmsg_create_ept(struct rpmsg_device *rpdev,
 						      rpmsg_rx_cb_t cb,
-						      void *priv, u32 addr)
+						      void *priv,
+						      struct rpmsg_channel_info chinfo)
 {
 	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(&rpdev->dev);
-	return __rpmsg_create_ept(vch->vrp, rpdev, cb, priv, addr);
+	return __rpmsg_create_ept(vch->vrp, rpdev, cb, priv, chinfo.src);
 }
 
 /**
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index db409a8e3178..bdd1a2285733 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -49,6 +49,18 @@ struct rpmsg_endpoint;
 typedef void (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
 
 /**
+ * struct rpmsg_channel_info - internal channel info representation
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
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
@@ -120,7 +132,8 @@ int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
 void unregister_rpmsg_driver(struct rpmsg_driver *drv);
 void rpmsg_destroy_ept(struct rpmsg_endpoint *);
 struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *,
-					rpmsg_rx_cb_t cb, void *priv, u32 addr);
+					rpmsg_rx_cb_t cb, void *priv,
+					struct rpmsg_channel_info chinfo);
 
 /* use a macro to avoid include chaining to get THIS_MODULE */
 #define register_rpmsg_driver(drv) \
-- 
2.5.0
