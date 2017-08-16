From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:48:55 +0530
Subject: [PATCH 02/18] rpmsg: glink: Associate indirections for pipe fifo
 accessor's
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-3-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

With the intention of reusing the glink core protocol commands
and code across both rpm and smem based transports, the only thing
different is way of accessing the shared-memory of the transport
(FIFO). So put the fifo accessor's of the transport's pipe (rx/tx)
behind indirections, so that the rest of the code can be shared.

For this, have a qcom_glink_pipe that can be used in the common code
containing the indirections and wrap it with glink_rpm_pipe that contains
the transport specific members.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_rpm.c | 144 ++++++++++++++++++++++++++++++-----------
 1 file changed, 106 insertions(+), 38 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
index 56a0a66..870ce32 100644
--- a/drivers/rpmsg/qcom_glink_rpm.c
+++ b/drivers/rpmsg/qcom_glink_rpm.c
@@ -41,12 +41,28 @@
 #define RPM_GLINK_CID_MIN	1
 #define RPM_GLINK_CID_MAX	65536
 
+#define to_rpm_pipe(p)	container_of(p, struct glink_rpm_pipe, native)
+
 struct rpm_toc_entry {
 	__le32 id;
 	__le32 offset;
 	__le32 size;
 } __packed;
 
+struct qcom_glink;
+
+struct qcom_glink_pipe {
+	size_t length;
+
+	size_t (*avail)(struct qcom_glink_pipe *glink_pipe);
+	void (*peak)(struct qcom_glink_pipe *glink_pipe, void *data,
+		     size_t count);
+	void (*advance)(struct qcom_glink_pipe *glink_pipe, size_t count);
+	void (*write)(struct qcom_glink_pipe *glink_pipe,
+		      const void *hdr, size_t hlen,
+		      const void *data, size_t dlen);
+};
+
 struct rpm_toc {
 	__le32 magic;
 	__le32 count;
@@ -62,12 +78,12 @@ struct glink_msg {
 } __packed;
 
 struct glink_rpm_pipe {
+	struct qcom_glink_pipe native;
+
 	void __iomem *tail;
 	void __iomem *head;
 
 	void __iomem *fifo;
-
-	size_t length;
 };
 
 /**
@@ -107,8 +123,8 @@ struct qcom_glink {
 	struct mbox_client mbox_client;
 	struct mbox_chan *mbox_chan;
 
-	struct glink_rpm_pipe rx_pipe;
-	struct glink_rpm_pipe tx_pipe;
+	struct qcom_glink_pipe *rx_pipe;
+	struct qcom_glink_pipe *tx_pipe;
 
 	int irq;
 
@@ -215,9 +231,9 @@ static void qcom_glink_channel_release(struct kref *ref)
 	kfree(channel);
 }
 
-static size_t qcom_glink_rx_avail(struct qcom_glink *glink)
+static size_t glink_rpm_rx_avail(struct qcom_glink_pipe *glink_pipe)
 {
-	struct glink_rpm_pipe *pipe = &glink->rx_pipe;
+	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
 	unsigned int head;
 	unsigned int tail;
 
@@ -225,21 +241,26 @@ static size_t qcom_glink_rx_avail(struct qcom_glink *glink)
 	tail = readl(pipe->tail);
 
 	if (head < tail)
-		return pipe->length - tail + head;
+		return pipe->native.length - tail + head;
 	else
 		return head - tail;
 }
 
-static void qcom_glink_rx_peak(struct qcom_glink *glink,
-			       void *data, size_t count)
+static size_t qcom_glink_rx_avail(struct qcom_glink *glink)
+{
+	return glink->rx_pipe->avail(glink->rx_pipe);
+}
+
+static void glink_rpm_rx_peak(struct qcom_glink_pipe *glink_pipe,
+			      void *data, size_t count)
 {
-	struct glink_rpm_pipe *pipe = &glink->rx_pipe;
+	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
 	unsigned int tail;
 	size_t len;
 
 	tail = readl(pipe->tail);
 
-	len = min_t(size_t, count, pipe->length - tail);
+	len = min_t(size_t, count, pipe->native.length - tail);
 	if (len) {
 		__ioread32_copy(data, pipe->fifo + tail,
 				len / sizeof(u32));
@@ -251,24 +272,35 @@ static void qcom_glink_rx_peak(struct qcom_glink *glink,
 	}
 }
 
-static void qcom_glink_rx_advance(struct qcom_glink *glink,
-				  size_t count)
+static void qcom_glink_rx_peak(struct qcom_glink *glink,
+			       void *data, size_t count)
 {
-	struct glink_rpm_pipe *pipe = &glink->rx_pipe;
+	glink->rx_pipe->peak(glink->rx_pipe, data, count);
+}
+
+static void glink_rpm_rx_advance(struct qcom_glink_pipe *glink_pipe,
+				 size_t count)
+{
+	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
 	unsigned int tail;
 
 	tail = readl(pipe->tail);
 
 	tail += count;
-	if (tail >= pipe->length)
-		tail -= pipe->length;
+	if (tail >= pipe->native.length)
+		tail -= pipe->native.length;
 
 	writel(tail, pipe->tail);
 }
 
-static size_t qcom_glink_tx_avail(struct qcom_glink *glink)
+static void qcom_glink_rx_advance(struct qcom_glink *glink, size_t count)
+{
+	glink->rx_pipe->advance(glink->rx_pipe, count);
+}
+
+static size_t glink_rpm_tx_avail(struct qcom_glink_pipe *glink_pipe)
 {
-	struct glink_rpm_pipe *pipe = &glink->tx_pipe;
+	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
 	unsigned int head;
 	unsigned int tail;
 
@@ -276,19 +308,23 @@ static size_t qcom_glink_tx_avail(struct qcom_glink *glink)
 	tail = readl(pipe->tail);
 
 	if (tail <= head)
-		return pipe->length - head + tail;
+		return pipe->native.length - head + tail;
 	else
 		return tail - head;
 }
 
-static unsigned int qcom_glink_tx_write(struct qcom_glink *glink,
-					unsigned int head,
-					const void *data, size_t count)
+static size_t qcom_glink_tx_avail(struct qcom_glink *glink)
+{
+	return glink->tx_pipe->avail(glink->tx_pipe);
+}
+
+static unsigned int glink_rpm_tx_write_one(struct glink_rpm_pipe *pipe,
+					   unsigned int head,
+					   const void *data, size_t count)
 {
-	struct glink_rpm_pipe *pipe = &glink->tx_pipe;
 	size_t len;
 
-	len = min_t(size_t, count, pipe->length - head);
+	len = min_t(size_t, count, pipe->native.length - head);
 	if (len) {
 		__iowrite32_copy(pipe->fifo + head, data,
 				 len / sizeof(u32));
@@ -300,23 +336,41 @@ static unsigned int qcom_glink_tx_write(struct qcom_glink *glink,
 	}
 
 	head += count;
-	if (head >= pipe->length)
-		head -= pipe->length;
+	if (head >= pipe->native.length)
+		head -= pipe->native.length;
 
 	return head;
 }
 
+static void glink_rpm_tx_write(struct qcom_glink_pipe *glink_pipe,
+			       const void *hdr, size_t hlen,
+			       const void *data, size_t dlen)
+{
+	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
+	unsigned int head;
+
+	head = readl(pipe->head);
+	head = glink_rpm_tx_write_one(pipe, head, hdr, hlen);
+	head = glink_rpm_tx_write_one(pipe, head, data, dlen);
+	writel(head, pipe->head);
+}
+
+static void qcom_glink_tx_write(struct qcom_glink *glink,
+				const void *hdr, size_t hlen,
+				const void *data, size_t dlen)
+{
+	glink->tx_pipe->write(glink->tx_pipe, hdr, hlen, data, dlen);
+}
+
 static int qcom_glink_tx(struct qcom_glink *glink,
 			 const void *hdr, size_t hlen,
 			const void *data, size_t dlen, bool wait)
 {
-	struct glink_rpm_pipe *pipe = &glink->tx_pipe;
-	unsigned int head;
 	unsigned int tlen = hlen + dlen;
 	int ret;
 
 	/* Reject packets that are too big */
-	if (tlen >= glink->tx_pipe.length)
+	if (tlen >= glink->tx_pipe->length)
 		return -EINVAL;
 
 	if (WARN(tlen % 8, "Unaligned TX request"))
@@ -335,10 +389,7 @@ static int qcom_glink_tx(struct qcom_glink *glink,
 		msleep(10);
 	}
 
-	head = readl(pipe->head);
-	head = qcom_glink_tx_write(glink, head, hdr, hlen);
-	head = qcom_glink_tx_write(glink, head, data, dlen);
-	writel(head, pipe->head);
+	qcom_glink_tx_write(glink, hdr, hlen, data, dlen);
 
 	mbox_send_message(glink->mbox_chan, NULL);
 	mbox_client_txdone(glink->mbox_chan, 0);
@@ -1075,14 +1126,14 @@ static int glink_rpm_parse_toc(struct device *dev,
 
 		switch (id) {
 		case RPM_RX_FIFO_ID:
-			rx->length = size;
+			rx->native.length = size;
 
 			rx->tail = msg_ram + offset;
 			rx->head = msg_ram + offset + sizeof(u32);
 			rx->fifo = msg_ram + offset + 2 * sizeof(u32);
 			break;
 		case RPM_TX_FIFO_ID:
-			tx->length = size;
+			tx->native.length = size;
 
 			tx->tail = msg_ram + offset;
 			tx->head = msg_ram + offset + sizeof(u32);
@@ -1107,6 +1158,8 @@ static int glink_rpm_parse_toc(struct device *dev,
 static int glink_rpm_probe(struct platform_device *pdev)
 {
 	struct qcom_glink *glink;
+	struct glink_rpm_pipe *rx_pipe;
+	struct glink_rpm_pipe *tx_pipe;
 	struct device_node *np;
 	void __iomem *msg_ram;
 	size_t msg_ram_size;
@@ -1121,6 +1174,11 @@ static int glink_rpm_probe(struct platform_device *pdev)
 
 	glink->dev = dev;
 
+	rx_pipe = devm_kzalloc(&pdev->dev, sizeof(*rx_pipe), GFP_KERNEL);
+	tx_pipe = devm_kzalloc(&pdev->dev, sizeof(*tx_pipe), GFP_KERNEL);
+	if (!rx_pipe || !tx_pipe)
+		return -ENOMEM;
+
 	mutex_init(&glink->tx_lock);
 	spin_lock_init(&glink->rx_lock);
 	INIT_LIST_HEAD(&glink->rx_queue);
@@ -1150,12 +1208,22 @@ static int glink_rpm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = glink_rpm_parse_toc(dev, msg_ram, msg_ram_size,
-				  &glink->rx_pipe, &glink->tx_pipe);
+				  rx_pipe, tx_pipe);
 	if (ret)
 		return ret;
 
-	writel(0, glink->tx_pipe.head);
-	writel(0, glink->rx_pipe.tail);
+	/* Pipe specific accessors */
+	rx_pipe->native.avail = glink_rpm_rx_avail;
+	rx_pipe->native.peak = glink_rpm_rx_peak;
+	rx_pipe->native.advance = glink_rpm_rx_advance;
+	tx_pipe->native.avail = glink_rpm_tx_avail;
+	tx_pipe->native.write = glink_rpm_tx_write;
+
+	glink->tx_pipe = &tx_pipe->native;
+	glink->rx_pipe = &rx_pipe->native;
+
+	writel(0, tx_pipe->head);
+	writel(0, rx_pipe->tail);
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(dev, irq,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
