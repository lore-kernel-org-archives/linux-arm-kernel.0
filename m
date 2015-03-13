From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 13 Mar 2015 23:19:48 +0530
Subject: [PATCH 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1426268992-19298-3-git-send-email-sricharan@codeaurora.org>
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
 drivers/i2c/busses/i2c-qup.c | 342 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 305 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 49c6cba..e4e223f 100644
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
 
@@ -80,17 +84,31 @@
 
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
+#define I2C_QUP_CLK_MAX_FREQ           3400000
+
 /* Status, Error flags */
 #define I2C_STATUS_WR_BUFFER_FULL	BIT(0)
 #define I2C_STATUS_BUS_ACTIVE		BIT(8)
@@ -99,6 +117,11 @@
 
 #define QUP_READ_LIMIT			256
 
+struct qup_i2c_config {
+	int tag_ver;
+	int max_freq;
+};
+
 struct qup_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;
@@ -112,9 +135,20 @@ struct qup_i2c_dev {
 	int			in_fifo_sz;
 	int			out_blk_sz;
 	int			in_blk_sz;
-
+	int			blocks;
+	u8			*block_tag_len;
+	int			*block_data_len;
+	int			block_pos;
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
@@ -262,8 +296,13 @@ static int qup_i2c_wait_ready(struct qup_i2c_dev *qup, int op, bool val,
 
 static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
-	/* Number of entries to shift out, including the start */
-	int total = msg->len + 1;
+	/* Total Number of entries to shift out, including the tags */
+	int total;
+
+	if (qup->use_v2_tags)
+		total = msg->len + qup->tx_tag_len;
+	else
+		total = msg->len + 1; /* plus start tag */
 
 	if (total < qup->out_fifo_sz) {
 		/* FIFO mode */
@@ -277,7 +316,7 @@ static void qup_i2c_set_write_mode(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	}
 }
 
-static void qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static void qup_i2c_issue_write_v1(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	u32 addr = msg->addr << 1;
 	u32 qup_tag;
@@ -318,6 +357,136 @@ static void qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	}
 }
 
+static void qup_i2c_create_tag_v2(struct qup_i2c_dev *qup,
+				  struct i2c_msg *msg)
+{
+	u16 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) == I2C_M_RD);
+	int len = 0, prev_len = 0;
+	int blocks = 0;
+	int rem;
+	int block_len = 0;
+	int data_len;
+
+	qup->block_pos = 0;
+	qup->pos = 0;
+	qup->blocks = (msg->len + QUP_READ_LIMIT - 1) / (QUP_READ_LIMIT);
+	rem = msg->len % QUP_READ_LIMIT;
+
+	/* 2 tag bytes for each block + 2 extra bytes for first block */
+	qup->tags = kzalloc((qup->blocks << 1) + 2, GFP_KERNEL);
+	qup->block_tag_len = kzalloc(qup->blocks, GFP_KERNEL);
+	qup->block_data_len = kzalloc(sizeof(int) * qup->blocks, GFP_KERNEL);
+
+	while (blocks < qup->blocks) {
+		/* 0 is used to specify a READ_LIMIT of 256 bytes */
+		data_len = (blocks < (qup->blocks - 1)) ? 0 : rem;
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
+		if (blocks == (qup->blocks - 1)) {
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
+		qup->block_tag_len[blocks] = block_len;
+
+		if (!data_len)
+			qup->block_data_len[blocks] = QUP_READ_LIMIT;
+		else
+			qup->block_data_len[blocks] = data_len;
+
+		qup->tags_pos = 0;
+		blocks++;
+	}
+
+	qup->tx_tag_len = len;
+
+	if (msg->flags & I2C_M_RD)
+		qup->rx_tag_len = (qup->blocks << 1);
+	else
+		qup->rx_tag_len = 0;
+}
+
+static u32 qup_i2c_xfer_data(struct qup_i2c_dev *qup, int len,
+			     u8 *buf, int last)
+{
+	static u32 val, idx;
+	u32  t, rem, pos = 0;
+
+	rem = len - pos + idx;
+
+	while (rem) {
+		if (qup_i2c_wait_ready(qup, QUP_OUT_FULL, 0, 4)) {
+			dev_err(qup->dev, "timeout for fifo out full");
+			break;
+		}
+
+		t = (rem >= 4) ? 4 : rem;
+
+		while (idx < t)
+			val |= buf[pos++] << (idx++ << 3);
+
+		if (t == 4) {
+			writel(val, qup->base + QUP_OUT_FIFO_BASE);
+			idx = val = 0;
+		}
+
+		rem = len - pos;
+	}
+
+	if (last) {
+		writel(val, qup->base + QUP_OUT_FIFO_BASE);
+		idx = val = 0;
+	}
+
+	return 0;
+}
+
+static void qup_i2c_issue_xfer_v2(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	u32 data_len, tag_len, rem;
+
+	tag_len = qup->block_tag_len[qup->block_pos];
+	data_len = qup->block_data_len[qup->block_pos];
+
+	qup_i2c_xfer_data(qup, tag_len, qup->tags, 0);
+
+	if (!(msg->flags & I2C_M_RD))
+		rem = qup_i2c_xfer_data(qup, data_len, msg->buf, 1);
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
 static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	unsigned long left;
@@ -326,6 +495,11 @@ static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	qup->msg = msg;
 	qup->pos = 0;
 
+	if (qup->use_v2_tags)
+		qup_i2c_create_tag_v2(qup, msg);
+	else
+		qup->blocks = 0;
+
 	enable_irq(qup->irq);
 
 	qup_i2c_set_write_mode(qup, msg);
@@ -360,7 +534,8 @@ static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 			ret = -EIO;
 			goto err;
 		}
-	} while (qup->pos < msg->len);
+		qup->block_pos++;
+	} while (qup->block_pos < qup->blocks);
 
 	/* Wait for the outstanding data in the fifo to drain */
 	ret = qup_i2c_wait_ready(qup, QUP_OUT_NOT_EMPTY, 0, 1);
@@ -374,6 +549,11 @@ err:
 
 static void qup_i2c_set_read_mode(struct qup_i2c_dev *qup, int len)
 {
+	if (qup->use_v2_tags) {
+		len += qup->rx_tag_len;
+		writel(qup->tx_tag_len, qup->base + QUP_MX_WRITE_CNT);
+	}
+
 	if (len < qup->in_fifo_sz) {
 		/* FIFO mode */
 		writel(QUP_REPACK_EN, qup->base + QUP_IO_MODE);
@@ -386,7 +566,8 @@ static void qup_i2c_set_read_mode(struct qup_i2c_dev *qup, int len)
 	}
 }
 
-static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+static void qup_i2c_issue_read_v1(struct qup_i2c_dev *qup, struct
+				  i2c_msg *msg)
 {
 	u32 addr, len, val;
 
@@ -395,24 +576,33 @@ static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	/* 0 is used to specify a length 256 (QUP_READ_LIMIT) */
 	len = (msg->len == QUP_READ_LIMIT) ? 0 : msg->len;
 
-	val = ((QUP_TAG_REC | len) << QUP_MSW_SHIFT) | QUP_TAG_START | addr;
+	val = ((QUP_TAG_REC | len) << QUP_MSW_SHIFT) | QUP_TAG_START |
+			addr;
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
 
@@ -423,11 +613,48 @@ static void qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	}
 }
 
+static void qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup, struct
+				 i2c_msg *msg)
+{
+	u32 val;
+	int idx;
+	int pos = 0;
+	int total = qup->block_data_len[qup->block_pos] + 2;
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
+static void qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg
+			      *msg)
+{
+	if (qup->use_v2_tags)
+		qup_i2c_read_fifo_v2(qup, msg);
+	else
+		qup_i2c_read_fifo_v1(qup, msg);
+}
+
 static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	unsigned long left;
 	int ret;
-
 	/*
 	 * The QUP block will issue a NACK and STOP on the bus when reaching
 	 * the end of the read, the length of the read is specified as one byte
@@ -441,6 +668,10 @@ static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 
 	qup->msg = msg;
 	qup->pos  = 0;
+	if (qup->use_v2_tags)
+		qup_i2c_create_tag_v2(qup, msg);
+	else
+		qup->blocks = 0;
 
 	enable_irq(qup->irq);
 
@@ -452,17 +683,17 @@ static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 
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
@@ -478,7 +709,8 @@ static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 		}
 
 		qup_i2c_read_fifo(qup, msg);
-	} while (qup->pos < msg->len);
+		qup->block_pos++;
+	} while (qup->block_pos < qup->blocks);
 
 err:
 	disable_irq(qup->irq);
@@ -504,7 +736,12 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
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
@@ -517,6 +754,8 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 			goto out;
 		}
 
+		reinit_completion(&qup->xfer);
+
 		if (msgs[idx].flags & I2C_M_RD)
 			ret = qup_i2c_read_one(qup, &msgs[idx]);
 		else
@@ -534,6 +773,12 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 		ret = num;
 out:
 
+	if (qup->use_v2_tags) {
+		kfree(qup->tags);
+		kfree(qup->block_tag_len);
+		kfree(qup->block_data_len);
+	}
+
 	pm_runtime_mark_last_busy(qup->dev);
 	pm_runtime_put_autosuspend(qup->dev);
 
@@ -556,6 +801,19 @@ static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
 	clk_prepare_enable(qup->pclk);
 }
 
+static const struct qup_i2c_config configs[] = {
+	{ 0, 400000, },
+	{ 1, 3400000, },
+};
+
+static const struct of_device_id qup_i2c_dt_match[] = {
+	{ .compatible = "qcom,i2c-qup-v1.1.1", .data = &configs[0] },
+	{ .compatible = "qcom,i2c-qup-v2.1.1", .data = &configs[1] },
+	{ .compatible = "qcom,i2c-qup-v2.2.1", .data = &configs[1] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qup_i2c_dt_match);
+
 static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 {
 	u32 config;
@@ -579,6 +837,8 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	int ret, fs_div, hs_div;
 	int src_clk_freq;
 	u32 clk_freq = 100000;
+	const struct qup_i2c_config *config;
+	const struct of_device_id *of_id;
 
 	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
 	if (!qup)
@@ -590,8 +850,15 @@ static int qup_i2c_probe(struct platform_device *pdev)
 
 	of_property_read_u32(node, "clock-frequency", &clk_freq);
 
-	/* We support frequencies up to FAST Mode (400KHz) */
-	if (!clk_freq || clk_freq > 400000) {
+	of_id = of_match_node(qup_i2c_dt_match, node);
+	if (!of_id)
+		return -EINVAL;
+
+	config = of_id->data;
+	qup->use_v2_tags = !!config->tag_ver;
+
+	/* We support frequencies up to HIGH SPEED Mode (3400KHz) */
+	if (!clk_freq || clk_freq > config->max_freq) {
 		dev_err(qup->dev, "clock frequency not supported %d\n",
 			clk_freq);
 		return -EINVAL;
@@ -669,8 +936,17 @@ static int qup_i2c_probe(struct platform_device *pdev)
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
@@ -767,14 +1043,6 @@ static const struct dev_pm_ops qup_i2c_qup_pm_ops = {
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
1.8.2.1
