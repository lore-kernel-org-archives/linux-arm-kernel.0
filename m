From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  9 Sep 2013 11:10:09 +0100
Subject: [PATCH 13/14] iio: sensors-core: st: Clean-up error handling in
 st_sensors_init_sensor()
In-Reply-To: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
References: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378721410-30937-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Strip out all those unnecessary gotos and just return the error right away.

Aids to simplicity and reduces code.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index eb261a5..05030e4 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -211,8 +211,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 		if (sdata->sensor->drdy_irq.mask_int1 == 0) {
 			dev_err(&indio_dev->dev,
 					"DRDY on INT1 not available.\n");
-			err = -EINVAL;
-			goto init_error;
+			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 1;
 		break;
@@ -220,42 +219,39 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 		if (sdata->sensor->drdy_irq.mask_int2 == 0) {
 			dev_err(&indio_dev->dev,
 					"DRDY on INT2 not available.\n");
-			err = -EINVAL;
-			goto init_error;
+			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 2;
 		break;
 	default:
 		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
-		err = -EINVAL;
-		goto init_error;
+		return -EINVAL;
 	}
 
 	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
-		goto init_error;
+		return err;
 
 	if (sdata->current_fullscale) {
 		err = st_sensors_set_fullscale(indio_dev,
 					       sdata->current_fullscale->num);
 		if (err < 0)
-			goto init_error;
+			return err;
 	} else
 		dev_info(&indio_dev->dev, "Full-scale not possible\n");
 
 	err = st_sensors_set_odr(indio_dev, sdata->odr);
 	if (err < 0)
-		goto init_error;
+		return err;
 
 	/* set BDU */
 	err = st_sensors_write_data_with_mask(indio_dev,
 			sdata->sensor->bdu.addr, sdata->sensor->bdu.mask, true);
 	if (err < 0)
-		goto init_error;
+		return err;
 
 	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 
-init_error:
 	return err;
 }
 EXPORT_SYMBOL(st_sensors_init_sensor);
-- 
1.8.1.2
