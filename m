From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Sep 2013 14:52:59 -0400
Subject: [PATCH] spi: davinci: Fix the build warning with CONFIG_ARM_LPAE=y
Message-ID: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_ARM_LPAE=y spi driver throws below warning

drivers/spi/spi-davinci.c: In function ?davinci_spi_probe?:
drivers/spi/spi-davinci.c:965:3: warning: format ?%d? expects argument of type ?int?, but argument 3 has type ?resource_size_t? [-Wformat]
drivers/spi/spi-davinci.c:965:3: warning: format ?%d? expects argument of type ?int?, but argument 4 has type ?resource_size_t? [-Wformat]

Lets use '%pa' to properly print 'resource_size_t' type variables.

Cc: Mark Brown <broonie@kernel.org>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/spi/spi-davinci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 8fbfe24..c91ad94 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -962,8 +962,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
 			goto free_clk;
 
 		dev_info(&pdev->dev, "DMA: supported\n");
-		dev_info(&pdev->dev, "DMA: RX channel: %d, TX channel: %d, "
-				"event queue: %d\n", dma_rx_chan, dma_tx_chan,
+		dev_info(&pdev->dev, "DMA: RX channel: %pa, TX channel: %pa, "
+				"event queue: %d\n", &dma_rx_chan, &dma_tx_chan,
 				pdata->dma_event_q);
 	}
 
-- 
1.7.9.5
