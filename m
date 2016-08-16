From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:10 -0700
Subject: [PATCH 04/14] rpmsg: Internalize rpmsg_send() implementations
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-5-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the rpmsg_send() implementations to virtio_rpmsg_bus.c in
preparation for upcoming changes making necessary data unavailable
outside the rpmsg implementation.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 169 ++++++++++++++++++++++++++++++++++++++-
 include/linux/rpmsg.h            | 166 ++------------------------------------
 2 files changed, 172 insertions(+), 163 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 1b63f4b7c2bd..f8fb9e065821 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -675,8 +675,9 @@ static void rpmsg_downref_sleepers(struct virtproc_info *vrp)
  *
  * Returns 0 on success and an appropriate error value on failure.
  */
-int rpmsg_send_offchannel_raw(struct rpmsg_channel *rpdev, u32 src, u32 dst,
-			      void *data, int len, bool wait)
+static int rpmsg_send_offchannel_raw(struct rpmsg_channel *rpdev,
+				     u32 src, u32 dst,
+				     void *data, int len, bool wait)
 {
 	struct virtproc_info *vrp = rpdev->vrp;
 	struct device *dev = &rpdev->dev;
@@ -770,7 +771,169 @@ out:
 	mutex_unlock(&vrp->tx_lock);
 	return err;
 }
-EXPORT_SYMBOL(rpmsg_send_offchannel_raw);
+
+/**
+ * rpmsg_send() - send a message across to the remote processor
+ * @ept: the rpmsg endpoint
+ * @data: payload of message
+ * @len: length of payload
+ *
+ * This function sends @data of length @len on the @ept endpoint.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to, using @ept's address and its associated rpmsg
+ * device destination addresses.
+ * In case there are no TX buffers available, the function will block until
+ * one becomes available, or a timeout of 15 seconds elapses. When the latter
+ * happens, -ERESTARTSYS is returned.
+ *
+ * Can only be called from process context (for now).
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
+{
+	struct rpmsg_channel *rpdev = ept->rpdev;
+	u32 src = ept->addr, dst = rpdev->dst;
+
+	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
+}
+EXPORT_SYMBOL(rpmsg_send);
+
+/**
+ * rpmsg_sendto() - send a message across to the remote processor, specify dst
+ * @ept: the rpmsg endpoint
+ * @data: payload of message
+ * @len: length of payload
+ * @dst: destination address
+ *
+ * This function sends @data of length @len to the remote @dst address.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to, using @ept's address as source.
+ * In case there are no TX buffers available, the function will block until
+ * one becomes available, or a timeout of 15 seconds elapses. When the latter
+ * happens, -ERESTARTSYS is returned.
+ *
+ * Can only be called from process context (for now).
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
+{
+	struct rpmsg_channel *rpdev = ept->rpdev;
+	u32 src = ept->addr;
+
+	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
+}
+EXPORT_SYMBOL(rpmsg_sendto);
+
+/**
+ * rpmsg_send_offchannel() - send a message using explicit src/dst addresses
+ * @ept: the rpmsg endpoint
+ * @src: source address
+ * @dst: destination address
+ * @data: payload of message
+ * @len: length of payload
+ *
+ * This function sends @data of length @len to the remote @dst address,
+ * and uses @src as the source address.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to.
+ * In case there are no TX buffers available, the function will block until
+ * one becomes available, or a timeout of 15 seconds elapses. When the latter
+ * happens, -ERESTARTSYS is returned.
+ *
+ * Can only be called from process context (for now).
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
+			  void *data, int len)
+{
+	struct rpmsg_channel *rpdev = ept->rpdev;
+
+	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
+}
+EXPORT_SYMBOL(rpmsg_send_offchannel);
+
+/**
+ * rpmsg_send() - send a message across to the remote processor
+ * @ept: the rpmsg endpoint
+ * @data: payload of message
+ * @len: length of payload
+ *
+ * This function sends @data of length @len on the @ept endpoint.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to, using @ept's addres as source and its associated
+ * rpdev's address as destination.
+ * In case there are no TX buffers available, the function will immediately
+ * return -ENOMEM without waiting until one becomes available.
+ *
+ * Can only be called from process context (for now).
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
+{
+	struct rpmsg_channel *rpdev = ept->rpdev;
+	u32 src = ept->addr, dst = rpdev->dst;
+
+	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
+}
+EXPORT_SYMBOL(rpmsg_trysend);
+
+/**
+ * rpmsg_sendto() - send a message across to the remote processor, specify dst
+ * @ept: the rpmsg endpoint
+ * @data: payload of message
+ * @len: length of payload
+ * @dst: destination address
+ *
+ * This function sends @data of length @len to the remote @dst address.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to, using @ept's address as source.
+ * In case there are no TX buffers available, the function will immediately
+ * return -ENOMEM without waiting until one becomes available.
+ *
+ * Can only be called from process context (for now).
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
+{
+	struct rpmsg_channel *rpdev = ept->rpdev;
+	u32 src = ept->addr;
+
+	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
+}
+EXPORT_SYMBOL(rpmsg_trysendto);
+
+/**
+ * rpmsg_send_offchannel() - send a message using explicit src/dst addresses
+ * @ept: the rpmsg endpoint
+ * @src: source address
+ * @dst: destination address
+ * @data: payload of message
+ * @len: length of payload
+ *
+ * This function sends @data of length @len to the remote @dst address,
+ * and uses @src as the source address.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to.
+ * In case there are no TX buffers available, the function will immediately
+ * return -ENOMEM without waiting until one becomes available.
+ *
+ * Can only be called from process context (for now).
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
+			     void *data, int len)
+{
+	struct rpmsg_channel *rpdev = ept->rpdev;
+
+	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
+}
+EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 
 static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 			     struct rpmsg_hdr *msg, unsigned int len)
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 88e302c011e6..554dc352d7e0 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -172,8 +172,6 @@ void unregister_rpmsg_driver(struct rpmsg_driver *drv);
 void rpmsg_destroy_ept(struct rpmsg_endpoint *);
 struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_channel *,
 					rpmsg_rx_cb_t cb, void *priv, u32 addr);
-int
-rpmsg_send_offchannel_raw(struct rpmsg_channel *, u32, u32, void *, int, bool);
 
 /* use a macro to avoid include chaining to get THIS_MODULE */
 #define register_rpmsg_driver(drv) \
@@ -191,166 +189,14 @@ rpmsg_send_offchannel_raw(struct rpmsg_channel *, u32, u32, void *, int, bool);
 	module_driver(__rpmsg_driver, register_rpmsg_driver, \
 			unregister_rpmsg_driver)
 
-/**
- * rpmsg_send() - send a message across to the remote processor
- * @ept: the rpmsg endpoint
- * @data: payload of message
- * @len: length of payload
- *
- * This function sends @data of length @len on the @ept endpoint.
- * The message will be sent to the remote processor which the @ept
- * endpoint belongs to, using @ept's address and its associated rpmsg
- * device destination addresses.
- * In case there are no TX buffers available, the function will block until
- * one becomes available, or a timeout of 15 seconds elapses. When the latter
- * happens, -ERESTARTSYS is returned.
- *
- * Can only be called from process context (for now).
- *
- * Returns 0 on success and an appropriate error value on failure.
- */
-static inline int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
-{
-	struct rpmsg_channel *rpdev = ept->rpdev;
-	u32 src = ept->addr, dst = rpdev->dst;
-
-	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
-}
-
-/**
- * rpmsg_sendto() - send a message across to the remote processor, specify dst
- * @ept: the rpmsg endpoint
- * @data: payload of message
- * @len: length of payload
- * @dst: destination address
- *
- * This function sends @data of length @len to the remote @dst address.
- * The message will be sent to the remote processor which the @ept
- * endpoint belongs to, using @ept's address as source.
- * In case there are no TX buffers available, the function will block until
- * one becomes available, or a timeout of 15 seconds elapses. When the latter
- * happens, -ERESTARTSYS is returned.
- *
- * Can only be called from process context (for now).
- *
- * Returns 0 on success and an appropriate error value on failure.
- */
-static inline
-int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
-{
-	struct rpmsg_channel *rpdev = ept->rpdev;
-	u32 src = ept->addr;
-
-	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
-}
-
-/**
- * rpmsg_send_offchannel() - send a message using explicit src/dst addresses
- * @ept: the rpmsg endpoint
- * @src: source address
- * @dst: destination address
- * @data: payload of message
- * @len: length of payload
- *
- * This function sends @data of length @len to the remote @dst address,
- * and uses @src as the source address.
- * The message will be sent to the remote processor which the @ept
- * endpoint belongs to.
- * In case there are no TX buffers available, the function will block until
- * one becomes available, or a timeout of 15 seconds elapses. When the latter
- * happens, -ERESTARTSYS is returned.
- *
- * Can only be called from process context (for now).
- *
- * Returns 0 on success and an appropriate error value on failure.
- */
-static inline
+int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
+int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst);
 int rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
-			  void *data, int len)
-{
-	struct rpmsg_channel *rpdev = ept->rpdev;
-
-	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
-}
+			  void *data, int len);
 
-/**
- * rpmsg_send() - send a message across to the remote processor
- * @ept: the rpmsg endpoint
- * @data: payload of message
- * @len: length of payload
- *
- * This function sends @data of length @len on the @ept endpoint.
- * The message will be sent to the remote processor which the @ept
- * endpoint belongs to, using @ept's addres as source and its associated
- * rpdev's address as destination.
- * In case there are no TX buffers available, the function will immediately
- * return -ENOMEM without waiting until one becomes available.
- *
- * Can only be called from process context (for now).
- *
- * Returns 0 on success and an appropriate error value on failure.
- */
-static inline
-int rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
-{
-	struct rpmsg_channel *rpdev = ept->rpdev;
-	u32 src = ept->addr, dst = rpdev->dst;
-
-	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
-}
-
-/**
- * rpmsg_sendto() - send a message across to the remote processor, specify dst
- * @ept: the rpmsg endpoint
- * @data: payload of message
- * @len: length of payload
- * @dst: destination address
- *
- * This function sends @data of length @len to the remote @dst address.
- * The message will be sent to the remote processor which the @ept
- * endpoint belongs to, using @ept's address as source.
- * In case there are no TX buffers available, the function will immediately
- * return -ENOMEM without waiting until one becomes available.
- *
- * Can only be called from process context (for now).
- *
- * Returns 0 on success and an appropriate error value on failure.
- */
-static inline
-int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
-{
-	struct rpmsg_channel *rpdev = ept->rpdev;
-	u32 src = ept->addr;
-
-	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
-}
-
-/**
- * rpmsg_send_offchannel() - send a message using explicit src/dst addresses
- * @ept: the rpmsg endpoint
- * @src: source address
- * @dst: destination address
- * @data: payload of message
- * @len: length of payload
- *
- * This function sends @data of length @len to the remote @dst address,
- * and uses @src as the source address.
- * The message will be sent to the remote processor which the @ept
- * endpoint belongs to.
- * In case there are no TX buffers available, the function will immediately
- * return -ENOMEM without waiting until one becomes available.
- *
- * Can only be called from process context (for now).
- *
- * Returns 0 on success and an appropriate error value on failure.
- */
-static inline
+int rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len);
+int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst);
 int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
-			     void *data, int len)
-{
-	struct rpmsg_channel *rpdev = ept->rpdev;
-
-	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
-}
+			     void *data, int len);
 
 #endif /* _LINUX_RPMSG_H */
-- 
2.5.0
