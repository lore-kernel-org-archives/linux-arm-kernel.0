From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 14 Apr 2014 14:29:58 +0800
Subject: [PATCH 2/5] spi: sirf: set SPI controller in RISC IO chipselect mode
In-Reply-To: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1397457001-5266-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

SPI bitbang supply "chipselect" interface for change chip-select line
, in the SiRFSoC SPI controller, we need to enable "SPI_CS_IO_MODE",
otherwise, spi_sirfsoc_chipselect() has no effect.
now the driver is working is because SPI controller will control CS
automatically without SPI_CS_IO_MODE. this patch makes the CS controller
really controlled by software.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/spi/spi-sirf.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 51d7c98..9b30743 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -559,6 +559,11 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		regval &= ~SIRFSOC_SPI_CMD_MODE;
 		sspi->tx_by_cmd = false;
 	}
+	/*
+	 * set spi controller in RISC chipselect mode, we are controlling CS by
+	 * software BITBANG_CS_ACTIVE and BITBANG_CS_INACTIVE.
+	 */
+	regval |= SIRFSOC_SPI_CS_IO_MODE;
 	writel(regval, sspi->base + SIRFSOC_SPI_CTRL);
 
 	if (IS_DMA_VALID(t)) {
-- 
1.7.5.4
