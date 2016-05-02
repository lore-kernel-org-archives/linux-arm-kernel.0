From: sricharan@codeaurora.org (Sricharan R)
Date: Mon,  2 May 2016 10:53:57 +0530
Subject: [PATCH 2/2] drivers: i2c: qup: Fix error handling
In-Reply-To: <1462166637-16778-1-git-send-email-sricharan@codeaurora.org>
References: <1462166637-16778-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1462166637-16778-3-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Among the bus errors reported from the QUP_MASTER_STATUS register
only NACK is considered and transfer gets suspended, while
other errors are ignored. Correct this and suspend the transfer
for other errors as well. This avoids unnessecary 'timeouts' which
happens when waiting for events that would never happen when there
is already an error condition on the bus.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 8620e99..8afb733 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -310,6 +310,7 @@ static int qup_i2c_wait_ready(struct qup_i2c_dev *qup, int op, bool val,
 	u32 opflags;
 	u32 status;
 	u32 shift = __ffs(op);
+	int ret = 0;
 
 	len *= qup->one_byte_t;
 	/* timeout after a wait of twice the max time */
@@ -321,18 +322,31 @@ static int qup_i2c_wait_ready(struct qup_i2c_dev *qup, int op, bool val,
 
 		if (((opflags & op) >> shift) == val) {
 			if ((op == QUP_OUT_NOT_EMPTY) && qup->is_last) {
-				if (!(status & I2C_STATUS_BUS_ACTIVE))
-					return 0;
+				if (!(status & I2C_STATUS_BUS_ACTIVE)) {
+					ret = 0;
+					goto done;
+				}
 			} else {
-				return 0;
+				ret = 0;
+				goto done;
 			}
 		}
 
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
-
+		if (time_after(jiffies, timeout)) {
+			ret = -ETIMEDOUT;
+			goto done;
+		}
 		usleep_range(len, len * 2);
 	}
+
+done:
+	if (qup->bus_err || qup->qup_err) {
+		if (qup->bus_err & QUP_I2C_NACK_FLAG)
+			dev_err(qup->dev, "NACK from %x\n", qup->msg->addr);
+		ret = -EIO;
+	}
+
+	return ret;
 }
 
 static void qup_i2c_set_write_mode_v2(struct qup_i2c_dev *qup,
@@ -882,10 +896,9 @@ static int qup_i2c_wait_for_complete(struct qup_i2c_dev *qup,
 	}
 
 	if (qup->bus_err || qup->qup_err) {
-		if (qup->bus_err & QUP_I2C_NACK_FLAG) {
+		if (qup->bus_err & QUP_I2C_NACK_FLAG)
 			dev_err(qup->dev, "NACK from %x\n", msg->addr);
-			ret = -EIO;
-		}
+		ret = -EIO;
 	}
 
 	return ret;
@@ -1227,6 +1240,9 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
 	int ret, len, idx = 0, use_dma = 0;
 
+	qup->bus_err = 0;
+	qup->qup_err = 0;
+
 	ret = pm_runtime_get_sync(qup->dev);
 	if (ret < 0)
 		goto out;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
