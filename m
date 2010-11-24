From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 24 Nov 2010 15:55:40 +0100
Subject: [PATCH 6/7] atmel_spi: fix warning In function
	'atmel_spi_dma_map_xfer'
In-Reply-To: <20101124143448.GH11909@game.jcrosoft.org>
References: <20101124143448.GH11909@game.jcrosoft.org>
Message-ID: <1290610541-29255-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

passing argument 2 of 'dma_map_single' discards qualifiers from pointer target type

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/spi/atmel_spi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 154529a..a067046 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -352,8 +352,12 @@ atmel_spi_dma_map_xfer(struct atmel_spi *as, struct spi_transfer *xfer)
 
 	xfer->tx_dma = xfer->rx_dma = INVALID_DMA_ADDRESS;
 	if (xfer->tx_buf) {
+		/* tx_buf is a const void* where we need a void * for the dma
+		 * mapping */
+		void *nonconst_tx = (void *)xfer->tx_buf;
+
 		xfer->tx_dma = dma_map_single(dev,
-				(void *) xfer->tx_buf, xfer->len,
+				nonconst_tx, xfer->len,
 				DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, xfer->tx_dma))
 			return -ENOMEM;
-- 
1.7.1
