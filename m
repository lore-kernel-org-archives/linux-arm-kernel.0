From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:21:44 +0000
Subject: [PATCH 13/18] ARM: PNX4008: kzalloc i2c drivers internal data
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <5c2bbfa405ccae35fee0f29fa1d2aafccfda45a9.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pnx4008/i2c.c  |   25 +++++++------------------
 drivers/i2c/busses/i2c-pnx.c |   29 +++++++++++++++++++----------
 include/linux/i2c-pnx.h      |    4 ++--
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-pnx4008/i2c.c b/arch/arm/mach-pnx4008/i2c.c
index 23ec335..33146e8 100644
--- a/arch/arm/mach-pnx4008/i2c.c
+++ b/arch/arm/mach-pnx4008/i2c.c
@@ -18,45 +18,34 @@
 #include <mach/irqs.h>
 #include <mach/i2c.h>
 
-static struct i2c_pnx_algo_data pnx_algo_data0 = {
-	.base = PNX4008_I2C1_BASE,
-	.irq = I2C_1_INT,
-};
-
-static struct i2c_pnx_algo_data pnx_algo_data1 = {
-	.base = PNX4008_I2C2_BASE,
-	.irq = I2C_2_INT,
-};
-
-static struct i2c_pnx_algo_data pnx_algo_data2 = {
-	.base = (PNX4008_USB_CONFIG_BASE + 0x300),
-	.irq = USB_I2C_INT,
-};
-
 static struct i2c_adapter pnx_adapter0 = {
 	.name = I2C_CHIP_NAME "0",
-	.algo_data = &pnx_algo_data0,
 };
+
 static struct i2c_adapter pnx_adapter1 = {
 	.name = I2C_CHIP_NAME "1",
-	.algo_data = &pnx_algo_data1,
 };
 
 static struct i2c_adapter pnx_adapter2 = {
 	.name = "USB-I2C",
-	.algo_data = &pnx_algo_data2,
 };
 
 static struct i2c_pnx_data i2c0_data = {
 	.adapter = &pnx_adapter0,
+	.base = PNX4008_I2C1_BASE,
+	.irq = I2C_1_INT,
 };
 
 static struct i2c_pnx_data i2c1_data = {
 	.adapter = &pnx_adapter1,
+	.base = PNX4008_I2C2_BASE,
+	.irq = I2C_2_INT,
 };
 
 static struct i2c_pnx_data i2c2_data = {
 	.adapter = &pnx_adapter2,
+	.base = (PNX4008_USB_CONFIG_BASE + 0x300),
+	.irq = USB_I2C_INT,
 };
 
 static struct platform_device i2c0_device = {
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 882579e..1d66856 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -587,10 +587,16 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	alg_data = kzalloc(sizeof(*alg_data), GFP_KERNEL);
+	if (!alg_data) {
+		ret = -ENOMEM;
+		goto err_kzalloc;
+	}
+
 	platform_set_drvdata(pdev, i2c_pnx);
 
 	i2c_pnx->adapter->algo = &pnx_algorithm;
-	alg_data = i2c_pnx->adapter->algo_data;
+	i2c_pnx->adapter->algo_data = alg_data;
 
 	alg_data->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(alg_data->clk)) {
@@ -603,16 +609,16 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	alg_data->mif.timer.data = (unsigned long)i2c_pnx->adapter;
 
 	/* Register I/O resource */
-	if (!request_mem_region(alg_data->base, I2C_PNX_REGION_SIZE,
+	if (!request_mem_region(i2c_pnx->base, I2C_PNX_REGION_SIZE,
 				pdev->name)) {
 		dev_err(&pdev->dev,
 		       "I/O region 0x%08x for I2C already in use.\n",
-		       alg_data->base);
+		       i2c_pnx->base);
 		ret = -ENODEV;
 		goto out_clkget;
 	}
 
-	alg_data->ioaddr = ioremap(alg_data->base, I2C_PNX_REGION_SIZE);
+	alg_data->ioaddr = ioremap(i2c_pnx->base, I2C_PNX_REGION_SIZE);
 	if (!alg_data->ioaddr) {
 		dev_err(&pdev->dev, "Couldn't ioremap I2C I/O region\n");
 		ret = -ENOMEM;
@@ -647,7 +653,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	}
 	init_completion(&alg_data->mif.complete);
 
-	ret = request_irq(alg_data->irq, i2c_pnx_interrupt,
+	ret = request_irq(i2c_pnx->irq, i2c_pnx_interrupt,
 			0, pdev->name, i2c_pnx->adapter);
 	if (ret)
 		goto out_clock;
@@ -662,21 +668,23 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
-	       i2c_pnx->adapter->name, alg_data->base, alg_data->irq);
+	       i2c_pnx->adapter->name, i2c_pnx->base, i2c_pnx->irq);
 
 	return 0;
 
 out_irq:
-	free_irq(alg_data->irq, i2c_pnx->adapter);
+	free_irq(i2c_pnx->irq, i2c_pnx->adapter);
 out_clock:
 	clk_disable(alg_data->clk);
 out_unmap:
 	iounmap(alg_data->ioaddr);
 out_release:
-	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
+	release_mem_region(i2c_pnx->base, I2C_PNX_REGION_SIZE);
 out_clkget:
 	clk_put(alg_data->clk);
 out_drvdata:
+	kfree(alg_data);
+err_kzalloc:
 	platform_set_drvdata(pdev, NULL);
 out:
 	return ret;
@@ -688,12 +696,13 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
 	struct i2c_adapter *adap = i2c_pnx->adapter;
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
 
-	free_irq(alg_data->irq, i2c_pnx->adapter);
+	free_irq(i2c_pnx->irq, i2c_pnx->adapter);
 	i2c_del_adapter(adap);
 	clk_disable(alg_data->clk);
 	iounmap(alg_data->ioaddr);
-	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
+	release_mem_region(i2c_pnx->base, I2C_PNX_REGION_SIZE);
 	clk_put(alg_data->clk);
+	kfree(alg_data);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
diff --git a/include/linux/i2c-pnx.h b/include/linux/i2c-pnx.h
index 5a48f33..9ebdf88 100644
--- a/include/linux/i2c-pnx.h
+++ b/include/linux/i2c-pnx.h
@@ -25,9 +25,7 @@ struct i2c_pnx_mif {
 };
 
 struct i2c_pnx_algo_data {
-	u32			base;
 	void __iomem		*ioaddr;
-	int			irq;
 	struct i2c_pnx_mif	mif;
 	int			last;
 	struct clk		*clk;
@@ -35,6 +33,8 @@ struct i2c_pnx_algo_data {
 
 struct i2c_pnx_data {
 	struct i2c_adapter *adapter;
+	u32 base;
+	int irq;
 };
 
 #endif /* __I2C_PNX_H__ */
-- 
1.6.2.5
