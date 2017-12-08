From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  8 Dec 2017 11:20:02 +0100
Subject: [PATCH] i2c: core: Use GPIO descriptors for recovery
Message-ID: <20171208102002.26456-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C core contains code for handling a fallback recovery
using GPIO when a piece of I2C hardware fails in duty.

This code passes GPIO numbers from the global GPIO
numberspace around and we want to get rid of this and use
GPIO descriptors associated with the devices.

After some digging it turns out that there are two users
of the mechanism in the entire kernel:

- i.MX that simply define "scl-gpios" and "sda-gpios" in
  the device tree which is already creating descriptors
  associated with the device, that we can pick up and use.

- Two DaVinci boards that pass the SCL and SDA GPIOs using
  custom platform data.

Refactor the core to grab the SCL and SDA GPIO descriptors
on-demand when doing recovery, and release them when
recovery is done. Grab the named descriptors "scl" and
"sda" which will make the i.MX method work out of the
box.

Augment the two DaVinci board files to pass descriptors
using static tables.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
It would be great to have this tested on i.MX and
DaVinci, or at least ACKed by the maintainers.
---
 arch/arm/mach-davinci/board-dm355-evm.c   | 15 +++++++--
 arch/arm/mach-davinci/board-dm644x-evm.c  | 15 +++++++--
 drivers/i2c/busses/i2c-davinci.c          |  4 +--
 drivers/i2c/busses/i2c-imx.c              | 12 ++------
 drivers/i2c/i2c-core-base.c               | 51 +++++++++++++------------------
 include/linux/i2c.h                       |  9 +++---
 include/linux/platform_data/i2c-davinci.h |  5 ++-
 7 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 62e7bc3018f0..60aec5437276 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/i2c.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/clk.h>
 #include <linux/videodev2.h>
 #include <media/i2c/tvp514x.h>
@@ -108,11 +109,20 @@ static struct platform_device davinci_nand_device = {
 	},
 };
 
+static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
+	.dev_id = "i2c_davinci",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio.0", 15, "sda",
+			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		GPIO_LOOKUP("davinci_gpio.0", 14, "scl",
+			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+	},
+};
+
 static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_freq	= 400	/* kHz */,
 	.bus_delay	= 0	/* usec */,
-	.sda_pin        = 15,
-	.scl_pin        = 14,
+	.gpio_recovery	= true,
 };
 
 static int dm355evm_mmc_gpios = -EINVAL;
@@ -141,6 +151,7 @@ static struct i2c_board_info dm355evm_i2c_info[] = {
 
 static void __init evm_init_i2c(void)
 {
+	gpiod_add_lookup_table(&i2c_recovery_gpiod_table);
 	davinci_init_i2c(&i2c_pdata);
 
 	gpio_request(5, "dm355evm_msp");
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index b07c9b18d427..2efc6dbc5ac0 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/at24.h>
@@ -595,18 +596,28 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	},
 };
 
+static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
+	.dev_id = "i2c_davinci",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio.0", 44, "sda",
+			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		GPIO_LOOKUP("davinci_gpio.0", 43, "scl",
+			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+	},
+};
+
 /* The msp430 uses a slow bitbanged I2C implementation (ergo 20 KHz),
  * which requires 100 usec of idle bus after i2c writes sent to it.
  */
 static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_freq	= 20 /* kHz */,
 	.bus_delay	= 100 /* usec */,
-	.sda_pin        = 44,
-	.scl_pin        = 43,
+	.gpio_recovery	= true,
 };
 
 static void __init evm_init_i2c(void)
 {
+	gpiod_add_lookup_table(&i2c_recovery_gpiod_table);
 	davinci_init_i2c(&i2c_pdata);
 	i2c_add_driver(&dm6446evm_msp_driver);
 	i2c_register_board_info(1, i2c_info, ARRAY_SIZE(i2c_info));
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 2ead9b9eebb7..5fae5daba946 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -868,10 +868,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	if (dev->pdata->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;
-	else if (dev->pdata->scl_pin) {
+	else if (dev->pdata->gpio_recovery) {
 		adap->bus_recovery_info = &davinci_i2c_gpio_recovery_info;
-		adap->bus_recovery_info->scl_gpio = dev->pdata->scl_pin;
-		adap->bus_recovery_info->sda_gpio = dev->pdata->sda_pin;
 	}
 
 	adap->nr = pdev->id;
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index f96830ffd9f1..f2e47ba2922f 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -46,7 +46,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
-#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/i2c-imx.h>
 #include <linux/platform_device.h>
@@ -1006,15 +1005,8 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 			PINCTRL_STATE_DEFAULT);
 	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
 			"gpio");
-	rinfo->sda_gpio = of_get_named_gpio(pdev->dev.of_node, "sda-gpios", 0);
-	rinfo->scl_gpio = of_get_named_gpio(pdev->dev.of_node, "scl-gpios", 0);
-
-	if (rinfo->sda_gpio == -EPROBE_DEFER ||
-	    rinfo->scl_gpio == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (!gpio_is_valid(rinfo->sda_gpio) ||
-		   !gpio_is_valid(rinfo->scl_gpio) ||
-		   IS_ERR(i2c_imx->pinctrl_pins_default) ||
+
+	if (IS_ERR(i2c_imx->pinctrl_pins_default) ||
 		   IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
 		dev_dbg(&pdev->dev, "recovery information incomplete\n");
 		return 0;
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 706164b4c5be..004bb83d6705 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -27,7 +27,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/i2c-smbus.h>
 #include <linux/idr.h>
@@ -134,42 +134,45 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 /* i2c bus recovery routines */
 static int get_scl_gpio_value(struct i2c_adapter *adap)
 {
-	return gpio_get_value(adap->bus_recovery_info->scl_gpio);
+	return gpiod_get_value(adap->bus_recovery_info->scl_gpio);
 }
 
 static void set_scl_gpio_value(struct i2c_adapter *adap, int val)
 {
-	gpio_set_value(adap->bus_recovery_info->scl_gpio, val);
+	gpiod_set_value(adap->bus_recovery_info->scl_gpio, val);
 }
 
 static int get_sda_gpio_value(struct i2c_adapter *adap)
 {
-	return gpio_get_value(adap->bus_recovery_info->sda_gpio);
+	return gpiod_get_value(adap->bus_recovery_info->sda_gpio);
 }
 
 static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
 {
 	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 	struct device *dev = &adap->dev;
-	int ret = 0;
+	int ret;
 
-	ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
-			GPIOF_OUT_INIT_HIGH, "i2c-scl");
-	if (ret) {
-		dev_warn(dev, "Can't get SCL gpio: %d\n", bri->scl_gpio);
-		return ret;
+	bri->scl_gpio = gpiod_get(dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
+	if (IS_ERR(bri->scl_gpio)) {
+		dev_warn(dev, "Can't get SCL gpio\n");
+		return PTR_ERR(bri->scl_gpio);
 	}
 
-	if (bri->get_sda) {
-		if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
-			/* work without SDA polling */
-			dev_warn(dev, "Can't get SDA gpio: %d. Not using SDA polling\n",
-					bri->sda_gpio);
-			bri->get_sda = NULL;
+	bri->sda_gpio = gpiod_get(dev, "sda", GPIOD_IN);
+	if (IS_ERR(bri->sda_gpio)) {
+		/* Work without SDA polling */
+		bri->get_sda = NULL;
+		ret = PTR_ERR(bri->sda_gpio);
+		if (ret != -ENOENT) {
+			dev_warn(dev,
+				 "Can't get SDA gpio. Not using SDA polling\n");
 		}
+	} else {
+		bri->get_sda = get_sda_gpio_value;
 	}
 
-	return ret;
+	return 0;
 }
 
 static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
@@ -177,9 +180,9 @@ static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
 	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 
 	if (bri->get_sda)
-		gpio_free(bri->sda_gpio);
+		gpiod_put(bri->sda_gpio);
 
-	gpio_free(bri->scl_gpio);
+	gpiod_put(bri->scl_gpio);
 }
 
 /*
@@ -279,16 +282,6 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
 
 	/* Generic GPIO recovery */
 	if (bri->recover_bus == i2c_generic_gpio_recovery) {
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
 		bri->get_scl = get_scl_gpio_value;
 		bri->set_scl = set_scl_gpio_value;
 	} else if (bri->recover_bus == i2c_generic_scl_recovery) {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 0f774406fad0..e1549be3aa42 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -34,6 +34,7 @@
 #include <linux/irqdomain.h>		/* for Host Notify IRQ */
 #include <linux/of.h>		/* for struct device_node */
 #include <linux/swab.h>		/* for swab16 */
+#include <linux/gpio/consumer.h>
 #include <uapi/linux/i2c.h>
 
 extern struct bus_type i2c_bus_type;
@@ -497,8 +498,8 @@ struct i2c_timings {
  *	configure padmux here for SDA/SCL line or something else they want.
  * @unprepare_recovery: This will be called after completing recovery. Platform
  *	may configure padmux here for SDA/SCL line or something else they want.
- * @scl_gpio: gpio number of the SCL line. Only required for GPIO recovery.
- * @sda_gpio: gpio number of the SDA line. Only required for GPIO recovery.
+ * @scl_gpio: gpio descriptor for the SCL line. Optional for GPIO recovery.
+ * @sda_gpio: gpio descriptor for the SDA line. Optional for GPIO recovery.
  */
 struct i2c_bus_recovery_info {
 	int (*recover_bus)(struct i2c_adapter *);
@@ -511,8 +512,8 @@ struct i2c_bus_recovery_info {
 	void (*unprepare_recovery)(struct i2c_adapter *);
 
 	/* gpio recovery */
-	int scl_gpio;
-	int sda_gpio;
+	struct gpio_desc *scl_gpio;
+	struct gpio_desc *sda_gpio;
 };
 
 int i2c_recover_bus(struct i2c_adapter *adap);
diff --git a/include/linux/platform_data/i2c-davinci.h b/include/linux/platform_data/i2c-davinci.h
index 89fd34727a24..98967df07468 100644
--- a/include/linux/platform_data/i2c-davinci.h
+++ b/include/linux/platform_data/i2c-davinci.h
@@ -16,9 +16,8 @@
 struct davinci_i2c_platform_data {
 	unsigned int	bus_freq;	/* standard bus frequency (kHz) */
 	unsigned int	bus_delay;	/* post-transaction delay (usec) */
-	unsigned int    sda_pin;        /* GPIO pin ID to use for SDA */
-	unsigned int    scl_pin;        /* GPIO pin ID to use for SCL */
-	bool		has_pfunc;	/*chip has a ICPFUNC register */
+	bool		gpio_recovery;	/* Use GPIO recovery method */
+	bool		has_pfunc;	/* Chip has a ICPFUNC register */
 };
 
 /* for board setup code */
-- 
2.14.3
