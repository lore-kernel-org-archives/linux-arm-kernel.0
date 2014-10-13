From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 13 Oct 2014 13:44:23 -0300
Subject: [RFC/PATCH] i2c: pxa: Use suspend() and resume() instead of the
 _noirq hooks
Message-ID: <1413218663-2847-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The _noirq were previously chosen to make sure all the users of the
adapter were suspended by the time the adapter itself enters the
suspended state.

The {suspend,resume}_noirq usage was converted from an earlier
implementation based on suspend_late and resume_early:

commit 57f4d4f1b72983f8c76e2f232e064730aeffe599
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Jul 8 13:22:39 2009 +0200

    I2C: Rework i2c-pxa suspend_late()/resume_early()

However, all the I2C devices are probed as children of its I2C adapter,
and hence the device model guarantees they get suspended before its
parent and resumed after it.

In other words, there's no need to use the _noirq hooks to get a
suspend/resume device/adapter order.

This commit changes this by using the suspend/resume PM hooks in the I2C
adapter.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/i2c/busses/i2c-pxa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index be671f7..3be19b36 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1292,7 +1292,7 @@ static int i2c_pxa_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM
-static int i2c_pxa_suspend_noirq(struct device *dev)
+static int i2c_pxa_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
@@ -1302,7 +1302,7 @@ static int i2c_pxa_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int i2c_pxa_resume_noirq(struct device *dev)
+static int i2c_pxa_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
@@ -1314,8 +1314,8 @@ static int i2c_pxa_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops i2c_pxa_dev_pm_ops = {
-	.suspend_noirq = i2c_pxa_suspend_noirq,
-	.resume_noirq = i2c_pxa_resume_noirq,
+	.suspend = i2c_pxa_suspend,
+	.resume = i2c_pxa_resume,
 };
 
 #define I2C_PXA_DEV_PM_OPS (&i2c_pxa_dev_pm_ops)
-- 
2.1.0
