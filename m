From: fisaksen@baylibre.com (Frode Isaksen)
Date: Thu, 23 Feb 2017 19:01:57 +0100
Subject: [PATCH v3 2/6] spi: davinci: enable DMA when channels are defined in
 DT
In-Reply-To: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
References: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1487872921-26628-3-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabien Parent <fparent@baylibre.com>

When booting with DT the SPI driver is always using
the SPI_IO_TYPE_INTR mode to transfer data even if DMA channels are
defined in the DT.

This commit changes the behaviour to select the SPI_IO_TYPE_DMA mode
if DMA channels are defined in the DT and will keep SPI_IO_TYPE_INTR
if the channels are not defined in it.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 164cc71..1e24395 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -389,6 +389,7 @@ static int davinci_spi_of_setup(struct spi_device *spi)
 {
 	struct davinci_spi_config *spicfg = spi->controller_data;
 	struct device_node *np = spi->dev.of_node;
+	struct davinci_spi *dspi = spi_master_get_devdata(spi->master);
 	u32 prop;
 
 	if (spicfg == NULL && np) {
@@ -400,6 +401,9 @@ static int davinci_spi_of_setup(struct spi_device *spi)
 		if (!of_property_read_u32(np, "ti,spi-wdelay", &prop))
 			spicfg->wdelay = (u8)prop;
 		spi->controller_data = spicfg;
+
+		if (dspi->dma_rx && dspi->dma_tx)
+			spicfg->io_type = SPI_IO_TYPE_DMA;
 	}
 
 	return 0;
-- 
2.7.4
