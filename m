From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:21:46 +0000
Subject: [PATCH 14/18] ARM: PNX4008: move i2c_adapter structure inside the
	drivers private data
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <4a57839e2a45ef8dc845d1c35560cc07e64141ac.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pnx4008/i2c.c  |   18 +++---------------
 drivers/i2c/busses/i2c-pnx.c |   40 ++++++++++++++++++++--------------------
 include/linux/i2c-pnx.h      |    4 +++-
 3 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-pnx4008/i2c.c b/arch/arm/mach-pnx4008/i2c.c
index 33146e8..8103f96 100644
--- a/arch/arm/mach-pnx4008/i2c.c
+++ b/arch/arm/mach-pnx4008/i2c.c
@@ -18,32 +18,20 @@
 #include <mach/irqs.h>
 #include <mach/i2c.h>
 
-static struct i2c_adapter pnx_adapter0 = {
-	.name = I2C_CHIP_NAME "0",
-};
-
-static struct i2c_adapter pnx_adapter1 = {
-	.name = I2C_CHIP_NAME "1",
-};
-
-static struct i2c_adapter pnx_adapter2 = {
-	.name = "USB-I2C",
-};
-
 static struct i2c_pnx_data i2c0_data = {
-	.adapter = &pnx_adapter0,
+	.name = I2C_CHIP_NAME "0",
 	.base = PNX4008_I2C1_BASE,
 	.irq = I2C_1_INT,
 };
 
 static struct i2c_pnx_data i2c1_data = {
-	.adapter = &pnx_adapter1,
+	.name = I2C_CHIP_NAME "1",
 	.base = PNX4008_I2C2_BASE,
 	.irq = I2C_2_INT,
 };
 
 static struct i2c_pnx_data i2c2_data = {
-	.adapter = &pnx_adapter2,
+	.name = "USB-I2C",
 	.base = (PNX4008_USB_CONFIG_BASE + 0x300),
 	.irq = USB_I2C_INT,
 };
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 1d66856..4fb6f72 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -551,8 +551,7 @@ static struct i2c_algorithm pnx_algorithm = {
 static int i2c_pnx_controller_suspend(struct platform_device *pdev,
 				      pm_message_t state)
 {
-	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
-	struct i2c_pnx_algo_data *alg_data = i2c_pnx->adapter->algo_data;
+	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
 
 	/* FIXME: shouldn't this be clk_disable? */
 	clk_enable(alg_data->clk);
@@ -562,8 +561,7 @@ static int i2c_pnx_controller_suspend(struct platform_device *pdev,
 
 static int i2c_pnx_controller_resume(struct platform_device *pdev)
 {
-	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
-	struct i2c_pnx_algo_data *alg_data = i2c_pnx->adapter->algo_data;
+	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
 
 	return clk_enable(alg_data->clk);
 }
@@ -580,7 +578,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	unsigned long freq;
 	struct i2c_pnx_data *i2c_pnx = pdev->dev.platform_data;
 
-	if (!i2c_pnx || !i2c_pnx->adapter) {
+	if (!i2c_pnx || !i2c_pnx->name) {
 		dev_err(&pdev->dev, "%s: no platform data supplied\n",
 		       __func__);
 		ret = -EINVAL;
@@ -593,10 +591,15 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 		goto err_kzalloc;
 	}
 
-	platform_set_drvdata(pdev, i2c_pnx);
+	platform_set_drvdata(pdev, alg_data);
 
-	i2c_pnx->adapter->algo = &pnx_algorithm;
-	i2c_pnx->adapter->algo_data = alg_data;
+	strlcpy(alg_data->adapter.name, i2c_pnx->name,
+		sizeof(alg_data->adapter.name));
+	alg_data->adapter.dev.parent = &pdev->dev;
+	alg_data->adapter.algo = &pnx_algorithm;
+	alg_data->adapter.algo_data = alg_data;
+	alg_data->adapter.nr = pdev->id;
+	alg_data->i2c_pnx = i2c_pnx;
 
 	alg_data->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(alg_data->clk)) {
@@ -606,7 +609,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 
 	init_timer(&alg_data->mif.timer);
 	alg_data->mif.timer.function = i2c_pnx_timeout;
-	alg_data->mif.timer.data = (unsigned long)i2c_pnx->adapter;
+	alg_data->mif.timer.data = (unsigned long)&alg_data->adapter;
 
 	/* Register I/O resource */
 	if (!request_mem_region(i2c_pnx->base, I2C_PNX_REGION_SIZE,
@@ -654,26 +657,24 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	init_completion(&alg_data->mif.complete);
 
 	ret = request_irq(i2c_pnx->irq, i2c_pnx_interrupt,
-			0, pdev->name, i2c_pnx->adapter);
+			0, pdev->name, &alg_data->adapter);
 	if (ret)
 		goto out_clock;
 
 	/* Register this adapter with the I2C subsystem */
-	i2c_pnx->adapter->dev.parent = &pdev->dev;
-	i2c_pnx->adapter->nr = pdev->id;
-	ret = i2c_add_numbered_adapter(i2c_pnx->adapter);
+	ret = i2c_add_adapter(&alg_data->adapter);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "I2C: Failed to add bus\n");
 		goto out_irq;
 	}
 
 	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
-	       i2c_pnx->adapter->name, i2c_pnx->base, i2c_pnx->irq);
+	       alg_data->adapter.name, i2c_pnx->base, i2c_pnx->irq);
 
 	return 0;
 
 out_irq:
-	free_irq(i2c_pnx->irq, i2c_pnx->adapter);
+	free_irq(i2c_pnx->irq, &alg_data->adapter);
 out_clock:
 	clk_disable(alg_data->clk);
 out_unmap:
@@ -692,12 +693,11 @@ out:
 
 static int __devexit i2c_pnx_remove(struct platform_device *pdev)
 {
-	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
-	struct i2c_adapter *adap = i2c_pnx->adapter;
-	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
+	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
+	struct i2c_pnx_data *i2c_pnx = alg_data->i2c_pnx;
 
-	free_irq(i2c_pnx->irq, i2c_pnx->adapter);
-	i2c_del_adapter(adap);
+	free_irq(i2c_pnx->irq, &alg_data->adapter);
+	i2c_del_adapter(&alg_data->adapter);
 	clk_disable(alg_data->clk);
 	iounmap(alg_data->ioaddr);
 	release_mem_region(i2c_pnx->base, I2C_PNX_REGION_SIZE);
diff --git a/include/linux/i2c-pnx.h b/include/linux/i2c-pnx.h
index 9ebdf88..a87124d 100644
--- a/include/linux/i2c-pnx.h
+++ b/include/linux/i2c-pnx.h
@@ -29,10 +29,12 @@ struct i2c_pnx_algo_data {
 	struct i2c_pnx_mif	mif;
 	int			last;
 	struct clk		*clk;
+	struct i2c_pnx_data	*i2c_pnx;
+	struct i2c_adapter	adapter;
 };
 
 struct i2c_pnx_data {
-	struct i2c_adapter *adapter;
+	const char *name;
 	u32 base;
 	int irq;
 };
-- 
1.6.2.5
