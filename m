From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 14 Apr 2016 15:48:27 +0000
Subject: [PATCH RFT 3/5] iio: mxs-lradc: move STMP reset out of ADC init
In-Reply-To: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1460648909-2657-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the STMP reset out of ADC init function
in order to make it never fail. This is also necessary
for PM ops.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/iio/adc/mxs-lradc.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index 7118fca..95d84c9 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -1482,18 +1482,13 @@ static const struct iio_chan_spec mx28_lradc_chan_spec[] = {
 	MXS_ADC_CHAN(15, IIO_VOLTAGE, "VDD5V"),
 };
 
-static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
+static void mxs_lradc_hw_init(struct mxs_lradc *lradc)
 {
 	/* The ADC always uses DELAY CHANNEL 0. */
 	const u32 adc_cfg =
 		(1 << (LRADC_DELAY_TRIGGER_DELAYS_OFFSET + 0)) |
 		(LRADC_DELAY_TIMER_PER << LRADC_DELAY_DELAY_OFFSET);
 
-	int ret = stmp_reset_block(lradc->base);
-
-	if (ret)
-		return ret;
-
 	/* Configure DELAY CHANNEL 0 for generic ADC sampling. */
 	mxs_lradc_reg_wrt(lradc, adc_cfg, LRADC_DELAY(0));
 
@@ -1504,8 +1499,6 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
 
 	/* Start internal temperature sensing. */
 	mxs_lradc_reg_wrt(lradc, 0, LRADC_CTRL2);
-
-	return 0;
 }
 
 static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
@@ -1705,11 +1698,13 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Configure the hardware. */
-	ret = mxs_lradc_hw_init(lradc);
+	ret = stmp_reset_block(lradc->base);
 	if (ret)
 		goto err_dev;
 
+	/* Configure the hardware. */
+	mxs_lradc_hw_init(lradc);
+
 	/* Register the touchscreen input device. */
 	if (touch_ret == 0) {
 		ret = mxs_lradc_ts_register(lradc);
-- 
1.7.9.5
