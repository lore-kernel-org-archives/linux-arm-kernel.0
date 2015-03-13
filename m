From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 13 Mar 2015 23:19:50 +0530
Subject: [PATCH 4/6] i2c: qup: Transfer every i2c_msg in i2c_msgs without stop
In-Reply-To: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1426268992-19298-5-git-send-email-sricharan@codeaurora.org>
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

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 192 ++++++++++++++++++++++++++-----------------
 1 file changed, 115 insertions(+), 77 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 11ea6af..90a2b5e 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -846,75 +846,91 @@ void qup_sg_set_buf(struct scatterlist *sg, void *buf, struct tag *tg,
 		sg_dma_address(sg) = tg->addr + ((u8 *) buf - tg->start);
 }
 
-static int bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static int bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg, int num)
 {
 	struct dma_async_tx_descriptor *txd, *rxd = NULL;
 	int ret = 0;
 	dma_cookie_t cookie_rx, cookie_tx;
-	u32 rx_nents = 0, tx_nents = 0, len = 0;
-	/* QUP I2C read/write limit for single command is 256bytes max*/
-	int blocks = (msg->len + QUP_READ_LIMIT) / QUP_READ_LIMIT;
-	int rem = msg->len % QUP_READ_LIMIT;
-	int tlen, i = 0, tx_len = 0;
-
-	if (msg->flags & I2C_M_RD) {
-		tx_nents = 1;
-		rx_nents = (blocks << 1) + 1;
-		sg_init_table(qup->sg_rx, rx_nents);
-
-		while (i < blocks) {
-			/* transfer length set to '0' implies 256 bytes */
-			tlen = (i == (blocks - 1)) ? rem : 0;
-			len += get_start_tag(&qup->start_tag.start[len],
-					      msg, !i, (i == (blocks-1)),
-					      tlen);
-
-			qup_sg_set_buf(&qup->sg_rx[i << 1],
-				       &qup->scratch_tag.start[0],
-				       &qup->scratch_tag,
-				       2, qup, 0, 0);
-
-			qup_sg_set_buf(&qup->sg_rx[(i << 1) + 1],
-				       &msg->buf[QUP_READ_LIMIT * i],
-				       NULL, tlen, qup, 1,
-				       DMA_FROM_DEVICE);
-
-			i++;
-		}
-
-		sg_init_one(qup->sg_tx, &qup->start_tag.start[0], len);
-		qup_sg_set_buf(qup->sg_tx, &qup->start_tag.start[0],
-			       &qup->start_tag, len, qup, 0, 0);
-		qup_sg_set_buf(&qup->sg_rx[i << 1],
-			       &qup->scratch_tag.start[1],
-			       &qup->scratch_tag, 2,
-			       qup, 0, 0);
-	} else {
-		qup->footer_tag.start[0] = QUP_BAM_FLUSH_STOP;
-		qup->footer_tag.start[1] = QUP_BAM_FLUSH_STOP;
-
-		tx_nents = (blocks << 1) + 1;
-		sg_init_table(qup->sg_tx, tx_nents);
-
-		while (i < blocks) {
-			tlen = (i == (blocks - 1)) ? rem : 0;
-			len = get_start_tag(&qup->start_tag.start[tx_len],
-					    msg, !i, (i == (blocks-1)), tlen);
-
-			qup_sg_set_buf(&qup->sg_tx[i << 1],
-				       &qup->start_tag.start[tx_len],
-				       &qup->start_tag,
-				       len, qup, 0, 0);
-
-			tx_len += len;
-			qup_sg_set_buf(&qup->sg_tx[(i << 1) + 1],
-				       &msg->buf[QUP_READ_LIMIT * i], NULL,
-				       tlen, qup, 1, DMA_TO_DEVICE);
-			i++;
+	u32 rx_nents = 0, tx_nents = 0, len, blocks, rem, last;
+	u32 cur_rx_nents, cur_tx_nents;
+	u32 tlen, i, tx_len, tx_buf = 0, rx_buf = 0, off = 0;
+
+	while (num) {
+		blocks = (msg->len + QUP_READ_LIMIT) / QUP_READ_LIMIT;
+		rem = msg->len % QUP_READ_LIMIT;
+		i = 0, tx_len = 0, len = 0;
+
+		if (msg->flags & I2C_M_RD) {
+			cur_tx_nents = 1;
+			cur_rx_nents = (blocks << 1) + 1;
+			rx_nents += cur_rx_nents;
+			tx_nents += cur_tx_nents;
+
+			while (i < blocks) {
+				/* transfer length set to '0' implies 256
+				   bytes */
+				tlen = (i == (blocks - 1)) ? rem : 0;
+				last = (i == (blocks-1)) && !(num-1);
+				len += get_start_tag(&qup->start_tag.start[off +
+									   len],
+						     msg, !i, last, tlen);
+
+				qup_sg_set_buf(&qup->sg_rx[rx_buf++],
+					   &qup->scratch_tag.start[0],
+					   &qup->scratch_tag,
+					   2, qup, 0, 0);
+
+				qup_sg_set_buf(&qup->sg_rx[rx_buf++],
+					   &msg->buf[QUP_READ_LIMIT * i],
+					   NULL, tlen, qup,
+					   1, DMA_FROM_DEVICE);
+				i++;
+			}
+			qup_sg_set_buf(&qup->sg_tx[tx_buf++],
+				   &qup->start_tag.start[off],
+				   &qup->start_tag, len, qup, 0, 0);
+			off += len;
+			qup_sg_set_buf(&qup->sg_rx[rx_buf++],
+				   &qup->scratch_tag.start[1],
+				   &qup->scratch_tag, 2,
+				   qup, 0, 0);
+		} else {
+			cur_tx_nents = (blocks << 1);
+			tx_nents += cur_tx_nents;
+
+			while (i < blocks) {
+				tlen = (i == (blocks - 1)) ? rem : 0;
+				last = (i == (blocks-1)) && !(num-1);
+				len = get_start_tag(&qup->start_tag.start[off +
+									tx_len],
+						    msg, !i, last, tlen);
+
+				qup_sg_set_buf(&qup->sg_tx[tx_buf++],
+					       &qup->start_tag.start[off +
+								     tx_len],
+					       &qup->start_tag, len,
+					       qup, 0, 0);
+
+				tx_len += len;
+				qup_sg_set_buf(&qup->sg_tx[tx_buf++],
+					   &msg->buf[QUP_READ_LIMIT * i], NULL,
+					   tlen, qup, 1, DMA_TO_DEVICE);
+				i++;
+			}
+			off += tx_len;
+
+			if (!(num-1)) {
+				qup->footer_tag.start[0] = QUP_BAM_FLUSH_STOP;
+				qup->footer_tag.start[1] = QUP_BAM_FLUSH_STOP;
+				qup_sg_set_buf(&qup->sg_tx[tx_buf++],
+					       &qup->footer_tag.start[0],
+					       &qup->footer_tag, 2,
+					       qup, 0, 0);
+				tx_nents += 1;
+			}
 		}
-		qup_sg_set_buf(&qup->sg_tx[i << 1], &qup->footer_tag.start[0],
-			       &qup->footer_tag, 2,
-			       qup, 0, 0);
+		msg++;
+		num--;
 	}
 
 	txd = dmaengine_prep_slave_sg(qup->dma_tx, qup->sg_tx, tx_nents,
@@ -965,6 +981,9 @@ static int bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 		qup_i2c_flush(qup);
 		qup_i2c_change_state(qup, QUP_RUN_STATE);
 
+		writel(QUP_BAM_INPUT_EOT, qup->base + QUP_OUT_FIFO_BASE);
+		writel(QUP_BAM_FLUSH_STOP, qup->base + QUP_OUT_FIFO_BASE);
+
 		/* wait for remaining interrupts to occur */
 		if (!wait_for_completion_timeout(&qup->xfer, HZ))
 			dev_err(qup->dev, "flush timed out\n");
@@ -974,7 +993,7 @@ desc_err:
 	return ret;
 }
 
-static int qup_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg)
+static int qup_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 {
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
 	int ret = 0;
@@ -1001,7 +1020,7 @@ static int qup_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg)
 	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
 
 	qup->msg = msg;
-	ret = bam_do_xfer(qup, qup->msg);
+	ret = bam_do_xfer(qup, qup->msg, num);
 out:
 	disable_irq(qup->irq);
 
@@ -1014,7 +1033,7 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 			int num)
 {
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
-	int ret, idx, len;
+	int ret, idx, use_dma = 0, len = 0;
 
 	ret = pm_runtime_get_sync(qup->dev);
 	if (ret < 0)
@@ -1033,12 +1052,28 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 		writel(I2C_MINI_CORE | I2C_N_VAL, qup->base + QUP_CONFIG);
 	}
 
-	for (idx = 0; idx < num; idx++) {
-		if (msgs[idx].len == 0) {
-			ret = -EINVAL;
-			goto out;
+	if ((qup->is_dma)) {
+		/* All i2c_msgs should be transferred using either dma or cpu */
+		for (idx = 0; idx < num; idx++) {
+			if (msgs[idx].len == 0) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			if (!len)
+				len = ((&msgs[idx])->len) > qup->out_fifo_sz;
+
+
+			if ((!is_vmalloc_addr((&msgs[idx])->buf)) && len) {
+				use_dma = 1;
+			 } else {
+				use_dma = 0;
+				break;
+			}
 		}
+	}
 
+	for (idx = 0; idx < num; idx++) {
 		if (qup_i2c_poll_state_i2c_master(qup)) {
 			ret = -EIO;
 			goto out;
@@ -1046,11 +1081,9 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 
 		reinit_completion(&qup->xfer);
 
-		len = (&msgs[idx])->len;
-
-		if ((qup->is_dma) && (!is_vmalloc_addr((&msgs[idx])->buf)) &&
-						(len > qup->out_fifo_sz)) {
-			ret = qup_bam_xfer(adap, &msgs[idx]);
+		if (use_dma) {
+			ret = qup_bam_xfer(adap, &msgs[idx], num);
+			idx = num;
 		} else {
 			if (msgs[idx].flags & I2C_M_RD)
 				ret = qup_i2c_read_one(qup, &msgs[idx]);
@@ -1191,15 +1224,20 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		qup->sg_tx = devm_kzalloc(&pdev->dev,
 					  sizeof(*qup->sg_tx) * blocks,
 					  GFP_KERNEL);
+
 		if (!qup->sg_tx)
 			return -ENOMEM;
 
+		sg_init_table(qup->sg_tx, blocks);
+
 		qup->sg_rx = devm_kzalloc(&pdev->dev,
-					  sizeof(*qup->sg_tx) * blocks,
+					  sizeof(*qup->sg_rx) * blocks,
 					  GFP_KERNEL);
 		if (!qup->sg_rx)
 			return -ENOMEM;
 
+		sg_init_table(qup->sg_rx, blocks);
+
 		size = sizeof(struct tag) * (blocks + 3);
 		qup->dpool = dma_pool_create("qup_i2c-dma-pool", &pdev->dev,
 					 size, 4, 0);
-- 
1.8.2.1
