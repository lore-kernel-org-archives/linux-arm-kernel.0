From: preid@electromag.com.au (Phil Reid)
Date: Thu,  2 Nov 2017 10:40:30 +0800
Subject: [PATCH v5 7/7] i2c: remove legacy integer scl/sda gpio for recovery
In-Reply-To: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
Message-ID: <1509590430-11968-8-git-send-email-preid@electromag.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove all reference to code related to using integer based ids for
scl/sda gpio for bus recovery. All in tree drivers are now using the
gpio descriptors to specific the required gpios.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-core-base.c | 78 ++-------------------------------------------
 include/linux/i2c.h         |  7 +---
 2 files changed, 3 insertions(+), 82 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index fdc6a9d..54ffc8d 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -147,46 +147,6 @@ static int get_sda_gpio_value(struct i2c_adapter *adap)
 	return gpiod_get_value_cansleep(adap->bus_recovery_info->sda_gpiod);
 }
 
-static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
-{
-	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
-	struct device *dev = &adap->dev;
-	int ret = 0;
-
-	ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
-			GPIOF_OUT_INIT_HIGH, "i2c-scl");
-	if (ret) {
-		dev_warn(dev, "Can't get SCL gpio: %d\n", bri->scl_gpio);
-		return ret;
-	}
-	bri->scl_gpiod = gpio_to_desc(bri->scl_gpio);
-
-	if (bri->get_sda) {
-		if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
-			/* work without SDA polling */
-			dev_warn(dev, "Can't get SDA gpio: %d. Not using SDA polling\n",
-					bri->sda_gpio);
-			bri->get_sda = NULL;
-		}
-		bri->sda_gpiod = gpio_to_desc(bri->sda_gpio);
-	}
-
-	return ret;
-}
-
-static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
-{
-	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
-
-	if (bri->get_sda) {
-		gpio_free(bri->sda_gpio);
-		bri->sda_gpiod = NULL;
-	}
-
-	gpio_free(bri->scl_gpio);
-	bri->scl_gpiod = NULL;
-}
-
 /*
  * We are generating clock pulses. ndelay() determines durating of clk pulses.
  * We will generate clock with rate 100 KHz and so duration of both clock levels
@@ -195,7 +155,7 @@ static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
 #define RECOVERY_NDELAY		5000
 #define RECOVERY_CLK_CNT	9
 
-static int i2c_generic_recovery(struct i2c_adapter *adap)
+int i2c_generic_scl_recovery(struct i2c_adapter *adap)
 {
 	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 	int i = 0, val = 1, ret = 0;
@@ -237,28 +197,8 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
 
 	return ret;
 }
-
-int i2c_generic_scl_recovery(struct i2c_adapter *adap)
-{
-	return i2c_generic_recovery(adap);
-}
 EXPORT_SYMBOL_GPL(i2c_generic_scl_recovery);
 
-int i2c_generic_gpio_recovery(struct i2c_adapter *adap)
-{
-	int ret;
-
-	ret = i2c_get_gpios_for_recovery(adap);
-	if (ret)
-		return ret;
-
-	ret = i2c_generic_recovery(adap);
-	i2c_put_gpios_for_recovery(adap);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(i2c_generic_gpio_recovery);
-
 int i2c_recover_bus(struct i2c_adapter *adap)
 {
 	if (!adap->bus_recovery_info)
@@ -290,21 +230,7 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
 		return;
 	}
 
-	/* Generic GPIO recovery */
-	if (bri->recover_bus == i2c_generic_gpio_recovery) {
-		if (!gpio_is_valid(bri->scl_gpio)) {
-			err_str = "invalid SCL gpio";
-			goto err;
-		}
-
-		if (gpio_is_valid(bri->sda_gpio))
-			bri->get_sda = get_sda_gpio_value;
-		else
-			bri->get_sda = NULL;
-
-		bri->get_scl = get_scl_gpio_value;
-		bri->set_scl = set_scl_gpio_value;
-	} else if (bri->recover_bus == i2c_generic_scl_recovery) {
+	if (bri->recover_bus == i2c_generic_scl_recovery) {
 		/* Generic SCL recovery */
 		if (!bri->set_scl || !bri->get_scl) {
 			err_str = "no {get|set}_scl() found";
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 25d5db5..8597eac 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -485,7 +485,7 @@ struct i2c_timings {
 /**
  * struct i2c_bus_recovery_info - I2C bus recovery information
  * @recover_bus: Recover routine. Either pass driver's recover_bus() routine, or
- *	i2c_generic_scl_recovery() or i2c_generic_gpio_recovery().
+ *	i2c_generic_scl_recovery().
  * @get_scl: This gets current value of SCL line. Mandatory for generic SCL
  *      recovery. Used internally for generic GPIO recovery.
  * @set_scl: This sets/clears SCL line. Mandatory for generic SCL recovery. Used
@@ -497,8 +497,6 @@ struct i2c_timings {
  *	configure padmux here for SDA/SCL line or something else they want.
  * @unprepare_recovery: This will be called after completing recovery. Platform
  *	may configure padmux here for SDA/SCL line or something else they want.
- * @scl_gpio: gpio number of the SCL line. Only required for GPIO recovery.
- * @sda_gpio: gpio number of the SDA line. Only required for GPIO recovery.
  * @scl_gpiod: gpiod of the SCL line. Only required for GPIO recovery.
  * @sda_gpiod: gpiod of the SDA line. Only required for GPIO recovery.
  */
@@ -513,8 +511,6 @@ struct i2c_bus_recovery_info {
 	void (*unprepare_recovery)(struct i2c_adapter *);
 
 	/* gpio recovery */
-	int scl_gpio;
-	int sda_gpio;
 	struct gpio_desc *scl_gpiod;
 	struct gpio_desc *sda_gpiod;
 };
@@ -522,7 +518,6 @@ struct i2c_bus_recovery_info {
 int i2c_recover_bus(struct i2c_adapter *adap);
 
 /* Generic recovery routines */
-int i2c_generic_gpio_recovery(struct i2c_adapter *adap);
 int i2c_generic_scl_recovery(struct i2c_adapter *adap);
 
 /**
-- 
1.8.3.1
