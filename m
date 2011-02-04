From: michael.williamson@criticallink.com (Michael Williamson)
Date: Thu,  3 Feb 2011 19:34:48 -0500
Subject: [PATCH 1/3] davinci: spi: move event_q parameter to platform data
In-Reply-To: <1296779690-9723-1-git-send-email-michael.williamson@criticallink.com>
References: <1296779690-9723-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1296779690-9723-2-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For DMA operation, the davinci spi driver needs an eventq number.
Currently, this number is passed as a IORESOURCE_DMA.  This is not
correct, as the eventq is not a DMA channel.  Pass the eventq
via the platform data structure instead.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/include/mach/spi.h |   15 ++++++++++-----
 drivers/spi/davinci_spi.c                |   11 +++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 38f4da5..0853a5f 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -19,6 +19,8 @@
 #ifndef __ARCH_ARM_DAVINCI_SPI_H
 #define __ARCH_ARM_DAVINCI_SPI_H
 
+#include <mach/edma.h>
+
 #define SPI_INTERN_CS	0xFF
 
 enum {
@@ -39,13 +41,16 @@ enum {
  *		to populate if all chip-selects are internal.
  * @cshold_bug:	set this to true if the SPI controller on your chip requires
  *		a write to CSHOLD bit in between transfers (like in DM355).
+ * @dma_event_q: DMA event_q to use if SPI_IO_TYPE_DMA is used for any device
+ *		on the bus.
  */
 struct davinci_spi_platform_data {
-	u8	version;
-	u8	num_chipselect;
-	u8	intr_line;
-	u8	*chip_sel;
-	bool	cshold_bug;
+	u8			version;
+	u8			num_chipselect;
+	u8			intr_line;
+	u8			*chip_sel;
+	bool			cshold_bug;
+	enum dma_event_q	dma_event_q;
 };
 
 /**
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 6beab99..166a879 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -790,7 +790,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	struct resource *r, *mem;
 	resource_size_t dma_rx_chan = SPI_NO_RESOURCE;
 	resource_size_t	dma_tx_chan = SPI_NO_RESOURCE;
-	resource_size_t	dma_eventq = SPI_NO_RESOURCE;
 	int i = 0, ret = 0;
 	u32 spipc0;
 
@@ -878,17 +877,13 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (r)
 		dma_tx_chan = r->start;
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 2);
-	if (r)
-		dma_eventq = r->start;
 
 	dspi->bitbang.txrx_bufs = davinci_spi_bufs;
 	if (dma_rx_chan != SPI_NO_RESOURCE &&
-	    dma_tx_chan != SPI_NO_RESOURCE &&
-	    dma_eventq != SPI_NO_RESOURCE) {
+	    dma_tx_chan != SPI_NO_RESOURCE) {
 		dspi->dma.rx_channel = dma_rx_chan;
 		dspi->dma.tx_channel = dma_tx_chan;
-		dspi->dma.eventq = dma_eventq;
+		dspi->dma.eventq = pdata->dma_event_q;
 
 		ret = davinci_spi_request_dma(dspi);
 		if (ret)
@@ -897,7 +892,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "DMA: supported\n");
 		dev_info(&pdev->dev, "DMA: RX channel: %d, TX channel: %d, "
 				"event queue: %d\n", dma_rx_chan, dma_tx_chan,
-				dma_eventq);
+				pdata->dma_event_q);
 	}
 
 	dspi->get_rx = davinci_spi_rx_buf_u8;
-- 
1.7.0.4
