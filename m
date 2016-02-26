From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 26 Feb 2016 21:28:54 +0530
Subject: [PATCH] drivers: i2c: Fix qup fifo handling
Message-ID: <1456502334-8687-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the addition of V2 support, there was a regression observed
when testing it on MSM8996. The reason is driver puts the controller
in to RUN state and writes the data to be 'tx' ed in fifo. But controller
has to be put in to 'PAUSE' state and data has to written to fifo. Then
should be put in to 'RUN' state separately.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 46 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 30f3a2b..23eaabb 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -372,6 +372,38 @@ static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	}
 }
 
+static int check_for_fifo_space(struct qup_i2c_dev *qup)
+{
+	int ret;
+
+	ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
+	if (ret)
+		goto out;
+
+	ret = qup_i2c_wait_ready(qup, QUP_OUT_FULL,
+				 RESET_BIT, 4 * ONE_BYTE);
+	if (ret) {
+		/* Fifo is full. Drain out the fifo */
+		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+		if (ret)
+			goto out;
+
+		ret = qup_i2c_wait_ready(qup, QUP_OUT_NOT_EMPTY,
+					 RESET_BIT, 256 * ONE_BYTE);
+		if (ret) {
+			dev_err(qup->dev, "timeout for fifo out full");
+			goto out;
+		}
+
+		ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
+		if (ret)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
 static int qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	u32 addr = msg->addr << 1;
@@ -390,8 +422,7 @@ static int qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 
 	while (qup->pos < msg->len) {
 		/* Check that there's space in the FIFO for our pair */
-		ret = qup_i2c_wait_ready(qup, QUP_OUT_FULL, RESET_BIT,
-					 4 * ONE_BYTE);
+		ret = check_for_fifo_space(qup);
 		if (ret)
 			return ret;
 
@@ -413,6 +444,8 @@ static int qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 		idx++;
 	}
 
+	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+
 	return ret;
 }
 
@@ -441,12 +474,9 @@ static int qup_i2c_send_data(struct qup_i2c_dev *qup, int tlen, u8 *tbuf,
 	int ret = 0;
 
 	while (len > 0) {
-		ret = qup_i2c_wait_ready(qup, QUP_OUT_FULL,
-					 RESET_BIT, 4 * ONE_BYTE);
-		if (ret) {
-			dev_err(qup->dev, "timeout for fifo out full");
+		ret = check_for_fifo_space(qup);
+		if (ret)
 			return ret;
-		}
 
 		t = (len >= 4) ? 4 : len;
 
@@ -465,6 +495,8 @@ static int qup_i2c_send_data(struct qup_i2c_dev *qup, int tlen, u8 *tbuf,
 		len -= 4;
 	}
 
+	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+
 	return ret;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
