From: Frank.Li@freescale.com (Frank Li)
Date: Sat, 4 Jan 2014 06:53:51 +0800
Subject: [PATCH v2 1/2] spi: spi-imx: enable dma support for escpi controller
Message-ID: <1388789632-12238-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After enable DMA

spi-nor read speed is
dd if=/dev/mtd0 of=/dev/null bs=1M count=1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB) copied, 0.720402 s, 1.5 MB/s

spi-nor write speed is
dd if=/dev/zero of=/dev/mtd0 bs=1M count=1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB) copied, 3.56044 s, 295 kB/s

Before enable DMA

spi-nor read speed is
dd if=/dev/mtd0 of=/dev/null bs=1M count=1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB) copied, 2.37717 s, 441 kB/s

spi-nor write speed is

dd if=/dev/zero of=/dev/mtd0 bs=1M count=1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB) copied, 4.83181 s, 217 kB/s

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/spi/spi-imx.c |  447 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 441 insertions(+), 6 deletions(-)

Change from v1.
	1. check if res is null at res = platform_get_resource(pdev, IORESOURCE_MEM, 0)
	2. fix failure transfer when len is not multiple watermark

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b80f2f7..1a9099a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -39,6 +39,10 @@
 #include <linux/of_gpio.h>
 
 #include <linux/platform_data/spi-imx.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_data/dma-imx.h>
+#include <linux/dmaengine.h>
+
 
 #define DRIVER_NAME "spi_imx"
 
@@ -52,6 +56,9 @@
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
 
+/* The maximum  bytes that a sdma BD can transfer.*/
+#define MAX_SDMA_BD_BYTES  (1 << 15)
+
 struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
@@ -84,6 +91,7 @@ struct spi_imx_data {
 
 	struct completion xfer_done;
 	void __iomem *base;
+	resource_size_t mapbase;
 	int irq;
 	struct clk *clk_per;
 	struct clk *clk_ipg;
@@ -92,6 +100,29 @@ struct spi_imx_data {
 	unsigned int count;
 	void (*tx)(struct spi_imx_data *);
 	void (*rx)(struct spi_imx_data *);
+	int (*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
+	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
+	unsigned int		dma_is_inited;
+	struct device *dev;
+
+	struct completion dma_rx_completion;
+	struct completion dma_tx_completion;
+
+	u8 *dma_rx_tmpbuf;
+	unsigned int dma_rx_tmpbuf_size;
+	unsigned int dma_rx_tmpbuf_phy_addr;
+
+	u8 *dma_tx_tmpbuf;
+	unsigned int dma_tx_tmpbuf_size;
+	unsigned int dma_tx_tmpbuf_phy_addr;
+
+	unsigned int usedma;
+	unsigned int dma_finished;
+	/* SDMA wartermark */
+	u32 rx_wml;
+	u32 tx_wml;
+	u32 rxt_wml;
+
 	void *rx_buf;
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
@@ -185,6 +216,7 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 #define MX51_ECSPI_CTRL		0x08
 #define MX51_ECSPI_CTRL_ENABLE		(1 <<  0)
 #define MX51_ECSPI_CTRL_XCH		(1 <<  2)
+#define MX51_ECSPI_CTRL_SMC		(1 <<  3)
 #define MX51_ECSPI_CTRL_MODE_MASK	(0xf << 4)
 #define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
@@ -202,9 +234,22 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
 #define MX51_ECSPI_INT_RREN		(1 <<  3)
 
+#define MX51_ECSPI_DMA      0x14
+#define MX51_ECSPI_DMA_TX_WML_OFFSET 0
+#define MX51_ECSPI_DMA_TX_WML_MASK 0x3F
+#define MX51_ECSPI_DMA_RX_WML_OFFSET 16
+#define MX51_ECSPI_DMA_RX_WML_MASK (0x3F << 16)
+#define MX51_ECSPI_DMA_RXT_WML_OFFSET 24
+#define MX51_ECSPI_DMA_RXT_WML_MASK (0x3F << 16)
+
+#define MX51_ECSPI_DMA_TEDEN_OFFSET 7
+#define MX51_ECSPI_DMA_RXDEN_OFFSET 23
+#define MX51_ECSPI_DMA_RXTDEN_OFFSET 31
+
 #define MX51_ECSPI_STAT		0x18
 #define MX51_ECSPI_STAT_RR		(1 <<  3)
 
+#define MX51_ECSPI_TESTREG	0x20
 /* MX51 eCSPI */
 static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi)
 {
@@ -255,16 +300,28 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 {
 	u32 reg;
 
-	reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
-	reg |= MX51_ECSPI_CTRL_XCH;
-	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	if (!spi_imx->usedma) {
+		reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+		reg |= MX51_ECSPI_CTRL_XCH;
+		writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	} else {
+		if (!spi_imx->dma_finished) {
+			reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+			reg |= MX51_ECSPI_CTRL_SMC;
+			writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+		} else {
+			reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+			reg &= (~MX51_ECSPI_CTRL_SMC);
+			writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+		}
+	}
 }
 
 static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
-	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0;
-
+	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0, dma = 0;
+	u32 tx_wml_cfg, rx_wml_cfg, rxt_wml_cfg;
 	/*
 	 * The hardware seems to have a race condition when changing modes. The
 	 * current assumption is that the selection of the channel arrives
@@ -297,6 +354,30 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
+	/*
+	 * Configure the DMA register: setup the watermark
+	 * and enable DMA request.
+	 */
+	if (spi_imx->dma_is_inited) {
+		dma = readl(spi_imx->base + MX51_ECSPI_DMA);
+
+		spi_imx->tx_wml = spi_imx_get_fifosize(spi_imx) / 2;
+		spi_imx->rx_wml = spi_imx_get_fifosize(spi_imx) / 2;
+		spi_imx->rxt_wml = spi_imx_get_fifosize(spi_imx) / 2;
+		rx_wml_cfg = spi_imx->rx_wml << MX51_ECSPI_DMA_RX_WML_OFFSET;
+		tx_wml_cfg = spi_imx->tx_wml << MX51_ECSPI_DMA_TX_WML_OFFSET;
+		rxt_wml_cfg = spi_imx->rxt_wml << MX51_ECSPI_DMA_RXT_WML_OFFSET;
+		dma = (dma & (~MX51_ECSPI_DMA_TX_WML_MASK)
+				   & (~MX51_ECSPI_DMA_RX_WML_MASK)
+				   & (~MX51_ECSPI_DMA_RXT_WML_MASK))
+				   | rx_wml_cfg | tx_wml_cfg | rxt_wml_cfg
+				   | (1 << MX51_ECSPI_DMA_TEDEN_OFFSET)
+				   | (1 << MX51_ECSPI_DMA_RXDEN_OFFSET)
+				   | (1 << MX51_ECSPI_DMA_RXTDEN_OFFSET);
+
+		writel(dma, spi_imx->base + MX51_ECSPI_DMA);
+	}
+
 	return 0;
 }
 
@@ -708,7 +789,285 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	return 0;
 }
 
-static int spi_imx_transfer(struct spi_device *spi,
+static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
+{
+	if (spi_imx->dma_chan_rx) {
+		dma_release_channel(spi_imx->dma_chan_rx);
+		spi_imx->dma_chan_rx = NULL;
+	}
+
+	if (spi_imx->dma_chan_tx) {
+		dma_release_channel(spi_imx->dma_chan_tx);
+		spi_imx->dma_chan_tx = NULL;
+	}
+
+	spi_imx->dma_is_inited = 0;
+}
+
+static void spi_imx_dma_rx_callback(void *cookie)
+{
+	struct spi_imx_data *spi_imx = (struct spi_imx_data *)cookie;
+
+	complete(&spi_imx->dma_rx_completion);
+
+}
+
+static void spi_imx_dma_tx_callback(void *cookie)
+{
+	struct spi_imx_data *spi_imx = (struct spi_imx_data *)cookie;
+
+	complete(&spi_imx->dma_tx_completion);
+}
+
+static int spi_imx_sdma_transfer(struct spi_device *spi,
+				struct spi_transfer *transfer)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	int ret = 0;
+	int sg_num;
+	int loop;
+	int left;
+	u32 dma;
+
+	struct scatterlist *sg_rx, *sg_tx;
+	struct dma_async_tx_descriptor *txdesc;
+	struct dma_async_tx_descriptor *rxdesc;
+
+	init_completion(&spi_imx->dma_rx_completion);
+	init_completion(&spi_imx->dma_tx_completion);
+
+	/*
+	 * Get the valid physical address for the tx buf, if the rx buf address
+	 * is null or it cannot be mapped, we should allocate memory for it.
+	 */
+	if (virt_addr_valid(transfer->tx_buf)) {
+		transfer->tx_dma = dma_map_single(spi_imx->dev,
+				 (void *)transfer->tx_buf, transfer->len,
+				 DMA_TO_DEVICE);
+		if (dma_mapping_error(spi_imx->dev, transfer->tx_dma)) {
+			dev_err(spi_imx->dev,
+			"Memory dma map fail, line = %d\n", __LINE__);
+			ret = -EFAULT;
+			goto err_tx;
+		}
+	} else {
+		if (transfer->len > spi_imx->dma_tx_tmpbuf_size) {
+			if (!spi_imx->dma_tx_tmpbuf_size) {
+				kfree(spi_imx->dma_tx_tmpbuf);
+				spi_imx->dma_tx_tmpbuf_size = 0;
+			}
+
+			spi_imx->dma_tx_tmpbuf =
+					kzalloc(transfer->len, GFP_KERNEL);
+			if (NULL == spi_imx->dma_tx_tmpbuf) {
+				dev_err(spi_imx->dev, "Alloc memory fail.\n");
+				ret = -EFAULT;
+				goto err_tx;
+			}
+			spi_imx->dma_tx_tmpbuf_size = transfer->len;
+		}
+
+		/*
+		 * Move the transfered data to new buffer from the old one
+		 * that cannot be mapped.
+		 */
+		if (transfer->tx_buf)
+			memcpy(spi_imx->dma_tx_tmpbuf,
+					transfer->tx_buf,
+					transfer->len);
+
+		spi_imx->dma_tx_tmpbuf_phy_addr = dma_map_single(spi_imx->dev,
+			spi_imx->dma_tx_tmpbuf, transfer->len,
+			DMA_TO_DEVICE);
+
+		if (dma_mapping_error(spi_imx->dev,
+			spi_imx->dma_tx_tmpbuf_phy_addr)) {
+			dev_err(spi_imx->dev,
+				"Memory dma map fail, line = %d\n",
+				__LINE__);
+			ret = -EFAULT;
+			goto err_tx;
+		}
+
+		transfer->tx_dma = spi_imx->dma_tx_tmpbuf_phy_addr;
+	}
+
+	/* Prepare sg for tx sdma. */
+	sg_num = ((transfer->len - 1) / MAX_SDMA_BD_BYTES) + 1;
+	sg_tx = kzalloc(sg_num * sizeof(struct scatterlist), GFP_KERNEL);
+	if (NULL == sg_tx) {
+		dev_err(spi_imx->dev,
+			"Memory allocate fail, line = %d\n",
+			__LINE__);
+		goto err_tx_sg;
+	}
+	sg_init_table(sg_tx, sg_num);
+	for (loop = 0; loop < (sg_num - 1); loop++) {
+		sg_dma_address(&sg_tx[loop]) =
+			transfer->tx_dma + loop * MAX_SDMA_BD_BYTES;
+		sg_dma_len(&sg_tx[loop]) = MAX_SDMA_BD_BYTES;
+	}
+
+	sg_dma_address(&sg_tx[loop]) =
+		transfer->tx_dma + loop * MAX_SDMA_BD_BYTES;
+	sg_dma_len(&sg_tx[loop]) = transfer->len - loop * MAX_SDMA_BD_BYTES;
+
+	txdesc = dmaengine_prep_slave_sg(spi_imx->dma_chan_tx,
+			sg_tx, sg_num , DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
+	if (!txdesc) {
+		ret = -EFAULT;
+		goto err_rx;
+	}
+
+	txdesc->callback = spi_imx_dma_tx_callback;
+	txdesc->callback_param = (void *)spi_imx;
+
+	/*
+	 * Get the valid physical address for the rx buf, if the rx buf address
+	 * is null or it cannot be mapped, we should allocate memory for it.
+	 */
+	if (virt_addr_valid(transfer->rx_buf)) {
+		transfer->rx_dma = dma_map_single(spi_imx->dev,
+				transfer->rx_buf, transfer->len,
+				DMA_FROM_DEVICE);
+
+		if (dma_mapping_error(spi_imx->dev, transfer->rx_dma)) {
+			dev_err(spi_imx->dev,
+				"Memory allocate fail, line = %d\n",
+				__LINE__);
+			ret = -EFAULT;
+			goto err_rx;
+		}
+	} else {
+		if (transfer->len > spi_imx->dma_rx_tmpbuf_size) {
+			if (!spi_imx->dma_rx_tmpbuf_size) {
+				kfree(spi_imx->dma_rx_tmpbuf);
+				spi_imx->dma_rx_tmpbuf_size = 0;
+			}
+
+			spi_imx->dma_rx_tmpbuf =
+					kzalloc(transfer->len, GFP_KERNEL);
+			if (NULL == spi_imx->dma_rx_tmpbuf) {
+				dev_err(spi_imx->dev, "Alloc memory fail.\n");
+				ret = -EFAULT;
+				goto err_rx;
+			}
+			spi_imx->dma_rx_tmpbuf_size = transfer->len;
+		}
+
+		spi_imx->dma_rx_tmpbuf_phy_addr = dma_map_single(spi_imx->dev,
+				spi_imx->dma_rx_tmpbuf, transfer->len,
+				DMA_FROM_DEVICE);
+
+		if (dma_mapping_error(spi_imx->dev,
+				spi_imx->dma_rx_tmpbuf_phy_addr)) {
+			dev_err(spi_imx->dev,
+				"Memory dma map fail, line = %d\n",
+				__LINE__);
+			ret = -EFAULT;
+			goto err_rx;
+		}
+
+		transfer->rx_dma = spi_imx->dma_rx_tmpbuf_phy_addr;
+	}
+
+	/* Prepare sg for rx sdma. */
+	sg_num = ((transfer->len - 1) / MAX_SDMA_BD_BYTES) + 1;
+	sg_rx = kzalloc(sg_num * sizeof(struct scatterlist), GFP_KERNEL);
+	if (NULL == sg_rx) {
+		dev_err(spi_imx->dev,
+			"Memory dma map fail, line = %d\n", __LINE__);
+		goto err_rx_sg;
+	}
+	sg_init_table(sg_rx, sg_num);
+	for (loop = 0; loop < (sg_num - 1); loop++) {
+		sg_dma_address(&sg_rx[loop]) =
+			transfer->rx_dma + loop * MAX_SDMA_BD_BYTES;
+		sg_dma_len(&sg_rx[loop]) = MAX_SDMA_BD_BYTES;
+	}
+
+	sg_dma_address(&sg_rx[loop]) =
+			transfer->rx_dma + loop * MAX_SDMA_BD_BYTES;
+	sg_dma_len(&sg_rx[loop]) = transfer->len - loop * MAX_SDMA_BD_BYTES;
+	rxdesc = dmaengine_prep_slave_sg(spi_imx->dma_chan_rx,
+			sg_rx, sg_num , DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!rxdesc) {
+		ret = -EFAULT;
+		goto err_desc;
+	}
+
+	rxdesc->callback = spi_imx_dma_rx_callback;
+	rxdesc->callback_param = (void *)spi_imx;
+
+	/* Trigger the cspi module. */
+	spi_imx->dma_finished = 0;
+
+	spi_imx->devtype_data->trigger(spi_imx);
+
+	dmaengine_submit(txdesc);
+	dmaengine_submit(rxdesc);
+
+	dma_async_issue_pending(spi_imx->dma_chan_tx);
+	dma_async_issue_pending(spi_imx->dma_chan_rx);
+
+	/* Wait SDMA to finish the data transfer.*/
+	ret = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
+						msecs_to_jiffies(3000));
+	if (!ret) {
+		dev_err(spi_imx->dev,
+			"I/O Error in DMA TX, line = %d ####\n", __LINE__);
+		dmaengine_terminate_all(spi_imx->dma_chan_tx);
+		goto err_desc;
+	} else {
+		dma = readl(spi_imx->base + MX51_ECSPI_DMA);
+		dma = dma & (~MX51_ECSPI_DMA_RXT_WML_MASK);
+		/* Change RX_DMA_LENGTH trigger dma fetch tail data */
+		left = transfer->len & (~spi_imx->rxt_wml);
+		if (left)
+			writel(dma | (left << MX51_ECSPI_DMA_RXT_WML_OFFSET),
+					spi_imx->base + MX51_ECSPI_DMA);
+
+		ret = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
+				msecs_to_jiffies(3000));
+
+		writel(dma | (spi_imx->rxt_wml << MX51_ECSPI_DMA_RXT_WML_OFFSET),
+				spi_imx->base + MX51_ECSPI_DMA);
+		if (!ret) {
+			dev_err(spi_imx->dev,
+				"I/O Error in DMA RX. len %d, line = %d\n",
+					transfer->len,
+					__LINE__);
+			spi_imx->devtype_data->reset(spi_imx);
+			dmaengine_terminate_all(spi_imx->dma_chan_rx);
+		}
+	}
+
+	/* Move the transfered data to rx buf when it cannot be mapped.*/
+	if (transfer->rx_buf && (!virt_addr_valid(transfer->rx_buf)))
+		memcpy(transfer->rx_buf,
+				spi_imx->dma_rx_tmpbuf,
+				transfer->len);
+
+err_desc:
+	kfree(sg_rx);
+err_rx_sg:
+	dma_unmap_single(spi_imx->dev, transfer->rx_dma,
+		transfer->len, DMA_TO_DEVICE);
+err_rx:
+	kfree(sg_tx);
+err_tx_sg:
+	dma_unmap_single(spi_imx->dev, transfer->tx_dma,
+		transfer->len, DMA_FROM_DEVICE);
+err_tx:
+	spi_imx->dma_finished = 1;
+	spi_imx->devtype_data->trigger(spi_imx);
+	if ((!ret) || (-EFAULT == ret))
+		return -EIO;
+	else
+		return transfer->len;
+}
+
+static int spi_imx_pio_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -729,6 +1088,27 @@ static int spi_imx_transfer(struct spi_device *spi,
 	return transfer->len;
 }
 
+static int spi_imx_transfer(struct spi_device *spi,
+				struct spi_transfer *transfer)
+{
+	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+
+	if (spi_imx->dma_chan_tx && spi_imx->dma_chan_rx) {
+		/*
+		 * Don't use sdma when the size of data to be transfered is
+		 * lower then SDMA wartermark.
+		 */
+		if ((transfer->len >= spi_imx->rx_wml) &&
+				(transfer->len > spi_imx->tx_wml)) {
+			spi_imx->usedma = 1;
+			return spi_imx_sdma_transfer(spi, transfer);
+		}
+	}
+
+	spi_imx->usedma = 0;
+	return spi_imx_pio_transfer(spi, transfer);
+}
+
 static int spi_imx_setup(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -778,6 +1158,56 @@ spi_imx_unprepare_message(struct spi_master *master, struct spi_message *msg)
 	return 0;
 }
 
+static int spi_imx_sdma_init(struct spi_imx_data *spi_imx)
+{
+	struct dma_slave_config slave_config = {};
+	struct device *dev = spi_imx->dev;
+	int ret;
+
+
+	/* Prepare for TX : */
+	spi_imx->dma_chan_tx = dma_request_slave_channel(dev, "tx");
+	if (!spi_imx->dma_chan_tx) {
+		dev_err(dev, "cannot get the TX DMA channel!\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	slave_config.direction = DMA_MEM_TO_DEV;
+	slave_config.dst_addr = spi_imx->mapbase + MXC_CSPITXDATA;
+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
+	ret = dmaengine_slave_config(spi_imx->dma_chan_tx, &slave_config);
+	if (ret) {
+		dev_err(dev, "error in TX dma configuration.");
+		goto err;
+	}
+
+	/* Prepare for RX : */
+	spi_imx->dma_chan_rx = dma_request_slave_channel(dev, "rx");
+	if (!spi_imx->dma_chan_rx) {
+		dev_dbg(dev, "cannot get the DMA channel.\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	slave_config.direction = DMA_DEV_TO_MEM;
+	slave_config.src_addr = spi_imx->mapbase + MXC_CSPIRXDATA;
+	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.src_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
+	ret = dmaengine_slave_config(spi_imx->dma_chan_rx, &slave_config);
+	if (ret) {
+		dev_err(dev, "error in RX dma configuration.\n");
+		goto err;
+	}
+	spi_imx->dma_is_inited = 1;
+
+	return 0;
+err:
+	spi_imx_sdma_exit(spi_imx);
+	return ret;
+}
+
 static int spi_imx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -849,6 +1279,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		spi_imx->mapbase = res->start;
 	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(spi_imx->base)) {
 		ret = PTR_ERR(spi_imx->base);
@@ -890,6 +1322,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
 
+	spi_imx->dev = &pdev->dev;
+	spi_imx_sdma_init(spi_imx);
+
 	spi_imx->devtype_data->reset(spi_imx);
 
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
-- 
1.7.8
