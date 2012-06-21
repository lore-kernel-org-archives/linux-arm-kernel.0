From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 21 Jun 2012 15:38:45 +0530
Subject: [PATCHv9 4/8] I2C: OMAP: Use SET_RUNTIME_PM_OPS
In-Reply-To: <1340273329-8319-1-git-send-email-shubhrajyoti@ti.com>
References: <1340273329-8319-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340273329-8319-5-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use SET_RUNTIME_PM_OPS macro to set runtime functions.

Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 328a022..ccb2fc4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1115,6 +1115,7 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 #ifdef CONFIG_PM_RUNTIME
 static void omap_i2c_restore(struct omap_i2c_dev *dev)
 {
@@ -1176,15 +1177,16 @@ static int omap_i2c_runtime_resume(struct device *dev)
 
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
