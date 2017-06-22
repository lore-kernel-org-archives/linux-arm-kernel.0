From: colin.king@canonical.com (Colin King)
Date: Thu, 22 Jun 2017 16:41:42 +0100
Subject: [PATCH][spi-next] spi: stm32: fix range limit checks on div
Message-ID: <20170622154142.22481-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check for range limits on div is incorrect and will
never return -EINVAL. Fix this by replacing && with ||

Detected by CoverityScan, CID#1446580 ("Structurally dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 0553f61ab3b7..b75909e7b117 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -262,7 +262,7 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
 	 * no need to check it there.
 	 * However, we need to ensure the following calculations.
 	 */
-	if ((div < SPI_MBR_DIV_MIN) &&
+	if ((div < SPI_MBR_DIV_MIN) ||
 	    (div > SPI_MBR_DIV_MAX))
 		return -EINVAL;
 
-- 
2.11.0
