From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 22 Nov 2016 12:31:32 +0530
Subject: [PATCH v3 3/3] spi: spi-fsl-dspi: Fix incorrect freeing of DMA
 allocated buffers
In-Reply-To: <cover.1479796821.git.maitysanchayan@gmail.com>
References: <cover.1479796821.git.maitysanchayan@gmail.com>
Message-ID: <fd3b1fa5d9fb2a0c2d1f6ded314acf20f5081a89.1479796821.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Buffers allocated with a call to dma_alloc_coherent should be
freed with dma_free_coherent instead of the currently used
devm_kfree.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8af3151..7ada112 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -420,9 +420,11 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	devm_kfree(dev, dma->rx_dma_buf);
+	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
+			dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	devm_kfree(dev, dma->tx_dma_buf);
+	dma_free_coherent(dev, DSPI_DMA_BUFSIZE,
+			dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
 err_tx_channel:
-- 
2.10.2
