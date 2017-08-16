From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:49:05 +0530
Subject: [PATCH 12/18] rpmsg: glink: Make RX FIFO peak accessor to take an
 offset
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-13-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

To fully read the received rx data from FIFO both the
command and data has to be read. Currently we read
command, data separately and process them. By adding
an offset parameter to RX FIFO peak accessor, command
and data can be read together, simplifying things.
So introduce this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 15 +++++++--------
 drivers/rpmsg/qcom_glink_native.h |  2 +-
 drivers/rpmsg/qcom_glink_rpm.c    |  5 ++++-
 drivers/rpmsg/qcom_glink_smem.c   |  5 ++++-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index d6aa589..b2a583a 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -226,9 +226,9 @@ static size_t qcom_glink_rx_avail(struct qcom_glink *glink)
 }
 
 static void qcom_glink_rx_peak(struct qcom_glink *glink,
-			       void *data, size_t count)
+			       void *data, unsigned int offset, size_t count)
 {
-	glink->rx_pipe->peak(glink->rx_pipe, data, count);
+	glink->rx_pipe->peak(glink->rx_pipe, data, offset, count);
 }
 
 static void qcom_glink_rx_advance(struct qcom_glink *glink, size_t count)
@@ -593,7 +593,7 @@ static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
 
 	INIT_LIST_HEAD(&dcmd->node);
 
-	qcom_glink_rx_peak(glink, &dcmd->msg, sizeof(dcmd->msg) + extra);
+	qcom_glink_rx_peak(glink, &dcmd->msg, 0, sizeof(dcmd->msg) + extra);
 
 	spin_lock(&glink->rx_lock);
 	list_add_tail(&dcmd->node, &glink->rx_queue);
@@ -626,7 +626,7 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 		return -EAGAIN;
 	}
 
-	qcom_glink_rx_peak(glink, &hdr, sizeof(hdr));
+	qcom_glink_rx_peak(glink, &hdr, 0, sizeof(hdr));
 	chunk_size = le32_to_cpu(hdr.chunk_size);
 	left_size = le32_to_cpu(hdr.left_size);
 
@@ -693,9 +693,8 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 		goto advance_rx;
 	}
 
-	qcom_glink_rx_advance(glink, ALIGN(sizeof(hdr), 8));
 	qcom_glink_rx_peak(glink, intent->data + intent->offset,
-			   chunk_size);
+			   sizeof(hdr), chunk_size);
 	intent->offset += chunk_size;
 
 	/* Handle message when no fragments remain to be received */
@@ -715,7 +714,7 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 	}
 
 advance_rx:
-	qcom_glink_rx_advance(glink, ALIGN(chunk_size, 8));
+	qcom_glink_rx_advance(glink, ALIGN(sizeof(hdr) + chunk_size, 8));
 
 	return ret;
 }
@@ -752,7 +751,7 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 		if (avail < sizeof(msg))
 			break;
 
-		qcom_glink_rx_peak(glink, &msg, sizeof(msg));
+		qcom_glink_rx_peak(glink, &msg, 0, sizeof(msg));
 
 		cmd = le16_to_cpu(msg.cmd);
 		param1 = le16_to_cpu(msg.param1);
diff --git a/drivers/rpmsg/qcom_glink_native.h b/drivers/rpmsg/qcom_glink_native.h
index d7538c3..0e1e420 100644
--- a/drivers/rpmsg/qcom_glink_native.h
+++ b/drivers/rpmsg/qcom_glink_native.h
@@ -24,7 +24,7 @@ struct qcom_glink_pipe {
 	size_t (*avail)(struct qcom_glink_pipe *glink_pipe);
 
 	void (*peak)(struct qcom_glink_pipe *glink_pipe, void *data,
-		     size_t count);
+		     unsigned int offset, size_t count);
 	void (*advance)(struct qcom_glink_pipe *glink_pipe, size_t count);
 
 	void (*write)(struct qcom_glink_pipe *glink_pipe,
diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
index 5a86e08..69b25d1 100644
--- a/drivers/rpmsg/qcom_glink_rpm.c
+++ b/drivers/rpmsg/qcom_glink_rpm.c
@@ -77,13 +77,16 @@ static size_t glink_rpm_rx_avail(struct qcom_glink_pipe *glink_pipe)
 }
 
 static void glink_rpm_rx_peak(struct qcom_glink_pipe *glink_pipe,
-			      void *data, size_t count)
+			      void *data, unsigned int offset, size_t count)
 {
 	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
 	unsigned int tail;
 	size_t len;
 
 	tail = readl(pipe->tail);
+	tail += offset;
+	if (tail >= pipe->native.length)
+		tail -= pipe->native.length;
 
 	len = min_t(size_t, count, pipe->native.length - tail);
 	if (len) {
diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index e792895..6d8f41f 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -87,13 +87,16 @@ static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
 }
 
 static void glink_smem_rx_peak(struct qcom_glink_pipe *np,
-			       void *data, size_t count)
+			       void *data, unsigned int offset, size_t count)
 {
 	struct glink_smem_pipe *pipe = to_smem_pipe(np);
 	size_t len;
 	u32 tail;
 
 	tail = le32_to_cpu(*pipe->tail);
+	tail += offset;
+	if (tail >= pipe->native.length)
+		tail -= pipe->native.length;
 
 	len = min_t(size_t, count, pipe->native.length - tail);
 	if (len) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
