From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 21 Apr 2016 20:11:16 +0000
Subject: [PATCH RFT V2 1/3] iio: mxs-lradc: simplify TS registration
In-Reply-To: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com>
References: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1461269478-449-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simplifies the TS registration of mxs-lradc by
using devm_input_allocate_device.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/iio/adc/mxs-lradc.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index ad26da1..223650b 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -1120,12 +1120,11 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
 {
 	struct input_dev *input;
 	struct device *dev = lradc->dev;
-	int ret;
 
 	if (!lradc->use_touchscreen)
 		return 0;
 
-	input = input_allocate_device();
+	input = devm_input_allocate_device(dev);
 	if (!input)
 		return -ENOMEM;
 
@@ -1146,11 +1145,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
 
 	lradc->ts_input = input;
 	input_set_drvdata(input, lradc);
-	ret = input_register_device(input);
-	if (ret)
-		input_free_device(lradc->ts_input);
 
-	return ret;
+	return input_register_device(input);
 }
 
 static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
@@ -1159,7 +1155,6 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
 		return;
 
 	mxs_lradc_disable_ts(lradc);
-	input_unregister_device(lradc->ts_input);
 }
 
 /*
-- 
1.7.9.5
