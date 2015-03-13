From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 13 Mar 2015 23:19:49 +0530
Subject: [PATCH 3/6] i2c: qup: Add bam dma capabilities
In-Reply-To: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1426268992-19298-4-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

QUP cores can be attached to a BAM module, which acts as
a dma engine for the QUP core. When DMA with BAM is enabled,
the BAM consumer pipe transmitted data is written to the output FIFO
and the BAM producer pipe received data is read from the input FIFO.

With BAM capabilities, qup-i2c core can transfer more than 256 bytes,
without a 'stop' which is not possible otherwise.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 365 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 359 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index e4e223f..11ea6af 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -25,6 +25,11 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include <linux/atomic.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
 
 /* QUP Registers */
 #define QUP_CONFIG		0x000
@@ -34,6 +39,7 @@
 #define QUP_OPERATIONAL		0x018
 #define QUP_ERROR_FLAGS		0x01c
 #define QUP_ERROR_FLAGS_EN	0x020
+#define QUP_OPERATIONAL_MASK	0x028
 #define QUP_HW_VERSION		0x030
 #define QUP_MX_OUTPUT_CNT	0x100
 #define QUP_OUT_FIFO_BASE	0x110
@@ -44,6 +50,7 @@
 #define QUP_I2C_CLK_CTL		0x400
 #define QUP_I2C_STATUS		0x404
 #define QUP_I2C_MASTER_GEN	0x408
+#define QUP_I2C_MASTER_CONFIG	0x408
 
 /* QUP States and reset values */
 #define QUP_RESET_STATE		0
@@ -53,6 +60,7 @@
 
 #define QUP_STATE_VALID		BIT(2)
 #define QUP_I2C_MAST_GEN	BIT(4)
+#define QUP_I2C_FLUSH		BIT(6)
 
 #define QUP_OPERATIONAL_RESET	0x000ff0
 #define QUP_I2C_STATUS_RESET	0xfffffc
@@ -78,7 +86,10 @@
 
 /* Packing/Unpacking words in FIFOs, and IO modes */
 #define QUP_OUTPUT_BLK_MODE	(1 << 10)
+#define QUP_OUTPUT_BAM_MODE	(3 << 10)
 #define QUP_INPUT_BLK_MODE	(1 << 12)
+#define QUP_INPUT_BAM_MODE	(3 << 12)
+#define QUP_BAM_MODE		(QUP_OUTPUT_BAM_MODE | QUP_INPUT_BAM_MODE)
 #define QUP_UNPACK_EN		BIT(14)
 #define QUP_PACK_EN		BIT(15)
 
@@ -105,6 +116,10 @@
 #define QUP_TAG_V2_DATARD              0x85
 #define QUP_TAG_V2_DATARD_STOP         0x87
 
+/* QUP BAM v2 tags */
+#define QUP_BAM_INPUT_EOT		0x93
+#define QUP_BAM_FLUSH_STOP		0x96
+
 /* frequency definitions for high speed and max speed */
 #define I2C_QUP_CLK_FAST_FREQ          1000000
 #define I2C_QUP_CLK_MAX_FREQ           3400000
@@ -116,12 +131,21 @@
 #define QUP_STATUS_ERROR_FLAGS		0x7c
 
 #define QUP_READ_LIMIT			256
+#define MX_TX_RX_LEN			SZ_64K
+#define MX_BLOCKS			(MX_TX_RX_LEN / QUP_READ_LIMIT)
+
+#define TOUT_MAX			300 /* Max timeout for 32k tx/tx */
 
 struct qup_i2c_config {
 	int tag_ver;
 	int max_freq;
 };
 
+struct tag {
+	u8 *start;
+	dma_addr_t addr;
+};
+
 struct qup_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;
@@ -157,9 +181,35 @@ struct qup_i2c_dev {
 	/* QUP core errors */
 	u32			qup_err;
 
+	/* dma parameters */
+	bool			is_dma;
+	struct			dma_pool *dpool;
+	struct			tag start_tag;
+	struct			tag scratch_tag;
+	struct			tag footer_tag;
+	struct			dma_chan *dma_tx;
+	struct			dma_chan *dma_rx;
+	struct			scatterlist *sg_tx;
+	struct			scatterlist *sg_rx;
+	dma_addr_t		sg_tx_phys;
+	dma_addr_t		sg_rx_phys;
+
 	struct completion	xfer;
 };
 
+struct i2c_bam_xfer {
+	struct qup_i2c_dev *qup;
+	u32 start_len;
+
+	u32 rx_nents;
+	u32 tx_nents;
+
+	struct dma_async_tx_descriptor *tx_desc;
+	dma_cookie_t tx_cookie;
+	struct dma_async_tx_descriptor *rx_desc;
+	dma_cookie_t rx_cookie;
+};
+
 static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
 {
 	struct qup_i2c_dev *qup = dev;
@@ -233,6 +283,14 @@ static int qup_i2c_poll_state(struct qup_i2c_dev *qup, u32 req_state)
 	return qup_i2c_poll_state_mask(qup, req_state, QUP_STATE_MASK);
 }
 
+static void qup_i2c_flush(struct qup_i2c_dev *qup)
+{
+	u32 val = readl(qup->base + QUP_STATE);
+
+	val |= QUP_I2C_FLUSH;
+	writel(val, qup->base + QUP_STATE);
+}
+
 static int qup_i2c_poll_state_valid(struct qup_i2c_dev *qup)
 {
 	return qup_i2c_poll_state_mask(qup, 0, 0);
@@ -719,12 +777,244 @@ err:
 	return ret;
 }
 
+static void bam_i2c_callback(void *data)
+{
+	struct qup_i2c_dev *qup = data;
+
+	complete(&qup->xfer);
+}
+
+static int get_start_tag(u8 *tag, struct i2c_msg *msg, int first, int last,
+			int blen)
+{
+	u8 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) == I2C_M_RD);
+	u8 op;
+	int len = 0;
+
+	/* always issue stop for each read block */
+	if (last) {
+		if (msg->flags & I2C_M_RD)
+			op = QUP_TAG_V2_DATARD_STOP;
+		else
+			op = QUP_TAG_V2_DATAWR_STOP;
+	} else {
+		if (msg->flags & I2C_M_RD)
+			op = QUP_TAG_V2_DATARD;
+		else
+			op = QUP_TAG_V2_DATAWR;
+	}
+
+	if (msg->flags & I2C_M_TEN) {
+		len += 5;
+		tag[0] = QUP_TAG_V2_START;
+		tag[1] = addr;
+		tag[2] = op;
+		tag[3] = blen;
+
+		if (msg->flags & I2C_M_RD && last) {
+			len += 2;
+			tag[4] = QUP_BAM_INPUT_EOT;
+			tag[5] = QUP_BAM_FLUSH_STOP;
+		}
+	} else {
+		if (first) {
+			tag[len++] = QUP_TAG_V2_START;
+			tag[len++] = addr;
+		}
+
+		tag[len++] = op;
+		tag[len++] = blen;
+
+		if (msg->flags & I2C_M_RD & last) {
+			tag[len++] = QUP_BAM_INPUT_EOT;
+			tag[len++] = QUP_BAM_FLUSH_STOP;
+		}
+	}
+
+	return len;
+}
+
+void qup_sg_set_buf(struct scatterlist *sg, void *buf, struct tag *tg,
+		    unsigned int buflen, struct qup_i2c_dev *qup,
+		    int map, int dir)
+{
+	sg_set_buf(sg, buf, buflen);
+
+	if (map)
+		sg->dma_address = dma_map_single(qup->dev, buf, buflen, dir);
+	else
+		sg_dma_address(sg) = tg->addr + ((u8 *) buf - tg->start);
+}
+
+static int bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg)
+{
+	struct dma_async_tx_descriptor *txd, *rxd = NULL;
+	int ret = 0;
+	dma_cookie_t cookie_rx, cookie_tx;
+	u32 rx_nents = 0, tx_nents = 0, len = 0;
+	/* QUP I2C read/write limit for single command is 256bytes max*/
+	int blocks = (msg->len + QUP_READ_LIMIT) / QUP_READ_LIMIT;
+	int rem = msg->len % QUP_READ_LIMIT;
+	int tlen, i = 0, tx_len = 0;
+
+	if (msg->flags & I2C_M_RD) {
+		tx_nents = 1;
+		rx_nents = (blocks << 1) + 1;
+		sg_init_table(qup->sg_rx, rx_nents);
+
+		while (i < blocks) {
+			/* transfer length set to '0' implies 256 bytes */
+			tlen = (i == (blocks - 1)) ? rem : 0;
+			len += get_start_tag(&qup->start_tag.start[len],
+					      msg, !i, (i == (blocks-1)),
+					      tlen);
+
+			qup_sg_set_buf(&qup->sg_rx[i << 1],
+				       &qup->scratch_tag.start[0],
+				       &qup->scratch_tag,
+				       2, qup, 0, 0);
+
+			qup_sg_set_buf(&qup->sg_rx[(i << 1) + 1],
+				       &msg->buf[QUP_READ_LIMIT * i],
+				       NULL, tlen, qup, 1,
+				       DMA_FROM_DEVICE);
+
+			i++;
+		}
+
+		sg_init_one(qup->sg_tx, &qup->start_tag.start[0], len);
+		qup_sg_set_buf(qup->sg_tx, &qup->start_tag.start[0],
+			       &qup->start_tag, len, qup, 0, 0);
+		qup_sg_set_buf(&qup->sg_rx[i << 1],
+			       &qup->scratch_tag.start[1],
+			       &qup->scratch_tag, 2,
+			       qup, 0, 0);
+	} else {
+		qup->footer_tag.start[0] = QUP_BAM_FLUSH_STOP;
+		qup->footer_tag.start[1] = QUP_BAM_FLUSH_STOP;
+
+		tx_nents = (blocks << 1) + 1;
+		sg_init_table(qup->sg_tx, tx_nents);
+
+		while (i < blocks) {
+			tlen = (i == (blocks - 1)) ? rem : 0;
+			len = get_start_tag(&qup->start_tag.start[tx_len],
+					    msg, !i, (i == (blocks-1)), tlen);
+
+			qup_sg_set_buf(&qup->sg_tx[i << 1],
+				       &qup->start_tag.start[tx_len],
+				       &qup->start_tag,
+				       len, qup, 0, 0);
+
+			tx_len += len;
+			qup_sg_set_buf(&qup->sg_tx[(i << 1) + 1],
+				       &msg->buf[QUP_READ_LIMIT * i], NULL,
+				       tlen, qup, 1, DMA_TO_DEVICE);
+			i++;
+		}
+		qup_sg_set_buf(&qup->sg_tx[i << 1], &qup->footer_tag.start[0],
+			       &qup->footer_tag, 2,
+			       qup, 0, 0);
+	}
+
+	txd = dmaengine_prep_slave_sg(qup->dma_tx, qup->sg_tx, tx_nents,
+				DMA_MEM_TO_DEV,
+				DMA_PREP_INTERRUPT | DMA_PREP_FENCE);
+	if (!txd) {
+		dev_err(qup->dev, "failed to get tx desc\n");
+		ret = -EINVAL;
+		goto desc_err;
+	}
+
+	if (!rx_nents) {
+		txd->callback = bam_i2c_callback;
+		txd->callback_param = qup;
+	}
+
+	cookie_tx = dmaengine_submit(txd);
+	dma_async_issue_pending(qup->dma_tx);
+
+	if (rx_nents) {
+		rxd = dmaengine_prep_slave_sg(qup->dma_rx, qup->sg_rx,
+			rx_nents, DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+
+		if (!rxd) {
+			dev_err(qup->dev, "failed to get rx desc\n");
+			ret = -EINVAL;
+
+			/* abort TX descriptors */
+			dmaengine_terminate_all(qup->dma_tx);
+			goto desc_err;
+		}
+
+		rxd->callback = bam_i2c_callback;
+		rxd->callback_param = qup;
+		cookie_rx = dmaengine_submit(rxd);
+		dma_async_issue_pending(qup->dma_rx);
+	}
+
+	if (!wait_for_completion_timeout(&qup->xfer, TOUT_MAX * HZ)) {
+		dev_err(qup->dev, "normal trans timed out\n");
+		ret = -ETIMEDOUT;
+	}
+
+	if (ret || qup->bus_err || qup->qup_err) {
+		if (qup->bus_err & QUP_I2C_NACK_FLAG)
+			dev_err(qup->dev, "NACK from %x\n", msg->addr);
+		ret = -EIO;
+		qup_i2c_flush(qup);
+		qup_i2c_change_state(qup, QUP_RUN_STATE);
+
+		/* wait for remaining interrupts to occur */
+		if (!wait_for_completion_timeout(&qup->xfer, HZ))
+			dev_err(qup->dev, "flush timed out\n");
+	}
+
+desc_err:
+	return ret;
+}
+
+static int qup_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg)
+{
+	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
+	int ret = 0;
+
+	enable_irq(qup->irq);
+
+	qup->bus_err = 0;
+	qup->qup_err = 0;
+
+	writel(0, qup->base + QUP_MX_INPUT_CNT);
+	writel(0, qup->base + QUP_MX_OUTPUT_CNT);
+
+	/* set BAM mode */
+	writel(QUP_REPACK_EN | QUP_BAM_MODE, qup->base + QUP_IO_MODE);
+
+	/* mask fifo irqs */
+	writel((0x3 << 8), qup->base + QUP_OPERATIONAL_MASK);
+
+	/* set RUN STATE */
+	ret = qup_i2c_change_state(qup, QUP_RUN_STATE);
+	if (ret)
+		goto out;
+
+	writel(qup->clk_ctl, qup->base + QUP_I2C_CLK_CTL);
+
+	qup->msg = msg;
+	ret = bam_do_xfer(qup, qup->msg);
+out:
+	disable_irq(qup->irq);
+
+	qup->msg = NULL;
+	return ret;
+}
+
 static int qup_i2c_xfer(struct i2c_adapter *adap,
 			struct i2c_msg msgs[],
 			int num)
 {
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
-	int ret, idx;
+	int ret, idx, len;
 
 	ret = pm_runtime_get_sync(qup->dev);
 	if (ret < 0)
@@ -756,10 +1046,17 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 
 		reinit_completion(&qup->xfer);
 
-		if (msgs[idx].flags & I2C_M_RD)
-			ret = qup_i2c_read_one(qup, &msgs[idx]);
-		else
-			ret = qup_i2c_write_one(qup, &msgs[idx]);
+		len = (&msgs[idx])->len;
+
+		if ((qup->is_dma) && (!is_vmalloc_addr((&msgs[idx])->buf)) &&
+						(len > qup->out_fifo_sz)) {
+			ret = qup_bam_xfer(adap, &msgs[idx]);
+		} else {
+			if (msgs[idx].flags & I2C_M_RD)
+				ret = qup_i2c_read_one(qup, &msgs[idx]);
+			else
+				ret = qup_i2c_write_one(qup, &msgs[idx]);
+		}
 
 		if (ret)
 			break;
@@ -790,7 +1087,7 @@ static u32 qup_i2c_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
 }
 
-static const struct i2c_algorithm qup_i2c_algo = {
+static struct i2c_algorithm qup_i2c_algo = {
 	.master_xfer	= qup_i2c_xfer,
 	.functionality	= qup_i2c_func,
 };
@@ -839,6 +1136,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	u32 clk_freq = 100000;
 	const struct qup_i2c_config *config;
 	const struct of_device_id *of_id;
+	int blocks;
 
 	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
 	if (!qup)
@@ -875,6 +1173,53 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		return qup->irq;
 	}
 
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,i2c-qup-v2.1.1") ||
+		of_device_is_compatible(pdev->dev.of_node,
+			"qcom,i2c-qup-v2.2.1")) {
+		qup->dma_rx = dma_request_slave_channel(&pdev->dev, "bam-rx");
+
+		if (!qup->dma_rx)
+			return -EPROBE_DEFER;
+
+		qup->dma_tx = dma_request_slave_channel(&pdev->dev, "bam-tx");
+		if (!qup->dma_tx)
+			return -EPROBE_DEFER;
+
+		qup->is_dma = 1;
+
+		blocks = (MX_BLOCKS << 1) + 1;
+		qup->sg_tx = devm_kzalloc(&pdev->dev,
+					  sizeof(*qup->sg_tx) * blocks,
+					  GFP_KERNEL);
+		if (!qup->sg_tx)
+			return -ENOMEM;
+
+		qup->sg_rx = devm_kzalloc(&pdev->dev,
+					  sizeof(*qup->sg_tx) * blocks,
+					  GFP_KERNEL);
+		if (!qup->sg_rx)
+			return -ENOMEM;
+
+		size = sizeof(struct tag) * (blocks + 3);
+		qup->dpool = dma_pool_create("qup_i2c-dma-pool", &pdev->dev,
+					 size, 4, 0);
+
+		qup->start_tag.start = dma_pool_alloc(qup->dpool, GFP_KERNEL,
+						     &qup->start_tag.addr);
+		if (!qup->start_tag.start)
+			return -ENOMEM;
+
+		qup->scratch_tag.start = dma_pool_alloc(qup->dpool, GFP_KERNEL,
+							&qup->scratch_tag.addr);
+		if (!qup->scratch_tag.start)
+			return -ENOMEM;
+
+		qup->footer_tag.start = dma_pool_alloc(qup->dpool, GFP_KERNEL,
+						       &qup->footer_tag.addr);
+		if (!qup->footer_tag.start)
+			return -ENOMEM;
+	}
+
 	qup->clk = devm_clk_get(qup->dev, "core");
 	if (IS_ERR(qup->clk)) {
 		dev_err(qup->dev, "Could not get core clock\n");
@@ -989,6 +1334,14 @@ static int qup_i2c_remove(struct platform_device *pdev)
 {
 	struct qup_i2c_dev *qup = platform_get_drvdata(pdev);
 
+	dma_pool_free(qup->dpool, qup->start_tag.start,
+		      qup->start_tag.addr);
+	dma_pool_free(qup->dpool, qup->scratch_tag.start,
+		      qup->scratch_tag.addr);
+	dma_pool_free(qup->dpool, qup->footer_tag.start,
+		      qup->footer_tag.addr);
+	dma_pool_destroy(qup->dpool);
+
 	disable_irq(qup->irq);
 	qup_i2c_disable_clocks(qup);
 	i2c_del_adapter(&qup->adap);
-- 
1.8.2.1
