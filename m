From: sricharan@codeaurora.org (Sricharan R)
Date: Thu,  9 Jul 2015 08:55:45 +0530
Subject: [PATCH V4 2/7] qup: i2c: factor out common code for reuse
In-Reply-To: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1436412350-19519-3-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qup_i2c_write/read_one functions can be split to have
the common initialization code and function to loop around
the data bytes separately. This way the initialization code
can be reused while adding v2 tags functionality.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 147 +++++++++++++++++++++++++------------------
 1 file changed, 87 insertions(+), 60 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 81ed120..131dc28 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -324,53 +324,72 @@ static int qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	return ret;
 }
 
-static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static int qup_i2c_wait_for_complete(struct qup_i2c_dev *qup,
+				     struct i2c_msg *msg)
 {
 	unsigned long left;
-	int ret;
-
-	qup->msg = msg;
-	qup->pos = 0;
+	int ret = 0;
 
-	enable_irq(qup->irq);
+	left = wait_for_completion_timeout(&qup->xfer, HZ);
+	if (!left) {
+		writel(1, qup->base + QUP_SW_RESET);
+		ret = -ETIMEDOUT;
+	}
 
-	qup_i2c_set_write_mode(qup, msg);
+	if (qup->bus_err || qup->qup_err) {
+		if (qup->bus_err & QUP_I2C_NACK_FLAG) {
+			dev_err(qup->dev, "NACK from %x\n", msg->addr);
+			ret = -EIO;
+		}
+	}
 
-	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
-	if (ret)
-		goto err;
+	return ret;
+}
 
-	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
+static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	int ret = 0;
 
 	do {
 		ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
 		if (ret)
-			goto err;
+			return ret;
 
 		ret = qup_i2c_issue_write(qup, msg);
 		if (ret)
-			goto err;
+			return ret;
 
 		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
 		if (ret)
-			goto err;
-
-		left = wait_for_completion_timeout(&qup->xfer, HZ);
-		if (!left) {
-			writel(1, qup->base + QUP_SW_RESET);
-			ret = -ETIMEDOUT;
-			goto err;
-		}
+			return ret;
 
-		if (qup->bus_err || qup->qup_err) {
-			if (qup->bus_err & QUP_I2C_NACK_FLAG)
-				dev_err(qup->dev, "NACK from %x\n", msg->addr);
-			ret = -EIO;
-			goto err;
-		}
+		ret = qup_i2c_wait_for_complete(qup, msg);
+		if (ret)
+			return ret;
 	} while (qup->pos < msg->len);
 
-	/* Wait for the outstanding data in the fifo to drain */
+	return ret;
+}
+
+static int qup_i2c_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	int ret;
+
+	qup->msg = msg;
+	qup->pos = 0;
+	enable_irq(qup->irq);
+	qup_i2c_set_write_mode(qup, msg);
+
+	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+	if (ret)
+		goto err;
+
+	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
+
+	ret = qup_i2c_write_one(qup, msg);
+	if (ret)
+		goto err;
+
 	ret = qup_i2c_wait_ready(qup, QUP_OUT_NOT_EMPTY, RESET_BIT, ONE_BYTE);
 
 err:
@@ -436,51 +455,59 @@ static int qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 
 static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
-	unsigned long left;
-	int ret;
+	int ret = 0;
 
-	qup->msg = msg;
-	qup->pos  = 0;
+	/*
+	 * The QUP block will issue a NACK and STOP on the bus when reaching
+	 * the end of the read, the length of the read is specified as one byte
+	 * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
+	 */
+	if (msg->len > QUP_READ_LIMIT) {
+		dev_err(qup->dev, "HW not capable of reads over %d bytes\n",
+			QUP_READ_LIMIT);
+		return -EINVAL;
+	}
 
-	enable_irq(qup->irq);
+	ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
+	if (ret)
+		return ret;
 
-	qup_i2c_set_read_mode(qup, msg->len);
+	qup_i2c_issue_read(qup, msg);
 
 	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
 	if (ret)
-		goto err;
+		return ret;
 
-	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
+	do {
+		ret = qup_i2c_wait_for_complete(qup, msg);
+		if (ret)
+			return ret;
+		ret = qup_i2c_read_fifo(qup, msg);
+		if (ret)
+			return ret;
+	} while (qup->pos < msg->len);
 
-	ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
-	if (ret)
-		goto err;
+	return ret;
+}
 
-	qup_i2c_issue_read(qup, msg);
+static int qup_i2c_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	int ret;
+
+	qup->msg = msg;
+	qup->pos  = 0;
+
+	enable_irq(qup->irq);
+
+	qup_i2c_set_read_mode(qup, msg->len);
 
 	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
 	if (ret)
 		goto err;
 
-	do {
-		left = wait_for_completion_timeout(&qup->xfer, HZ);
-		if (!left) {
-			writel(1, qup->base + QUP_SW_RESET);
-			ret = -ETIMEDOUT;
-			goto err;
-		}
-
-		if (qup->bus_err || qup->qup_err) {
-			if (qup->bus_err & QUP_I2C_NACK_FLAG)
-				dev_err(qup->dev, "NACK from %x\n", msg->addr);
-			ret = -EIO;
-			goto err;
-		}
+	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
 
-		ret = qup_i2c_read_fifo(qup, msg);
-		if (ret)
-			goto err;
-	} while (qup->pos < msg->len);
+	ret = qup_i2c_read_one(qup, msg);
 
 err:
 	disable_irq(qup->irq);
@@ -520,9 +547,9 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 		}
 
 		if (msgs[idx].flags & I2C_M_RD)
-			ret = qup_i2c_read_one(qup, &msgs[idx]);
+			ret = qup_i2c_read(qup, &msgs[idx]);
 		else
-			ret = qup_i2c_write_one(qup, &msgs[idx]);
+			ret = qup_i2c_write(qup, &msgs[idx]);
 
 		if (ret)
 			break;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
