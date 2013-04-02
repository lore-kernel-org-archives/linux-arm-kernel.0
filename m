From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:45 -0700
Subject: [PATCH V2 02/12] spi/mxs: Remove mxs_spi_enable and mxs_spi_disable
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-2-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These functions do nothing but one single writel call and are only
called in once.  And the names really aren't accurate or clear, since
they don't enable or disble SPI.  Rather they set the bit that
controls the state of CS at the end of transfer.  It easier to follow
the code to just set this bit with a writel() along with all the other
bits.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 9334167..7eb4bc9 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -157,22 +157,6 @@ static void mxs_spi_set_cs(struct mxs_spi *spi, unsigned cs)
 	writel(select, ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 }
 
-static inline void mxs_spi_enable(struct mxs_spi *spi)
-{
-	struct mxs_ssp *ssp = &spi->ssp;
-
-	writel(BM_SSP_CTRL0_IGNORE_CRC,
-		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
-}
-
-static inline void mxs_spi_disable(struct mxs_spi *spi)
-{
-	struct mxs_ssp *ssp = &spi->ssp;
-
-	writel(BM_SSP_CTRL0_IGNORE_CRC,
-		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
-}
-
 static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool set)
 {
 	const unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
@@ -346,14 +330,16 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 {
 	struct mxs_ssp *ssp = &spi->ssp;
 
-	if (*first)
-		mxs_spi_enable(spi);
+	/* Clear this now, set it on last transfer if needed */
+	writel(BM_SSP_CTRL0_IGNORE_CRC,
+	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 
 	mxs_spi_set_cs(spi, cs);
 
 	while (len--) {
 		if (*last && len == 0)
-			mxs_spi_disable(spi);
+			writel(BM_SSP_CTRL0_IGNORE_CRC,
+			       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 
 		if (ssp->devid == IMX23_SSP) {
 			writel(BM_SSP_CTRL0_XFER_COUNT,
-- 
1.7.10.4
