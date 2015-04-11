From: sricharan@codeaurora.org (Sricharan R)
Date: Sat, 11 Apr 2015 12:39:00 +0530
Subject: [PATCH V3 1/6] i2c: qup: Change qup_wait_writeready function to use
 for all timeouts
In-Reply-To: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
References: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1428736145-18361-2-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

qup_wait_writeready waits only on a output fifo empty event.
Change the same function to accept the event and data length
to wait as parameters. This way the same function can be used for
timeouts in otherplaces as well.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
[v3] Addressed comments from Andy Gross <agross@codeaurora.org>

 drivers/i2c/busses/i2c-qup.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 4dad23b..9ccf3e8 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -98,6 +98,9 @@
 #define QUP_STATUS_ERROR_FLAGS		0x7c
 
 #define QUP_READ_LIMIT			256
+#define SET_BIT				0x1
+#define RESET_BIT			0x0
+#define ONE_BYTE			0x1
 
 struct qup_i2c_dev {
 	struct device		*dev;
@@ -221,26 +224,42 @@ static int qup_i2c_change_state(struct qup_i2c_dev *qup, u32 state)
 	return 0;
 }
 
-static int qup_i2c_wait_writeready(struct qup_i2c_dev *qup)
+/**
+ * qup_i2c_wait_ready - wait for a give number of bytes in tx/rx path
+ * @qup: The qup_i2c_dev device
+ * @op: The bit/event to wait on
+ * @val: value of the bit to wait on, 0 or 1
+ * @len: The length the bytes to be transferred
+ */
+static int qup_i2c_wait_ready(struct qup_i2c_dev *qup, int op, bool val,
+			      int len)
 {
 	unsigned long timeout;
 	u32 opflags;
 	u32 status;
+	u32 shift = __ffs(op);
 
-	timeout = jiffies + HZ;
+	len *= qup->one_byte_t;
+	/* timeout after a wait of twice the max time */
+	timeout = jiffies + len * 4;
 
 	for (;;) {
 		opflags = readl(qup->base + QUP_OPERATIONAL);
 		status = readl(qup->base + QUP_I2C_STATUS);
 
-		if (!(opflags & QUP_OUT_NOT_EMPTY) &&
-		    !(status & I2C_STATUS_BUS_ACTIVE))
-			return 0;
+		if (((opflags & op) >> shift) == val) {
+			if (op == QUP_OUT_NOT_EMPTY) {
+				if (!(status & I2C_STATUS_BUS_ACTIVE))
+					return 0;
+			} else {
+				return 0;
+			}
+		}
 
 		if (time_after(jiffies, timeout))
 			return -ETIMEDOUT;
 
-		usleep_range(qup->one_byte_t, qup->one_byte_t * 2);
+		usleep_range(len, len * 2);
 	}
 }
 
@@ -347,7 +366,7 @@ static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	} while (qup->pos < msg->len);
 
 	/* Wait for the outstanding data in the fifo to drain */
-	ret = qup_i2c_wait_writeready(qup);
+	ret = qup_i2c_wait_ready(qup, QUP_OUT_NOT_EMPTY, RESET_BIT, ONE_BYTE);
 
 err:
 	disable_irq(qup->irq);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
