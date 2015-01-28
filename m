From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 28 Jan 2015 13:23:48 +0100
Subject: [PATCH v2 09/15] spi/xilinx: Make spi_tx and spi_rx simmetric
In-Reply-To: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422447834-23116-10-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi_rx handles the case where the buffer is null. Nevertheless spi_tx
did not handle it, and was handled by the caller function.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index ac94e54..6ce1066 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -116,6 +116,10 @@ static unsigned int xspi_read32_be(void __iomem *addr)
 
 static void xilinx_spi_tx(struct xilinx_spi *xspi)
 {
+	if (!xspi->tx_ptr) {
+		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
+		return;
+	}
 	xspi->write_fn(*(u32 *)(xspi->tx_ptr), xspi->regs + XSPI_TXD_OFFSET);
 	xspi->tx_ptr += xspi->bits_per_word / 8;
 }
@@ -230,10 +234,7 @@ static void xilinx_spi_fill_tx_fifo(struct xilinx_spi *xspi, int n_words)
 	xspi->remaining_bytes -= n_words * xspi->bits_per_word / 8;
 
 	while (n_words--)
-		if (xspi->tx_ptr)
-			xilinx_spi_tx(xspi);
-		else
-			xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
+		xilinx_spi_tx(xspi);
 	return;
 }
 
-- 
2.1.4
