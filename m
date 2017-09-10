From: chris.gekas@gmail.com (Christos Gkekas)
Date: Sun, 10 Sep 2017 14:55:29 +0100
Subject: [PATCH] spi: stm32: Fix logical error in stm32_spi_prepare_mbr()
Message-ID: <1505051729-22270-1-git-send-email-chris.gekas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32_spi_prepare_mbr() is returning an error value when div is less
than SPI_MBR_DIV_MIN *and* greater than SPI_MBR_DIV_MAX, which always
evaluates to false. This should change to use *or*.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 drivers/spi/spi-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 680cdf5..ba9743f 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -263,8 +263,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
 	 * no need to check it there.
 	 * However, we need to ensure the following calculations.
 	 */
-	if ((div < SPI_MBR_DIV_MIN) &&
-	    (div > SPI_MBR_DIV_MAX))
+	if (div < SPI_MBR_DIV_MIN ||
+	    div > SPI_MBR_DIV_MAX)
 		return -EINVAL;
 
 	/* Determine the first power of 2 greater than or equal to div */
-- 
2.7.4
