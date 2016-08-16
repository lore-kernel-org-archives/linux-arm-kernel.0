From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 15 Aug 2016 17:17:09 -0700
Subject: [PATCH 03/14] rpmsg: rpmsg_send() operations takes rpmsg_endpoint
In-Reply-To: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471306640-29917-4-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rpmsg_send() operations has been taking a rpmsg_device, but this
forces users of secondary rpmsg_endpoints to use the rpmsg_sendto()
interface - by extracting source and destination from the given data
structures. If we instead pass the rpmsg_endpoint to these functions a
service can use rpmsg_sendto() to respond to messages, even on secondary
endpoints.

In addition this would allow us to support operations on multiple
channels in future backends that does not support off-channel
operations.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c |  4 +--
 include/linux/rpmsg.h            | 70 +++++++++++++++++++++++-----------------
 2 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index c4bd89ea7681..1b63f4b7c2bd 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -382,7 +382,7 @@ static int rpmsg_dev_probe(struct device *dev)
 		nsm.addr = rpdev->src;
 		nsm.flags = RPMSG_NS_CREATE;
 
-		err = rpmsg_sendto(rpdev, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
+		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
 		if (err)
 			dev_err(dev, "failed to announce service %d\n", err);
 	}
@@ -407,7 +407,7 @@ static int rpmsg_dev_remove(struct device *dev)
 		nsm.addr = rpdev->src;
 		nsm.flags = RPMSG_NS_DESTROY;
 
-		err = rpmsg_sendto(rpdev, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
+		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
 		if (err)
 			dev_err(dev, "failed to announce service %d\n", err);
 	}
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 2b97c711a5e3..88e302c011e6 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -193,13 +193,14 @@ rpmsg_send_offchannel_raw(struct rpmsg_channel *, u32, u32, void *, int, bool);
 
 /**
  * rpmsg_send() - send a message across to the remote processor
- * @rpdev: the rpmsg channel
+ * @ept: the rpmsg endpoint
  * @data: payload of message
  * @len: length of payload
  *
- * This function sends @data of length @len on the @rpdev channel.
- * The message will be sent to the remote processor which the @rpdev
- * channel belongs to, using @rpdev's source and destination addresses.
+ * This function sends @data of length @len on the @ept endpoint.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to, using @ept's address and its associated rpmsg
+ * device destination addresses.
  * In case there are no TX buffers available, the function will block until
  * one becomes available, or a timeout of 15 seconds elapses. When the latter
  * happens, -ERESTARTSYS is returned.
@@ -208,23 +209,24 @@ rpmsg_send_offchannel_raw(struct rpmsg_channel *, u32, u32, void *, int, bool);
  *
  * Returns 0 on success and an appropriate error value on failure.
  */
-static inline int rpmsg_send(struct rpmsg_channel *rpdev, void *data, int len)
+static inline int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
 {
-	u32 src = rpdev->src, dst = rpdev->dst;
+	struct rpmsg_channel *rpdev = ept->rpdev;
+	u32 src = ept->addr, dst = rpdev->dst;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
 }
 
 /**
  * rpmsg_sendto() - send a message across to the remote processor, specify dst
- * @rpdev: the rpmsg channel
+ * @ept: the rpmsg endpoint
  * @data: payload of message
  * @len: length of payload
  * @dst: destination address
  *
  * This function sends @data of length @len to the remote @dst address.
- * The message will be sent to the remote processor which the @rpdev
- * channel belongs to, using @rpdev's source address.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to, using @ept's address as source.
  * In case there are no TX buffers available, the function will block until
  * one becomes available, or a timeout of 15 seconds elapses. When the latter
  * happens, -ERESTARTSYS is returned.
@@ -234,16 +236,17 @@ static inline int rpmsg_send(struct rpmsg_channel *rpdev, void *data, int len)
  * Returns 0 on success and an appropriate error value on failure.
  */
 static inline
-int rpmsg_sendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst)
+int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
 {
-	u32 src = rpdev->src;
+	struct rpmsg_channel *rpdev = ept->rpdev;
+	u32 src = ept->addr;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
 }
 
 /**
  * rpmsg_send_offchannel() - send a message using explicit src/dst addresses
- * @rpdev: the rpmsg channel
+ * @ept: the rpmsg endpoint
  * @src: source address
  * @dst: destination address
  * @data: payload of message
@@ -251,8 +254,8 @@ int rpmsg_sendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst)
  *
  * This function sends @data of length @len to the remote @dst address,
  * and uses @src as the source address.
- * The message will be sent to the remote processor which the @rpdev
- * channel belongs to.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to.
  * In case there are no TX buffers available, the function will block until
  * one becomes available, or a timeout of 15 seconds elapses. When the latter
  * happens, -ERESTARTSYS is returned.
@@ -262,21 +265,24 @@ int rpmsg_sendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst)
  * Returns 0 on success and an appropriate error value on failure.
  */
 static inline
-int rpmsg_send_offchannel(struct rpmsg_channel *rpdev, u32 src, u32 dst,
+int rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 			  void *data, int len)
 {
+	struct rpmsg_channel *rpdev = ept->rpdev;
+
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
 }
 
 /**
  * rpmsg_send() - send a message across to the remote processor
- * @rpdev: the rpmsg channel
+ * @ept: the rpmsg endpoint
  * @data: payload of message
  * @len: length of payload
  *
- * This function sends @data of length @len on the @rpdev channel.
- * The message will be sent to the remote processor which the @rpdev
- * channel belongs to, using @rpdev's source and destination addresses.
+ * This function sends @data of length @len on the @ept endpoint.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to, using @ept's addres as source and its associated
+ * rpdev's address as destination.
  * In case there are no TX buffers available, the function will immediately
  * return -ENOMEM without waiting until one becomes available.
  *
@@ -285,23 +291,24 @@ int rpmsg_send_offchannel(struct rpmsg_channel *rpdev, u32 src, u32 dst,
  * Returns 0 on success and an appropriate error value on failure.
  */
 static inline
-int rpmsg_trysend(struct rpmsg_channel *rpdev, void *data, int len)
+int rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
 {
-	u32 src = rpdev->src, dst = rpdev->dst;
+	struct rpmsg_channel *rpdev = ept->rpdev;
+	u32 src = ept->addr, dst = rpdev->dst;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
 }
 
 /**
  * rpmsg_sendto() - send a message across to the remote processor, specify dst
- * @rpdev: the rpmsg channel
+ * @ept: the rpmsg endpoint
  * @data: payload of message
  * @len: length of payload
  * @dst: destination address
  *
  * This function sends @data of length @len to the remote @dst address.
- * The message will be sent to the remote processor which the @rpdev
- * channel belongs to, using @rpdev's source address.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to, using @ept's address as source.
  * In case there are no TX buffers available, the function will immediately
  * return -ENOMEM without waiting until one becomes available.
  *
@@ -310,16 +317,17 @@ int rpmsg_trysend(struct rpmsg_channel *rpdev, void *data, int len)
  * Returns 0 on success and an appropriate error value on failure.
  */
 static inline
-int rpmsg_trysendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst)
+int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
 {
-	u32 src = rpdev->src;
+	struct rpmsg_channel *rpdev = ept->rpdev;
+	u32 src = ept->addr;
 
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
 }
 
 /**
  * rpmsg_send_offchannel() - send a message using explicit src/dst addresses
- * @rpdev: the rpmsg channel
+ * @ept: the rpmsg endpoint
  * @src: source address
  * @dst: destination address
  * @data: payload of message
@@ -327,8 +335,8 @@ int rpmsg_trysendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst)
  *
  * This function sends @data of length @len to the remote @dst address,
  * and uses @src as the source address.
- * The message will be sent to the remote processor which the @rpdev
- * channel belongs to.
+ * The message will be sent to the remote processor which the @ept
+ * endpoint belongs to.
  * In case there are no TX buffers available, the function will immediately
  * return -ENOMEM without waiting until one becomes available.
  *
@@ -337,9 +345,11 @@ int rpmsg_trysendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst)
  * Returns 0 on success and an appropriate error value on failure.
  */
 static inline
-int rpmsg_trysend_offchannel(struct rpmsg_channel *rpdev, u32 src, u32 dst,
+int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 			     void *data, int len)
 {
+	struct rpmsg_channel *rpdev = ept->rpdev;
+
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
 }
 
-- 
2.5.0
