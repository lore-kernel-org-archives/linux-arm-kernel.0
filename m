From: preid@electromag.com.au (Phil Reid)
Date: Tue, 31 Oct 2017 15:33:58 +0800
Subject: [PATCH v4 6/7] i2c: davinci: switch to using gpiod for bus recovery
 gpios
In-Reply-To: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
Message-ID: <1509435239-64848-7-git-send-email-preid@electromag.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the driver to use the gpio descriptors for the bus recovery
information instead of the deprecated integer interface.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/busses/i2c-davinci.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 2ead9b9..2afb12a 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -294,7 +294,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 }
 
 /*
- * This routine does i2c bus recovery by using i2c_generic_gpio_recovery
+ * This routine does i2c bus recovery by using i2c_generic_scl_recovery
  * which is provided by I2C Bus recovery infrastructure.
  */
 static void davinci_i2c_prepare_recovery(struct i2c_adapter *adap)
@@ -316,7 +316,7 @@ static void davinci_i2c_unprepare_recovery(struct i2c_adapter *adap)
 }
 
 static struct i2c_bus_recovery_info davinci_i2c_gpio_recovery_info = {
-	.recover_bus = i2c_generic_gpio_recovery,
+	.recover_bus = i2c_generic_scl_recovery,
 	.prepare_recovery = davinci_i2c_prepare_recovery,
 	.unprepare_recovery = davinci_i2c_unprepare_recovery,
 };
@@ -769,6 +769,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	struct davinci_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	struct resource *mem;
+	struct i2c_bus_recovery_info *rinfo;
 	int r, irq;
 
 	irq = platform_get_irq(pdev, 0);
@@ -869,9 +870,18 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	if (dev->pdata->has_pfunc)
 		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;
 	else if (dev->pdata->scl_pin) {
-		adap->bus_recovery_info = &davinci_i2c_gpio_recovery_info;
-		adap->bus_recovery_info->scl_gpio = dev->pdata->scl_pin;
-		adap->bus_recovery_info->sda_gpio = dev->pdata->sda_pin;
+		rinfo =  &davinci_i2c_gpio_recovery_info;
+		adap->bus_recovery_info = rinfo;
+		r = gpio_request_one(dev->pdata->scl_pin, GPIOF_OPEN_DRAIN |
+				     GPIOF_OUT_INIT_HIGH, "i2c-scl");
+		if (r)
+			goto err_unuse_clocks;
+		rinfo->scl_gpiod = gpio_to_desc(dev->pdata->scl_pin);
+
+		r = gpio_request_one(dev->pdata->sda_pin, GPIOF_IN, "i2c-sda");
+		if (r)
+			goto err_unuse_clocks;
+		rinfo->sda_gpiod = gpio_to_desc(dev->pdata->scl_pin);
 	}
 
 	adap->nr = pdev->id;
-- 
1.8.3.1
