From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 21 Jan 2015 16:53:10 +0100
Subject: [PATCH 3/3] spi/xilinx: Support for spi mode LOOP
In-Reply-To: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1421855590-9210-4-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware supports LOOP mode. Support it also in the driver.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index b8ce58d..f6ceb60 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -35,7 +35,7 @@
 #define XSPI_CR_CPOL		0x08
 #define XSPI_CR_CPHA		0x10
 #define XSPI_CR_MODE_MASK	(XSPI_CR_CPHA | XSPI_CR_CPOL | \
-				 XSPI_CR_LSB_FIRST)
+				 XSPI_CR_LSB_FIRST | XSPI_CR_LOOP)
 #define XSPI_CR_TXFIFO_RESET	0x20
 #define XSPI_CR_RXFIFO_RESET	0x40
 #define XSPI_CR_MANUAL_SSELECT	0x80
@@ -197,6 +197,8 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 			cr |= XSPI_CR_CPOL;
 		if (spi->mode & SPI_LSB_FIRST)
 			cr |= XSPI_CR_LSB_FIRST;
+		if (spi->mode & SPI_LOOP)
+			cr |= XSPI_CR_LOOP;
 		xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
 
 		/* We do not check spi->max_speed_hz here as the SPI clock
-- 
2.1.4
