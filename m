From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 12 Aug 2015 18:04:04 +0200
Subject: [PATCH] spi/spi-xilinx: Fix mixed poll/irq mode
Message-ID: <1439395444-25599-1-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once the module process a transfer in irq mode, the next poll transfer
will not work because the transmitter is left in inhibited state.

Fixes: 22417352f6b7f623 (Use polling mode on small transfers)
Reported-by: Edward Kigwana <ekigwana@scires.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 133f53a9c1d4..7abf6792cc11 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -302,8 +302,10 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		remaining_words -= n_words;
 	}
 
-	if (use_irq)
+	if (use_irq) {
 		xspi->write_fn(0, xspi->regs + XIPIF_V123B_DGIER_OFFSET);
+		xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
+	}
 
 	return t->len;
 }
-- 
2.5.0
