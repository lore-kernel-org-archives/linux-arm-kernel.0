From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon, 21 Nov 2016 11:24:02 +0530
Subject: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix continuous selection format
In-Reply-To: <cover.1479706671.git.maitysanchayan@gmail.com>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
Message-ID: <1317eff8a40789c47311c219d9cfb4105863bd9f.1479706671.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current DMA implementation was not handling the continuous selection
format viz. SPI chip select would be deasserted even between sequential
serial transfers. Use the cs_change variable and correctly set or
reset the CONT bit accordingly for case where peripherals require
the chip select to be asserted between sequential transfers.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index b1ee1f5..41422cd 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -261,6 +261,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
 					SPI_PUSHR_PCS(dspi->cs) |
 					SPI_PUSHR_CTAS(0);
+	if (!dspi->cs_change)
+		dspi->dma->tx_dma_buf[i] |= SPI_PUSHR_CONT;
 	dspi->tx += tx_word + 1;
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
-- 
2.10.2
