From: davidm@egauge.net (David Mosberger-Tang)
Date: Mon, 19 Oct 2015 14:54:44 -0600
Subject: [PATCH] spi: atmel: Fix DMA-setup for transfers with more than 8 bits
 per word.
Message-ID: <1445288084-31805-1-git-send-email-davidm@egauge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA-slave configuration depends on the whether <= 8 or > 8 bits
are transferred per word, so we need to call
atmel_spi_dma_slave_config() with the correct value.

Signed-off-by: David Mosberger <davidm@egauge.net>
---
 drivers/spi/spi-atmel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 04e48e5..855cc56 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -758,7 +758,8 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	*plen = len;
 
-	if (atmel_spi_dma_slave_config(as, &slave_config, 8))
+	if (atmel_spi_dma_slave_config(as, &slave_config,
+				       xfer->bits_per_word))
 		goto err_exit;
 
 	/* Send both scatterlists */
-- 
1.9.1
