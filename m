From: richard.zhao@linaro.org (Richard Zhao)
Date: Sat, 12 May 2012 21:02:23 +0800
Subject: [PATCH] i2c: imx: convert to use managed functions
Message-ID: <1336827744-16520-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c |   59 ++++++++++--------------------------------
 1 file changed, 14 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 56bce9a..927da64 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -118,7 +118,6 @@ static u16 __initdata i2c_clk_div[50][2] = {
 
 struct imx_i2c_struct {
 	struct i2c_adapter	adapter;
-	struct resource		*res;
 	struct clk		*clk;
 	void __iomem		*base;
 	int			irq;
@@ -473,7 +472,6 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
 	struct pinctrl *pinctrl;
 	void __iomem *base;
-	resource_size_t res_size;
 	int irq, bitrate;
 	int ret;
 
@@ -490,25 +488,16 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	res_size = resource_size(res);
-
-	if (!request_mem_region(res->start, res_size, DRIVER_NAME)) {
-		dev_err(&pdev->dev, "request_mem_region failed\n");
+	base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!base)
 		return -EBUSY;
-	}
-
-	base = ioremap(res->start, res_size);
-	if (!base) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -EIO;
-		goto fail1;
-	}
 
-	i2c_imx = kzalloc(sizeof(struct imx_i2c_struct), GFP_KERNEL);
+	i2c_imx = devm_kzalloc(&pdev->dev, sizeof(struct imx_i2c_struct),
+				GFP_KERNEL);
 	if (!i2c_imx) {
 		dev_err(&pdev->dev, "can't allocate interface\n");
 		ret = -ENOMEM;
-		goto fail2;
+		return ret;
 	}
 
 	/* Setup i2c_imx driver structure */
@@ -520,27 +509,27 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
 	i2c_imx->irq			= irq;
 	i2c_imx->base			= base;
-	i2c_imx->res			= res;
 
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl)) {
 		ret = PTR_ERR(pinctrl);
-		goto fail3;
+		return ret;
 	}
 
 	/* Get I2C clock */
-	i2c_imx->clk = clk_get(&pdev->dev, "i2c_clk");
+	i2c_imx->clk = devm_clk_get(&pdev->dev, "i2c_clk");
 	if (IS_ERR(i2c_imx->clk)) {
 		ret = PTR_ERR(i2c_imx->clk);
 		dev_err(&pdev->dev, "can't get I2C clock\n");
-		goto fail3;
+		return ret;
 	}
 
 	/* Request IRQ */
-	ret = request_irq(i2c_imx->irq, i2c_imx_isr, 0, pdev->name, i2c_imx);
+	ret = devm_request_irq(&pdev->dev, i2c_imx->irq, i2c_imx_isr, 0,
+				pdev->name, i2c_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't claim irq %d\n", i2c_imx->irq);
-		goto fail4;
+		return ret;
 	}
 
 	/* Init queue */
@@ -565,7 +554,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "registration failed\n");
-		goto fail5;
+		return ret;
 	}
 
 	of_i2c_register_devices(&i2c_imx->adapter);
@@ -575,26 +564,14 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 
 	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", i2c_imx->irq);
 	dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
-		i2c_imx->res->start, i2c_imx->res->end);
+		res->start, res->end);
 	dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0x%x \n",
-		res_size, i2c_imx->res->start);
+		resource_size(res), res->start);
 	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
 		i2c_imx->adapter.name);
 	dev_dbg(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 
 	return 0;   /* Return OK */
-
-fail5:
-	free_irq(i2c_imx->irq, i2c_imx);
-fail4:
-	clk_put(i2c_imx->clk);
-fail3:
-	kfree(i2c_imx);
-fail2:
-	iounmap(base);
-fail1:
-	release_mem_region(res->start, resource_size(res));
-	return ret; /* Return error number */
 }
 
 static int __exit i2c_imx_remove(struct platform_device *pdev)
@@ -606,20 +583,12 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
 	i2c_del_adapter(&i2c_imx->adapter);
 	platform_set_drvdata(pdev, NULL);
 
-	/* free interrupt */
-	free_irq(i2c_imx->irq, i2c_imx);
-
 	/* setup chip registers to defaults */
 	writeb(0, i2c_imx->base + IMX_I2C_IADR);
 	writeb(0, i2c_imx->base + IMX_I2C_IFDR);
 	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
 	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
 
-	clk_put(i2c_imx->clk);
-
-	iounmap(i2c_imx->base);
-	release_mem_region(i2c_imx->res->start, resource_size(i2c_imx->res));
-	kfree(i2c_imx);
 	return 0;
 }
 
-- 
1.7.9.5
