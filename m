From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:01:04 +0800
Subject: [PATCH 4/8] spi: sirf: fix 'cmd_transfer' function typos
In-Reply-To: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1409648468-5436-5-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

unify 'cmd_transfer' like 'pio_transfer' and 'dma_transfer' as void
function, and also change left_rx_word according to transfer result.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 7789385..93376a2 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -303,7 +303,7 @@ static void spi_sirfsoc_dma_fini_callback(void *data)
 	complete(dma_complete);
 }
 
-static int spi_sirfsoc_cmd_transfer(struct spi_device *spi,
+static void spi_sirfsoc_cmd_transfer(struct spi_device *spi,
 	struct spi_transfer *t)
 {
 	struct sirfsoc_spi *sspi;
@@ -325,10 +325,9 @@ static int spi_sirfsoc_cmd_transfer(struct spi_device *spi,
 		sspi->base + SIRFSOC_SPI_TX_RX_EN);
 	if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
 		dev_err(&spi->dev, "cmd transfer timeout\n");
-		return 0;
+		return;
 	}
-
-	return t->len;
+	sspi->left_rx_word -= t->len;
 }
 
 static void spi_sirfsoc_dma_transfer(struct spi_device *spi,
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
