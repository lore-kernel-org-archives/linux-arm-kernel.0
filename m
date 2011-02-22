From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 22 Feb 2011 08:36:58 -0500
Subject: [PATCH v3 3/9] davinci: spi: move event queue parameter to platform
	data
In-Reply-To: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
References: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1298381824-7723-4-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For DMA operation, the davinci spi driver needs an event queue number.
Currently, this number is passed as a IORESOURCE_DMA.  This is not
correct, as the event queue is not a DMA channel.  Pass the event queue
via the platform data structure instead.

On dm355 and dm365, move the eventq assignment for spi0 out of resources
array and into platform data.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/dm355.c            |    5 +----
 arch/arm/mach-davinci/dm365.c            |    5 +----
 arch/arm/mach-davinci/include/mach/spi.h |   15 ++++++++++-----
 drivers/spi/davinci_spi.c                |   11 +++--------
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a5f8a80..76364d1 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -403,16 +403,13 @@ static struct resource dm355_spi0_resources[] = {
 		.start = 16,
 		.flags = IORESOURCE_DMA,
 	},
-	{
-		.start = EVENTQ_1,
-		.flags = IORESOURCE_DMA,
-	},
 };
 
 static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.cshold_bug	= true,
+	.dma_event_q	= EVENTQ_1,
 };
 static struct platform_device dm355_spi0_device = {
 	.name = "spi_davinci",
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 02d2cc3..4604e72 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -625,6 +625,7 @@ static u64 dm365_spi0_dma_mask = DMA_BIT_MASK(32);
 static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
+	.dma_event_q	= EVENTQ_3,
 };
 
 static struct resource dm365_spi0_resources[] = {
@@ -645,10 +646,6 @@ static struct resource dm365_spi0_resources[] = {
 		.start = 16,
 		.flags = IORESOURCE_DMA,
 	},
-	{
-		.start = EVENTQ_3,
-		.flags = IORESOURCE_DMA,
-	},
 };
 
 static struct platform_device dm365_spi0_device = {
diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 38f4da5..7af305b 100644
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
+ * @dma_event_q: DMA event queue to use if SPI_IO_TYPE_DMA is used for any
+ *		device on the bus.
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
