From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:23 +0100
Subject: [PATCH 22/38] iio: sensors-core: st: Clean-up error handling in
 st_sensors_read_info_raw()
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378817379-8238-23-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Saving a few lines of code.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 148f0e5..25d4c7e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -359,28 +359,25 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
 		err = -EBUSY;
-		goto read_error;
+		goto out;
 	} else {
 		err = st_sensors_set_enable(indio_dev, true);
 		if (err < 0)
-			goto read_error;
+			goto out;
 
 		msleep((sdata->sensor->bootime * 1000) / sdata->odr);
 		err = st_sensors_read_axis_data(indio_dev, ch, val);
 		if (err < 0)
-			goto read_error;
+			goto out;
 
 		*val = *val >> ch->scan_type.shift;
 
 		err = st_sensors_set_enable(indio_dev, false);
 	}
+out:
 	mutex_unlock(&indio_dev->mlock);
 
 	return err;
-
-read_error:
-	mutex_unlock(&indio_dev->mlock);
-	return err;
 }
 EXPORT_SYMBOL(st_sensors_read_info_raw);
 
-- 
1.8.1.2
