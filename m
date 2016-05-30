From: naga.sureshkumar.relli@xilinx.com (Naga Sureshkumar Relli)
Date: Mon, 30 May 2016 15:17:01 +0530
Subject: [PATCH v2 2/3] spi: xilinx: Add QUAD support
Message-ID: <1464601621-5157-1-git-send-email-nagasure@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds QUAD mode support to axi spi controller.
updated supported mode bits to SPI_TX_QUAD and SPI_RX_QUAD.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
changes for v2
 - none
---
 drivers/spi/spi-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index d903857..4467590 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -74,6 +74,7 @@
 
 /* Number of data lines used to receive */
 #define XSPI_RX_ONE_WIRE	1
+#define XSPI_RX_FOUR_WIRE	4
 
 /**
  * struct xilinx_spi - This definition define spi driver instance
@@ -558,8 +559,10 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 			xspi->tx_fifo = xspi_fill_tx_fifo_32;
 			xspi->rx_fifo = xspi_read_rx_fifo_32;
 		}
+	} else if (xspi->rx_bus_width == XSPI_RX_FOUR_WIRE) {
+		master->mode_bits |= SPI_TX_QUAD | SPI_RX_QUAD;
 	} else {
-		dev_err(&pdev->dev, "Dual/Quad Modes are not supported\n");
+		dev_err(&pdev->dev, "Dual Mode not supported\n");
 		goto put_master;
 	}
 	xspi->cs_inactive = 0xffffffff;
-- 
2.1.1
