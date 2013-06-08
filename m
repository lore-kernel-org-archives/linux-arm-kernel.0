From: r.sricharan@ti.com (Sricharan R)
Date: Sat, 8 Jun 2013 22:05:38 +0530
Subject: [PATCH] spi: omap2-mcspi: Skip platform_get_resource_byname() for dt
 case
Message-ID: <1370709338-19810-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

McSPI driver probe will abort for DT case because of failed
platform_get_resource_byname() lookup. Fix it by skipping resource
byname lookup for device tree build.

Issue comes out when dma entries are removed from the hwmod data.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e4829aa..99172d2 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1275,25 +1275,31 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		struct resource *dma_res;
 
 		sprintf(dma_rx_ch_name, "rx%d", i);
-		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-				dma_rx_ch_name);
-		if (!dma_res) {
-			dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
-			status = -ENODEV;
-			break;
+
+		if (!pdev->dev.of_node) {
+			dma_res = platform_get_resource_byname(pdev,
+					IORESOURCE_DMA, dma_rx_ch_name);
+			if (!dma_res) {
+				dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
+				status = -ENODEV;
+				break;
+			}
+			mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
 		}
 
-		mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
 		sprintf(dma_tx_ch_name, "tx%d", i);
-		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-				dma_tx_ch_name);
-		if (!dma_res) {
-			dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
-			status = -ENODEV;
-			break;
-		}
 
-		mcspi->dma_channels[i].dma_tx_sync_dev = dma_res->start;
+		if (!pdev->dev.of_node) {
+			dma_res = platform_get_resource_byname(pdev,
+					IORESOURCE_DMA, dma_tx_ch_name);
+
+			if (!dma_res) {
+				dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
+				status = -ENODEV;
+				break;
+			}
+			mcspi->dma_channels[i].dma_tx_sync_dev = dma_res->start;
+		}
 	}
 
 	if (status < 0)
-- 
1.7.9.5
