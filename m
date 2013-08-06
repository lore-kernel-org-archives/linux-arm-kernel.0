From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  6 Aug 2013 14:21:21 +0800
Subject: [PATCH] spi: sirf: use DMA if both buffer address and length are
 aligned
Message-ID: <1375770081-12873-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch enables DMA support for SiRFSoC SPI driver, if both
buffers and length are aligned with DMA controller's hardware
limitation, use generic SiRF generic dmaengine driver.

for PIO, SiRF SPI controller actually is using rx to trigger rx,
that means if we write any word to tx fifo, we will get a word
from rx fifo. for DMA, we use two different channel for tx and
rx, and issue them both for every transfer.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 180 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 157 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 9608716..62c92c3 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -19,6 +19,10 @@
 #include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/sirfsoc_dma.h>
 
 #define DRIVER_NAME "sirfsoc_spi"
 
@@ -119,9 +123,20 @@
 #define SIRFSOC_SPI_FIFO_HC(x)		(((x) & 0x3F) << 20)
 #define SIRFSOC_SPI_FIFO_THD(x)		(((x) & 0xFF) << 2)
 
+/*
+ * only if the rx/tx buffer and transfer size are 4-bytes aligned, we use dma
+ * due to the limitation of dma controller
+ */
+
+#define ALIGNED(x) (!((u32)x & 0x3))
+#define IS_DMA_VALID(x) (x && ALIGNED(x->tx_buf) && ALIGNED(x->rx_buf) && \
+	ALIGNED(x->len * sspi->word_width) && (x->len * sspi->word_width < \
+		2 * PAGE_SIZE))
+
 struct sirfsoc_spi {
 	struct spi_bitbang bitbang;
-	struct completion done;
+	struct completion rx_done;
+	struct completion tx_done;
 
 	void __iomem *base;
 	u32 ctrl_freq;  /* SPI controller clock speed */
@@ -140,6 +155,14 @@ struct sirfsoc_spi {
 	unsigned int left_tx_cnt;
 	unsigned int left_rx_cnt;
 
+	/* rx & tx DMA channels */
+	struct dma_chan *rx_chan;
+	struct dma_chan *tx_chan;
+	dma_addr_t src_start;
+	dma_addr_t dst_start;
+	void *dummypage;
+	int word_width; /* in bytes */
+
 	int chipselect[0];
 };
 
@@ -241,7 +264,7 @@ static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 	/* Error Conditions */
 	if (spi_stat & SIRFSOC_SPI_RX_OFLOW ||
 			spi_stat & SIRFSOC_SPI_TX_UFLOW) {
-		complete(&sspi->done);
+		complete(&sspi->rx_done);
 		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
 	}
 
@@ -261,22 +284,30 @@ static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 
 	/* Received all words */
 	if ((sspi->left_rx_cnt == 0) && (sspi->left_tx_cnt == 0)) {
-		complete(&sspi->done);
+		complete(&sspi->rx_done);
 		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
 	}
 	return IRQ_HANDLED;
 }
 
+static void spi_sirfsoc_dma_fini_callback(void *data)
+{
+	struct completion *dma_complete = data;
+
+	complete(dma_complete);
+}
+
 static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct sirfsoc_spi *sspi;
 	int timeout = t->len * 10;
 	sspi = spi_master_get_devdata(spi->master);
 
-	sspi->tx = t->tx_buf;
-	sspi->rx = t->rx_buf;
+	sspi->tx = t->tx_buf ? t->tx_buf : sspi->dummypage;
+	sspi->rx = t->rx_buf ? t->rx_buf : sspi->dummypage;
 	sspi->left_tx_cnt = sspi->left_rx_cnt = t->len;
-	INIT_COMPLETION(sspi->done);
+	INIT_COMPLETION(sspi->rx_done);
+	INIT_COMPLETION(sspi->tx_done);
 
 	writel(SIRFSOC_SPI_INT_MASK_ALL, sspi->base + SIRFSOC_SPI_INT_STATUS);
 
@@ -305,17 +336,65 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
 	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
 
-	/* Send the first word to trigger the whole tx/rx process */
-	sspi->tx_word(sspi);
+	if (IS_DMA_VALID(t)) {
+		struct dma_async_tx_descriptor *rx_desc, *tx_desc;
+		unsigned int size = t->len * sspi->word_width;
+
+		sspi->dst_start = dma_map_single(&spi->dev, sspi->rx, t->len, DMA_FROM_DEVICE);
+		rx_desc = dmaengine_prep_slave_single(sspi->rx_chan,
+			sspi->dst_start, size, DMA_DEV_TO_MEM,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		rx_desc->callback = spi_sirfsoc_dma_fini_callback;
+		rx_desc->callback_param = &sspi->rx_done;
+
+		sspi->src_start = dma_map_single(&spi->dev, (void *)sspi->tx, t->len, DMA_TO_DEVICE);
+		tx_desc = dmaengine_prep_slave_single(sspi->tx_chan,
+			sspi->src_start, size, DMA_MEM_TO_DEV,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		tx_desc->callback = spi_sirfsoc_dma_fini_callback;
+		tx_desc->callback_param = &sspi->tx_done;
+
+		dmaengine_submit(tx_desc);
+		dmaengine_submit(rx_desc);
+		dma_async_issue_pending(sspi->tx_chan);
+		dma_async_issue_pending(sspi->rx_chan);
+	} else {
+		/* Send the first word to trigger the whole tx/rx process */
+		sspi->tx_word(sspi);
+
+		writel(SIRFSOC_SPI_RX_OFLOW_INT_EN | SIRFSOC_SPI_TX_UFLOW_INT_EN |
+			SIRFSOC_SPI_RXFIFO_THD_INT_EN | SIRFSOC_SPI_TXFIFO_THD_INT_EN |
+			SIRFSOC_SPI_FRM_END_INT_EN | SIRFSOC_SPI_RXFIFO_FULL_INT_EN |
+			SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN, sspi->base + SIRFSOC_SPI_INT_EN);
+	}
 
-	writel(SIRFSOC_SPI_RX_OFLOW_INT_EN | SIRFSOC_SPI_TX_UFLOW_INT_EN |
-		SIRFSOC_SPI_RXFIFO_THD_INT_EN | SIRFSOC_SPI_TXFIFO_THD_INT_EN |
-		SIRFSOC_SPI_FRM_END_INT_EN | SIRFSOC_SPI_RXFIFO_FULL_INT_EN |
-		SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN, sspi->base + SIRFSOC_SPI_INT_EN);
 	writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN, sspi->base + SIRFSOC_SPI_TX_RX_EN);
 
-	if (wait_for_completion_timeout(&sspi->done, timeout) == 0)
+	if (!IS_DMA_VALID(t)) { /* for PIO */
+		if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0)
+			dev_err(&spi->dev, "transfer timeout\n");
+	} else if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0) {
 		dev_err(&spi->dev, "transfer timeout\n");
+		dmaengine_terminate_all(sspi->rx_chan);
+	} else
+		sspi->left_rx_cnt = 0;
+
+	/*
+	 * we only wait tx-done event if transferring by DMA. for PIO,
+	 * we get rx data by writing tx data, so if rx is done, tx has
+	 * done earlier
+	 */
+	if (IS_DMA_VALID(t)) {
+		if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
+			dev_err(&spi->dev, "transfer timeout\n");
+			dmaengine_terminate_all(sspi->tx_chan);
+		}
+	}
+
+	if (IS_DMA_VALID(t)) {
+		dma_unmap_single(&spi->dev, sspi->src_start, t->len, DMA_TO_DEVICE);
+		dma_unmap_single(&spi->dev, sspi->dst_start, t->len, DMA_FROM_DEVICE);
+	}
 
 	/* TX, RX FIFO stop */
 	writel(0, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
@@ -332,7 +411,6 @@ static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
 
 	if (sspi->chipselect[spi->chip_select] == 0) {
 		u32 regval = readl(sspi->base + SIRFSOC_SPI_CTRL);
-		regval |= SIRFSOC_SPI_CS_IO_OUT;
 		switch (value) {
 		case BITBANG_CS_ACTIVE:
 			if (spi->mode & SPI_CS_HIGH)
@@ -369,11 +447,7 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	bits_per_word = (t) ? t->bits_per_word : spi->bits_per_word;
 	hz = t && t->speed_hz ? t->speed_hz : spi->max_speed_hz;
 
-	/* Enable IO mode for RX, TX */
-	writel(SIRFSOC_SPI_IO_MODE_SEL, sspi->base + SIRFSOC_SPI_TX_DMA_IO_CTRL);
-	writel(SIRFSOC_SPI_IO_MODE_SEL, sspi->base + SIRFSOC_SPI_RX_DMA_IO_CTRL);
 	regval = (sspi->ctrl_freq / (2 * hz)) - 1;
-
 	if (regval > 0xFFFF || regval < 0) {
 		dev_err(&spi->dev, "Speed %d not supported\n", hz);
 		return -EINVAL;
@@ -388,6 +462,7 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 					SIRFSOC_SPI_FIFO_WIDTH_BYTE;
 		rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
 					SIRFSOC_SPI_FIFO_WIDTH_BYTE;
+		sspi->word_width = 1;
 		break;
 	case 12:
 	case 16:
@@ -399,6 +474,7 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 					SIRFSOC_SPI_FIFO_WIDTH_WORD;
 		rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
 					SIRFSOC_SPI_FIFO_WIDTH_WORD;
+		sspi->word_width = 2;
 		break;
 	case 32:
 		regval |= SIRFSOC_SPI_TRAN_DAT_FORMAT_32;
@@ -408,6 +484,7 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 					SIRFSOC_SPI_FIFO_WIDTH_DWORD;
 		rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
 					SIRFSOC_SPI_FIFO_WIDTH_DWORD;
+		sspi->word_width = 4;
 		break;
 	default:
 		BUG();
@@ -442,6 +519,17 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	writel(rxfifo_ctrl, sspi->base + SIRFSOC_SPI_RXFIFO_CTRL);
 
 	writel(regval, sspi->base + SIRFSOC_SPI_CTRL);
+
+	if (IS_DMA_VALID(t)) {
+		/* Enable DMA mode for RX, TX */
+		writel(0, sspi->base + SIRFSOC_SPI_TX_DMA_IO_CTRL);
+		writel(SIRFSOC_SPI_RX_DMA_FLUSH, sspi->base + SIRFSOC_SPI_RX_DMA_IO_CTRL);
+	} else {
+		/* Enable IO mode for RX, TX */
+		writel(SIRFSOC_SPI_IO_MODE_SEL, sspi->base + SIRFSOC_SPI_TX_DMA_IO_CTRL);
+		writel(SIRFSOC_SPI_IO_MODE_SEL, sspi->base + SIRFSOC_SPI_RX_DMA_IO_CTRL);
+	}
+
 	return 0;
 }
 
@@ -466,6 +554,8 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct resource *mem_res;
 	int num_cs, cs_gpio, irq;
+	u32 rx_dma_ch, tx_dma_ch;
+	dma_cap_mask_t dma_cap_mask;
 	int i;
 	int ret;
 
@@ -476,6 +566,20 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 		goto err_cs;
 	}
 
+	ret = of_property_read_u32(pdev->dev.of_node,
+			"sirf,spi-dma-rx-channel", &rx_dma_ch);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to get rx dma channel\n");
+		goto err_cs;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+			"sirf,spi-dma-tx-channel", &tx_dma_ch);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to get tx dma channel\n");
+		goto err_cs;
+	}
+
 	master = spi_alloc_master(&pdev->dev, sizeof(*sspi) + sizeof(int) * num_cs);
 	if (!master) {
 		dev_err(&pdev->dev, "Unable to allocate SPI master\n");
@@ -543,15 +647,33 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 					SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
 	sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
 
+	/* request DMA channels */
+	dma_cap_zero(dma_cap_mask);
+	dma_cap_set(DMA_INTERLEAVE, dma_cap_mask);
+
+	sspi->rx_chan = dma_request_channel(dma_cap_mask, (dma_filter_fn)sirfsoc_dma_filter_id,
+		(void *)rx_dma_ch);
+	if (!sspi->rx_chan) {
+		dev_err(&pdev->dev, "can not allocate rx dma channel\n");
+		goto free_master;
+	}
+	sspi->tx_chan = dma_request_channel(dma_cap_mask, (dma_filter_fn)sirfsoc_dma_filter_id,
+		(void *)tx_dma_ch);
+	if (!sspi->tx_chan) {
+		dev_err(&pdev->dev, "can not allocate tx dma channel\n");
+		goto free_rx_dma;
+	}
+
 	sspi->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sspi->clk)) {
-		ret = -EINVAL;
-		goto free_master;
+		ret = PTR_ERR(sspi->clk);
+		goto free_tx_dma;
 	}
 	clk_prepare_enable(sspi->clk);
 	sspi->ctrl_freq = clk_get_rate(sspi->clk);
 
-	init_completion(&sspi->done);
+	init_completion(&sspi->rx_done);
+	init_completion(&sspi->tx_done);
 
 	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
 	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
@@ -560,17 +682,26 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	/* We are not using dummy delay between command and data */
 	writel(0, sspi->base + SIRFSOC_SPI_DUMMY_DELAY_CTL);
 
+	sspi->dummypage = kmalloc(2 * PAGE_SIZE, GFP_KERNEL);
+	if (!sspi->dummypage)
+		goto free_clk;
+
 	ret = spi_bitbang_start(&sspi->bitbang);
 	if (ret)
-		goto free_clk;
+		goto free_dummypage;
 
 	dev_info(&pdev->dev, "registerred, bus number = %d\n", master->bus_num);
 
 	return 0;
-
+free_dummypage:
+	kfree(sspi->dummypage);
 free_clk:
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
+free_tx_dma:
+	dma_release_channel(sspi->tx_chan);
+free_rx_dma:
+	dma_release_channel(sspi->rx_chan);
 free_master:
 	spi_master_put(master);
 err_cs:
@@ -591,8 +722,11 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
 		if (sspi->chipselect[i] > 0)
 			gpio_free(sspi->chipselect[i]);
 	}
+	kfree(sspi->dummypage);
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
+	dma_release_channel(sspi->rx_chan);
+	dma_release_channel(sspi->tx_chan);
 	spi_master_put(master);
 	return 0;
 }
-- 
1.8.2.3
