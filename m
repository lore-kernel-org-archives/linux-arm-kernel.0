From: sricharan@codeaurora.org (Sricharan R)
Date: Sat, 11 Apr 2015 12:39:01 +0530
Subject: [PATCH V3 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
References: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1428736145-18361-3-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Gross <agross@codeaurora.org>

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
[V3] Addressed comments from Andy Gross <agross@codeaurora.org>
     to coalesce each i2c_msg in i2c_msgs as a single transfer.
     Added macros to i2c_wait_ready function.

 drivers/i2c/busses/i2c-qup.c | 393 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 337 insertions(+), 56 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 9ccf3e8..16a8f69 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 
 /* QUP Registers */
 #define QUP_CONFIG		0x000
@@ -42,6 +43,7 @@
 #define QUP_IN_FIFO_BASE	0x218
 #define QUP_I2C_CLK_CTL		0x400
 #define QUP_I2C_STATUS		0x404
+#define QUP_I2C_MASTER_GEN	0x408
 
 /* QUP States and reset values */
 #define QUP_RESET_STATE		0
@@ -69,6 +71,8 @@
 #define QUP_CLOCK_AUTO_GATE	BIT(13)
 #define I2C_MINI_CORE		(2 << 8)
 #define I2C_N_VAL		15
+#define I2C_N_VAL_V2		7
+
 /* Most significant word offset in FIFO port */
 #define QUP_MSW_SHIFT		(I2C_N_VAL + 1)
 
@@ -80,17 +84,30 @@
 
 #define QUP_REPACK_EN		(QUP_UNPACK_EN | QUP_PACK_EN)
 
+#define QUP_V2_TAGS_EN		1
+
 #define QUP_OUTPUT_BLOCK_SIZE(x)(((x) >> 0) & 0x03)
 #define QUP_OUTPUT_FIFO_SIZE(x)	(((x) >> 2) & 0x07)
 #define QUP_INPUT_BLOCK_SIZE(x)	(((x) >> 5) & 0x03)
 #define QUP_INPUT_FIFO_SIZE(x)	(((x) >> 7) & 0x07)
 
-/* QUP tags */
+/* QUP V1 tags */
 #define QUP_TAG_START		(1 << 8)
 #define QUP_TAG_DATA		(2 << 8)
 #define QUP_TAG_STOP		(3 << 8)
 #define QUP_TAG_REC		(4 << 8)
 
+/* QUP v2 tags */
+#define QUP_TAG_V2_HS                  0xff
+#define QUP_TAG_V2_START               0x81
+#define QUP_TAG_V2_DATAWR              0x82
+#define QUP_TAG_V2_DATAWR_STOP         0x83
+#define QUP_TAG_V2_DATARD              0x85
+#define QUP_TAG_V2_DATARD_STOP         0x87
+
+/* frequency definitions for high speed and max speed */
+#define I2C_QUP_CLK_FAST_FREQ          1000000
+
 /* Status, Error flags */
 #define I2C_STATUS_WR_BUFFER_FULL	BIT(0)
 #define I2C_STATUS_BUS_ACTIVE		BIT(8)
@@ -102,6 +119,15 @@
 #define RESET_BIT			0x0
 #define ONE_BYTE			0x1
 
+#define QUP_I2C_MX_CONFIG_DURING_RUN	BIT(31)
+
+struct qup_i2c_block {
+	int	blocks;
+	u8	*block_tag_len;
+	int	*block_data_len;
+	int	block_pos;
+};
+
 struct qup_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;
@@ -115,9 +141,17 @@ struct qup_i2c_dev {
 	int			in_fifo_sz;
 	int			out_blk_sz;
 	int			in_blk_sz;
-
+	struct	qup_i2c_block	blk;
 	unsigned long		one_byte_t;
 
+	int			is_hs;
+	bool			use_v2_tags;
+
+	int			tx_tag_len;
+	int			rx_tag_len;
+	u8			*tags;
+	int			tags_pos;
+
 	struct i2c_msg		*msg;
 	/* Current posion in user message buffer */
 	int			pos;
@@ -263,10 +297,19 @@ static int qup_i2c_wait_ready(struct qup_i2c_dev *qup, int op, bool val,
 	}
 }
 
-static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg,
+				   int run)
 {
-	/* Number of entries to shift out, including the start */
-	int total = msg->len + 1;
+	/* Total Number of entries to shift out, including the tags */
+	int total;
+
+	if (qup->use_v2_tags) {
+		total = msg->len + qup->tx_tag_len;
+		if (run)
+			total |= QUP_I2C_MX_CONFIG_DURING_RUN;
+	} else {
+		total = msg->len + 1; /* plus start tag */
+	}
 
 	if (total < qup->out_fifo_sz) {
 		/* FIFO mode */
@@ -280,7 +323,7 @@ static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	}
 }
 
-static void qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static void qup_i2c_issue_write_v1(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	u32 addr = msg->addr << 1;
 	u32 qup_tag;
@@ -321,7 +364,136 @@ static void qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	}
 }
 
-static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static void qup_i2c_create_tag_v2(struct qup_i2c_dev *qup,
+				  struct i2c_msg *msg, int last)
+{
+	u16 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) == I2C_M_RD);
+	int len = 0, prev_len = 0;
+	int blocks = 0;
+	int rem;
+	int block_len = 0;
+	int data_len;
+
+	qup->blk.block_pos = 0;
+	qup->pos = 0;
+	qup->blk.blocks = (msg->len + QUP_READ_LIMIT - 1) / QUP_READ_LIMIT;
+	rem = msg->len % QUP_READ_LIMIT;
+
+	/* 2 tag bytes for each block + 2 extra bytes for first block */
+	qup->tags = kzalloc((qup->blk.blocks * 2) + 2, GFP_KERNEL);
+	qup->blk.block_tag_len = kzalloc(qup->blk.blocks, GFP_KERNEL);
+	qup->blk.block_data_len = kzalloc(sizeof(*qup->blk.block_data_len) *
+				  qup->blk.blocks, GFP_KERNEL);
+
+	while (blocks < qup->blk.blocks) {
+		/* 0 is used to specify a READ_LIMIT of 256 bytes */
+		data_len = (blocks < (qup->blk.blocks - 1)) ? 0 : rem;
+
+		/* Send START and ADDR bytes only for the first block */
+		if (!blocks) {
+			qup->tags[len++] = QUP_TAG_V2_START;
+
+			if (qup->is_hs) {
+				qup->tags[len++] = QUP_TAG_V2_HS;
+				qup->tags[len++] = QUP_TAG_V2_START;
+			}
+
+			qup->tags[len++] = addr & 0xff;
+			if (msg->flags & I2C_M_TEN)
+				qup->tags[len++] = addr >> 8;
+		}
+
+		/* Send _STOP commands for the last block */
+		if ((blocks == (qup->blk.blocks - 1)) && last) {
+			if (msg->flags & I2C_M_RD)
+				qup->tags[len++] = QUP_TAG_V2_DATARD_STOP;
+			else
+				qup->tags[len++] = QUP_TAG_V2_DATAWR_STOP;
+		} else {
+			if (msg->flags & I2C_M_RD)
+				qup->tags[len++] = QUP_TAG_V2_DATARD;
+			else
+				qup->tags[len++] = QUP_TAG_V2_DATAWR;
+		}
+
+		qup->tags[len++] = data_len;
+		block_len = len - prev_len;
+		prev_len = len;
+		qup->blk.block_tag_len[blocks] = block_len;
+
+		if (!data_len)
+			qup->blk.block_data_len[blocks] = QUP_READ_LIMIT;
+		else
+			qup->blk.block_data_len[blocks] = data_len;
+
+		qup->tags_pos = 0;
+		blocks++;
+	}
+
+	qup->tx_tag_len = len;
+
+	if (msg->flags & I2C_M_RD)
+		qup->rx_tag_len = (qup->blk.blocks * 2);
+	else
+		qup->rx_tag_len = 0;
+}
+
+static u32 qup_i2c_send_data(struct qup_i2c_dev *qup, int tlen, u8 *tbuf,
+			     int dlen, u8 *dbuf)
+{
+	u32 val = 0, idx = 0, pos = 0, i = 0, t;
+	int  len = tlen + dlen;
+	u8 *buf = tbuf;
+
+	while (len > 0) {
+		if (qup_i2c_wait_ready(qup, QUP_OUT_FULL, 0, 4)) {
+			dev_err(qup->dev, "timeout for fifo out full");
+			break;
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
+	return 0;
+}
+
+static void qup_i2c_issue_xfer_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	u32 data_len = 0, tag_len;
+
+	tag_len = qup->blk.block_tag_len[qup->blk.block_pos];
+
+	if (!(msg->flags & I2C_M_RD))
+		data_len = qup->blk.block_data_len[qup->blk.block_pos];
+
+	qup_i2c_send_data(qup, tag_len, qup->tags, data_len, msg->buf);
+}
+
+static void qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg
+				*msg)
+{
+	if (qup->use_v2_tags)
+		qup_i2c_issue_xfer_v2(qup, msg);
+	else
+		qup_i2c_issue_write_v1(qup, msg);
+}
+
+static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg,
+			     int run, int last)
 {
 	unsigned long left;
 	int ret;
@@ -329,13 +501,20 @@ static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	qup->msg = msg;
 	qup->pos = 0;
 
+	if (qup->use_v2_tags)
+		qup_i2c_create_tag_v2(qup, msg, last);
+	else
+		qup->blk.blocks = 0;
+
 	enable_irq(qup->irq);
 
-	qup_i2c_set_write_mode(qup, msg);
+	qup_i2c_set_write_mode(qup, msg, run);
 
-	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
-	if (ret)
-		goto err;
+	if (!run) {
+		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+		if (ret)
+			goto err;
+	}
 
 	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
 
@@ -363,10 +542,13 @@ static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 			ret = -EIO;
 			goto err;
 		}
-	} while (qup->pos < msg->len);
+		qup->blk.block_pos++;
+	} while (qup->blk.block_pos < qup->blk.blocks);
 
 	/* Wait for the outstanding data in the fifo to drain */
-	ret = qup_i2c_wait_ready(qup, QUP_OUT_NOT_EMPTY, RESET_BIT, ONE_BYTE);
+	if (last)
+		ret = qup_i2c_wait_ready(qup, QUP_OUT_NOT_EMPTY, RESET_BIT,
+					 ONE_BYTE);
 
 err:
 	disable_irq(qup->irq);
@@ -375,8 +557,17 @@ err:
 	return ret;
 }
 
-static void qup_i2c_set_read_mode(struct qup_i2c_dev *qup, int len)
+static void qup_i2c_set_read_mode(struct qup_i2c_dev *qup, int len, int run)
 {
+	if (qup->use_v2_tags) {
+		len += qup->rx_tag_len;
+		if (run) {
+			len |= QUP_I2C_MX_CONFIG_DURING_RUN;
+			qup->tx_tag_len |= QUP_I2C_MX_CONFIG_DURING_RUN;
+		}
+		writel(qup->tx_tag_len, qup->base + QUP_MX_WRITE_CNT);
+	}
+
 	if (len < qup->in_fifo_sz) {
 		/* FIFO mode */
 		writel(QUP_REPACK_EN, qup->base + QUP_IO_MODE);
@@ -389,7 +580,8 @@ static void qup_i2c_set_read_mode(struct qup_i2c_dev *qup, int len)
 	}
 }
 
-static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static void qup_i2c_issue_read_v1(struct qup_i2c_dev *qup,
+				  struct i2c_msg *msg)
 {
 	u32 addr, len, val;
 
@@ -402,20 +594,28 @@ static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	writel(val, qup->base + QUP_OUT_FIFO_BASE);
 }
 
+static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg
+			       *msg)
+{
+	if (qup->use_v2_tags)
+		qup_i2c_issue_xfer_v2(qup, msg);
+	else
+		qup_i2c_issue_read_v1(qup, msg);
+}
 
-static void qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static void qup_i2c_read_fifo_v1(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
-	u32 opflags;
 	u32 val = 0;
 	int idx;
+	int len = msg->len + qup->rx_tag_len;
 
-	for (idx = 0; qup->pos < msg->len; idx++) {
+	for (idx = 0; qup->pos < len; idx++) {
 		if ((idx & 1) == 0) {
 			/* Check that FIFO have data */
-			opflags = readl(qup->base + QUP_OPERATIONAL);
-			if (!(opflags & QUP_IN_NOT_EMPTY))
+			if (qup_i2c_wait_ready(qup, QUP_IN_NOT_EMPTY, 1, 4)) {
+				dev_err(qup->dev, "timeout for fifo not empty");
 				break;
-
+			}
 			/* Reading 2 words at time */
 			val = readl(qup->base + QUP_IN_FIFO_BASE);
 
@@ -426,11 +626,50 @@ static void qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	}
 }
 
-static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static void qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup,
+				 struct i2c_msg *msg)
+{
+	u32 val;
+	int idx;
+	int pos = 0;
+	/* 2 extra bytes for read tags */
+	int total = qup->blk.block_data_len[qup->blk.block_pos] + 2;
+
+	while (pos < total) {
+		/* Check that FIFO have data */
+		if (qup_i2c_wait_ready(qup, QUP_IN_NOT_EMPTY, 1, 4)) {
+			dev_err(qup->dev, "timeout for fifo not empty");
+			break;
+		}
+		val = readl(qup->base + QUP_IN_FIFO_BASE);
+
+		for (idx = 0; idx < 4; idx++, val >>= 8, pos++) {
+			/* first 2 bytes are tag bytes */
+			if (pos < 2)
+				continue;
+
+			if (pos >= total)
+				return;
+
+			msg->buf[qup->pos++] = val & 0xff;
+		}
+	}
+}
+
+static void qup_i2c_read_fifo(struct qup_i2c_dev *qup,
+			      struct i2c_msg *msg)
+{
+	if (qup->use_v2_tags)
+		qup_i2c_read_fifo_v2(qup, msg);
+	else
+		qup_i2c_read_fifo_v1(qup, msg);
+}
+
+static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg,
+			    int run, int last)
 {
 	unsigned long left;
 	int ret;
-
 	/*
 	 * The QUP block will issue a NACK and STOP on the bus when reaching
 	 * the end of the read, the length of the read is specified as one byte
@@ -444,28 +683,34 @@ static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 
 	qup->msg = msg;
 	qup->pos  = 0;
+	if (qup->use_v2_tags)
+		qup_i2c_create_tag_v2(qup, msg, last);
+	else
+		qup->blk.blocks = 0;
 
 	enable_irq(qup->irq);
 
-	qup_i2c_set_read_mode(qup, msg->len);
+	qup_i2c_set_read_mode(qup, msg->len, run);
 
-	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
-	if (ret)
-		goto err;
+	if (!run) {
+		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+		if (ret)
+			goto err;
+	}
 
 	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
 
-	ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
-	if (ret)
-		goto err;
+	do {
+		ret = qup_i2c_change_state(qup, QUP_PAUSE_STATE);
+		if (ret)
+			goto err;
 
-	qup_i2c_issue_read(qup, msg);
+		qup_i2c_issue_read(qup, msg);
 
-	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
-	if (ret)
-		goto err;
+		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+		if (ret)
+			goto err;
 
-	do {
 		left = wait_for_completion_timeout(&qup->xfer, HZ);
 		if (!left) {
 			writel(1, qup->base + QUP_SW_RESET);
@@ -481,7 +726,8 @@ static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 		}
 
 		qup_i2c_read_fifo(qup, msg);
-	} while (qup->pos < msg->len);
+		qup->blk.block_pos++;
+	} while (qup->blk.block_pos < qup->blk.blocks);
 
 err:
 	disable_irq(qup->irq);
@@ -495,7 +741,7 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 			int num)
 {
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
-	int ret, idx;
+	int ret, idx, last;
 
 	ret = pm_runtime_get_sync(qup->dev);
 	if (ret < 0)
@@ -507,7 +753,12 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 		goto out;
 
 	/* Configure QUP as I2C mini core */
-	writel(I2C_MINI_CORE | I2C_N_VAL, qup->base + QUP_CONFIG);
+	if (qup->use_v2_tags) {
+		writel(I2C_MINI_CORE | I2C_N_VAL_V2, qup->base + QUP_CONFIG);
+		writel(QUP_V2_TAGS_EN, qup->base + QUP_I2C_MASTER_GEN);
+	} else {
+		writel(I2C_MINI_CORE | I2C_N_VAL, qup->base + QUP_CONFIG);
+	}
 
 	for (idx = 0; idx < num; idx++) {
 		if (msgs[idx].len == 0) {
@@ -520,23 +771,32 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 			goto out;
 		}
 
+		reinit_completion(&qup->xfer);
+
+		last = (idx == (num - 1));
+
 		if (msgs[idx].flags & I2C_M_RD)
-			ret = qup_i2c_read_one(qup, &msgs[idx]);
+			ret = qup_i2c_read_one(qup, &msgs[idx], idx, last);
 		else
-			ret = qup_i2c_write_one(qup, &msgs[idx]);
+			ret = qup_i2c_write_one(qup, &msgs[idx], idx, last);
 
 		if (ret)
 			break;
+	}
 
+	if (!ret)
 		ret = qup_i2c_change_state(qup, QUP_RESET_STATE);
-		if (ret)
-			break;
-	}
 
 	if (ret == 0)
 		ret = num;
 out:
 
+	if (qup->use_v2_tags) {
+		kfree(qup->tags);
+		kfree(qup->blk.block_tag_len);
+		kfree(qup->blk.block_data_len);
+	}
+
 	pm_runtime_mark_last_busy(qup->dev);
 	pm_runtime_put_autosuspend(qup->dev);
 
@@ -559,6 +819,14 @@ static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
 	clk_prepare_enable(qup->pclk);
 }
 
+static const struct of_device_id qup_i2c_dt_match[] = {
+	{ .compatible = "qcom,i2c-qup-v1.1.1"},
+	{ .compatible = "qcom,i2c-qup-v2.1.1"},
+	{ .compatible = "qcom,i2c-qup-v2.2.1"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, qup_i2c_dt_match);
+
 static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 {
 	u32 config;
@@ -580,8 +848,9 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	struct resource *res;
 	u32 io_mode, hw_ver, size;
 	int ret, fs_div, hs_div;
-	int src_clk_freq;
+	int src_clk_freq, clk_freq_max;
 	u32 clk_freq = 100000;
+	const struct of_device_id *of_id;
 
 	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
 	if (!qup)
@@ -593,8 +862,19 @@ static int qup_i2c_probe(struct platform_device *pdev)
 
 	of_property_read_u32(node, "clock-frequency", &clk_freq);
 
-	/* We support frequencies up to FAST Mode (400KHz) */
-	if (!clk_freq || clk_freq > 400000) {
+	of_id = of_match_node(qup_i2c_dt_match, node);
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "qcom,i2c-qup-v1.1.1")) {
+		qup->use_v2_tags = 0;
+		clk_freq_max = 400000;
+	} else {
+		qup->use_v2_tags = 1;
+		clk_freq_max = 3400000;
+	}
+
+	/* We support frequencies up to HIGH SPEED Mode (3400KHz) */
+	if (!clk_freq || clk_freq > clk_freq_max) {
 		dev_err(qup->dev, "clock frequency not supported %d\n",
 			clk_freq);
 		return -EINVAL;
@@ -672,8 +952,17 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	qup->in_fifo_sz = qup->in_blk_sz * (2 << size);
 
 	src_clk_freq = clk_get_rate(qup->clk);
-	fs_div = ((src_clk_freq / clk_freq) / 2) - 3;
-	hs_div = 3;
+	if (clk_freq > I2C_QUP_CLK_FAST_FREQ) {
+		fs_div = I2C_QUP_CLK_FAST_FREQ;
+		hs_div = (src_clk_freq / clk_freq) / 3;
+
+		qup->is_hs = 1;
+	} else {
+		fs_div = ((src_clk_freq / clk_freq) / 2) - 3;
+		hs_div = 3;
+	}
+
+	hs_div = min_t(int, hs_div, 0x7);
 	qup->clk_ctl = (hs_div << 8) | (fs_div & 0xff);
 
 	/*
@@ -770,14 +1059,6 @@ static const struct dev_pm_ops qup_i2c_qup_pm_ops = {
 		NULL)
 };
 
-static const struct of_device_id qup_i2c_dt_match[] = {
-	{ .compatible = "qcom,i2c-qup-v1.1.1" },
-	{ .compatible = "qcom,i2c-qup-v2.1.1" },
-	{ .compatible = "qcom,i2c-qup-v2.2.1" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, qup_i2c_dt_match);
-
 static struct platform_driver qup_i2c_driver = {
 	.probe  = qup_i2c_probe,
 	.remove = qup_i2c_remove,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
