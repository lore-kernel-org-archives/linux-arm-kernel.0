From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 21 Jan 2015 16:53:09 +0100
Subject: [PATCH 2/3] spi/xilinx: Support for spi mode LSB_FIRST
In-Reply-To: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1421855590-9210-3-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware supports LSB_FIRST mode. Support it also in the driver.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 2ea4ca5..b8ce58d 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -34,7 +34,8 @@
 #define XSPI_CR_MASTER_MODE	0x04
 #define XSPI_CR_CPOL		0x08
 #define XSPI_CR_CPHA		0x10
-#define XSPI_CR_MODE_MASK	(XSPI_CR_CPHA | XSPI_CR_CPOL)
+#define XSPI_CR_MODE_MASK	(XSPI_CR_CPHA | XSPI_CR_CPOL | \
+				 XSPI_CR_LSB_FIRST)
 #define XSPI_CR_TXFIFO_RESET	0x20
 #define XSPI_CR_RXFIFO_RESET	0x40
 #define XSPI_CR_MANUAL_SSELECT	0x80
@@ -194,6 +195,8 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 			cr |= XSPI_CR_CPHA;
 		if (spi->mode & SPI_CPOL)
 			cr |= XSPI_CR_CPOL;
+		if (spi->mode & SPI_LSB_FIRST)
+			cr |= XSPI_CR_LSB_FIRST;
 		xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
 
 		/* We do not check spi->max_speed_hz here as the SPI clock
-- 
2.1.4
