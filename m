From: wolfgang.mues@auerswald.de (Wolfgang =?iso-8859-15?q?M=FCes?=)
Date: Thu, 25 Feb 2010 15:21:52 +0100
Subject: [PATCH4/5] at91_mci: use DMA buffer for read
Message-ID: <201002251521.52390.wolfgang.mues@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

this is thes 4th part of my fixes and improvements for the at91_mci driver.

This patch converts the read to use the DMA buffer as well. The old
code was doing double-buffering DMA with the PDC, and this code was
never tested. We could not get it to work, so we replaced it with
a single-PDC approach. 

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>

---
diff -ur linux-2.6.33-rc8-coherent/drivers/mmc/host/at91_mci.c linux-2.6.33-rc8-readbuf/drivers/mmc/host/at91_mci.c
--- linux-2.6.33-rc8-coherent/drivers/mmc/host/at91_mci.c	2010-02-25 14:31:00.971238838 +0100
+++ linux-2.6.33-rc8-readbuf/drivers/mmc/host/at91_mci.c	2010-02-25 14:42:05.803239154 +0100
@@ -251,80 +251,14 @@
 }
 
 /*
- * Prepare a dma read
- */
-static void at91_mci_pre_dma_read(struct at91mci_host *host)
-{
-	int i;
-	struct scatterlist *sg;
-	struct mmc_command *cmd;
-	struct mmc_data *data;
-
-	pr_debug("pre dma read\n");
-
-	cmd = host->cmd;
-	if (!cmd) {
-		pr_debug("no command\n");
-		return;
-	}
-
-	data = cmd->data;
-	if (!data) {
-		pr_debug("no data\n");
-		return;
-	}
-
-	for (i = 0; i < 2; i++) {
-		/* nothing left to transfer */
-		if (host->transfer_index >= data->sg_len) {
-			pr_debug("Nothing left to transfer (index = %d)\n", host->transfer_index);
-			break;
-		}
-
-		/* Check to see if this needs filling */
-		if (i == 0) {
-			if (at91_mci_read(host, ATMEL_PDC_RCR) != 0) {
-				pr_debug("Transfer active in current\n");
-				continue;
-			}
-		}
-		else {
-			if (at91_mci_read(host, ATMEL_PDC_RNCR) != 0) {
-				pr_debug("Transfer active in next\n");
-				continue;
-			}
-		}
-
-		/* Setup the next transfer */
-		pr_debug("Using transfer index %d\n", host->transfer_index);
-
-		sg = &data->sg[host->transfer_index++];
-		pr_debug("sg = %p\n", sg);
-
-		sg->dma_address = dma_map_page(NULL, sg_page(sg), sg->offset, sg->length, DMA_FROM_DEVICE);
-
-		pr_debug("dma address = %08X, length = %d\n", sg->dma_address, sg->length);
-
-		if (i == 0) {
-			at91_mci_write(host, ATMEL_PDC_RPR, sg->dma_address);
-			at91_mci_write(host, ATMEL_PDC_RCR, (data->blksz & 0x3) ? sg->length : sg->length / 4);
-		}
-		else {
-			at91_mci_write(host, ATMEL_PDC_RNPR, sg->dma_address);
-			at91_mci_write(host, ATMEL_PDC_RNCR, (data->blksz & 0x3) ? sg->length : sg->length / 4);
-		}
-	}
-
-	pr_debug("pre dma read done\n");
-}
-
-/*
  * Handle after a dma read
  */
 static void at91_mci_post_dma_read(struct at91mci_host *host)
 {
 	struct mmc_command *cmd;
 	struct mmc_data *data;
+	unsigned int len, i, size;
+	unsigned *dmabuf = host->buffer;
 
 	pr_debug("post dma read\n");
 
@@ -340,42 +274,39 @@
 		return;
 	}
 
-	while (host->in_use_index < host->transfer_index) {
-		struct scatterlist *sg;
-
-		pr_debug("finishing index %d\n", host->in_use_index);
-
-		sg = &data->sg[host->in_use_index++];
+	size = data->blksz * data->blocks;
+	len = data->sg_len;
+ 
+	at91_mci_write(host, AT91_MCI_IDR, AT91_MCI_ENDRX);
+	at91_mci_write(host, AT91_MCI_IER, AT91_MCI_RXBUFF);
 
-		pr_debug("Unmapping page %08X\n", sg->dma_address);
+	for (i = 0; i < len; i++) {
+		struct scatterlist *sg;
+		int amount;
+		unsigned int *sgbuffer;
 
-		dma_unmap_page(NULL, sg->dma_address, sg->length, DMA_FROM_DEVICE);
+		sg = &data->sg[i];
+ 
+		sgbuffer = kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ) + sg->offset;
+		amount = min(size, sg->length);
+		size -= amount;
 
 		if (cpu_is_at91rm9200()) {	/* AT91RM9200 errata */
-			unsigned int *buffer;
 			int index;
-
-			/* Swap the contents of the buffer */
-			buffer = kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ) + sg->offset;
-			pr_debug("buffer = %p, length = %d\n", buffer, sg->length);
-
-			for (index = 0; index < (sg->length / 4); index++)
-				buffer[index] = swab32(buffer[index]);
-
-			kunmap_atomic(buffer, KM_BIO_SRC_IRQ);
+			for (index = 0; index < (amount / 4); index++)
+				sgbuffer[index] = swab32(*dmabuf++);
+		} else {
+			char *tmpv = (char *)dmabuf;
+			memcpy(sgbuffer, tmpv, amount);
+			tmpv += amount;
+			dmabuf = (unsigned *)tmpv;
 		}
 
-		flush_dcache_page(sg_page(sg));
-
-		data->bytes_xfered += sg->length;
-	}
-
-	/* Is there another transfer to trigger? */
-	if (host->transfer_index < data->sg_len)
-		at91_mci_pre_dma_read(host);
-	else {
-		at91_mci_write(host, AT91_MCI_IDR, AT91_MCI_ENDRX);
-		at91_mci_write(host, AT91_MCI_IER, AT91_MCI_RXBUFF);
+		kunmap_atomic(((void*)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);
+		dmac_flush_range ((void*)sgbuffer, ((void*)sgbuffer)+amount);
+		data->bytes_xfered += amount;
+		if (size == 0)
+			break;
 	}
 
 	pr_debug("post dma read done\n");
@@ -610,7 +541,12 @@
 				 */
 				host->total_length = 0;
 
-				at91_mci_pre_dma_read(host);
+				at91_mci_write(host, ATMEL_PDC_RPR, host->physical_address);
+				at91_mci_write(host, ATMEL_PDC_RCR, (data->blksz & 0x3) ? 
+					(blocks * block_length) : (blocks * block_length) / 4);
+				at91_mci_write(host, ATMEL_PDC_RNPR, 0);
+				at91_mci_write(host, ATMEL_PDC_RNCR, 0);
+				
 				ier = AT91_MCI_ENDRX /* | AT91_MCI_RXBUFF */;
 			}
 			else {
---
best regards
 
i. A. Wolfgang M?es
-- 
Auerswald Gesellschaft f?r Datensysteme mbH
Hardware Development
Telefon: +49 (0)5306 9219 562
Telefax: +49 (0)5306 9219 94 
E-Mail: Wolfgang.Mues at Auerswald.de
Web: http://www.auerswald.de
 
--------------------------------------------------------------
Auerswald Gesellschaft f?r Datensysteme mbH
Vor den Grash?fen 1, 38162 Cremlingen
Registriert beim AG Braunschweig HRB 7499
Gesch?ftsf?hrer: Dipl-Ing. Gerhard Auerswald
