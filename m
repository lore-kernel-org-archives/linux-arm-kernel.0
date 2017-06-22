From: colin.king@canonical.com (Colin King)
Date: Thu, 22 Jun 2017 17:34:49 +0100
Subject: [PATCH] spi: stm32: fix error check on mbr being -ve
Message-ID: <20170622163449.23925-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

The error check of mbr < 0 is always false because mbr is a u32. Make
mbt an int so that a -ve error return from stm32_spi_prepare_mbr can be
detected.

Detected by CoverityScan, CID#1446586 ("Unsigned compared against 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b75909e7b117..82a6616f46b8 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -857,7 +857,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	}
 
 	if (spi->cur_speed != transfer->speed_hz) {
-		u32 mbr;
+		int mbr;
 
 		/* Update spi->cur_speed with real clock speed */
 		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz);
@@ -869,7 +869,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 		transfer->speed_hz = spi->cur_speed;
 
 		cfg1_clrb |= SPI_CFG1_MBR;
-		cfg1_setb |= (mbr << SPI_CFG1_MBR_SHIFT) & SPI_CFG1_MBR;
+		cfg1_setb |= ((u32)mbr << SPI_CFG1_MBR_SHIFT) & SPI_CFG1_MBR;
 	}
 
 	if (cfg1_clrb || cfg1_setb)
-- 
2.11.0
