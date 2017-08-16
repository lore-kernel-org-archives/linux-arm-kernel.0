From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:48:58 +0530
Subject: [PATCH 05/18] rpmsg: glink: Allow unaligned data access
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-6-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Glink protocol requires that each message is aligned
on a 8 byte offset. This is purely a restriction
from glink, so in order to support clients which
do not adher to this, allow data packets of any size,
but align the head index accordingly, effectively
removing the alignment restriction.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c |  6 ------
 drivers/rpmsg/qcom_glink_rpm.c    | 22 +++++++++++++++++++++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 04afbb2..1aa92daf 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -226,9 +226,6 @@ static int qcom_glink_tx(struct qcom_glink *glink,
 	if (tlen >= glink->tx_pipe->length)
 		return -EINVAL;
 
-	if (WARN(tlen % 8, "Unaligned TX request"))
-		return -EINVAL;
-
 	ret = mutex_lock_interruptible(&glink->tx_lock);
 	if (ret)
 		return ret;
@@ -694,9 +691,6 @@ static int __qcom_glink_send(struct glink_channel *channel,
 		__le32 left_size;
 	} __packed req;
 
-	if (WARN(len % 8, "RPM GLINK expects 8 byte aligned messages\n"))
-		return -EINVAL;
-
 	req.msg.cmd = cpu_to_le16(RPM_CMD_TX_DATA);
 	req.msg.param1 = cpu_to_le16(channel->lcid);
 	req.msg.param2 = cpu_to_le32(channel->rcid);
diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
index 33daa32..cc73af0 100644
--- a/drivers/rpmsg/qcom_glink_rpm.c
+++ b/drivers/rpmsg/qcom_glink_rpm.c
@@ -156,11 +156,31 @@ static void glink_rpm_tx_write(struct qcom_glink_pipe *glink_pipe,
 			       const void *data, size_t dlen)
 {
 	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
+	size_t tlen = hlen + dlen;
+	size_t aligned_dlen;
 	unsigned int head;
+	char padding[8] = {0};
+	size_t pad;
+
+	/* Header length comes from glink native and is always 4 byte aligned */
+	if (WARN(hlen % 4, "Glink Header length must be 4 bytes aligned\n"))
+		return;
+
+	/*
+	 * Move the unaligned tail of the message to the padding chunk, to
+	 * ensure word aligned accesses
+	 */
+	aligned_dlen = ALIGN_DOWN(dlen, 4);
+	if (aligned_dlen != dlen)
+		memcpy(padding, data + aligned_dlen, dlen - aligned_dlen);
 
 	head = readl(pipe->head);
 	head = glink_rpm_tx_write_one(pipe, head, hdr, hlen);
-	head = glink_rpm_tx_write_one(pipe, head, data, dlen);
+	head = glink_rpm_tx_write_one(pipe, head, data, aligned_dlen);
+
+	pad = ALIGN(tlen, 8) - ALIGN_DOWN(tlen, 4);
+	if (pad)
+		head = glink_rpm_tx_write_one(pipe, head, padding, pad);
 	writel(head, pipe->head);
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
