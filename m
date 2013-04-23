From: cedric@precidata.com (Cedric Berger)
Date: Tue, 23 Apr 2013 10:02:20 +0200 (CEST)
Subject: [PATCH 4/10] LPC32XX: 004-mmc.2: Enable dma for Phytec board (V2)
Message-ID: <mailman.0.1366704147.1125.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA for phy3250. Without that, the mmc driver is unusable.

Signed-off-by: Gabriele Mondada <gabriele@precidata.com>
---

Index: arch/arm/mach-lpc32xx/phy3250.c
===================================================================
--- arch/arm/mach-lpc32xx/phy3250.c	(revision 1769)
+++ arch/arm/mach-lpc32xx/phy3250.c	(working copy)
@@ -168,6 +168,12 @@
 		.max_signal = 12,
 		.periph_buses = PL08X_AHB1,
 	},
+	{
+		.bus_id = "mmc",
+		.min_signal = 4,
+		.max_signal = 4,
+		.periph_buses = PL08X_AHB1,
+	},
 };
 
 static int pl08x_get_signal(const struct pl08x_channel_data *cd)
@@ -202,9 +208,14 @@
 	.ocr_mask	= MMC_VDD_30_31 | MMC_VDD_31_32 |
 			  MMC_VDD_32_33 | MMC_VDD_33_34,
 	.ios_handler	= mmc_handle_ios,
-	.dma_filter	= NULL,
-	/* No DMA for now since AMBA PL080 dmaengine driver only does scatter
-	 * gather, and the MMCI driver doesn't do it this way */
+	.dma_filter	= pl08x_filter_id,
+	.dma_quirks	= MCI_DMA_QUIRK_PL18X_RX | MCI_DMA_QUIRK_PL18X_TX,
+	.dma_rx_param	= "mmc",
+	/*
+	 * When not defined, tx channel is the same as rx.
+	 * Defining dma_tx_param with the same value as dma_rx_param does not
+	 * work.
+	 */
 };
 
 static struct lpc32xx_slc_platform_data lpc32xx_slc_data = {
