From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 28 Jan 2015 13:23:51 +0100
Subject: [PATCH v2 12/15] spi/xilinx: Remove iowrite/ioread wrappers
In-Reply-To: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422447834-23116-13-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save a stack level and cleanup code.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index b16fccf..8c25c59 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -94,26 +94,6 @@ struct xilinx_spi {
 	void (*write_fn)(u32, void __iomem *);
 };
 
-static void xspi_write32(u32 val, void __iomem *addr)
-{
-	iowrite32(val, addr);
-}
-
-static unsigned int xspi_read32(void __iomem *addr)
-{
-	return ioread32(addr);
-}
-
-static void xspi_write32_be(u32 val, void __iomem *addr)
-{
-	iowrite32be(val, addr);
-}
-
-static unsigned int xspi_read32_be(void __iomem *addr)
-{
-	return ioread32be(addr);
-}
-
 static void xilinx_spi_tx(struct xilinx_spi *xspi)
 {
 	if (!xspi->tx_ptr) {
@@ -398,15 +378,15 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	 * Setup little endian helper functions first and try to use them
 	 * and check if bit was correctly setup or not.
 	 */
-	xspi->read_fn = xspi_read32;
-	xspi->write_fn = xspi_write32;
+	xspi->read_fn = ioread32;
+	xspi->write_fn = iowrite32;
 
 	xspi->write_fn(XSPI_CR_LOOP, xspi->regs + XSPI_CR_OFFSET);
 	tmp = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
 	tmp &= XSPI_CR_LOOP;
 	if (tmp != XSPI_CR_LOOP) {
-		xspi->read_fn = xspi_read32_be;
-		xspi->write_fn = xspi_write32_be;
+		xspi->read_fn = ioread32be;
+		xspi->write_fn = iowrite32be;
 	}
 
 	master->bits_per_word_mask = SPI_BPW_MASK(bits_per_word);
-- 
2.1.4
