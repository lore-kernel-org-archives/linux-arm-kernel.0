From: hechtb@gmail.com (Bastian Hecht)
Date: Thu, 17 Jul 2014 16:48:38 +0200
Subject: [PATCH v3 3/5] i2c: exynos5: Remove suspension check
In-Reply-To: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
Message-ID: <1405608520-5644-3-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now take care of suspension in the i2c core code. So we can remove this
check here.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
same as v1

 drivers/i2c/busses/i2c-exynos5.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 63d2292..a80cf28 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -145,7 +145,6 @@
 
 struct exynos5_i2c {
 	struct i2c_adapter	adap;
-	unsigned int		suspended:1;
 
 	struct i2c_msg		*msg;
 	struct completion	msg_complete;
@@ -610,11 +609,6 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
 	struct exynos5_i2c *i2c = adap->algo_data;
 	int i = 0, ret = 0, stop = 0;
 
-	if (i2c->suspended) {
-		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
-		return -EIO;
-	}
-
 	clk_prepare_enable(i2c->clk);
 
 	for (i = 0; i < num; i++, msgs++) {
@@ -757,16 +751,6 @@ static int exynos5_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int exynos5_i2c_suspend_noirq(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct exynos5_i2c *i2c = platform_get_drvdata(pdev);
-
-	i2c->suspended = 1;
-
-	return 0;
-}
-
 static int exynos5_i2c_resume_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -783,14 +767,12 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
 
 	exynos5_i2c_init(i2c);
 	clk_disable_unprepare(i2c->clk);
-	i2c->suspended = 0;
 
 	return 0;
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(exynos5_i2c_dev_pm_ops, exynos5_i2c_suspend_noirq,
-			 exynos5_i2c_resume_noirq);
+static SIMPLE_DEV_PM_OPS(exynos5_i2c_dev_pm_ops, exynos5_i2c_resume_noirq);
 
 static struct platform_driver exynos5_i2c_driver = {
 	.probe		= exynos5_i2c_probe,
-- 
1.9.1
