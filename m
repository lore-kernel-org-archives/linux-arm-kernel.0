From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 16 Jul 2018 11:40:35 +0200
Subject: [PATCH v3 1/3] i2c: at91: segregate master mode specific code from
 probe and init func
In-Reply-To: <20180716094037.1843-1-ludovic.desroches@microchip.com>
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
Message-ID: <20180716094037.1843-2-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Fitschen <me@jue.yt>

In order to implement slave mode support for the at91 hardware we have to
segregate all master mode specific function parts from the general parts.
The upcoming slave mode patch will call its sepcific probe resp. init
function instead of the master mode functions after the shared general
code has been executed.

This concept has been influenced by the i2c-designware driver.

Signed-off-by: Juergen Fitschen <me@jue.yt>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/i2c/busses/i2c-at91.c | 90 ++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 3f3e8b3bf5ff..bc74184462c6 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -174,10 +174,8 @@ static void at91_twi_irq_restore(struct at91_twi_dev *dev)
 	at91_twi_write(dev, AT91_TWI_IER, dev->imr);
 }
 
-static void at91_init_twi_bus(struct at91_twi_dev *dev)
+static void at91_init_twi_bus_master(struct at91_twi_dev *dev)
 {
-	at91_disable_twi_interrupts(dev);
-	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
 	/* FIFO should be enabled immediately after the software reset */
 	if (dev->fifo_size)
 		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_FIFOEN);
@@ -186,6 +184,14 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
 	at91_twi_write(dev, AT91_TWI_CWGR, dev->twi_cwgr_reg);
 }
 
+static void at91_init_twi_bus(struct at91_twi_dev *dev)
+{
+	at91_disable_twi_interrupts(dev);
+	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
+
+	at91_init_twi_bus_master(dev);
+}
+
 /*
  * Calculate symmetric clock as stated in datasheet:
  * twi_clk = F_MAIN / (2 * (cdiv * (1 << ckdiv) + offset))
@@ -1046,18 +1052,56 @@ static struct at91_twi_pdata *at91_twi_get_driver_data(
 	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
 }
 
+static int at91_twi_probe_master(struct platform_device *pdev,
+				 u32 phy_addr, struct at91_twi_dev *dev)
+{
+	int rc;
+	u32 bus_clk_rate;
+
+	init_completion(&dev->cmd_complete);
+
+	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt, 0,
+			      dev_name(dev->dev), dev);
+	if (rc) {
+		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
+		return rc;
+	}
+
+	if (dev->dev->of_node) {
+		rc = at91_twi_configure_dma(dev, phy_addr);
+		if (rc == -EPROBE_DEFER)
+			return rc;
+	}
+
+	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
+				  &dev->fifo_size)) {
+		dev_info(dev->dev, "Using FIFO (%u data)\n", dev->fifo_size);
+	}
+
+	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
+				  &bus_clk_rate);
+	if (rc)
+		bus_clk_rate = DEFAULT_TWI_CLK_HZ;
+
+	at91_calc_twi_clock(dev, bus_clk_rate);
+
+	dev->adapter.algo = &at91_twi_algorithm;
+	dev->adapter.quirks = &at91_twi_quirks;
+
+	return 0;
+}
+
 static int at91_twi_probe(struct platform_device *pdev)
 {
 	struct at91_twi_dev *dev;
 	struct resource *mem;
 	int rc;
 	u32 phy_addr;
-	u32 bus_clk_rate;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
-	init_completion(&dev->cmd_complete);
+
 	dev->dev = &pdev->dev;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1077,13 +1121,6 @@ static int at91_twi_probe(struct platform_device *pdev)
 	if (dev->irq < 0)
 		return dev->irq;
 
-	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt, 0,
-			 dev_name(dev->dev), dev);
-	if (rc) {
-		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
-		return rc;
-	}
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
@@ -1095,38 +1132,21 @@ static int at91_twi_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	if (dev->dev->of_node) {
-		rc = at91_twi_configure_dma(dev, phy_addr);
-		if (rc == -EPROBE_DEFER) {
-			clk_disable_unprepare(dev->clk);
-			return rc;
-		}
-	}
-
-	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
-				  &dev->fifo_size)) {
-		dev_info(dev->dev, "Using FIFO (%u data)\n", dev->fifo_size);
-	}
-
-	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
-			&bus_clk_rate);
-	if (rc)
-		bus_clk_rate = DEFAULT_TWI_CLK_HZ;
-
-	at91_calc_twi_clock(dev, bus_clk_rate);
-	at91_init_twi_bus(dev);
-
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
 	i2c_set_adapdata(&dev->adapter, dev);
 	dev->adapter.owner = THIS_MODULE;
 	dev->adapter.class = I2C_CLASS_DEPRECATED;
-	dev->adapter.algo = &at91_twi_algorithm;
-	dev->adapter.quirks = &at91_twi_quirks;
 	dev->adapter.dev.parent = dev->dev;
 	dev->adapter.nr = pdev->id;
 	dev->adapter.timeout = AT91_I2C_TIMEOUT;
 	dev->adapter.dev.of_node = pdev->dev.of_node;
 
+	rc = at91_twi_probe_master(pdev, phy_addr, dev);
+	if (rc)
+		return rc;
+
+	at91_init_twi_bus(dev);
+
 	pm_runtime_set_autosuspend_delay(dev->dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev->dev);
 	pm_runtime_set_active(dev->dev);
-- 
2.12.2
