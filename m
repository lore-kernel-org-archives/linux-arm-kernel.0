From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Fri, 30 Jan 2015 07:10:09 +0100
Subject: [PATCH] spi/xilinx: Fix access invalid memory on xilinx_spi_tx
Message-ID: <1422598209-5999-1-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 and 2 bytes per word, the transfer of the 3 last bytes will access
memory outside rx_ptr.

Although this has not trigger any error on real hardware, we should
better fix this.

Fixes: 24ba5e593f391507 Remove rx_fn and tx_fn pointer
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 2ca55f6..a1b664d 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -97,11 +97,26 @@ struct xilinx_spi {
 
 static void xilinx_spi_tx(struct xilinx_spi *xspi)
 {
+	u32 data = 0;
+
 	if (!xspi->tx_ptr) {
 		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
 		return;
 	}
-	xspi->write_fn(*(u32 *)(xspi->tx_ptr), xspi->regs + XSPI_TXD_OFFSET);
+
+	switch (xspi->bytes_per_word) {
+	case 1:
+		data = *(u8 *)(xspi->rx_ptr);
+		break;
+	case 2:
+		data = *(u16 *)(xspi->rx_ptr);
+		break;
+	case 4:
+		data = *(u32 *)(xspi->rx_ptr);
+		break;
+	}
+
+	xspi->write_fn(data, xspi->regs + XSPI_TXD_OFFSET);
 	xspi->tx_ptr += xspi->bytes_per_word;
 }
 
-- 
2.1.4
