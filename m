From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  2 Sep 2015 15:46:50 -0700
Subject: [PATCH v2 7/8] soc: qcom: smd_rpm: Handle big endian CPUs
In-Reply-To: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1441234011-4259-8-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smd rpm structures are always in little endian, but this
driver is not capable of being used on big endian CPUs. Annotate
the little endian data members and update the code to do the
proper byte swapping.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
 * New patch

 drivers/soc/qcom/smd-rpm.c | 50 ++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index e86c206b9e97..a79a804e338d 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -45,8 +45,8 @@ struct qcom_smd_rpm {
  * @length:		length of the payload
  */
 struct qcom_rpm_header {
-	u32 service_type;
-	u32 length;
+	__le32 service_type;
+	__le32 length;
 };
 
 /**
@@ -58,11 +58,11 @@ struct qcom_rpm_header {
  * @data_len:	length of the payload following this header
  */
 struct qcom_rpm_request {
-	u32 msg_id;
-	u32 flags;
-	u32 type;
-	u32 id;
-	u32 data_len;
+	__le32 msg_id;
+	__le32 flags;
+	__le32 type;
+	__le32 id;
+	__le32 data_len;
 };
 
 /**
@@ -75,10 +75,10 @@ struct qcom_rpm_request {
  * Multiple of these messages can be stacked in an rpm message.
  */
 struct qcom_rpm_message {
-	u32 msg_type;
-	u32 length;
+	__le32 msg_type;
+	__le32 length;
 	union {
-		u32 msg_id;
+		__le32 msg_id;
 		u8 message[0];
 	};
 };
@@ -122,14 +122,14 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 
 	mutex_lock(&rpm->lock);
 
-	pkt->hdr.service_type = RPM_SERVICE_TYPE_REQUEST;
-	pkt->hdr.length = sizeof(struct qcom_rpm_request) + count;
+	pkt->hdr.service_type = cpu_to_le32(RPM_SERVICE_TYPE_REQUEST);
+	pkt->hdr.length = cpu_to_le32(sizeof(struct qcom_rpm_request) + count);
 
-	pkt->req.msg_id = msg_id++;
-	pkt->req.flags = BIT(state);
-	pkt->req.type = type;
-	pkt->req.id = id;
-	pkt->req.data_len = count;
+	pkt->req.msg_id = cpu_to_le32(msg_id++);
+	pkt->req.flags = cpu_to_le32(BIT(state));
+	pkt->req.type = cpu_to_le32(type);
+	pkt->req.id = cpu_to_le32(id);
+	pkt->req.data_len = cpu_to_le32(count);
 	memcpy(pkt->payload, buf, count);
 
 	ret = qcom_smd_send(rpm->rpm_channel, pkt, sizeof(*pkt));
@@ -154,27 +154,29 @@ static int qcom_smd_rpm_callback(struct qcom_smd_device *qsdev,
 				 size_t count)
 {
 	const struct qcom_rpm_header *hdr = data;
+	size_t hdr_length = le32_to_cpu(hdr->length);
 	const struct qcom_rpm_message *msg;
 	struct qcom_smd_rpm *rpm = dev_get_drvdata(&qsdev->dev);
 	const u8 *buf = data + sizeof(struct qcom_rpm_header);
-	const u8 *end = buf + hdr->length;
+	const u8 *end = buf + hdr_length;
 	char msgbuf[32];
 	int status = 0;
-	u32 len;
+	u32 len, msg_length;
 
-	if (hdr->service_type != RPM_SERVICE_TYPE_REQUEST ||
-	    hdr->length < sizeof(struct qcom_rpm_message)) {
+	if (le32_to_cpu(hdr->service_type) != RPM_SERVICE_TYPE_REQUEST ||
+	    hdr_length < sizeof(struct qcom_rpm_message)) {
 		dev_err(&qsdev->dev, "invalid request\n");
 		return 0;
 	}
 
 	while (buf < end) {
 		msg = (struct qcom_rpm_message *)buf;
-		switch (msg->msg_type) {
+		msg_length = le32_to_cpu(msg->length);
+		switch (le32_to_cpu(msg->msg_type)) {
 		case RPM_MSG_TYPE_MSG_ID:
 			break;
 		case RPM_MSG_TYPE_ERR:
-			len = min_t(u32, ALIGN(msg->length, 4), sizeof(msgbuf));
+			len = min_t(u32, ALIGN(msg_length, 4), sizeof(msgbuf));
 			memcpy_fromio(msgbuf, msg->message, len);
 			msgbuf[len - 1] = 0;
 
@@ -185,7 +187,7 @@ static int qcom_smd_rpm_callback(struct qcom_smd_device *qsdev,
 			break;
 		}
 
-		buf = PTR_ALIGN(buf + 2 * sizeof(u32) + msg->length, 4);
+		buf = PTR_ALIGN(buf + 2 * sizeof(u32) + msg_length, 4);
 	}
 
 	rpm->ack_status = status;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
