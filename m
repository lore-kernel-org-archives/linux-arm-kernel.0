From: linuxzsc@gmail.com (Richard Zhao)
Date: Sat, 17 Oct 2009 17:46:24 +0800
Subject: [PATCH V1 3/3] i2c: imx: disable clock when it's possible to save
	power.
In-Reply-To: <1255772784-11387-2-git-send-email-linuxzsc@gmail.com>
References: <1255772784-11387-1-git-send-email-linuxzsc@gmail.com>
	<1255772784-11387-2-git-send-email-linuxzsc@gmail.com>
Message-ID: <1255772784-11387-3-git-send-email-linuxzsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable clock before START, disable it after STOP.

Signed-off-by: Richard Zhao <linuxzsc@gmail.com>

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 671d37c..e3654d6 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -121,6 +121,7 @@ struct imx_i2c_struct {
 	unsigned long		i2csr;
 	unsigned int 		disable_delay;
 	int			stopped;
+	unsigned int		ifdr; /* IMX_I2C_IFDR */
 };
 
 /** Functions for IMX I2C adapter driver ***************************************
@@ -192,6 +193,8 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
+	clk_enable(i2c_imx->clk);
+	writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
 	/* Enable I2C controller */
 	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
 	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
@@ -238,6 +241,7 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 
 	/* Disable I2C controller */
 	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
+	clk_disable(i2c_imx->clk);
 }
 
 static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
@@ -257,8 +261,8 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
 	else
 		for (i = 0; i2c_clk_div[i][0] < div; i++);
 
-	/* Write divider value to register */
-	writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
+	/* Store divider value */
+	i2c_imx->ifdr = i2c_clk_div[i][1];
 
 	/*
 	 * There dummy delay is calculated.
@@ -528,7 +532,6 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "can't get I2C clock\n");
 		goto fail3;
 	}
-	clk_enable(i2c_imx->clk);
 
 	/* Request IRQ */
 	ret = request_irq(i2c_imx->irq, i2c_imx_isr, 0, pdev->name, i2c_imx);
@@ -577,7 +580,6 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 fail5:
 	free_irq(i2c_imx->irq, i2c_imx);
 fail4:
-	clk_disable(i2c_imx->clk);
 	clk_put(i2c_imx->clk);
 fail3:
 	release_mem_region(i2c_imx->res->start, resource_size(res));
@@ -614,8 +616,6 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
 	if (pdata && pdata->exit)
 		pdata->exit(&pdev->dev);
 
-	/* Disable I2C clock */
-	clk_disable(i2c_imx->clk);
 	clk_put(i2c_imx->clk);
 
 	release_mem_region(i2c_imx->res->start, resource_size(i2c_imx->res));
-- 
1.6.0.4
