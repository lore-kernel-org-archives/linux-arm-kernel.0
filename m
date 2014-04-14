From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 14 Apr 2014 14:29:57 +0800
Subject: [PATCH 1/5] spi: sirf: correct TXFIFO empty interrupt status bit
In-Reply-To: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1397457001-5266-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

the old code uses wrong marco - SIRFSOC_SPI_FIFO_FULL is not for
FIFO interrupt status, it is for FIFO status. here in the ISR,
SIRFSOC_SPI_TXFIFO_EMPTY is the right bit for SPI TXFIFO interrupt
status.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 1a77ad5..51d7c98 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -287,8 +287,8 @@ static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 				sspi->left_rx_word)
 			sspi->rx_word(sspi);
 
-	if (spi_stat & (SIRFSOC_SPI_FIFO_EMPTY
-			| SIRFSOC_SPI_TXFIFO_THD_REACH))
+	if (spi_stat & (SIRFSOC_SPI_TXFIFO_EMPTY |
+			SIRFSOC_SPI_TXFIFO_THD_REACH))
 		while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS)
 				& SIRFSOC_SPI_FIFO_FULL)) &&
 				sspi->left_tx_word)
-- 
1.7.5.4
