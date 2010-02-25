From: wolfgang.mues@auerswald.de (Wolfgang =?iso-8859-15?q?M=FCes?=)
Date: Thu, 25 Feb 2010 15:15:55 +0100
Subject: [PATCH3/5] at91_mci: use coherent DMA buffer
Message-ID: <201002251515.55506.wolfgang.mues@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

this is thes third part of my fixes and improvements for the at91_mci driver.

The TX DMA buffer is allocated only once, because the allocation/deallocation
of the buffer for EACH chunk of data is time-consuming and prone to memory
fragmentation.

Using a coherent DMA buffer avoids extra data cache calls.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>

---
diff -ur linux-2.6.33-rc8-times/drivers/mmc/host/at91_mci.c linux-2.6.33-rc8-coherent/drivers/mmc/host/at91_mci.c
--- linux-2.6.33-rc8-times/drivers/mmc/host/at91_mci.c	2010-02-25 14:14:24.211239350 +0100
+++ linux-2.6.33-rc8-coherent/drivers/mmc/host/at91_mci.c	2010-02-25 14:31:00.971238838 +0100
@@ -88,6 +88,10 @@
 #define at91_mci_read(host, reg)	__raw_readl((host)->baseaddr + (reg))
 #define at91_mci_write(host, reg, val)	__raw_writel((val), (host)->baseaddr + (reg))
 
+#define MCI_BLKSIZE 		512
+#define MCI_MAXBLKSIZE 		4095
+#define MCI_BLKATONCE 		256
+#define MCI_BUFSIZE 		(MCI_BLKSIZE * MCI_BLKATONCE)
 
 /*
  * Low level type for this driver
@@ -604,7 +608,6 @@
 				/*
 				 * Handle a read
 				 */
-				host->buffer = NULL;
 				host->total_length = 0;
 
 				at91_mci_pre_dma_read(host);
@@ -623,20 +626,8 @@
 					if (host->total_length < 12)
 						host->total_length = 12;
 
-				host->buffer = kmalloc(host->total_length, GFP_KERNEL);
-				if (!host->buffer) {
-					pr_debug("Can't alloc tx buffer\n");
-					cmd->error = -ENOMEM;
-					mmc_request_done(host->mmc, host->request);
-					return;
-				}
-
 				at91_mci_sg_to_dma(host, data);
 
-				host->physical_address = dma_map_single(NULL,
-						host->buffer, host->total_length,
-						DMA_TO_DEVICE);
-
 				pr_debug("Transmitting %d bytes\n", host->total_length);
 
 				at91_mci_write(host, ATMEL_PDC_TPR, host->physical_address);
@@ -703,14 +694,6 @@
 	cmd->resp[2] = at91_mci_read(host, AT91_MCI_RSPR(2));
 	cmd->resp[3] = at91_mci_read(host, AT91_MCI_RSPR(3));
 
-	if (host->buffer) {
-		dma_unmap_single(NULL,
-				host->physical_address, host->total_length,
-				DMA_TO_DEVICE);
-		kfree(host->buffer);
-		host->buffer = NULL;
-	}
-
 	pr_debug("Status = %08X/%08x [%08X %08X %08X %08X]\n",
 		 status, at91_mci_read(host, AT91_MCI_SR),
 		 cmd->resp[0], cmd->resp[1], cmd->resp[2], cmd->resp[3]);
@@ -1012,12 +995,12 @@
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 	mmc->caps = MMC_CAP_SDIO_IRQ;
 
-	mmc->max_blk_size = 4095;
-	mmc->max_blk_count = mmc->max_req_size;
+	mmc->max_blk_size  = MCI_MAXBLKSIZE; 
+	mmc->max_blk_count = MCI_BLKATONCE;
+	mmc->max_req_size  = MCI_BUFSIZE;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
-	host->buffer = NULL;
 	host->bus_mode = 0;
 	host->board = pdev->dev.platform_data;
 	if (host->board->wire4) {
@@ -1028,6 +1011,13 @@
 				" - using 1 wire\n");
 	}
 
+	host->buffer = dma_alloc_coherent(&pdev->dev, MCI_BUFSIZE, &host->physical_address, GFP_KERNEL);
+	if (!host->buffer){
+		ret = -ENOMEM;
+		dev_err(&pdev->dev, "Can't allocate transmit buffer\n");
+		goto fail5;
+	}
+
 	/*
 	 * Reserve GPIOs ... board init code makes sure these pins are set
 	 * up as GPIOs with the right direction (input, except for vcc)
@@ -1036,7 +1026,7 @@
 		ret = gpio_request(host->board->det_pin, "mmc_detect");
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "couldn't claim card detect pin\n");
-			goto fail5;
+			goto fail4b;
 		}
 	}
 	if (host->board->wp_pin) {
@@ -1136,6 +1126,9 @@
 fail4:
 	if (host->board->det_pin)
 		gpio_free(host->board->det_pin);
+fail4b:
+	if (host->buffer)
+		dma_free_coherent (&pdev->dev, MCI_BUFSIZE, host->buffer, host->physical_address);
 fail5:
 	mmc_free_host(mmc);
 fail6:
@@ -1158,6 +1151,9 @@
 
 	host = mmc_priv(mmc);
 
+	if (host->buffer)
+		dma_free_coherent (&pdev->dev, MCI_BUFSIZE, host->buffer, host->physical_address);
+
 	if (host->board->det_pin) {
 		if (device_can_wakeup(&pdev->dev))
 			free_irq(gpio_to_irq(host->board->det_pin), host);
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
