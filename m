From: broonie@kernel.org (Mark Brown)
Date: Fri, 05 Jan 2018 12:43:04 +0000
Subject: Applied "spi: atmel: Implements transfers with bounce buffer" to the
 spi tree
In-Reply-To: <1513696679-4987-1-git-send-email-radu.pirea@microchip.com>
Message-ID: <E1eXRKy-00059r-6w@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: atmel: Implements transfers with bounce buffer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a9889ed62d06ec76f41492ebdc6cc6538e761e3e Mon Sep 17 00:00:00 2001
From: Radu Pirea <radu.pirea@microchip.com>
Date: Tue, 19 Dec 2017 17:17:59 +0200
Subject: [PATCH] spi: atmel: Implements transfers with bounce buffer

This patch enables SPI DMA transfers for Atmel SAM9 SoCs and implements a
bounce buffer for transfers which have vmalloc allocated buffers. Those
buffers are not cache coherent even if they have been transformed into sg
lists. UBIFS is affected by this cache coherency issue.

In this patch I also reverted "spi: atmel: fix corrupted data issue on SAM9
family SoCs"(7094576ccdc3acfe1e06a1e2ab547add375baf7f).

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 113 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 84 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 669470971023..4a11fc0d4136 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -291,6 +291,10 @@ struct atmel_spi {
 	struct spi_transfer	*current_transfer;
 	int			current_remaining_bytes;
 	int			done_status;
+	dma_addr_t		dma_addr_rx_bbuf;
+	dma_addr_t		dma_addr_tx_bbuf;
+	void			*addr_rx_bbuf;
+	void			*addr_tx_bbuf;
 
 	struct completion	xfer_completion;
 
@@ -436,6 +440,11 @@ static void atmel_spi_unlock(struct atmel_spi *as) __releases(&as->lock)
 	spin_unlock_irqrestore(&as->lock, as->flags);
 }
 
+static inline bool atmel_spi_is_vmalloc_xfer(struct spi_transfer *xfer)
+{
+	return is_vmalloc_addr(xfer->tx_buf) || is_vmalloc_addr(xfer->rx_buf);
+}
+
 static inline bool atmel_spi_use_dma(struct atmel_spi *as,
 				struct spi_transfer *xfer)
 {
@@ -448,7 +457,12 @@ static bool atmel_spi_can_dma(struct spi_master *master,
 {
 	struct atmel_spi *as = spi_master_get_devdata(master);
 
-	return atmel_spi_use_dma(as, xfer);
+	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5))
+		return atmel_spi_use_dma(as, xfer) &&
+			!atmel_spi_is_vmalloc_xfer(xfer);
+	else
+		return atmel_spi_use_dma(as, xfer);
+
 }
 
 static int atmel_spi_dma_slave_config(struct atmel_spi *as,
@@ -594,6 +608,11 @@ static void dma_callback(void *data)
 	struct spi_master	*master = data;
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 
+	if (is_vmalloc_addr(as->current_transfer->rx_buf) &&
+	    IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
+		memcpy(as->current_transfer->rx_buf, as->addr_rx_bbuf,
+		       as->current_transfer->len);
+	}
 	complete(&as->xfer_completion);
 }
 
@@ -744,17 +763,41 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 		goto err_exit;
 
 	/* Send both scatterlists */
-	rxdesc = dmaengine_prep_slave_sg(rxchan,
-					 xfer->rx_sg.sgl, xfer->rx_sg.nents,
-					 DMA_FROM_DEVICE,
-					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (atmel_spi_is_vmalloc_xfer(xfer) &&
+	    IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
+		rxdesc = dmaengine_prep_slave_single(rxchan,
+						     as->dma_addr_rx_bbuf,
+						     xfer->len,
+						     DMA_FROM_DEVICE,
+						     DMA_PREP_INTERRUPT |
+						     DMA_CTRL_ACK);
+	} else {
+		rxdesc = dmaengine_prep_slave_sg(rxchan,
+						 xfer->rx_sg.sgl,
+						 xfer->rx_sg.nents,
+						 DMA_FROM_DEVICE,
+						 DMA_PREP_INTERRUPT |
+						 DMA_CTRL_ACK);
+	}
 	if (!rxdesc)
 		goto err_dma;
 
-	txdesc = dmaengine_prep_slave_sg(txchan,
-					 xfer->tx_sg.sgl, xfer->tx_sg.nents,
-					 DMA_TO_DEVICE,
-					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (atmel_spi_is_vmalloc_xfer(xfer) &&
+	    IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
+		memcpy(as->addr_tx_bbuf, xfer->tx_buf, xfer->len);
+		txdesc = dmaengine_prep_slave_single(txchan,
+						     as->dma_addr_tx_bbuf,
+						     xfer->len, DMA_TO_DEVICE,
+						     DMA_PREP_INTERRUPT |
+						     DMA_CTRL_ACK);
+	} else {
+		txdesc = dmaengine_prep_slave_sg(txchan,
+						 xfer->tx_sg.sgl,
+						 xfer->tx_sg.nents,
+						 DMA_TO_DEVICE,
+						 DMA_PREP_INTERRUPT |
+						 DMA_CTRL_ACK);
+	}
 	if (!txdesc)
 		goto err_dma;
 
@@ -1426,27 +1469,7 @@ static void atmel_get_caps(struct atmel_spi *as)
 
 	as->caps.is_spi2 = version > 0x121;
 	as->caps.has_wdrbt = version >= 0x210;
-#ifdef CONFIG_SOC_SAM_V4_V5
-	/*
-	 * Atmel SoCs based on ARM9 (SAM9x) cores should not use spi_map_buf()
-	 * since this later function tries to map buffers with dma_map_sg()
-	 * even if they have not been allocated inside DMA-safe areas.
-	 * On SoCs based on Cortex A5 (SAMA5Dx), it works anyway because for
-	 * those ARM cores, the data cache follows the PIPT model.
-	 * Also the L2 cache controller of SAMA5D2 uses the PIPT model too.
-	 * In case of PIPT caches, there cannot be cache aliases.
-	 * However on ARM9 cores, the data cache follows the VIVT model, hence
-	 * the cache aliases issue can occur when buffers are allocated from
-	 * DMA-unsafe areas, by vmalloc() for instance, where cache coherency is
-	 * not taken into account or at least not handled completely (cache
-	 * lines of aliases are not invalidated).
-	 * This is not a theorical issue: it was reproduced when trying to mount
-	 * a UBI file-system on a at91sam9g35ek board.
-	 */
-	as->caps.has_dma_support = false;
-#else
 	as->caps.has_dma_support = version >= 0x212;
-#endif
 	as->caps.has_pdc_support = version < 0x212;
 }
 
@@ -1592,6 +1615,30 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		as->use_pdc = true;
 	}
 
+	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
+		as->addr_rx_bbuf = dma_alloc_coherent(&pdev->dev,
+						      SPI_MAX_DMA_XFER,
+						      &as->dma_addr_rx_bbuf,
+						      GFP_KERNEL | GFP_DMA);
+		if (!as->addr_rx_bbuf) {
+			as->use_dma = false;
+		} else {
+			as->addr_tx_bbuf = dma_alloc_coherent(&pdev->dev,
+					SPI_MAX_DMA_XFER,
+					&as->dma_addr_tx_bbuf,
+					GFP_KERNEL | GFP_DMA);
+			if (!as->addr_tx_bbuf) {
+				as->use_dma = false;
+				dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
+						  as->addr_rx_bbuf,
+						  as->dma_addr_rx_bbuf);
+			}
+		}
+		if (!as->use_dma)
+			dev_info(master->dev.parent,
+				 "  can not allocate dma coherent memory\n");
+	}
+
 	if (as->caps.has_dma_support && !as->use_dma)
 		dev_info(&pdev->dev, "Atmel SPI Controller using PIO only\n");
 
@@ -1664,6 +1711,14 @@ static int atmel_spi_remove(struct platform_device *pdev)
 	if (as->use_dma) {
 		atmel_spi_stop_dma(master);
 		atmel_spi_release_dma(master);
+		if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
+			dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
+					  as->addr_tx_bbuf,
+					  as->dma_addr_tx_bbuf);
+			dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
+					  as->addr_rx_bbuf,
+					  as->dma_addr_rx_bbuf);
+		}
 	}
 
 	spin_lock_irq(&as->lock);
-- 
2.15.1
