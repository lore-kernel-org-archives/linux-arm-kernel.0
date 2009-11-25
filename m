From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 25 Nov 2009 22:23:21 +0100
Subject: [PATCH 1/1] Remove suspend/resume functionality, add dynamic clocking
Message-ID: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove suspend/resume functionality, I2C driver gates clock on
only when an I2C transaction is in progress

Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 drivers/i2c/busses/i2c-pnx.c |   35 +++++++----------------------------
 1 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index cd4805d..c3c5425 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -453,6 +453,8 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	dev_dbg(&adap->dev, "%s(): entering: %d messages, stat = %04x.\n",
 		__func__, num, ioread32(I2C_REG_STS(alg_data)));
 
+	clk_enable(alg_data->clk);
+
 	bus_reset_if_active(adap);
 
 	/* Process transactions in a loop. */
@@ -521,6 +523,8 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	bus_reset_if_active(adap);
 
+	clk_disable(alg_data->clk);
+
 	/* Cleanup to be sure... */
 	alg_data->mif.buf = NULL;
 	alg_data->mif.len = 0;
@@ -544,31 +548,6 @@ static struct i2c_algorithm pnx_algorithm = {
 	.functionality = i2c_pnx_func,
 };
 
-#ifdef CONFIG_PM
-static int i2c_pnx_controller_suspend(struct platform_device *pdev,
-				      pm_message_t state)
-{
-	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
-	struct i2c_pnx_algo_data *alg_data = i2c_pnx->adapter->algo_data;
-
-	/* FIXME: shouldn't this be clk_disable? */
-	clk_enable(alg_data->clk);
-
-	return 0;
-}
-
-static int i2c_pnx_controller_resume(struct platform_device *pdev)
-{
-	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
-	struct i2c_pnx_algo_data *alg_data = i2c_pnx->adapter->algo_data;
-
-	return clk_enable(alg_data->clk);
-}
-#else
-#define i2c_pnx_controller_suspend	NULL
-#define i2c_pnx_controller_resume	NULL
-#endif
-
 static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 {
 	unsigned long tmp;
@@ -664,6 +643,9 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
 	       i2c_pnx->adapter->name, alg_data->base, alg_data->irq);
 
+	/* Disable clock until needed */
+	clk_disable(alg_data->clk);
+
 	return 0;
 
 out_irq:
@@ -690,7 +672,6 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
 
 	free_irq(alg_data->irq, alg_data);
 	i2c_del_adapter(adap);
-	clk_disable(alg_data->clk);
 	iounmap((void *)alg_data->ioaddr);
 	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
 	clk_put(alg_data->clk);
@@ -706,8 +687,6 @@ static struct platform_driver i2c_pnx_driver = {
 	},
 	.probe = i2c_pnx_probe,
 	.remove = __devexit_p(i2c_pnx_remove),
-	.suspend = i2c_pnx_controller_suspend,
-	.resume = i2c_pnx_controller_resume,
 };
 
 static int __init i2c_adap_pnx_init(void)
-- 
1.6.0.6
