From: stephanolbrich@gmx.de (stephanolbrich at gmx.de)
Date: Tue,  9 Feb 2016 19:10:33 +0100
Subject: [PATCH 2/4] spi: bcm2835aux: disable tx fifo empty irq
In-Reply-To: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
Message-ID: <1455041435-8015-3-git-send-email-stephanolbrich@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephan Olbrich <stephanolbrich@gmx.de>

The tx empty irq can be disabled when all data was copied.
This prevents unnecessary interrupts while the last bytes are sent.

Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
---
 drivers/spi/spi-bcm2835aux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index ecc73c0..d2f0067 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -212,6 +212,12 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 	}
 
+	if (!bs->tx_len) {
+		/* disable tx fifo empty interrupt */
+		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1] |
+			BCM2835_AUX_SPI_CNTL1_IDLE);
+	}
+
 	/* and if rx_len is 0 then wake up completion and disable spi */
 	if (!bs->rx_len) {
 		bcm2835aux_spi_reset_hw(bs);
-- 
2.5.0
