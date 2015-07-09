From: sricharan@codeaurora.org (Sricharan R)
Date: Thu,  9 Jul 2015 08:55:47 +0530
Subject: [PATCH V4 4/7] i2c: qup: Transfer each i2c_msg in i2c_msgs without a
 stop bit
In-Reply-To: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1436412350-19519-5-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of i2c_msg says that

"If this is the last message in a group, it is followed by a STOP.
Otherwise it is followed by the next @i2c_msg transaction segment,
beginning with a (repeated) START"

So the expectation is that there is no 'STOP' bit inbetween individual
i2c_msg segments with repeated 'START'. The QUP i2c hardware has no way
to inform that there should not be a 'STOP' at the end of transaction.
The only way to implement this is to coalesce all the i2c_msg in i2c_msgs
in to one transaction and transfer them. Adding the support for the same.

This is required for some clients like touchscreen which keeps
incrementing counts across individual transfers and 'STOP' bit inbetween
resets the counter, which is not required.

This patch adds the support in non-dma mode.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index a4e20d9..c0757d9 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -113,6 +113,7 @@
 #define SET_BIT				0x1
 #define RESET_BIT			0x0
 #define ONE_BYTE			0x1
+#define QUP_I2C_MX_CONFIG_DURING_RUN   BIT(31)
 
 struct qup_i2c_block {
 	int	count;
@@ -121,6 +122,7 @@ struct qup_i2c_block {
 	int	rx_tag_len;
 	int	data_len;
 	u8	tags[6];
+	int     config_run;
 };
 
 struct qup_i2c_dev {
@@ -152,6 +154,10 @@ struct qup_i2c_dev {
 
 	int (*qup_i2c_write_one)(struct qup_i2c_dev *qup,
 				 struct i2c_msg *msg);
+	/* Current i2c_msg in i2c_msgs */
+	int			cmsg;
+	/* total num of i2c_msgs */
+	int			num;
 
 	int (*qup_i2c_read_one)(struct qup_i2c_dev *qup,
 				struct i2c_msg *msg);
@@ -278,7 +284,8 @@ static int qup_i2c_wait_ready(struct qup_i2c_dev *qup, int op, bool val,
 		status = readl(qup->base + QUP_I2C_STATUS);
 
 		if (((opflags & op) >> shift) == val) {
-			if (op == QUP_OUT_NOT_EMPTY) {
+			if ((op == QUP_OUT_NOT_EMPTY) &&
+			    (qup->cmsg == (qup->num - 1))) {
 				if (!(status & I2C_STATUS_BUS_ACTIVE))
 					return 0;
 			} else {
@@ -301,12 +308,14 @@ static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	if (total < qup->out_fifo_sz) {
 		/* FIFO mode */
 		writel(QUP_REPACK_EN, qup->base + QUP_IO_MODE);
-		writel(total, qup->base + QUP_MX_WRITE_CNT);
+		writel(total | qup->blk.config_run,
+		       qup->base + QUP_MX_WRITE_CNT);
 	} else {
 		/* BLOCK mode (transfer data on chunks) */
 		writel(QUP_OUTPUT_BLK_MODE | QUP_REPACK_EN,
 		       qup->base + QUP_IO_MODE);
-		writel(total, qup->base + QUP_MX_OUTPUT_CNT);
+		writel(total | qup->blk.config_run,
+		       qup->base + QUP_MX_OUTPUT_CNT);
 	}
 }
 
@@ -374,6 +383,9 @@ static void qup_i2c_get_blk_data(struct qup_i2c_dev *qup,
 	/* There are 2 tag bytes that are read in to fifo for every block */
 	if (msg->flags & I2C_M_RD)
 		qup->blk.rx_tag_len = qup->blk.count * 2;
+
+	if (qup->cmsg)
+		qup->blk.config_run = QUP_I2C_MX_CONFIG_DURING_RUN;
 }
 
 static int qup_i2c_send_data(struct qup_i2c_dev *qup, int tlen, u8 *tbuf,
@@ -440,7 +452,8 @@ static int qup_i2c_get_tags(u8 *tags, struct qup_i2c_dev *qup,
 	}
 
 	/* Send _STOP commands for the last block */
-	if (qup->blk.pos == (qup->blk.count - 1)) {
+	if (qup->blk.pos == (qup->blk.count - 1)
+	    && (qup->cmsg == (qup->num - 1))) {
 		if (msg->flags & I2C_M_RD)
 			tags[len++] = QUP_TAG_V2_DATARD_STOP;
 		else
@@ -571,7 +584,6 @@ static int qup_i2c_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 		goto err;
 
 	ret = qup_i2c_wait_ready(qup, QUP_OUT_NOT_EMPTY, RESET_BIT, ONE_BYTE);
-
 err:
 	disable_irq(qup->irq);
 	qup->msg = NULL;
@@ -584,18 +596,19 @@ static void qup_i2c_set_read_mode(struct qup_i2c_dev *qup, int len)
 	int tx_len = qup->blk.tx_tag_len;
 
 	len += qup->blk.rx_tag_len;
+	tx_len |= qup->blk.config_run;
 
 	if (len < qup->in_fifo_sz) {
 		/* FIFO mode */
 		writel(QUP_REPACK_EN, qup->base + QUP_IO_MODE);
-		writel(len, qup->base + QUP_MX_READ_CNT);
 		writel(tx_len, qup->base + QUP_MX_WRITE_CNT);
+		writel(len | qup->blk.config_run, qup->base + QUP_MX_READ_CNT);
 	} else {
 		/* BLOCK mode (transfer data on chunks) */
 		writel(QUP_INPUT_BLK_MODE | QUP_REPACK_EN,
 		       qup->base + QUP_IO_MODE);
-		writel(len, qup->base + QUP_MX_INPUT_CNT);
 		writel(tx_len, qup->base + QUP_MX_OUTPUT_CNT);
+		writel(len | qup->blk.config_run, qup->base + QUP_MX_INPUT_CNT);
 	}
 }
 
@@ -770,6 +783,8 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
 	int ret, idx;
 
+	qup->num = 1;
+
 	ret = pm_runtime_get_sync(qup->dev);
 	if (ret < 0)
 		goto out;
@@ -823,6 +838,9 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
 	int ret, idx;
 
+	qup->num = num;
+	qup->cmsg = 0;
+
 	ret = pm_runtime_get_sync(qup->dev);
 	if (ret < 0)
 		goto out;
@@ -854,13 +872,15 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 		else
 			ret = qup_i2c_write(qup, &msgs[idx]);
 
-		if (!ret)
-			ret = qup_i2c_change_state(qup, QUP_RESET_STATE);
-
 		if (ret)
 			break;
+
+		qup->cmsg++;
 	}
 
+	if (!ret)
+		ret = qup_i2c_change_state(qup, QUP_RESET_STATE);
+
 	if (ret == 0)
 		ret = num;
 out:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
