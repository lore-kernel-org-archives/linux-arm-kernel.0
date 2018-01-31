From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 31 Jan 2018 22:10:36 +0100
Subject: [PATCH] iio/adc: Delete an error message for a failed memory
 allocation in two functions
Message-ID: <0a3e6b48-f837-ce30-4adf-28ce5d885c24@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 31 Jan 2018 21:57:50 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/adc/at91_adc.c | 1 -
 drivers/iio/adc/max1027.c  | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 3836d4222a3e..ce37cfeb8d1c 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -912,7 +912,6 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 					sizeof(struct at91_adc_trigger),
 					GFP_KERNEL);
 	if (!st->trigger_list) {
-		dev_err(&idev->dev, "Could not allocate trigger list memory.\n");
 		ret = -ENOMEM;
 		goto error_ret;
 	}
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 375da6491499..74b305c775f2 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -425,10 +425,8 @@ static int max1027_probe(struct spi_device *spi)
 	st->buffer = devm_kmalloc(&indio_dev->dev,
 				  indio_dev->num_channels * 2,
 				  GFP_KERNEL);
-	if (st->buffer == NULL) {
-		dev_err(&indio_dev->dev, "Can't allocate buffer\n");
+	if (!st->buffer)
 		return -ENOMEM;
-	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
 					 &max1027_trigger_handler, NULL);
-- 
2.16.1
