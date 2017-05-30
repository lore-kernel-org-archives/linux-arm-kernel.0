From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 30 May 2017 16:35:27 +0530
Subject: [PATCH] iio:adc:lpc32xx Handle return value of clk_prepare_enable
Message-ID: <e54764708d74134ef1f5b3566b2d4d3ab4187b45.1496045161.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iio/adc/lpc32xx_adc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index 0de709b..6a5b9a9 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -76,10 +76,14 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct lpc32xx_adc_state *st = iio_priv(indio_dev);
-
+	int ret;
 	if (mask == IIO_CHAN_INFO_RAW) {
 		mutex_lock(&indio_dev->mlock);
-		clk_prepare_enable(st->clk);
+		ret = clk_prepare_enable(st->clk);
+		if (ret) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
 		/* Measurement setup */
 		__raw_writel(LPC32XXAD_INTERNAL | (chan->address) |
 			     LPC32XXAD_REFp | LPC32XXAD_REFm,
-- 
1.9.1
