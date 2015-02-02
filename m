From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Mon,  2 Feb 2015 11:06:56 +0100
Subject: [PATCH v2] spi/xilinx: Fix access invalid memory on xilinx_spi_tx
Message-ID: <1422871616-6686-1-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 and 2 bytes per word, the transfer of the 3 last bytes will access
memory outside tx_ptr.

Although this has not trigger any error on real hardware, we should
better fix this.

Fixes: 24ba5e593f391507 Remove rx_fn and tx_fn pointer
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---

v2:

v1 was completely wrong, sorry about that :(. This v2 has been tested on x86
 1 byte per word

 drivers/spi/spi-xilinx.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index d1901d5..133f53a 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -117,11 +117,26 @@ static unsigned int xspi_read32_be(void __iomem *addr)
 
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
+		data = *(u8 *)(xspi->tx_ptr);
+		break;
+	case 2:
+		data = *(u16 *)(xspi->tx_ptr);
+		break;
+	case 4:
+		data = *(u32 *)(xspi->tx_ptr);
+		break;
+	}
+
+	xspi->write_fn(data, xspi->regs + XSPI_TXD_OFFSET);
 	xspi->tx_ptr += xspi->bytes_per_word;
 }
 
-- 
2.1.4
