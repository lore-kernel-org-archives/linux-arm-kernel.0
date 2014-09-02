From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:02:34 +0800
Subject: [PATCH 5/8] spi: sirf: add fifo reset/start for cmd transfer
Message-ID: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

for command mode spi transfer, HW spec requires to do fifo reset work to
clear FIFO status.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 93376a2..7499076 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -311,6 +311,8 @@ static void spi_sirfsoc_cmd_transfer(struct spi_device *spi,
 	u32 cmd;
 
 	sspi = spi_master_get_devdata(spi->master);
+	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
 	memcpy(&cmd, sspi->tx, t->len);
 	if (sspi->word_width == 1 && !(spi->mode & SPI_LSB_FIRST))
 		cmd = cpu_to_be32(cmd) >>
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
