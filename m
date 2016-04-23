From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 23 Apr 2016 19:57:59 +0000
Subject: [PATCH V3 3/3] iio: mxs-lradc: disable only masked channels in
 mxs_lradc_hw_stop
In-Reply-To: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
References: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1461441479-23218-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disabling of the touchscreen IRQs should be done in
mxs_lradc_disable_ts. So disable only the masked virtual channels
in mxs_lradc_hw_stop and finally remove the unused function
mxs_lradc_irq_en_mask.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Tested-by: Marek Vasut <marex@denx.de>
---
 drivers/iio/adc/mxs-lradc.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index 90242ba..b84d37c 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -373,13 +373,6 @@ static u32 mxs_lradc_plate_mask(struct mxs_lradc *lradc)
 	return LRADC_CTRL0_MX28_PLATE_MASK;
 }
 
-static u32 mxs_lradc_irq_en_mask(struct mxs_lradc *lradc)
-{
-	if (lradc->soc == IMX23_LRADC)
-		return LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK;
-	return LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK;
-}
-
 static u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
 {
 	if (lradc->soc == IMX23_LRADC)
@@ -1496,7 +1489,9 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
 {
 	int i;
 
-	mxs_lradc_reg_clear(lradc, mxs_lradc_irq_en_mask(lradc), LRADC_CTRL1);
+	mxs_lradc_reg_clear(lradc,
+		lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
+		LRADC_CTRL1);
 
 	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
 		mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(i));
-- 
1.7.9.5
