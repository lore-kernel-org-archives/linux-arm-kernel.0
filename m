From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 14 Apr 2016 15:48:26 +0000
Subject: [PATCH RFT 2/5] iio: mxs-lradc: move TS config into suitable function
In-Reply-To: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1460648909-2657-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the touchscreen type configuration into
a more suitable function. Btw this simplifies PM ops later.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/iio/adc/mxs-lradc.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index 0576953..7118fca 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -686,6 +686,17 @@ static void mxs_lradc_prepare_pressure(struct mxs_lradc *lradc)
 
 static void mxs_lradc_enable_touch_detection(struct mxs_lradc *lradc)
 {
+	/* Configure the touchscreen type */
+	if (lradc->soc == IMX28_LRADC) {
+		mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
+				    LRADC_CTRL0);
+
+		if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
+			mxs_lradc_reg_set(lradc,
+					  LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
+					  LRADC_CTRL0);
+	}
+
 	mxs_lradc_setup_touch_detection(lradc);
 
 	lradc->cur_plate = LRADC_TOUCH;
@@ -1491,16 +1502,6 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
 	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(2));
 	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(3));
 
-	/* Configure the touchscreen type */
-	if (lradc->soc == IMX28_LRADC) {
-		mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
-				    LRADC_CTRL0);
-
-	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
-		mxs_lradc_reg_set(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
-				  LRADC_CTRL0);
-	}
-
 	/* Start internal temperature sensing. */
 	mxs_lradc_reg_wrt(lradc, 0, LRADC_CTRL2);
 
-- 
1.7.9.5
