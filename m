From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:22 +0100
Subject: [PATCH 21/38] iio: sensors-core: st: Clean-up error handling in
 st_sensors_read_axis_data()
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-22-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gets rid of those unnecessary gotos.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 8c4c54c..148f0e5 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -331,26 +331,23 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	unsigned int byte_for_channel = ch->scan_type.storagebits >> 3;
 
 	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
-	if (!outdata) {
-		err = -EINVAL;
-		goto st_sensors_read_axis_data_error;
-	}
+	if (!outdata)
+		return -ENOMEM;
 
 	err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
 				ch->address, byte_for_channel,
 				outdata, sdata->multiread_bit);
-	if (err < 0)
-		goto st_sensors_free_memory;
+	if (err < 0) {
+		kfree(outdata);
+		return err;
+	}
 
 	if (byte_for_channel == 2)
 		*data = (s16)get_unaligned_le16(outdata);
 	else if (byte_for_channel == 3)
 		*data = (s32)st_sensors_get_unaligned_le24(outdata);
 
-st_sensors_free_memory:
-	kfree(outdata);
-st_sensors_read_axis_data_error:
-	return err;
+	return 0;
 }
 
 int st_sensors_read_info_raw(struct iio_dev *indio_dev,
-- 
1.8.1.2
