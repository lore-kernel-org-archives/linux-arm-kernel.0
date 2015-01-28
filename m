From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:58:44 +0100
Subject: [PATCH] iio: ak8975: fix AK09911 dependencies
Message-ID: <7968545.0Cq9DcaG85@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ak8975 depends on I2C and GPIOLIB, so any symbols that selects
ak8975 must have the same dependency, or we get build errors:

drivers/iio/magnetometer/ak8975.c: In function 'ak8975_who_i_am':
drivers/iio/magnetometer/ak8975.c:393:2: error: implicit declaration of function 'i2c_smbus_read_i2c_block_data' [-Werror=implicit-function-declaration]
  ret = i2c_smbus_read_i2c_block_data(client, AK09912_REG_WIA1,
  ^
drivers/iio/magnetometer/ak8975.c: In function 'ak8975_set_mode':
drivers/iio/magnetometer/ak8975.c:431:2: error: implicit declaration of function 'i2c_smbus_write_byte_data' [-Werror=implicit-function-declaration]
  ret = i2c_smbus_write_byte_data(data->client,

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 57e73a423b1e85 ("iio: ak8975: add ak09911 and ak09912 support")
---
I found this recent regression doing ARM randconfig builds, please apply

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 4c7a4c52dd06..a5d6de72c523 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -18,6 +18,8 @@ config AK8975
 
 config AK09911
 	tristate "Asahi Kasei AK09911 3-axis Compass"
+	depends on I2C
+	depends on GPIOLIB
 	select AK8975
 	help
 	  Deprecated: AK09911 is now supported by AK8975 driver.
