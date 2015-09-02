From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  2 Sep 2015 15:46:48 -0700
Subject: [PATCH v2 5/8] soc: qcom: smd: Remove use of VLAIS
In-Reply-To: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1441234011-4259-6-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of VLAIS prevents clang from compiling this file, and it
also opens us to the possibility of allocating a large structure
on the stack to the point that we blow past the limit of the
kernel stack. Remove the VLAIS and allocate a structure on the
heap with kmalloc so that we're safer and more clang friendly.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
 * New patch

 drivers/soc/qcom/smd-rpm.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 1392ccf14a20..7709579d63d0 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/slab.h>
 
 #include <linux/soc/qcom/smd.h>
 #include <linux/soc/qcom/smd-rpm.h>
@@ -104,30 +105,34 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 	static unsigned msg_id = 1;
 	int left;
 	int ret;
-
 	struct {
 		struct qcom_rpm_header hdr;
 		struct qcom_rpm_request req;
-		u8 payload[count];
-	} pkt;
+		u8 payload[];
+	} *pkt;
+	size_t size = sizeof(*pkt) + count;
 
 	/* SMD packets to the RPM may not exceed 256 bytes */
-	if (WARN_ON(sizeof(pkt) >= 256))
+	if (WARN_ON(size >= 256))
 		return -EINVAL;
 
+	pkt = kmalloc(size, GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+
 	mutex_lock(&rpm->lock);
 
-	pkt.hdr.service_type = RPM_SERVICE_TYPE_REQUEST;
-	pkt.hdr.length = sizeof(struct qcom_rpm_request) + count;
+	pkt->hdr.service_type = RPM_SERVICE_TYPE_REQUEST;
+	pkt->hdr.length = sizeof(struct qcom_rpm_request) + count;
 
-	pkt.req.msg_id = msg_id++;
-	pkt.req.flags = BIT(state);
-	pkt.req.type = type;
-	pkt.req.id = id;
-	pkt.req.data_len = count;
-	memcpy(pkt.payload, buf, count);
+	pkt->req.msg_id = msg_id++;
+	pkt->req.flags = BIT(state);
+	pkt->req.type = type;
+	pkt->req.id = id;
+	pkt->req.data_len = count;
+	memcpy(pkt->payload, buf, count);
 
-	ret = qcom_smd_send(rpm->rpm_channel, &pkt, sizeof(pkt));
+	ret = qcom_smd_send(rpm->rpm_channel, pkt, sizeof(*pkt));
 	if (ret)
 		goto out;
 
@@ -138,6 +143,7 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 		ret = rpm->ack_status;
 
 out:
+	kfree(pkt);
 	mutex_unlock(&rpm->lock);
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
