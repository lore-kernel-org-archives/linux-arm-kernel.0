From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 20 Oct 2015 14:26:47 +0200
Subject: [RESEND PATCH] spi: atmel: Fix DMA-setup for transfers with more than
 8 bits per word
In-Reply-To: <1445288084-31805-1-git-send-email-davidm@egauge.net>
References: <1445288084-31805-1-git-send-email-davidm@egauge.net>
Message-ID: <1445344007-18706-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Mosberger-Tang <davidm@egauge.net>

The DMA-slave configuration depends on the whether <= 8 or > 8 bits
are transferred per word, so we need to call
atmel_spi_dma_slave_config() with the correct value.

Signed-off-by: David Mosberger <davidm@egauge.net>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/spi/spi-atmel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 1cc1f1e0d17f..0b6e5ecbc752 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -773,7 +773,8 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	*plen = len;
 
-	if (atmel_spi_dma_slave_config(as, &slave_config, 8))
+	if (atmel_spi_dma_slave_config(as, &slave_config,
+				       xfer->bits_per_word))
 		goto err_exit;
 
 	/* Send both scatterlists */
-- 
2.1.3
