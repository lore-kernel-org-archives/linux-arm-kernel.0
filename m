From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Thu, 13 Aug 2015 16:09:28 +0200
Subject: [PATCH] spi/spi-xilinx: Fix spurious IRQ ACK on irq mode
Message-ID: <1439474968-10260-1-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACK of an inexistent IRQ can trigger an spurious IRQ that breaks the
txrx logic. This has been observed on axi_quad_spi:3.2 core.

This patch only ACKs IRQs that have not been Acknowledge jet.

Reported-by: Edward Kigwana <ekigwana@scires.com>
Tested-by: Edward Kigwana <ekigwana@scires.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 7abf6792cc11..a339c1e9997a 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -249,19 +249,23 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 	xspi->tx_ptr = t->tx_buf;
 	xspi->rx_ptr = t->rx_buf;
 	remaining_words = t->len / xspi->bytes_per_word;
-	reinit_completion(&xspi->done);
 
 	if (xspi->irq >= 0 &&  remaining_words > xspi->buffer_size) {
+		u32 isr;
 		use_irq = true;
-		xspi->write_fn(XSPI_INTR_TX_EMPTY,
-				xspi->regs + XIPIF_V123B_IISR_OFFSET);
-		/* Enable the global IPIF interrupt */
-		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
-				xspi->regs + XIPIF_V123B_DGIER_OFFSET);
 		/* Inhibit irq to avoid spurious irqs on tx_empty*/
 		cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
 		xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
 			       xspi->regs + XSPI_CR_OFFSET);
+		/* ACK old irqs (if any) */
+		isr = xspi->read_fn(xspi->regs + XIPIF_V123B_IISR_OFFSET);
+		if (isr)
+			xspi->write_fn(isr,
+				       xspi->regs + XIPIF_V123B_IISR_OFFSET);
+		/* Enable the global IPIF interrupt */
+		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
+				xspi->regs + XIPIF_V123B_DGIER_OFFSET);
+		reinit_completion(&xspi->done);
 	}
 
 	while (remaining_words) {
-- 
2.5.0
