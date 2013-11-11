From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 11 Nov 2013 17:47:58 +0800
Subject: [PATCH] spi: sirf: move to use generic dma dt-binding
Message-ID: <1384163278-28108-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sirf-dma driver enabled generic dt binding for dma channels.
see here we remove self-defined dma channel prop and move to
use generic dma_request_slave_channel.
related changes in dts is something like:
    dmas = <&dmac1 9>,
    <&dmac1 4>;
    dma-names = "rx", "tx";

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index a1f21b7..7c6a797 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -22,7 +22,6 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
-#include <linux/sirfsoc_dma.h>
 
 #define DRIVER_NAME "sirfsoc_spi"
 
@@ -555,8 +554,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct resource *mem_res;
 	int num_cs, cs_gpio, irq;
-	u32 rx_dma_ch, tx_dma_ch;
-	dma_cap_mask_t dma_cap_mask;
 	int i;
 	int ret;
 
@@ -567,20 +564,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 		goto err_cs;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node,
-			"sirf,spi-dma-rx-channel", &rx_dma_ch);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Unable to get rx dma channel\n");
-		goto err_cs;
-	}
-
-	ret = of_property_read_u32(pdev->dev.of_node,
-			"sirf,spi-dma-tx-channel", &tx_dma_ch);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Unable to get tx dma channel\n");
-		goto err_cs;
-	}
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*sspi) + sizeof(int) * num_cs);
 	if (!master) {
 		dev_err(&pdev->dev, "Unable to allocate SPI master\n");
@@ -644,18 +627,13 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
 
 	/* request DMA channels */
-	dma_cap_zero(dma_cap_mask);
-	dma_cap_set(DMA_INTERLEAVE, dma_cap_mask);
-
-	sspi->rx_chan = dma_request_channel(dma_cap_mask, (dma_filter_fn)sirfsoc_dma_filter_id,
-		(void *)rx_dma_ch);
+	sspi->rx_chan = dma_request_slave_channel(&pdev->dev, "rx");
 	if (!sspi->rx_chan) {
 		dev_err(&pdev->dev, "can not allocate rx dma channel\n");
 		ret = -ENODEV;
 		goto free_master;
 	}
-	sspi->tx_chan = dma_request_channel(dma_cap_mask, (dma_filter_fn)sirfsoc_dma_filter_id,
-		(void *)tx_dma_ch);
+	sspi->tx_chan = dma_request_slave_channel(&pdev->dev, "tx");
 	if (!sspi->tx_chan) {
 		dev_err(&pdev->dev, "can not allocate tx dma channel\n");
 		ret = -ENODEV;
-- 
1.8.2.3
