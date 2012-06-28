From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 28 Jun 2012 20:41:28 +0530
Subject: [PATCHv11 2/6] i2c: omap: Use SET_RUNTIME_PM_OPS
In-Reply-To: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340896292-12112-3-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use SET_RUNTIME_PM_OPS macro to set runtime functions.

Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b086076..b9915bb 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1126,6 +1126,7 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 #ifdef CONFIG_PM_RUNTIME
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
@@ -1174,15 +1175,16 @@ static int omap_i2c_runtime_resume(struct device *dev)
 
 	return 0;
 }
+#endif /* CONFIG_PM_RUNTIME */
 
 static struct dev_pm_ops omap_i2c_pm_ops = {
-	.runtime_suspend = omap_i2c_runtime_suspend,
-	.runtime_resume = omap_i2c_runtime_resume,
+	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
+			   omap_i2c_runtime_resume, NULL)
 };
 #define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
 #else
 #define OMAP_I2C_PM_OPS NULL
-#endif
+#endif /* CONFIG_PM */
 
 static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
-- 
1.7.5.4
