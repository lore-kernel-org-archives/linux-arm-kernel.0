From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu,  1 Sep 2016 15:28:07 -0700
Subject: [PATCH v2 15/17] rpmsg: Move virtio specifics from public header
In-Reply-To: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
References: <1472768889-3906-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1472768889-3906-16-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move virtio rpmsg implementation details from the public header file to
the virtio rpmsg implementation.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/rpmsg/virtio_rpmsg_bus.c | 52 ++++++++++++++++++++++++++++++++++++++++
 include/linux/rpmsg.h            | 52 ----------------------------------------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index ac2241242188..671cb1803431 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -75,6 +75,58 @@ struct virtproc_info {
 	struct rpmsg_endpoint *ns_ept;
 };
 
+/* The feature bitmap for virtio rpmsg */
+#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
+
+/**
+ * struct rpmsg_hdr - common header for all rpmsg messages
+ * @src: source address
+ * @dst: destination address
+ * @reserved: reserved for future use
+ * @len: length of payload (in bytes)
+ * @flags: message flags
+ * @data: @len bytes of message payload data
+ *
+ * Every message sent(/received) on the rpmsg bus begins with this header.
+ */
+struct rpmsg_hdr {
+	u32 src;
+	u32 dst;
+	u32 reserved;
+	u16 len;
+	u16 flags;
+	u8 data[0];
+} __packed;
+
+/**
+ * struct rpmsg_ns_msg - dynamic name service announcement message
+ * @name: name of remote service that is published
+ * @addr: address of remote service that is published
+ * @flags: indicates whether service is created or destroyed
+ *
+ * This message is sent across to publish a new service, or announce
+ * about its removal. When we receive these messages, an appropriate
+ * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
+ * or ->remove() handler of the appropriate rpmsg driver will be invoked
+ * (if/as-soon-as one is registered).
+ */
+struct rpmsg_ns_msg {
+	char name[RPMSG_NAME_SIZE];
+	u32 addr;
+	u32 flags;
+} __packed;
+
+/**
+ * enum rpmsg_ns_flags - dynamic name service announcement flags
+ *
+ * @RPMSG_NS_CREATE: a new remote service was just created
+ * @RPMSG_NS_DESTROY: a known remote service was just destroyed
+ */
+enum rpmsg_ns_flags {
+	RPMSG_NS_CREATE		= 0,
+	RPMSG_NS_DESTROY	= 1,
+};
+
 /**
  * @vrp: the remote processor this channel belongs to
  */
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index b4b56b010f71..71b16d37503a 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -41,58 +41,6 @@
 #include <linux/kref.h>
 #include <linux/mutex.h>
 
-/* The feature bitmap for virtio rpmsg */
-#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
-
-/**
- * struct rpmsg_hdr - common header for all rpmsg messages
- * @src: source address
- * @dst: destination address
- * @reserved: reserved for future use
- * @len: length of payload (in bytes)
- * @flags: message flags
- * @data: @len bytes of message payload data
- *
- * Every message sent(/received) on the rpmsg bus begins with this header.
- */
-struct rpmsg_hdr {
-	u32 src;
-	u32 dst;
-	u32 reserved;
-	u16 len;
-	u16 flags;
-	u8 data[0];
-} __packed;
-
-/**
- * struct rpmsg_ns_msg - dynamic name service announcement message
- * @name: name of remote service that is published
- * @addr: address of remote service that is published
- * @flags: indicates whether service is created or destroyed
- *
- * This message is sent across to publish a new service, or announce
- * about its removal. When we receive these messages, an appropriate
- * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
- * or ->remove() handler of the appropriate rpmsg driver will be invoked
- * (if/as-soon-as one is registered).
- */
-struct rpmsg_ns_msg {
-	char name[RPMSG_NAME_SIZE];
-	u32 addr;
-	u32 flags;
-} __packed;
-
-/**
- * enum rpmsg_ns_flags - dynamic name service announcement flags
- *
- * @RPMSG_NS_CREATE: a new remote service was just created
- * @RPMSG_NS_DESTROY: a known remote service was just destroyed
- */
-enum rpmsg_ns_flags {
-	RPMSG_NS_CREATE		= 0,
-	RPMSG_NS_DESTROY	= 1,
-};
-
 #define RPMSG_ADDR_ANY		0xFFFFFFFF
 
 struct rpmsg_device;
-- 
2.5.0
