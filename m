From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 16 Aug 2017 22:49:00 +0530
Subject: [PATCH 07/18] rpmsg: glink: Fix default case while handling received
 commands
In-Reply-To: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1502903951-5403-8-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently if we receive a command that we still do not
support, then its simply discarded. While doing so, the
RX FIFO pointer also needs to be incremented. Fixing this.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 1aa92daf..dd22a23 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -540,6 +540,7 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 			ret = 0;
 			break;
 		default:
+			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
 			ret = -EINVAL;
 			break;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
