From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:11 -0700
Subject: [PATCH 05/14] rpmsg: Unify rpmsg device vs channel naming
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-6-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rpmsg device representing struct is called rpmsg_channel and the
variable name used throughout is rpdev, unify these as "rpmsg device" so
that we can use the identifier "channel" for the internal object in the
future.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 54 ++++++++++++++++++++--------------------
 include/linux/rpmsg.h            | 18 ++++++++------
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index f8fb9e065821..a9f8cc8d968b 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -85,7 +85,7 @@ struct rpmsg_channel_info {
 	u32 dst;
 };
 
-#define to_rpmsg_channel(d) container_of(d, struct rpmsg_channel, dev)
+#define to_rpmsg_device(d) container_of(d, struct rpmsg_device, dev)
 #define to_rpmsg_driver(d) container_of(d, struct rpmsg_driver, drv)
 
 /*
@@ -125,7 +125,7 @@ static ssize_t								\
 field##_show(struct device *dev,					\
 			struct device_attribute *attr, char *buf)	\
 {									\
-	struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);		\
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
 									\
 	return sprintf(buf, format_string, rpdev->path);		\
 }
@@ -139,7 +139,7 @@ rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 
 	return sprintf(buf, RPMSG_DEVICE_MODALIAS_FMT "\n", rpdev->id.name);
 }
@@ -154,7 +154,7 @@ static struct device_attribute rpmsg_dev_attrs[] = {
 };
 
 /* rpmsg devices and drivers are matched using the service name */
-static inline int rpmsg_id_match(const struct rpmsg_channel *rpdev,
+static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
 				 const struct rpmsg_device_id *id)
 {
 	return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
@@ -163,7 +163,7 @@ static inline int rpmsg_id_match(const struct rpmsg_channel *rpdev,
 /* match rpmsg channel and rpmsg driver */
 static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
 {
-	struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct rpmsg_driver *rpdrv = to_rpmsg_driver(drv);
 	const struct rpmsg_device_id *ids = rpdrv->id_table;
 	unsigned int i;
@@ -178,7 +178,7 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
 
 static int rpmsg_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 
 	return add_uevent_var(env, "MODALIAS=" RPMSG_DEVICE_MODALIAS_FMT,
 					rpdev->id.name);
@@ -206,7 +206,7 @@ static void __ept_release(struct kref *kref)
 
 /* for more info, see below documentation of rpmsg_create_ept() */
 static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
-						 struct rpmsg_channel *rpdev,
+						 struct rpmsg_device *rpdev,
 						 rpmsg_rx_cb_t cb,
 						 void *priv, u32 addr)
 {
@@ -294,7 +294,7 @@ free_ept:
  *
  * Returns a pointer to the endpoint on success, or NULL on error.
  */
-struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_channel *rpdev,
+struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
 					rpmsg_rx_cb_t cb, void *priv, u32 addr)
 {
 	return __rpmsg_create_ept(rpdev->vrp, rpdev, cb, priv, addr);
@@ -350,7 +350,7 @@ EXPORT_SYMBOL(rpmsg_destroy_ept);
  */
 static int rpmsg_dev_probe(struct device *dev)
 {
-	struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
 	struct virtproc_info *vrp = rpdev->vrp;
 	struct rpmsg_endpoint *ept;
@@ -393,7 +393,7 @@ out:
 
 static int rpmsg_dev_remove(struct device *dev)
 {
-	struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
 	struct virtproc_info *vrp = rpdev->vrp;
 	int err = 0;
@@ -457,7 +457,7 @@ EXPORT_SYMBOL(unregister_rpmsg_driver);
 
 static void rpmsg_release_device(struct device *dev)
 {
-	struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 
 	kfree(rpdev);
 }
@@ -467,10 +467,10 @@ static void rpmsg_release_device(struct device *dev)
  * this is used to make sure we're not creating rpmsg devices for channels
  * that already exist.
  */
-static int rpmsg_channel_match(struct device *dev, void *data)
+static int rpmsg_device_match(struct device *dev, void *data)
 {
 	struct rpmsg_channel_info *chinfo = data;
-	struct rpmsg_channel *rpdev = to_rpmsg_channel(dev);
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 
 	if (chinfo->src != RPMSG_ADDR_ANY && chinfo->src != rpdev->src)
 		return 0;
@@ -490,15 +490,15 @@ static int rpmsg_channel_match(struct device *dev, void *data)
  * this function will be used to create both static and dynamic
  * channels.
  */
-static struct rpmsg_channel *rpmsg_create_channel(struct virtproc_info *vrp,
-				struct rpmsg_channel_info *chinfo)
+static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
+						 struct rpmsg_channel_info *chinfo)
 {
-	struct rpmsg_channel *rpdev;
+	struct rpmsg_device *rpdev;
 	struct device *tmp, *dev = &vrp->vdev->dev;
 	int ret;
 
 	/* make sure a similar channel doesn't already exist */
-	tmp = device_find_child(dev, chinfo, rpmsg_channel_match);
+	tmp = device_find_child(dev, chinfo, rpmsg_device_match);
 	if (tmp) {
 		/* decrement the matched device's refcount back */
 		put_device(tmp);
@@ -550,7 +550,7 @@ static int rpmsg_destroy_channel(struct virtproc_info *vrp,
 	struct virtio_device *vdev = vrp->vdev;
 	struct device *dev;
 
-	dev = device_find_child(&vdev->dev, chinfo, rpmsg_channel_match);
+	dev = device_find_child(&vdev->dev, chinfo, rpmsg_device_match);
 	if (!dev)
 		return -EINVAL;
 
@@ -675,7 +675,7 @@ static void rpmsg_downref_sleepers(struct virtproc_info *vrp)
  *
  * Returns 0 on success and an appropriate error value on failure.
  */
-static int rpmsg_send_offchannel_raw(struct rpmsg_channel *rpdev,
+static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
 				     u32 src, u32 dst,
 				     void *data, int len, bool wait)
 {
@@ -792,7 +792,7 @@ out:
  */
 int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
 {
-	struct rpmsg_channel *rpdev = ept->rpdev;
+	struct rpmsg_device *rpdev = ept->rpdev;
 	u32 src = ept->addr, dst = rpdev->dst;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
@@ -819,7 +819,7 @@ EXPORT_SYMBOL(rpmsg_send);
  */
 int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
 {
-	struct rpmsg_channel *rpdev = ept->rpdev;
+	struct rpmsg_device *rpdev = ept->rpdev;
 	u32 src = ept->addr;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
@@ -849,7 +849,7 @@ EXPORT_SYMBOL(rpmsg_sendto);
 int rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 			  void *data, int len)
 {
-	struct rpmsg_channel *rpdev = ept->rpdev;
+	struct rpmsg_device *rpdev = ept->rpdev;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
 }
@@ -874,7 +874,7 @@ EXPORT_SYMBOL(rpmsg_send_offchannel);
  */
 int rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
 {
-	struct rpmsg_channel *rpdev = ept->rpdev;
+	struct rpmsg_device *rpdev = ept->rpdev;
 	u32 src = ept->addr, dst = rpdev->dst;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
@@ -900,7 +900,7 @@ EXPORT_SYMBOL(rpmsg_trysend);
  */
 int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
 {
-	struct rpmsg_channel *rpdev = ept->rpdev;
+	struct rpmsg_device *rpdev = ept->rpdev;
 	u32 src = ept->addr;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
@@ -929,7 +929,7 @@ EXPORT_SYMBOL(rpmsg_trysendto);
 int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 			     void *data, int len)
 {
-	struct rpmsg_channel *rpdev = ept->rpdev;
+	struct rpmsg_device *rpdev = ept->rpdev;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
 }
@@ -1048,11 +1048,11 @@ static void rpmsg_xmit_done(struct virtqueue *svq)
 }
 
 /* invoked when a name service announcement arrives */
-static void rpmsg_ns_cb(struct rpmsg_channel *rpdev, void *data, int len,
+static void rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 			void *priv, u32 src)
 {
 	struct rpmsg_ns_msg *msg = data;
-	struct rpmsg_channel *newch;
+	struct rpmsg_device *newch;
 	struct rpmsg_channel_info chinfo;
 	struct virtproc_info *vrp = priv;
 	struct device *dev = &vrp->vdev->dev;
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 554dc352d7e0..3e3d5b1c154a 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -98,7 +98,7 @@ enum rpmsg_ns_flags {
 struct virtproc_info;
 
 /**
- * rpmsg_channel - devices that belong to the rpmsg bus are called channels
+ * rpmsg_device - device that belong to the rpmsg bus
  * @vrp: the remote processor this channel belongs to
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
@@ -107,7 +107,7 @@ struct virtproc_info;
  * @ept: the rpmsg endpoint of this channel
  * @announce: if set, rpmsg will announce the creation/removal of this channel
  */
-struct rpmsg_channel {
+struct rpmsg_device {
 	struct virtproc_info *vrp;
 	struct device dev;
 	struct rpmsg_device_id id;
@@ -117,7 +117,7 @@ struct rpmsg_channel {
 	bool announce;
 };
 
-typedef void (*rpmsg_rx_cb_t)(struct rpmsg_channel *, void *, int, void *, u32);
+typedef void (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
 
 /**
  * struct rpmsg_endpoint - binds a local rpmsg address to its user
@@ -143,7 +143,7 @@ typedef void (*rpmsg_rx_cb_t)(struct rpmsg_channel *, void *, int, void *, u32);
  * create additional endpoints by themselves (see rpmsg_create_ept()).
  */
 struct rpmsg_endpoint {
-	struct rpmsg_channel *rpdev;
+	struct rpmsg_device *rpdev;
 	struct kref refcount;
 	rpmsg_rx_cb_t cb;
 	struct mutex cb_lock;
@@ -162,15 +162,17 @@ struct rpmsg_endpoint {
 struct rpmsg_driver {
 	struct device_driver drv;
 	const struct rpmsg_device_id *id_table;
-	int (*probe)(struct rpmsg_channel *dev);
-	void (*remove)(struct rpmsg_channel *dev);
-	void (*callback)(struct rpmsg_channel *, void *, int, void *, u32);
+	int (*probe)(struct rpmsg_device *dev);
+	void (*remove)(struct rpmsg_device *dev);
+	void (*callback)(struct rpmsg_device *, void *, int, void *, u32);
 };
 
+int register_rpmsg_device(struct rpmsg_device *dev);
+void unregister_rpmsg_device(struct rpmsg_device *dev);
 int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
 void unregister_rpmsg_driver(struct rpmsg_driver *drv);
 void rpmsg_destroy_ept(struct rpmsg_endpoint *);
-struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_channel *,
+struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *,
 					rpmsg_rx_cb_t cb, void *priv, u32 addr);
 
 /* use a macro to avoid include chaining to get THIS_MODULE */
-- 
2.5.0
