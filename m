From: preid@electromag.com.au (Phil Reid)
Date: Thu,  2 Nov 2017 10:40:24 +0800
Subject: [PATCH v5 1/7] i2c: Switch to using gpiod interface for gpio bus
 recovery
In-Reply-To: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
Message-ID: <1509590430-11968-2-git-send-email-preid@electromag.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the i2c gpio recovery code uses gpio integer interface
instead of the gpiod. This change switch the core code to use
the gpiod while still retaining compatibility with the gpio integer
interface. This will allow individual driver to be updated and tested
individual to switch to using the gpiod interface.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-core-base.c | 21 +++++++++++++++++----
 include/linux/i2c.h         |  4 ++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 706164b..fdc6a9d 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -134,17 +134,17 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 /* i2c bus recovery routines */
 static int get_scl_gpio_value(struct i2c_adapter *adap)
 {
-	return gpio_get_value(adap->bus_recovery_info->scl_gpio);
+	return gpiod_get_value_cansleep(adap->bus_recovery_info->scl_gpiod);
 }
 
 static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
 {
-	gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
+	gpiod_set_value_cansleep(adap->bus_recovery_info->scl_gpiod, val);
 }
 
 static int get_sda_gpio_value(struct i2c_adapter *adap)
 {
-	return gpio_get_value(adap->bus_recovery_info->sda_gpio);
+	return gpiod_get_value_cansleep(adap->bus_recovery_info->sda_gpiod);
 }
 
 static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
@@ -159,6 +159,7 @@ static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
 		dev_warn(dev, "Can't get SCL gpio: %d\n", bri->scl_gpio);
 		return ret;
 	}
+	bri->scl_gpiod = gpio_to_desc(bri->scl_gpio);
 
 	if (bri->get_sda) {
 		if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
@@ -167,6 +168,7 @@ static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
 					bri->sda_gpio);
 			bri->get_sda = NULL;
 		}
+		bri->sda_gpiod = gpio_to_desc(bri->sda_gpio);
 	}
 
 	return ret;
@@ -176,10 +178,13 @@ static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
 {
 	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 
-	if (bri->get_sda)
+	if (bri->get_sda) {
 		gpio_free(bri->sda_gpio);
+		bri->sda_gpiod = NULL;
+	}
 
 	gpio_free(bri->scl_gpio);
+	bri->scl_gpiod = NULL;
 }
 
 /*
@@ -277,6 +282,14 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
 		goto err;
 	}
 
+	if (bri->scl_gpiod && bri->recover_bus == i2c_generic_scl_recovery) {
+		bri->get_scl = get_scl_gpio_value;
+		bri->set_scl = set_scl_gpio_value;
+		if (bri->sda_gpiod)
+			bri->get_sda = get_sda_gpio_value;
+		return;
+	}
+
 	/* Generic GPIO recovery */
 	if (bri->recover_bus == i2c_generic_gpio_recovery) {
 		if (!gpio_is_valid(bri->scl_gpio)) {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 0f77440..25d5db5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -499,6 +499,8 @@ struct i2c_timings {
  *	may configure padmux here for SDA/SCL line or something else they want.
  * @scl_gpio: gpio number of the SCL line. Only required for GPIO recovery.
  * @sda_gpio: gpio number of the SDA line. Only required for GPIO recovery.
+ * @scl_gpiod: gpiod of the SCL line. Only required for GPIO recovery.
+ * @sda_gpiod: gpiod of the SDA line. Only required for GPIO recovery.
  */
 struct i2c_bus_recovery_info {
 	int (*recover_bus)(struct i2c_adapter *);
@@ -513,6 +515,8 @@ struct i2c_bus_recovery_info {
 	/* gpio recovery */
 	int scl_gpio;
 	int sda_gpio;
+	struct gpio_desc *scl_gpiod;
+	struct gpio_desc *sda_gpiod;
 };
 
 int i2c_recover_bus(struct i2c_adapter *adap);
-- 
1.8.3.1
