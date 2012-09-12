From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 12 Sep 2012 08:42:10 +0200
Subject: [PATCH v3 1/8] i2c: at91: use managed resources
In-Reply-To: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
References: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1347432137-25058-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Use managed resources to ease the cleanup.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nikolaus Voss <n.voss@weinmann.de>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 85 +++++++++++++------------------------------
 1 file changed, 25 insertions(+), 60 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 2b8b2c2..08aaee7 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -326,61 +326,49 @@ static struct i2c_algorithm at91_twi_algorithm = {
 static int __devinit at91_twi_probe(struct platform_device *pdev)
 {
 	struct at91_twi_dev *dev;
-	struct resource *mem, *ioarea;
-	int irq, rc;
+	struct resource *mem;
+	int rc;
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+	init_completion(&dev->cmd_complete);
+	dev->dev = &pdev->dev;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem)
 		return -ENODEV;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ioarea = request_mem_region(mem->start, resource_size(mem), pdev->name);
-	if (!ioarea)
+	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
+	if (!dev->base)
 		return -EBUSY;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		rc = -ENOMEM;
-		goto err_release_region;
+	dev->irq = platform_get_irq(pdev, 0);
+	if (dev->irq < 0)
+		return dev->irq;
+
+	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt, 0,
+			 dev_name(dev->dev), dev);
+	if (rc) {
+		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
+		return rc;
 	}
 
 	if (pdev->id_entry)
 		dev->ip_id = pdev->id_entry->driver_data;
 
-	init_completion(&dev->cmd_complete);
-
-	dev->dev = &pdev->dev;
-	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
-	dev->clk = clk_get(dev->dev, NULL);
+	dev->clk = devm_clk_get(dev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		dev_err(dev->dev, "no clock defined\n");
-		rc = -ENODEV;
-		goto err_free_mem;
-	}
-	clk_prepare(dev->clk);
-	clk_enable(dev->clk);
-
-	dev->base = ioremap(mem->start, resource_size(mem));
-	if (!dev->base) {
-		rc = -EBUSY;
-		goto err_mem_ioremap;
+		return -ENODEV;
 	}
+	clk_prepare_enable(dev->clk);
 
 	at91_calc_twi_clock(dev, TWI_CLK_HZ);
 	at91_init_twi_bus(dev);
 
-	rc = request_irq(dev->irq, atmel_twi_interrupt, 0,
-			 dev_name(dev->dev), dev);
-	if (rc) {
-		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
-		goto err_unuse_clocks;
-	}
-
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
 	i2c_set_adapdata(&dev->adapter, dev);
 	dev->adapter.owner = THIS_MODULE;
@@ -394,44 +382,21 @@ static int __devinit at91_twi_probe(struct platform_device *pdev)
 	if (rc) {
 		dev_err(dev->dev, "Adapter %s registration failed\n",
 			dev->adapter.name);
-		goto err_free_irq;
+		clk_disable_unprepare(dev->clk);
+		return rc;
 	}
 
 	dev_info(dev->dev, "AT91 i2c bus driver.\n");
 	return 0;
-
-err_free_irq:
-	free_irq(dev->irq, dev);
-err_unuse_clocks:
-	iounmap(dev->base);
-err_mem_ioremap:
-	clk_disable(dev->clk);
-	clk_unprepare(dev->clk);
-	clk_put(dev->clk);
-err_free_mem:
-	kfree(dev);
-err_release_region:
-	release_mem_region(mem->start, resource_size(mem));
-
-	return rc;
 }
 
 static int __devexit at91_twi_remove(struct platform_device *pdev)
 {
 	struct at91_twi_dev *dev = platform_get_drvdata(pdev);
-	struct resource *mem;
 	int rc;
 
 	rc = i2c_del_adapter(&dev->adapter);
-	clk_disable(dev->clk);
-	clk_unprepare(dev->clk);
-	clk_put(dev->clk);
-	free_irq(dev->irq, dev);
-	iounmap(dev->base);
-	kfree(dev);
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
+	clk_disable_unprepare(dev->clk);
 
 	return rc;
 }
-- 
1.7.11.3
