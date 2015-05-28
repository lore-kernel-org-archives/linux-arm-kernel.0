From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 18:33:43 +0530
Subject: [PATCH 11/12] i2c:pxa: Use devm_ variants in probe function
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432818224-17070-12-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans up i2c_pxa_probe() function,

 - Use devm_ variants wherever
   This will clean both probe exit and i2c_pxa_remove() functions

 - Check platform resource before parsing any other data from DT/platform

 - Use dev_err on failure from i2c_add_numbered_adapter()

 - Use pr_info instead of printk for KERN_INFO

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 71 ++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 065e647..844e1fc 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1270,10 +1270,17 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	struct resource *res = NULL;
 	int ret, irq;
 
-	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
+	i2c = devm_kzalloc(&dev->dev, sizeof(struct pxa_i2c), GFP_KERNEL);
 	if (!i2c) {
-		ret = -ENOMEM;
-		goto emalloc;
+		dev_err(&dev->dev, "memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(dev, 0);
+	if (res == NULL || irq < 0) {
+		dev_err(&dev->dev, "no mem/irq resource\n");
+		return -ENODEV;
 	}
 
 	/* Default adapter num to device id; i2c_pxa_probe_dt can override. */
@@ -1283,19 +1290,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	if (ret > 0)
 		ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
 	if (ret < 0)
-		goto eclk;
-
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(dev, 0);
-	if (res == NULL || irq < 0) {
-		ret = -ENODEV;
-		goto eclk;
-	}
-
-	if (!request_mem_region(res->start, resource_size(res), res->name)) {
-		ret = -ENOMEM;
-		goto eclk;
-	}
+		return ret;
 
 	i2c->adap.owner   = THIS_MODULE;
 	i2c->adap.retries = 5;
@@ -1305,16 +1300,16 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	strlcpy(i2c->adap.name, "pxa_i2c-i2c", sizeof(i2c->adap.name));
 
-	i2c->clk = clk_get(&dev->dev, NULL);
+	i2c->clk = devm_clk_get(&dev->dev, NULL);
 	if (IS_ERR(i2c->clk)) {
-		ret = PTR_ERR(i2c->clk);
-		goto eclk;
+		dev_err(&dev->dev, "failed to get the clk\n");
+		return PTR_ERR(i2c->clk);
 	}
 
-	i2c->reg_base = ioremap(res->start, resource_size(res));
+	i2c->reg_base = devm_ioremap_resource(&dev->dev, res);
 	if (!i2c->reg_base) {
-		ret = -EIO;
-		goto eremap;
+		dev_err(&dev->dev, "failed to map resource\n");
+		return -EIO;
 	}
 
 	i2c->reg_ibmr = i2c->reg_base + pxa_reg_layout[i2c_type].ibmr;
@@ -1361,11 +1356,13 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
 	} else {
 		i2c->adap.algo = &i2c_pxa_algorithm;
-		ret = request_irq(irq, i2c_pxa_handler,
+		ret = devm_request_irq(&dev->dev, irq, i2c_pxa_handler,
 				IRQF_SHARED | IRQF_NO_SUSPEND,
 				dev_name(&dev->dev), i2c);
-		if (ret)
+		if (ret) {
+			dev_err(&dev->dev, "failed to request irq\n");
 			goto ereqirq;
+		}
 	}
 
 	i2c_pxa_reset(i2c);
@@ -1380,8 +1377,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0) {
-		printk(KERN_INFO "I2C: Failed to add bus\n");
-		goto eadapt;
+		dev_err(&dev->dev, "failed to add bus\n");
+		goto ereqirq;
 	}
 
 	platform_set_drvdata(dev, i2c);
@@ -1411,26 +1408,15 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		}
 	}
 #ifdef CONFIG_I2C_PXA_SLAVE
-	printk(KERN_INFO "I2C: %s: PXA I2C adapter, slave address %d\n",
+	pr_info("I2C: %s: PXA I2C adapter, slave address %d\n",
 	       dev_name(&i2c->adap.dev), i2c->slave_addr);
 #else
-	printk(KERN_INFO "I2C: %s: PXA I2C adapter\n",
-	       dev_name(&i2c->adap.dev));
+	pr_info("I2C: %s: PXA I2C adapter\n", dev_name(&i2c->adap.dev));
 #endif
 	return 0;
 
-eadapt:
-	if (!i2c->use_pio)
-		free_irq(irq, i2c);
 ereqirq:
 	clk_disable_unprepare(i2c->clk);
-	iounmap(i2c->reg_base);
-eremap:
-	clk_put(i2c->clk);
-eclk:
-	kfree(i2c);
-emalloc:
-	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
@@ -1439,15 +1425,8 @@ static int i2c_pxa_remove(struct platform_device *dev)
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
 	i2c_del_adapter(&i2c->adap);
-	if (!i2c->use_pio)
-		free_irq(i2c->irq, i2c);
 
 	clk_disable_unprepare(i2c->clk);
-	clk_put(i2c->clk);
-
-	iounmap(i2c->reg_base);
-	release_mem_region(i2c->iobase, i2c->iosize);
-	kfree(i2c);
 
 	return 0;
 }
-- 
1.9.1
