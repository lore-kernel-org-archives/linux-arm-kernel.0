From: marex@denx.de (Marek Vasut)
Date: Tue,  4 Sep 2012 04:40:17 +0200
Subject: [PATCH 3/4] mxs/spi: Decrement the DMA/PIO border
In-Reply-To: <1346726418-2856-1-git-send-email-marex@denx.de>
References: <1346726418-2856-1-git-send-email-marex@denx.de>
Message-ID: <1346726418-2856-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver checks the length of transfer to be made and based
on this information, either chooses to transfer data via DMA or
PIO. Decrement this border further to gain better performace eg.
during SPI flash writes.

Empiric measurement shows that this gives extra 3kB/s write speed
with a M25P80 flash clocked at 40MHz.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 282bdd7..6650ded 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -445,7 +445,7 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		 * DMA only: 2.164808 seconds, 473.0KB/s
 		 * Combined: 1.676276 seconds, 610.9KB/s
 		 */
-		if (t->len <= 256) {
+		if (t->len < 32) {
 			writel(BM_SSP_CTRL1_DMA_ENABLE,
 				ssp->base + HW_SSP_CTRL1(ssp) +
 				STMP_OFFSET_REG_CLR);
-- 
1.7.10.4
