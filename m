From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 24 Nov 2016 12:25:01 +0100
Subject: [PATCH 5/5] spi: atmel: remove the use of private channel fields
In-Reply-To: <cover.1479985886.git.nicolas.ferre@atmel.com>
References: <cover.1479985886.git.nicolas.ferre@atmel.com>
Message-ID: <c68cd05242ce0e770b639f8cf1019ca94ec2f694.1479985886.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For DMA transfers, we now use the core DMA framework which provides
channel fields in the spi_master structure. Remove the private channels
from atmel_spi stucture which were located in a sub-structure. This
last one (atmel_spi_dma) which is now empty is also removed.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/spi/spi-atmel.c | 86 ++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f3a225585575..0e7712bac3b6 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -265,11 +265,6 @@
 
 #define AUTOSUSPEND_TIMEOUT	2000
 
-struct atmel_spi_dma {
-	struct dma_chan			*chan_rx;
-	struct dma_chan			*chan_tx;
-};
-
 struct atmel_spi_caps {
 	bool	is_spi2;
 	bool	has_wdrbt;
@@ -303,8 +298,6 @@ struct atmel_spi {
 	bool			use_dma;
 	bool			use_pdc;
 	bool			use_cs_gpios;
-	/* dmaengine data */
-	struct atmel_spi_dma	dma;
 
 	bool			keep_cs;
 	bool			cs_active;
@@ -461,6 +454,7 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 				struct dma_slave_config *slave_config,
 				u8 bits_per_word)
 {
+	struct spi_master *master = platform_get_drvdata(as->pdev);
 	int err = 0;
 
 	if (bits_per_word > 8) {
@@ -492,7 +486,7 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 	 * path works the same whether FIFOs are available (and enabled) or not.
 	 */
 	slave_config->direction = DMA_MEM_TO_DEV;
-	if (dmaengine_slave_config(as->dma.chan_tx, slave_config)) {
+	if (dmaengine_slave_config(master->dma_tx, slave_config)) {
 		dev_err(&as->pdev->dev,
 			"failed to configure tx dma channel\n");
 		err = -EINVAL;
@@ -507,7 +501,7 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 	 * enabled) or not.
 	 */
 	slave_config->direction = DMA_DEV_TO_MEM;
-	if (dmaengine_slave_config(as->dma.chan_rx, slave_config)) {
+	if (dmaengine_slave_config(master->dma_rx, slave_config)) {
 		dev_err(&as->pdev->dev,
 			"failed to configure rx dma channel\n");
 		err = -EINVAL;
@@ -516,7 +510,8 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 	return err;
 }
 
-static int atmel_spi_configure_dma(struct atmel_spi *as)
+static int atmel_spi_configure_dma(struct spi_master *master,
+				   struct atmel_spi *as)
 {
 	struct dma_slave_config	slave_config;
 	struct device *dev = &as->pdev->dev;
@@ -526,26 +521,26 @@ static int atmel_spi_configure_dma(struct atmel_spi *as)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	as->dma.chan_tx = dma_request_slave_channel_reason(dev, "tx");
-	if (IS_ERR(as->dma.chan_tx)) {
-		err = PTR_ERR(as->dma.chan_tx);
+	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
+		err = PTR_ERR(master->dma_tx);
 		if (err == -EPROBE_DEFER) {
 			dev_warn(dev, "no DMA channel available at the moment\n");
-			return err;
+			goto error_clear;
 		}
 		dev_err(dev,
 			"DMA TX channel not available, SPI unable to use DMA\n");
 		err = -EBUSY;
-		goto error;
+		goto error_clear;
 	}
 
 	/*
 	 * No reason to check EPROBE_DEFER here since we have already requested
 	 * tx channel. If it fails here, it's for another reason.
 	 */
-	as->dma.chan_rx = dma_request_slave_channel(dev, "rx");
+	master->dma_rx = dma_request_slave_channel(dev, "rx");
 
-	if (!as->dma.chan_rx) {
+	if (!master->dma_rx) {
 		dev_err(dev,
 			"DMA RX channel not available, SPI unable to use DMA\n");
 		err = -EBUSY;
@@ -558,31 +553,38 @@ static int atmel_spi_configure_dma(struct atmel_spi *as)
 
 	dev_info(&as->pdev->dev,
 			"Using %s (tx) and %s (rx) for DMA transfers\n",
-			dma_chan_name(as->dma.chan_tx),
-			dma_chan_name(as->dma.chan_rx));
+			dma_chan_name(master->dma_tx),
+			dma_chan_name(master->dma_rx));
+
 	return 0;
 error:
-	if (as->dma.chan_rx)
-		dma_release_channel(as->dma.chan_rx);
-	if (!IS_ERR(as->dma.chan_tx))
-		dma_release_channel(as->dma.chan_tx);
+	if (master->dma_rx)
+		dma_release_channel(master->dma_rx);
+	if (!IS_ERR(master->dma_tx))
+		dma_release_channel(master->dma_tx);
+error_clear:
+	master->dma_tx = master->dma_rx = NULL;
 	return err;
 }
 
-static void atmel_spi_stop_dma(struct atmel_spi *as)
+static void atmel_spi_stop_dma(struct spi_master *master)
 {
-	if (as->dma.chan_rx)
-		dmaengine_terminate_all(as->dma.chan_rx);
-	if (as->dma.chan_tx)
-		dmaengine_terminate_all(as->dma.chan_tx);
+	if (master->dma_rx)
+		dmaengine_terminate_all(master->dma_rx);
+	if (master->dma_tx)
+		dmaengine_terminate_all(master->dma_tx);
 }
 
-static void atmel_spi_release_dma(struct atmel_spi *as)
+static void atmel_spi_release_dma(struct spi_master *master)
 {
-	if (as->dma.chan_rx)
-		dma_release_channel(as->dma.chan_rx);
-	if (as->dma.chan_tx)
-		dma_release_channel(as->dma.chan_tx);
+	if (master->dma_rx) {
+		dma_release_channel(master->dma_rx);
+		master->dma_rx = NULL;
+	}
+	if (master->dma_tx) {
+		dma_release_channel(master->dma_tx);
+		master->dma_tx = NULL;
+	}
 }
 
 /* This function is called by the DMA driver from tasklet context */
@@ -718,8 +720,8 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 				u32 *plen)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
-	struct dma_chan		*rxchan = as->dma.chan_rx;
-	struct dma_chan		*txchan = as->dma.chan_tx;
+	struct dma_chan		*rxchan = master->dma_rx;
+	struct dma_chan		*txchan = master->dma_tx;
 	struct dma_async_tx_descriptor *rxdesc;
 	struct dma_async_tx_descriptor *txdesc;
 	struct dma_slave_config	slave_config;
@@ -783,7 +785,7 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 err_dma:
 	spi_writel(as, IDR, SPI_BIT(OVRES));
-	atmel_spi_stop_dma(as);
+	atmel_spi_stop_dma(master);
 err_exit:
 	atmel_spi_lock(as);
 	return -ENOMEM;
@@ -1311,7 +1313,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 			spi_readl(as, SR);
 
 		} else if (atmel_spi_use_dma(as, xfer)) {
-			atmel_spi_stop_dma(as);
+			atmel_spi_stop_dma(master);
 		}
 
 		if (!msg->is_dma_mapped
@@ -1540,10 +1542,8 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	as->use_dma = false;
 	as->use_pdc = false;
 	if (as->caps.has_dma_support) {
-		ret = atmel_spi_configure_dma(as);
+		ret = atmel_spi_configure_dma(master, as);
 		if (ret == 0) {
-			master->dma_tx = as->dma.chan_tx;
-			master->dma_rx = as->dma.chan_rx;
 			as->use_dma = true;
 		} else if (ret == -EPROBE_DEFER) {
 			return ret;
@@ -1612,7 +1612,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 
 	if (as->use_dma)
-		atmel_spi_release_dma(as);
+		atmel_spi_release_dma(master);
 
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
@@ -1634,8 +1634,8 @@ static int atmel_spi_remove(struct platform_device *pdev)
 	/* reset the hardware and block queue progress */
 	spin_lock_irq(&as->lock);
 	if (as->use_dma) {
-		atmel_spi_stop_dma(as);
-		atmel_spi_release_dma(as);
+		atmel_spi_stop_dma(master);
+		atmel_spi_release_dma(master);
 	}
 
 	spi_writel(as, CR, SPI_BIT(SWRST));
-- 
2.9.0
