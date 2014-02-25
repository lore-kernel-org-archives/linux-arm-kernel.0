From: b44548@freescale.com (Chao Fu)
Date: Tue, 25 Feb 2014 14:54:18 +0800
Subject: [PATCH 3/3] spi:fsl-dspi:add dspi dma transfer support
In-Reply-To: <1393311258-14380-1-git-send-email-b44548@freescale.com>
References: <1393311258-14380-1-git-send-email-b44548@freescale.com>
Message-ID: <1393311258-14380-3-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

DSPI can transfer data in DMA mode or PIO mode.This patch will add the DMA
transfer driver support. Add DMA reference functions and variables to form DMA
transfer process.
DSPI DMA mode need work with Freescale eDMA module together.

The software will be changed in two transfer methods as followwing:
		 DMA			PIO
trigger write:	 dspi_tx_dma		dspi_tx_pio
write complete:	 dspi_dma_tx_complete   irq_handle
trigger read:	 dspi_receive_dma	dspi_rx_pio
read complete:	 dspi_rx_dma		none

Remove bitbang:
Add DMA funtions, DSPI module need get cs change information in a spi transfer.
According cs change, DSPI will give last data the right flag. Bitbang provide
cs change behind the last data in a transfer. DSPI can not deal the last data in
every transfer properly, so remove the bitbang in driver.

Signed-off-by: Chao Fu      <b44548@freescale.com>
---
 drivers/spi/Kconfig        |   1 -
 drivers/spi/spi-fsl-dspi.c | 425 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 360 insertions(+), 66 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6554bd0..c9240e9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -269,7 +269,6 @@ config SPI_FSL_SPI
 
 config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
-	select SPI_BITBANG
 	select REGMAP_MMIO
 	depends on SOC_VF610 || COMPILE_TEST
 	help
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 42ede0d..a22061f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -25,7 +25,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi_bitbang.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -37,6 +38,7 @@
 #define TRAN_STATE_WORD_ODD_NUM	0x04
 
 #define DSPI_FIFO_SIZE			4
+#define DSPI_DMA_BUFSIZE		(DSPI_FIFO_SIZE * 4)
 
 #define SPI_MCR		0x00
 #define SPI_MCR_MASTER		(1 << 31)
@@ -67,6 +69,10 @@
 
 #define SPI_RSER		0x30
 #define SPI_RSER_EOQFE		0x10000000
+#define SPI_RSER_TFFFE		0x02000000
+#define SPI_RSER_TFFFD		0x01000000
+#define SPI_RSER_RFDFE		0x00020000
+#define SPI_RSER_RFDFD		0x00010000
 
 #define SPI_PUSHR		0x34
 #define SPI_PUSHR_CONT		(1 << 31)
@@ -106,7 +112,7 @@ struct chip_data {
 };
 
 struct fsl_dspi {
-	struct spi_bitbang	bitbang;
+	struct spi_master	*master;
 	struct platform_device	*pdev;
 
 	struct regmap		*regmap;
@@ -114,6 +120,7 @@ struct fsl_dspi {
 	struct clk		*clk;
 
 	struct spi_transfer	*cur_transfer;
+	struct spi_message	*cur_msg;
 	struct chip_data	*cur_chip;
 	size_t			len;
 	void			*tx;
@@ -123,11 +130,31 @@ struct fsl_dspi {
 	char			dataflags;
 	u8			cs;
 	u16			void_write_data;
+	u32			cs_change;
 
 	wait_queue_head_t	waitq;
 	u32			waitflags;
+
+	/*For DMA Support*/
+	bool			use_dma;
+	struct dma_chan		*chan_tx;
+	struct dma_chan		*chan_rx;
+	u32			*dma_tx_buf;
+	u32			*dma_rx_buf;
+	dma_addr_t		dma_tx_bufphy;
+	dma_addr_t		dma_rx_bufphy;
+	struct dma_async_tx_descriptor *tx_desc;
+	struct dma_async_tx_descriptor *rx_desc;
+	size_t			dma_count;
+	dma_addr_t		phybase;
 };
 
+static int dspi_send_dma(struct fsl_dspi *dspi, size_t count);
+static int dspi_receive_dma(struct fsl_dspi *dspi, size_t count);
+void dspi_rx_dma(void *arg);
+static int dspi_tx_dma(struct fsl_dspi *dspi);
+static void dspi_release_dma(struct fsl_dspi *dspi);
+
 static inline int is_double_byte_mode(struct fsl_dspi *dspi)
 {
 	unsigned int val;
@@ -165,7 +192,249 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 	*br =  ARRAY_SIZE(brs) - 1;
 }
 
-static int dspi_transfer_write(struct fsl_dspi *dspi)
+static void dspi_dma_tx_complete(void *arg)
+{
+	struct fsl_dspi *dspi = arg;
+	struct spi_message *msg = dspi->cur_msg;
+
+	dspi_receive_dma(dspi, dspi->dma_count);
+
+	if (dspi->len > 0)
+		msg->actual_length += dspi_tx_dma(dspi);
+}
+
+static int dspi_send_dma(struct fsl_dspi *dspi, size_t count)
+{
+	dspi->tx_desc = dmaengine_prep_slave_single(
+			dspi->chan_tx, dspi->dma_tx_bufphy,
+			count * DMA_SLAVE_BUSWIDTH_4_BYTES,
+			DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+
+	if (!dspi->tx_desc) {
+		dev_err(&dspi->pdev->dev, "dma prepare tx desc fail!\n");
+		dspi->use_dma = 0;
+		dspi_release_dma(dspi);
+		dspi->waitflags = 1;
+		wake_up_interruptible(&dspi->waitq);
+
+		return -EINVAL;
+	}
+
+	dspi->tx_desc->callback = dspi_dma_tx_complete;
+	dspi->tx_desc->callback_param = dspi;
+
+	dmaengine_submit(dspi->tx_desc);
+	dma_async_issue_pending(dspi->chan_tx);
+
+	return 0;
+}
+
+static int dspi_receive_dma(struct fsl_dspi *dspi, size_t count)
+{
+
+	dspi->rx_desc = dmaengine_prep_slave_single(
+			dspi->chan_rx, dspi->dma_rx_bufphy,
+			count * DMA_SLAVE_BUSWIDTH_4_BYTES,
+			DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+
+	if (!dspi->rx_desc) {
+		dev_err(&dspi->pdev->dev, "dma prepare rx desc fail!\n");
+		dspi->use_dma = 0;
+		dspi_release_dma(dspi);
+		dspi->waitflags = 1;
+		wake_up_interruptible(&dspi->waitq);
+
+		return -EINVAL;
+	}
+
+	dspi->rx_desc->callback = dspi_rx_dma;
+	dspi->rx_desc->callback_param = dspi;
+	dma_sync_single_for_device(&dspi->pdev->dev,
+				dspi->dma_rx_bufphy,
+				DSPI_DMA_BUFSIZE, DMA_FROM_DEVICE);
+
+	dmaengine_submit(dspi->rx_desc);
+	dma_async_issue_pending(dspi->chan_rx);
+
+	return 0;
+}
+
+static int dspi_request_dma(struct fsl_dspi *dspi)
+{
+	struct dma_slave_config cfg;
+	int ret = -EINVAL;
+
+	dspi->chan_rx = dma_request_slave_channel(&dspi->pdev->dev, "rx");
+	if (dspi->chan_rx) {
+		cfg.direction = DMA_DEV_TO_MEM;
+		cfg.dst_addr = 0;
+		cfg.src_addr = dspi->phybase + SPI_POPR;
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		cfg.src_maxburst = 1;
+		ret = dmaengine_slave_config(dspi->chan_rx, &cfg);
+		if (!ret)
+			dev_info(&dspi->pdev->dev, "Configed DSPI rx channel");
+		else
+			return ret;
+	}
+
+	dspi->chan_tx = dma_request_slave_channel(&dspi->pdev->dev, "tx");
+	if (dspi->chan_tx) {
+		cfg.direction = DMA_MEM_TO_DEV;
+		cfg.dst_addr = dspi->phybase + SPI_PUSHR;
+		cfg.src_addr = 0;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		cfg.dst_maxburst = 1;
+		ret = dmaengine_slave_config(dspi->chan_tx, &cfg);
+		if (!ret)
+			dev_info(&dspi->pdev->dev, "Configed DSPI tx channel");
+		else
+			return ret;
+	}
+
+	dspi->dma_tx_buf = devm_kzalloc(&dspi->pdev->dev,
+					DSPI_DMA_BUFSIZE, GFP_DMA);
+	if (!dspi->dma_tx_buf)
+		return -ENOMEM;
+	dspi->dma_rx_buf = devm_kzalloc(&dspi->pdev->dev,
+					DSPI_DMA_BUFSIZE, GFP_DMA);
+	if (!dspi->dma_rx_buf)
+		return -ENOMEM;
+
+	dspi->dma_tx_bufphy = dma_map_single(dspi->chan_tx->device->dev,
+						dspi->dma_tx_buf,
+						DSPI_DMA_BUFSIZE,
+						DMA_TO_DEVICE);
+	dspi->dma_rx_bufphy = dma_map_single(dspi->chan_rx->device->dev,
+						dspi->dma_rx_buf,
+						DSPI_DMA_BUFSIZE,
+						DMA_FROM_DEVICE);
+
+	return ret;
+}
+
+static void dspi_release_dma(struct fsl_dspi *dspi)
+{
+	if (dspi->dma_tx_buf)
+		devm_kfree(&dspi->pdev->dev, dspi->dma_tx_buf);
+	if (dspi->dma_rx_buf)
+		devm_kfree(&dspi->pdev->dev, dspi->dma_rx_buf);
+	if (dspi->chan_tx)
+		dma_release_channel(dspi->chan_tx);
+	if (dspi->chan_rx)
+		dma_release_channel(dspi->chan_rx);
+}
+
+void dspi_rx_dma(void *arg)
+{
+	struct fsl_dspi *dspi = arg;
+	int rx_count = 0;
+	int rx_word = is_double_byte_mode(dspi);
+	u16 d;
+
+	dma_sync_single_for_cpu(&dspi->pdev->dev, dspi->dma_rx_bufphy,
+					DSPI_DMA_BUFSIZE, DMA_FROM_DEVICE);
+
+	while ((dspi->rx < dspi->rx_end)
+			&& (rx_count < DSPI_FIFO_SIZE)) {
+		if (rx_word) {
+			if ((dspi->rx_end - dspi->rx) == 1)
+				break;
+
+			d = SPI_POPR_RXDATA(*(dspi->dma_rx_buf + rx_count));
+
+			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
+				*(u16 *)dspi->rx = d;
+			dspi->rx += 2;
+
+		} else {
+			d = SPI_POPR_RXDATA(*(dspi->dma_rx_buf + rx_count));
+			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
+				*(u8 *)dspi->rx = d;
+			dspi->rx++;
+		}
+
+		rx_count++;
+	}
+
+	if (dspi->len == 0) {
+		dspi->waitflags = 1;
+		wake_up_interruptible(&dspi->waitq);
+	}
+}
+
+static int dspi_tx_dma(struct fsl_dspi *dspi)
+{
+	int tx_count = 0;
+	int tx_word;
+	u16 d16;
+	u8  d8;
+	u32 *dma_buf = (u32 *)dspi->dma_tx_buf;
+
+	dma_sync_single_for_cpu(&dspi->pdev->dev, dspi->dma_tx_bufphy,
+					DSPI_DMA_BUFSIZE, DMA_TO_DEVICE);
+
+	tx_word = is_double_byte_mode(dspi);
+
+	if (tx_word && (dspi->len == 1)) {
+		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
+		regmap_update_bits(dspi->regmap, SPI_CTAR(dspi->cs),
+			SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
+		tx_word = 0;
+	}
+
+	while (dspi->len && (tx_count < DSPI_FIFO_SIZE)) {
+		if (tx_word) {
+			if (dspi->len == 1)
+				break;
+
+			if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
+				d16 = *(u16 *)dspi->tx;
+				dspi->tx += 2;
+			} else {
+				d16 = dspi->void_write_data;
+			}
+
+			*(dma_buf + tx_count) =
+					SPI_PUSHR_TXDATA(d16) |
+					SPI_PUSHR_PCS(dspi->cs) |
+					SPI_PUSHR_CTAS(dspi->cs) |
+					SPI_PUSHR_CONT;
+			dspi->len -= 2;
+		} else {
+			if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
+				d8 = *(u8 *)dspi->tx;
+				dspi->tx++;
+			} else {
+				d8 = (u8)dspi->void_write_data;
+			}
+
+			*(dma_buf + tx_count) =
+					SPI_PUSHR_TXDATA(d8) |
+					SPI_PUSHR_PCS(dspi->cs) |
+					SPI_PUSHR_CTAS(dspi->cs) |
+					SPI_PUSHR_CONT;
+			dspi->len--;
+		}
+
+		if ((dspi->cs_change) && (!dspi->len))
+			*(dma_buf + tx_count) &= ~SPI_PUSHR_CONT;
+
+		tx_count++;
+	}
+
+	*(dma_buf) |= SPI_PUSHR_CTCNT; /*first clear fifo count*/
+	dspi->dma_count = tx_count;
+
+	dma_sync_single_for_device(&dspi->pdev->dev, dspi->dma_tx_bufphy,
+					DSPI_DMA_BUFSIZE, DMA_TO_DEVICE);
+	dspi_send_dma(dspi, dspi->dma_count);
+
+	return tx_count * (tx_word + 1);
+}
+
+
+static int dspi_tx_pio(struct fsl_dspi *dspi)
 {
 	int tx_count = 0;
 	int tx_word;
@@ -225,6 +494,9 @@ static int dspi_transfer_write(struct fsl_dspi *dspi)
 		if (dspi->len == 0 || tx_count == DSPI_FIFO_SIZE - 1) {
 			/* last transfer in the transfer */
 			dspi_pushr |= SPI_PUSHR_EOQ;
+			if ((dspi->cs_change) && (!dspi->len))
+				dspi_pushr &= ~SPI_PUSHR_CONT;
+
 		} else if (tx_word && (dspi->len == 1))
 			dspi_pushr |= SPI_PUSHR_EOQ;
 
@@ -241,7 +513,7 @@ static int dspi_transfer_write(struct fsl_dspi *dspi)
 	return tx_count * (tx_word + 1);
 }
 
-static int dspi_transfer_read(struct fsl_dspi *dspi)
+static int dspi_rx_pio(struct fsl_dspi *dspi)
 {
 	int rx_count = 0;
 	int rx_word = is_double_byte_mode(dspi);
@@ -276,64 +548,74 @@ static int dspi_transfer_read(struct fsl_dspi *dspi)
 	return rx_count;
 }
 
-static int dspi_txrx_transfer(struct spi_device *spi, struct spi_transfer *t)
+static int dspi_transfer_one_message(struct spi_master *master,
+		struct spi_message *message)
 {
-	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
-	dspi->cur_transfer = t;
-	dspi->cur_chip = spi_get_ctldata(spi);
-	dspi->cs = spi->chip_select;
-	dspi->void_write_data = dspi->cur_chip->void_write_data;
-
-	dspi->dataflags = 0;
-	dspi->tx = (void *)t->tx_buf;
-	dspi->tx_end = dspi->tx + t->len;
-	dspi->rx = t->rx_buf;
-	dspi->rx_end = dspi->rx + t->len;
-	dspi->len = t->len;
-
-	if (!dspi->rx)
-		dspi->dataflags |= TRAN_STATE_RX_VOID;
-
-	if (!dspi->tx)
-		dspi->dataflags |= TRAN_STATE_TX_VOID;
-
-	regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val);
-	regmap_write(dspi->regmap, SPI_CTAR(dspi->cs), dspi->cur_chip->ctar_val);
-	regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
-
-	if (t->speed_hz)
+	struct fsl_dspi *dspi = spi_master_get_devdata(master);
+	struct spi_device *spi = message->spi;
+	struct spi_transfer *transfer;
+	int status = 0;
+	message->actual_length = 0;
+
+	list_for_each_entry(transfer, &message->transfers, transfer_list) {
+		dspi->cur_transfer = transfer;
+		dspi->cur_msg = message;
+		dspi->cur_chip = spi_get_ctldata(spi);
+		dspi->cs = spi->chip_select;
+		if (dspi->cur_transfer->transfer_list.next
+				== &dspi->cur_msg->transfers)
+			transfer->cs_change = 1;
+		dspi->cs_change = transfer->cs_change;
+		dspi->void_write_data = dspi->cur_chip->void_write_data;
+
+		dspi->dataflags = 0;
+		dspi->tx = (void *)transfer->tx_buf;
+		dspi->tx_end = dspi->tx + transfer->len;
+		dspi->rx = transfer->rx_buf;
+		dspi->rx_end = dspi->rx + transfer->len;
+		dspi->len = transfer->len;
+
+		if (!dspi->rx)
+			dspi->dataflags |= TRAN_STATE_RX_VOID;
+
+		if (!dspi->tx)
+			dspi->dataflags |= TRAN_STATE_TX_VOID;
+
+		regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val);
 		regmap_write(dspi->regmap, SPI_CTAR(dspi->cs),
 				dspi->cur_chip->ctar_val);
+		if (dspi->use_dma)
+			regmap_write(dspi->regmap, SPI_RSER,
+					SPI_RSER_TFFFE | SPI_RSER_TFFFD
+					| SPI_RSER_RFDFE | SPI_RSER_RFDFD);
+		else
+			regmap_write(dspi->regmap, SPI_RSER, SPI_RSER_EOQFE);
 
-	dspi_transfer_write(dspi);
-
-	if (wait_event_interruptible(dspi->waitq, dspi->waitflags))
-		dev_err(&dspi->pdev->dev, "wait transfer complete fail!\n");
-	dspi->waitflags = 0;
+		if (transfer->speed_hz)
+			regmap_write(dspi->regmap, SPI_CTAR(dspi->cs),
+					dspi->cur_chip->ctar_val);
 
-	return t->len - dspi->len;
-}
+		if (dspi->use_dma)
+			message->actual_length += dspi_tx_dma(dspi);
+		else
+			message->actual_length += dspi_tx_pio(dspi);
 
-static void dspi_chipselect(struct spi_device *spi, int value)
-{
-	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
-	unsigned int pushr;
+		if (wait_event_interruptible(dspi->waitq, dspi->waitflags))
+			dev_err(&dspi->pdev->dev, "wait transfer complete fail!\n");
+		dspi->waitflags = 0;
 
-	regmap_read(dspi->regmap, SPI_PUSHR, &pushr);
+		if (transfer->delay_usecs)
+			udelay(transfer->delay_usecs);
 
-	switch (value) {
-	case BITBANG_CS_ACTIVE:
-		pushr |= SPI_PUSHR_CONT;
-		break;
-	case BITBANG_CS_INACTIVE:
-		pushr &= ~SPI_PUSHR_CONT;
-		break;
 	}
 
-	regmap_write(dspi->regmap, SPI_PUSHR, pushr);
+	message->status = status;
+	spi_finalize_current_message(master);
+
+	return status;
 }
 
-static int dspi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
+static int dspi_setup(struct spi_device *spi)
 {
 	struct chip_data *chip;
 	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
@@ -374,21 +656,24 @@ static int dspi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	return 0;
 }
 
-static int dspi_setup(struct spi_device *spi)
+static void dspi_cleanup(struct spi_device *spi)
 {
-	if (!spi->max_speed_hz)
-		return -EINVAL;
+	struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
 
-	return dspi_setup_transfer(spi, NULL);
+	dev_dbg(&spi->dev, "spi_device %u.%u cleanup\n",
+			spi->master->bus_num, spi->chip_select);
+
+	kfree(chip);
 }
 
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	struct spi_message *msg = dspi->cur_msg;
 
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_EOQF);
 
-	dspi_transfer_read(dspi);
+	dspi_rx_pio(dspi);
 
 	if (!dspi->len) {
 		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM)
@@ -398,7 +683,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 		dspi->waitflags = 1;
 		wake_up_interruptible(&dspi->waitq);
 	} else {
-		dspi_transfer_write(dspi);
+		msg->actual_length += dspi_tx_pio(dspi);
 
 		return IRQ_HANDLED;
 	}
@@ -463,13 +748,14 @@ static int dspi_probe(struct platform_device *pdev)
 
 	dspi = spi_master_get_devdata(master);
 	dspi->pdev = pdev;
-	dspi->bitbang.master = master;
-	dspi->bitbang.chipselect = dspi_chipselect;
-	dspi->bitbang.setup_transfer = dspi_setup_transfer;
-	dspi->bitbang.txrx_bufs = dspi_txrx_transfer;
-	dspi->bitbang.master->setup = dspi_setup;
-	dspi->bitbang.master->dev.of_node = pdev->dev.of_node;
+	dspi->master = master;
+
+	master->transfer = NULL;
+	master->cleanup = dspi_cleanup;
+	master->setup = dspi_setup;
+	master->transfer_one_message = dspi_transfer_one_message;
 
+	master->dev.of_node = pdev->dev.of_node;
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 	master->bits_per_word_mask = SPI_BPW_MASK(4) | SPI_BPW_MASK(8) |
 					SPI_BPW_MASK(16);
@@ -490,6 +776,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
+	dspi->phybase = res->start;
 	if (IS_ERR(base)) {
 		ret = PTR_ERR(base);
 		goto out_master_put;
@@ -529,10 +816,18 @@ static int dspi_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(dspi->clk);
 
+	dspi->use_dma = of_property_read_bool(np, "use-dma");
+	if (dspi->use_dma)
+		if (dspi_request_dma(dspi)) {
+			dspi->use_dma = 0;
+			dev_err(&pdev->dev, "request dma channel fail\n");
+			dspi_release_dma(dspi);
+		}
+
 	init_waitqueue_head(&dspi->waitq);
 	platform_set_drvdata(pdev, dspi);
 
-	ret = spi_bitbang_start(&dspi->bitbang);
+	ret = spi_register_master(master);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Problem registering DSPI master\n");
 		goto out_clk_put;
@@ -554,9 +849,9 @@ static int dspi_remove(struct platform_device *pdev)
 	struct fsl_dspi *dspi = platform_get_drvdata(pdev);
 
 	/* Disconnect from the SPI framework */
-	spi_bitbang_stop(&dspi->bitbang);
 	clk_disable_unprepare(dspi->clk);
-	spi_master_put(dspi->bitbang.master);
+	spi_unregister_master(dspi->master);
+	spi_master_put(dspi->master);
 
 	return 0;
 }
-- 
1.8.4
