From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:01:03 +0800
Subject: [PATCH 3/8] spi: sirf: enable RX_IO_DMA_INT interrupt
In-Reply-To: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1409648468-5436-4-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

in spi interrupt handler, we need check RX_IO_DMA status to ensure
rx fifo have received the specify count data.

if not set, the while statement in spi isr function will keep loop,
at last, make the kernel hang.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index a21e423..7789385 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -437,7 +437,8 @@ static void spi_sirfsoc_pio_transfer(struct spi_device *spi,
 			sspi->tx_word(sspi);
 		writel(SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN |
 			SIRFSOC_SPI_TX_UFLOW_INT_EN |
-			SIRFSOC_SPI_RX_OFLOW_INT_EN,
+			SIRFSOC_SPI_RX_OFLOW_INT_EN |
+			SIRFSOC_SPI_RX_IO_DMA_INT_EN,
 			sspi->base + SIRFSOC_SPI_INT_EN);
 		writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
 			sspi->base + SIRFSOC_SPI_TX_RX_EN);
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
