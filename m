From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Fri, 23 Jan 2015 17:08:34 +0100
Subject: [PATCH 02/18] spi/xilinx: Support for spi mode LOOP
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422029330-10971-3-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware supports LOOP mode. Support it also in the driver.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index d4edeee..e1d9a20 100644
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
@@ -356,7 +358,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_LOOP;
 
 	xspi = spi_master_get_devdata(master);
 	xspi->bitbang.master = master;
-- 
2.1.4
