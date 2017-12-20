From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Dec 2017 13:17:49 +0100
Subject: [PATCH v2] i2c/ARM: davinci: Deep refactoring of I2C recovery
Message-ID: <20171220121749.12064-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alter the DaVinci GPIO recovery fetch to use descriptors
all the way down into the board files.

Cc: arm at kernel.org
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
Tested-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Change gpiochip name from gpio_davinci.0 to gpio_davinci, simply.
---
 arch/arm/mach-davinci/board-dm355-evm.c   | 15 +++++++++++++--
 arch/arm/mach-davinci/board-dm644x-evm.c  | 15 +++++++++++++--
 drivers/i2c/busses/i2c-davinci.c          | 21 +++++++++++----------
 include/linux/platform_data/i2c-davinci.h |  5 ++---
 4 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 62e7bc3018f0..e457f299cd44 100644
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
+		GPIO_LOOKUP("davinci_gpio", 15, "sda",
+			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		GPIO_LOOKUP("davinci_gpio", 14, "scl",
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
index b07c9b18d427..85e6fb33b1ee 100644
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
+		GPIO_LOOKUP("davinci_gpio", 44, "sda",
+			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		GPIO_LOOKUP("davinci_gpio", 43, "scl",
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
index 2afb12a89eb3..cb24a3ffdfa2 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -33,7 +33,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/cpufreq.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_device.h>
 #include <linux/platform_data/i2c-davinci.h>
 #include <linux/pm_runtime.h>
@@ -869,19 +869,20 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	if (dev->pdata->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;
-	else if (dev->pdata->scl_pin) {
+	else if (dev->pdata->gpio_recovery) {
 		rinfo =  &davinci_i2c_gpio_recovery_info;
 		adap->bus_recovery_info = rinfo;
-		r = gpio_request_one(dev->pdata->scl_pin, GPIOF_OPEN_DRAIN |
-				     GPIOF_OUT_INIT_HIGH, "i2c-scl");
-		if (r)
+		rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl",
+						  GPIOD_OUT_HIGH_OPEN_DRAIN);
+		if (IS_ERR(rinfo->scl_gpiod)) {
+			r = PTR_ERR(rinfo->scl_gpiod);
 			goto err_unuse_clocks;
-		rinfo->scl_gpiod = gpio_to_desc(dev->pdata->scl_pin);
-
-		r = gpio_request_one(dev->pdata->sda_pin, GPIOF_IN, "i2c-sda");
-		if (r)
+		}
+		rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
+		if (IS_ERR(rinfo->sda_gpiod)) {
+			r = PTR_ERR(rinfo->sda_gpiod);
 			goto err_unuse_clocks;
-		rinfo->sda_gpiod = gpio_to_desc(dev->pdata->scl_pin);
+		}
 	}
 
 	adap->nr = pdev->id;
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
