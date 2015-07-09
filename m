From: sricharan@codeaurora.org (Sricharan R)
Date: Thu,  9 Jul 2015 08:55:46 +0530
Subject: [PATCH V4 3/7] i2c: qup: Add V2 tags support
In-Reply-To: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1436412350-19519-4-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

QUP from version 2.1.1 onwards, supports a new format of
i2c command tags. Tag codes instructs the controller to
perform a operation like read/write. This new tagging version
supports bam dma and transfers of more than 256 bytes without 'stop'
in between. Adding the support for the same.

For each block a data_write/read tag and data_len tag is added to
the output fifo. For the final block of data write_stop/read_stop
tag is used.

Signed-off-by: Andy Gross <agross@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 330 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 323 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 131dc28..a4e20d9 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -43,6 +43,8 @@
 #define QUP_I2C_CLK_CTL		0x400
 #define QUP_I2C_STATUS		0x404
 
+#define QUP_I2C_MASTER_GEN	0x408
+
 /* QUP States and reset values */
 #define QUP_RESET_STATE		0
 #define QUP_RUN_STATE		1
@@ -69,6 +71,8 @@
 #define QUP_CLOCK_AUTO_GATE	BIT(13)
 #define I2C_MINI_CORE		(2 << 8)
 #define I2C_N_VAL		15
+#define I2C_N_VAL_V2		7
+
 /* Most significant word offset in FIFO port */
 #define QUP_MSW_SHIFT		(I2C_N_VAL + 1)
 
@@ -79,6 +83,7 @@
 #define QUP_PACK_EN		BIT(15)
 
 #define QUP_REPACK_EN		(QUP_UNPACK_EN | QUP_PACK_EN)
+#define QUP_V2_TAGS_EN		1
 
 #define QUP_OUTPUT_BLOCK_SIZE(x)(((x) >> 0) & 0x03)
 #define QUP_OUTPUT_FIFO_SIZE(x)	(((x) >> 2) & 0x07)
@@ -91,6 +96,13 @@
 #define QUP_TAG_STOP		(3 << 8)
 #define QUP_TAG_REC		(4 << 8)
 
+/* QUP v2 tags */
+#define QUP_TAG_V2_START               0x81
+#define QUP_TAG_V2_DATAWR              0x82
+#define QUP_TAG_V2_DATAWR_STOP         0x83
+#define QUP_TAG_V2_DATARD              0x85
+#define QUP_TAG_V2_DATARD_STOP         0x87
+
 /* Status, Error flags */
 #define I2C_STATUS_WR_BUFFER_FULL	BIT(0)
 #define I2C_STATUS_BUS_ACTIVE		BIT(8)
@@ -102,6 +114,15 @@
 #define RESET_BIT			0x0
 #define ONE_BYTE			0x1
 
+struct qup_i2c_block {
+	int	count;
+	int	pos;
+	int	tx_tag_len;
+	int	rx_tag_len;
+	int	data_len;
+	u8	tags[6];
+};
+
 struct qup_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;
@@ -117,6 +138,7 @@ struct qup_i2c_dev {
 	int			in_blk_sz;
 
 	unsigned long		one_byte_t;
+	struct qup_i2c_block	blk;
 
 	struct i2c_msg		*msg;
 	/* Current posion in user message buffer */
@@ -126,6 +148,14 @@ struct qup_i2c_dev {
 	/* QUP core errors */
 	u32			qup_err;
 
+	int			use_v2_tags;
+
+	int (*qup_i2c_write_one)(struct qup_i2c_dev *qup,
+				 struct i2c_msg *msg);
+
+	int (*qup_i2c_read_one)(struct qup_i2c_dev *qup,
+				struct i2c_msg *msg);
+
 	struct completion	xfer;
 };
 
@@ -266,7 +296,7 @@ static int qup_i2c_wait_ready(struct qup_i2c_dev *qup, int op, bool val,
 static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	/* Number of entries to shift out, including the start */
-	int total = msg->len + 1;
+	int total = msg->len + qup->blk.tx_tag_len;
 
 	if (total < qup->out_fifo_sz) {
 		/* FIFO mode */
@@ -324,6 +354,134 @@ static int qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	return ret;
 }
 
+static void qup_i2c_get_blk_data(struct qup_i2c_dev *qup,
+				 struct i2c_msg *msg)
+{
+	memset(&qup->blk, 0, sizeof(qup->blk));
+
+	if (!qup->use_v2_tags) {
+		if (!(msg->flags & I2C_M_RD))
+			qup->blk.tx_tag_len = 1;
+		return;
+	}
+
+	qup->blk.data_len = msg->len;
+	qup->blk.count = (msg->len + QUP_READ_LIMIT - 1) / QUP_READ_LIMIT;
+
+	/* 4 bytes for first block and 2 writes for rest */
+	qup->blk.tx_tag_len = 4 + (qup->blk.count - 1) * 2;
+
+	/* There are 2 tag bytes that are read in to fifo for every block */
+	if (msg->flags & I2C_M_RD)
+		qup->blk.rx_tag_len = qup->blk.count * 2;
+}
+
+static int qup_i2c_send_data(struct qup_i2c_dev *qup, int tlen, u8 *tbuf,
+			     int dlen, u8 *dbuf)
+{
+	u32 val = 0, idx = 0, pos = 0, i = 0, t;
+	int  len = tlen + dlen;
+	u8 *buf = tbuf;
+	int ret = 0;
+
+	while (len > 0) {
+		ret = qup_i2c_wait_ready(qup, QUP_OUT_FULL,
+					 RESET_BIT, 4 * ONE_BYTE);
+		if (ret) {
+			dev_err(qup->dev, "timeout for fifo out full");
+			return ret;
+		}
+
+		t = (len >= 4) ? 4 : len;
+
+		while (idx < t) {
+			if (!i && (pos >= tlen)) {
+				buf = dbuf;
+				pos = 0;
+				i = 1;
+			}
+			val |= buf[pos++] << (idx++ * 8);
+		}
+
+		writel(val, qup->base + QUP_OUT_FIFO_BASE);
+		idx  = 0;
+		val = 0;
+		len -= 4;
+	}
+
+	return ret;
+}
+
+static int qup_i2c_get_data_len(struct qup_i2c_dev *qup)
+{
+	int data_len;
+
+	if (qup->blk.data_len > QUP_READ_LIMIT)
+		data_len = QUP_READ_LIMIT;
+	else
+		data_len = qup->blk.data_len;
+
+	return data_len;
+}
+
+static int qup_i2c_get_tags(u8 *tags, struct qup_i2c_dev *qup,
+			    struct i2c_msg *msg)
+{
+	u16 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) == I2C_M_RD);
+	int len = 0;
+	int data_len;
+
+	if (qup->blk.pos == 0) {
+		tags[len++] = QUP_TAG_V2_START;
+		tags[len++] = addr & 0xff;
+
+		if (msg->flags & I2C_M_TEN)
+			tags[len++] = addr >> 8;
+	}
+
+	/* Send _STOP commands for the last block */
+	if (qup->blk.pos == (qup->blk.count - 1)) {
+		if (msg->flags & I2C_M_RD)
+			tags[len++] = QUP_TAG_V2_DATARD_STOP;
+		else
+			tags[len++] = QUP_TAG_V2_DATAWR_STOP;
+	} else {
+		if (msg->flags & I2C_M_RD)
+			tags[len++] = QUP_TAG_V2_DATARD;
+		else
+			tags[len++] = QUP_TAG_V2_DATAWR;
+	}
+
+	data_len = qup_i2c_get_data_len(qup);
+
+	/* 0 implies 256 bytes */
+	if (data_len == QUP_READ_LIMIT)
+		tags[len++] = 0;
+	else
+		tags[len++] = data_len;
+
+	return len;
+}
+
+static int qup_i2c_issue_xfer_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	int data_len = 0, tag_len, index;
+	int ret;
+
+	tag_len = qup_i2c_get_tags(qup->blk.tags, qup, msg);
+	index = msg->len - qup->blk.data_len;
+
+	/* only tags are written for read */
+	if (!(msg->flags & I2C_M_RD))
+		data_len = qup_i2c_get_data_len(qup);
+
+	ret = qup_i2c_send_data(qup, tag_len, qup->blk.tags,
+				data_len, &msg->buf[index]);
+	qup->blk.data_len -= data_len;
+
+	return ret;
+}
+
 static int qup_i2c_wait_for_complete(struct qup_i2c_dev *qup,
 				     struct i2c_msg *msg)
 {
@@ -346,7 +504,27 @@ static int qup_i2c_wait_for_complete(struct qup_i2c_dev *qup,
 	return ret;
 }
 
-static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static int qup_i2c_write_one_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	int ret = 0;
+
+	do {
+		ret = qup_i2c_issue_xfer_v2(qup, msg);
+		if (ret)
+			goto err;
+
+		ret = qup_i2c_wait_for_complete(qup, msg);
+		if (ret)
+			goto err;
+
+		qup->blk.pos++;
+	} while (qup->blk.pos < qup->blk.count);
+
+err:
+	return ret;
+}
+
+static int qup_i2c_write_one_v1(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	int ret = 0;
 
@@ -378,6 +556,8 @@ static int qup_i2c_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	qup->msg = msg;
 	qup->pos = 0;
 	enable_irq(qup->irq);
+	qup_i2c_get_blk_data(qup, msg);
+
 	qup_i2c_set_write_mode(qup, msg);
 
 	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
@@ -386,7 +566,7 @@ static int qup_i2c_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 
 	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
 
-	ret = qup_i2c_write_one(qup, msg);
+	ret = qup->qup_i2c_write_one(qup, msg);
 	if (ret)
 		goto err;
 
@@ -401,15 +581,21 @@ err:
 
 static void qup_i2c_set_read_mode(struct qup_i2c_dev *qup, int len)
 {
+	int tx_len = qup->blk.tx_tag_len;
+
+	len += qup->blk.rx_tag_len;
+
 	if (len < qup->in_fifo_sz) {
 		/* FIFO mode */
 		writel(QUP_REPACK_EN, qup->base + QUP_IO_MODE);
 		writel(len, qup->base + QUP_MX_READ_CNT);
+		writel(tx_len, qup->base + QUP_MX_WRITE_CNT);
 	} else {
 		/* BLOCK mode (transfer data on chunks) */
 		writel(QUP_INPUT_BLK_MODE | QUP_REPACK_EN,
 		       qup->base + QUP_IO_MODE);
 		writel(len, qup->base + QUP_MX_INPUT_CNT);
+		writel(tx_len, qup->base + QUP_MX_OUTPUT_CNT);
 	}
 }
 
@@ -426,7 +612,6 @@ static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	writel(val, qup->base + QUP_OUT_FIFO_BASE);
 }
 
-
 static int qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	u32 val = 0;
@@ -453,7 +638,68 @@ static int qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	return ret;
 }
 
-static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static int qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup,
+				struct i2c_msg *msg)
+{
+	u32 val;
+	int idx, pos = 0, ret = 0, total;
+
+	total = qup_i2c_get_data_len(qup);
+
+	/* 2 extra bytes for read tags */
+	while (pos < (total + 2)) {
+		/* Check that FIFO have data */
+		ret = qup_i2c_wait_ready(qup, QUP_IN_NOT_EMPTY,
+					 SET_BIT, 4 * ONE_BYTE);
+		if (ret) {
+			dev_err(qup->dev, "timeout for fifo not empty");
+			return ret;
+		}
+		val = readl(qup->base + QUP_IN_FIFO_BASE);
+
+		for (idx = 0; idx < 4; idx++, val >>= 8, pos++) {
+			/* first 2 bytes are tag bytes */
+			if (pos < 2)
+				continue;
+
+			if (pos >= (total + 2))
+				goto out;
+
+			msg->buf[qup->pos++] = val & 0xff;
+		}
+	}
+
+out:
+	qup->blk.data_len -= total;
+
+	return ret;
+}
+
+static int qup_i2c_read_one_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	int ret = 0;
+
+	do {
+		ret = qup_i2c_issue_xfer_v2(qup, msg);
+		if (ret)
+			goto err;
+
+		ret = qup_i2c_wait_for_complete(qup, msg);
+		if (ret)
+			goto err;
+
+		ret = qup_i2c_read_fifo_v2(qup, msg);
+		if (ret)
+			goto err;
+
+		qup->blk.pos++;
+	} while (qup->blk.pos < qup->blk.count);
+
+err:
+	return ret;
+}
+
+static int qup_i2c_read_one_v1(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	int ret = 0;
 
@@ -498,6 +744,7 @@ static int qup_i2c_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	qup->pos  = 0;
 
 	enable_irq(qup->irq);
+	qup_i2c_get_blk_data(qup, msg);
 
 	qup_i2c_set_read_mode(qup, msg->len);
 
@@ -507,7 +754,7 @@ static int qup_i2c_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 
 	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
 
-	ret = qup_i2c_read_one(qup, msg);
+	ret = qup->qup_i2c_read_one(qup, msg);
 
 err:
 	disable_irq(qup->irq);
@@ -569,6 +816,60 @@ out:
 	return ret;
 }
 
+static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
+			   struct i2c_msg msgs[],
+			   int num)
+{
+	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
+	int ret, idx;
+
+	ret = pm_runtime_get_sync(qup->dev);
+	if (ret < 0)
+		goto out;
+
+	writel(1, qup->base + QUP_SW_RESET);
+	ret = qup_i2c_poll_state(qup, QUP_RESET_STATE);
+	if (ret)
+		goto out;
+
+	/* Configure QUP as I2C mini core */
+	writel(I2C_MINI_CORE | I2C_N_VAL_V2, qup->base + QUP_CONFIG);
+	writel(QUP_V2_TAGS_EN, qup->base + QUP_I2C_MASTER_GEN);
+
+	for (idx = 0; idx < num; idx++) {
+		if (msgs[idx].len == 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (qup_i2c_poll_state_i2c_master(qup)) {
+			ret = -EIO;
+			goto out;
+		}
+
+		reinit_completion(&qup->xfer);
+
+		if (msgs[idx].flags & I2C_M_RD)
+			ret = qup_i2c_read(qup, &msgs[idx]);
+		else
+			ret = qup_i2c_write(qup, &msgs[idx]);
+
+		if (!ret)
+			ret = qup_i2c_change_state(qup, QUP_RESET_STATE);
+
+		if (ret)
+			break;
+	}
+
+	if (ret == 0)
+		ret = num;
+out:
+	pm_runtime_mark_last_busy(qup->dev);
+	pm_runtime_put_autosuspend(qup->dev);
+
+	return ret;
+}
+
 static u32 qup_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
@@ -588,6 +889,11 @@ static struct i2c_adapter_quirks qup_i2c_quirks = {
 	.max_read_len = QUP_READ_LIMIT,
 };
 
+static const struct i2c_algorithm qup_i2c_algo_v2 = {
+	.master_xfer	= qup_i2c_xfer_v2,
+	.functionality	= qup_i2c_func,
+};
+
 static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
 {
 	clk_prepare_enable(qup->clk);
@@ -628,6 +934,17 @@ static int qup_i2c_probe(struct platform_device *pdev)
 
 	of_property_read_u32(node, "clock-frequency", &clk_freq);
 
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,i2c-qup-v1.1.1")) {
+		qup->adap.algo = &qup_i2c_algo;
+		qup->qup_i2c_write_one = qup_i2c_write_one_v1;
+		qup->qup_i2c_read_one = qup_i2c_read_one_v1;
+	} else {
+		qup->adap.algo = &qup_i2c_algo_v2;
+		qup->qup_i2c_write_one = qup_i2c_write_one_v2;
+		qup->qup_i2c_read_one = qup_i2c_read_one_v2;
+		qup->use_v2_tags = 1;
+	}
+
 	/* We support frequencies up to FAST Mode (400KHz) */
 	if (!clk_freq || clk_freq > 400000) {
 		dev_err(qup->dev, "clock frequency not supported %d\n",
@@ -723,7 +1040,6 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		qup->out_blk_sz, qup->out_fifo_sz);
 
 	i2c_set_adapdata(&qup->adap, qup);
-	qup->adap.algo = &qup_i2c_algo;
 	qup->adap.quirks = &qup_i2c_quirks;
 	qup->adap.dev.parent = qup->dev;
 	qup->adap.dev.of_node = pdev->dev.of_node;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
