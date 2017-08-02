From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 2 Aug 2017 17:17:51 -0500
Subject: [PATCH 2/4] i2c: davinci: Add PM Runtime Support
In-Reply-To: <20170802221753.13786-1-fcooper@ti.com>
References: <20170802221753.13786-1-fcooper@ti.com>
Message-ID: <20170802221753.13786-3-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PM runtime support to the I2C Davinci driver.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/i2c/busses/i2c-davinci.c | 61 ++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 5749aac..62ff869 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -36,6 +36,7 @@
 #include <linux/gpio.h>
 #include <linux/of_device.h>
 #include <linux/platform_data/i2c-davinci.h>
+#include <linux/pm_runtime.h>
 
 /* ----- global defines ----------------------------------------------- */
 
@@ -122,6 +123,9 @@
 /* set the SDA GPIO low */
 #define DAVINCI_I2C_DCLR_PDCLR1	BIT(1)
 
+/* timeout for pm runtime autosuspend */
+#define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
+
 struct davinci_i2c_dev {
 	struct device           *dev;
 	void __iomem		*base;
@@ -541,10 +545,17 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
 
+	ret = pm_runtime_get_sync(dev->dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "Failed to runtime_get device: %d\n", ret);
+		pm_runtime_put_noidle(dev->dev);
+		return ret;
+	}
+
 	ret = i2c_davinci_wait_bus_not_busy(dev);
 	if (ret < 0) {
 		dev_warn(dev->dev, "timeout waiting for bus ready\n");
-		return ret;
+		goto out;
 	}
 
 	for (i = 0; i < num; i++) {
@@ -552,14 +563,19 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		dev_dbg(dev->dev, "%s [%d/%d] ret: %d\n", __func__, i + 1, num,
 			ret);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
+	ret = num;
 #ifdef CONFIG_CPU_FREQ
 	complete(&dev->xfr_complete);
 #endif
 
-	return num;
+out:
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
+	return ret;
 }
 
 static u32 i2c_davinci_func(struct i2c_adapter *adap)
@@ -599,6 +615,9 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 	int count = 0;
 	u16 w;
 
+	if (pm_runtime_suspended(dev->dev))
+		return IRQ_NONE;
+
 	while ((stat = davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG))) {
 		dev_dbg(dev->dev, "%s: stat=0x%x\n", __func__, stat);
 		if (count++ == 100) {
@@ -802,7 +821,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
-	clk_prepare_enable(dev->clk);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dev->base = devm_ioremap_resource(&pdev->dev, mem);
@@ -811,6 +829,17 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
+	pm_runtime_enable(dev->dev);
+	pm_runtime_set_autosuspend_delay(dev->dev,
+					 DAVINCI_I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev->dev);
+
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0) {
+		dev_err(dev->dev, "failed to runtime_get device: %d\n", r);
+		goto err_unuse_clocks;
+	}
+
 	i2c_davinci_init(dev);
 
 	r = devm_request_irq(&pdev->dev, dev->irq, i2c_davinci_isr, 0,
@@ -849,10 +878,16 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	if (r)
 		goto err_unuse_clocks;
 
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
 	return 0;
 
 err_unuse_clocks:
-	clk_disable_unprepare(dev->clk);
+	pm_runtime_dont_use_autosuspend(dev->dev);
+	pm_runtime_put_sync(dev->dev);
+	pm_runtime_disable(dev->dev);
+
 	dev->clk = NULL;
 	return r;
 }
@@ -860,16 +895,26 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 static int davinci_i2c_remove(struct platform_device *pdev)
 {
 	struct davinci_i2c_dev *dev = platform_get_drvdata(pdev);
+	int ret;
 
 	i2c_davinci_cpufreq_deregister(dev);
 
 	i2c_del_adapter(&dev->adapter);
 
-	clk_disable_unprepare(dev->clk);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		return ret;
+	}
+
 	dev->clk = NULL;
 
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, 0);
 
+	pm_runtime_dont_use_autosuspend(dev->dev);
+	pm_runtime_put_sync(dev->dev);
+	pm_runtime_disable(dev->dev);
+
 	return 0;
 }
 
@@ -881,7 +926,6 @@ static int davinci_i2c_suspend(struct device *dev)
 
 	/* put I2C into reset */
 	davinci_i2c_reset_ctrl(i2c_dev, 0);
-	clk_disable_unprepare(i2c_dev->clk);
 
 	return 0;
 }
@@ -891,7 +935,6 @@ static int davinci_i2c_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct davinci_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 
-	clk_prepare_enable(i2c_dev->clk);
 	/* take I2C out of reset */
 	davinci_i2c_reset_ctrl(i2c_dev, 1);
 
@@ -901,6 +944,8 @@ static int davinci_i2c_resume(struct device *dev)
 static const struct dev_pm_ops davinci_i2c_pm = {
 	.suspend        = davinci_i2c_suspend,
 	.resume         = davinci_i2c_resume,
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
 };
 
 #define davinci_i2c_pm_ops (&davinci_i2c_pm)
-- 
2.9.4.dirty
