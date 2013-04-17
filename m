From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:56 +0200 (CEST)
Subject: [PATCH 8/10] LPC32XX: 008-pl022.1: Supports is_dma_mapped for pl022
Message-ID: <mailman.22.1366231494.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Cedric Berger <cedric@precidata.com>
---
Supports the is_dma_mapped message flag for the pl022

Index: drivers/spi/spi-pl022.c
===================================================================
--- drivers/spi/spi-pl022.c	(revision 1709)
+++ drivers/spi/spi-pl022.c	(revision 1710)
@@ -780,12 +780,16 @@
 static void unmap_free_dma_scatter(struct pl022 *pl022)
 {
 	/* Unmap and free the SG tables */
-	dma_unmap_sg(pl022->dma_tx_channel->device->dev, pl022->sgt_tx.sgl,
-		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
-	dma_unmap_sg(pl022->dma_rx_channel->device->dev, pl022->sgt_rx.sgl,
-		     pl022->sgt_rx.nents, DMA_FROM_DEVICE);
-	sg_free_table(&pl022->sgt_rx);
-	sg_free_table(&pl022->sgt_tx);
+	if (pl022->sgt_tx.sgl) {
+		dma_unmap_sg(pl022->dma_tx_channel->device->dev,
+		     pl022->sgt_tx.sgl, pl022->sgt_tx.nents, DMA_TO_DEVICE);
+		sg_free_table(&pl022->sgt_tx);
+	}
+	if (pl022->sgt_rx.sgl) {
+		dma_unmap_sg(pl022->dma_rx_channel->device->dev,
+		     pl022->sgt_rx.sgl, pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+		sg_free_table(&pl022->sgt_rx);
+	}
 }
 
 static void dma_callback(void *data)
@@ -793,8 +797,6 @@
 	struct pl022 *pl022 = data;
 	struct spi_message *msg = pl022->cur_msg;
 
-	BUG_ON(!pl022->sgt_rx.sgl);
-
 #ifdef VERBOSE_DEBUG
 	/*
 	 * Optionally dump out buffers to inspect contents, this is
@@ -802,7 +804,7 @@
 	 * read/write contents are the same, when adopting to a new
 	 * DMA engine.
 	 */
-	{
+	if (!msg->is_dma_mapped) {
 		struct scatterlist *sg;
 		unsigned int i;
 
@@ -897,6 +899,120 @@
 }
 
 /**
+ * configure_dma_mappings_single - configure mappings for dma-capable buffers
+ * @pl022: SSP driver's private data structure
+ */
+static int configure_dma_mappings_single(struct pl022 *pl022,
+		struct dma_async_tx_descriptor **prxdesc,
+		struct dma_async_tx_descriptor **ptxdesc)
+{
+	*prxdesc = dmaengine_prep_slave_single(
+			pl022->dma_rx_channel,
+			pl022->cur_transfer->rx_dma,
+			pl022->cur_transfer->len,
+			DMA_DEV_TO_MEM,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!*prxdesc)
+		goto err_rxdesc;
+
+	*ptxdesc = dmaengine_prep_slave_single(
+			pl022->dma_tx_channel,
+			pl022->cur_transfer->tx_dma,
+			pl022->cur_transfer->len,
+			DMA_MEM_TO_DEV,
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!*ptxdesc)
+		goto err_txdesc;
+
+	return 0;
+
+err_txdesc:
+	dmaengine_terminate_all(pl022->dma_tx_channel);
+err_rxdesc:
+	dmaengine_terminate_all(pl022->dma_rx_channel);
+	return -ENOMEM;
+}
+
+/*
+ * configure_dma_mappings_sg - configure mappings for non-dma-capable buffers
+ * @pl022: SSP driver's private data structure
+ */
+static int configure_dma_mappings_sg(struct pl022 *pl022,
+		struct dma_async_tx_descriptor **prxdesc,
+		struct dma_async_tx_descriptor **ptxdesc)
+{
+	struct dma_chan *rxchan = pl022->dma_rx_channel;
+	struct dma_chan *txchan = pl022->dma_tx_channel;
+	unsigned int pages;
+	int ret;
+	int rx_sglen, tx_sglen;
+
+	/* Create sglists for the transfers */
+	pages = DIV_ROUND_UP(pl022->cur_transfer->len, PAGE_SIZE);
+	dev_dbg(&pl022->adev->dev, "using %d pages for transfer\n", pages);
+
+	ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_ATOMIC);
+	if (ret)
+		goto err_alloc_rx_sg;
+
+	ret = sg_alloc_table(&pl022->sgt_tx, pages, GFP_ATOMIC);
+	if (ret)
+		goto err_alloc_tx_sg;
+
+	/* Fill in the scatterlists for the RX+TX buffers */
+	setup_dma_scatter(pl022, pl022->rx,
+			  pl022->cur_transfer->len, &pl022->sgt_rx);
+	setup_dma_scatter(pl022, pl022->tx,
+			  pl022->cur_transfer->len, &pl022->sgt_tx);
+
+	/* Map DMA buffers */
+	rx_sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
+			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+	if (!rx_sglen)
+		goto err_rx_sgmap;
+
+	tx_sglen = dma_map_sg(txchan->device->dev, pl022->sgt_tx.sgl,
+			   pl022->sgt_tx.nents, DMA_TO_DEVICE);
+	if (!tx_sglen)
+		goto err_tx_sgmap;
+
+	/* Send both scatterlists */
+	*prxdesc = dmaengine_prep_slave_sg(rxchan,
+				      pl022->sgt_rx.sgl,
+				      rx_sglen,
+				      DMA_DEV_TO_MEM,
+				      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!*prxdesc)
+		goto err_rxdesc;
+
+	*ptxdesc = dmaengine_prep_slave_sg(txchan,
+				      pl022->sgt_tx.sgl,
+				      tx_sglen,
+				      DMA_MEM_TO_DEV,
+				      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!*ptxdesc)
+		goto err_txdesc;
+	return 0;
+
+err_txdesc:
+	dmaengine_terminate_all(pl022->dma_tx_channel);
+err_rxdesc:
+	dmaengine_terminate_all(pl022->dma_rx_channel);
+	dma_unmap_sg(txchan->device->dev, pl022->sgt_tx.sgl,
+		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
+err_tx_sgmap:
+	dma_unmap_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
+		     pl022->sgt_tx.nents, DMA_FROM_DEVICE);
+err_rx_sgmap:
+	sg_free_table(&pl022->sgt_tx);
+err_alloc_tx_sg:
+	sg_free_table(&pl022->sgt_rx);
+err_alloc_rx_sg:
+	return -ENOMEM;
+}
+
+
+/**
  * configure_dma - configures the channels for the next transfer
  * @pl022: SSP driver's private data structure
  */
@@ -912,9 +1028,7 @@
 		.direction = DMA_MEM_TO_DEV,
 		.device_fc = false,
 	};
-	unsigned int pages;
 	int ret;
-	int rx_sglen, tx_sglen;
 	struct dma_chan *rxchan = pl022->dma_rx_channel;
 	struct dma_chan *txchan = pl022->dma_tx_channel;
 	struct dma_async_tx_descriptor *rxdesc;
@@ -1014,52 +1128,13 @@
 	dmaengine_slave_config(rxchan, &rx_conf);
 	dmaengine_slave_config(txchan, &tx_conf);
 
-	/* Create sglists for the transfers */
-	pages = DIV_ROUND_UP(pl022->cur_transfer->len, PAGE_SIZE);
-	dev_dbg(&pl022->adev->dev, "using %d pages for transfer\n", pages);
-
-	ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_ATOMIC);
+	if (pl022->cur_msg->is_dma_mapped)
+		ret = configure_dma_mappings_single(pl022, &rxdesc, &txdesc);
+	else
+		ret = configure_dma_mappings_sg(pl022, &rxdesc, &txdesc);
 	if (ret)
-		goto err_alloc_rx_sg;
+		return ret;
 
-	ret = sg_alloc_table(&pl022->sgt_tx, pages, GFP_ATOMIC);
-	if (ret)
-		goto err_alloc_tx_sg;
-
-	/* Fill in the scatterlists for the RX+TX buffers */
-	setup_dma_scatter(pl022, pl022->rx,
-			  pl022->cur_transfer->len, &pl022->sgt_rx);
-	setup_dma_scatter(pl022, pl022->tx,
-			  pl022->cur_transfer->len, &pl022->sgt_tx);
-
-	/* Map DMA buffers */
-	rx_sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
-			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
-	if (!rx_sglen)
-		goto err_rx_sgmap;
-
-	tx_sglen = dma_map_sg(txchan->device->dev, pl022->sgt_tx.sgl,
-			   pl022->sgt_tx.nents, DMA_TO_DEVICE);
-	if (!tx_sglen)
-		goto err_tx_sgmap;
-
-	/* Send both scatterlists */
-	rxdesc = dmaengine_prep_slave_sg(rxchan,
-				      pl022->sgt_rx.sgl,
-				      rx_sglen,
-				      DMA_DEV_TO_MEM,
-				      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!rxdesc)
-		goto err_rxdesc;
-
-	txdesc = dmaengine_prep_slave_sg(txchan,
-				      pl022->sgt_tx.sgl,
-				      tx_sglen,
-				      DMA_MEM_TO_DEV,
-				      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!txdesc)
-		goto err_txdesc;
-
 	/* Put the callback on the RX transfer only, that should finish last */
 	rxdesc->callback = dma_callback;
 	rxdesc->callback_param = pl022;
@@ -1072,22 +1147,6 @@
 	pl022->dma_running = true;
 
 	return 0;
-
-err_txdesc:
-	dmaengine_terminate_all(txchan);
-err_rxdesc:
-	dmaengine_terminate_all(rxchan);
-	dma_unmap_sg(txchan->device->dev, pl022->sgt_tx.sgl,
-		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
-err_tx_sgmap:
-	dma_unmap_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
-		     pl022->sgt_tx.nents, DMA_FROM_DEVICE);
-err_rx_sgmap:
-	sg_free_table(&pl022->sgt_tx);
-err_alloc_tx_sg:
-	sg_free_table(&pl022->sgt_rx);
-err_alloc_rx_sg:
-	return -ENOMEM;
 }
 
 static int pl022_dma_probe(struct pl022 *pl022)
