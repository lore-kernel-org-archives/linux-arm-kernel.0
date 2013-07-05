From: shuah.kh@samsung.com (Shuah Khan)
Date: Fri,  5 Jul 2013 16:41:03 -0600
Subject: [PATCH] arm: Convert locomo platform and bus legacy pm_ops to
 dev_pm_ops
Message-ID: <1373064063-13473-1-git-send-email-shuah.kh@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert arch/arm/common/locomo platform and bus legacy pm_ops to dev_pm_ops.
This change also updates the use of COMFIG_PM to CONFIG_PM_SLEEP as this
platform and bus code implements PM_SLEEP ops and not the PM_RUNTIME ops.
Compile tested.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 arch/arm/common/locomo.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index b55c362..4028e41 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -262,7 +262,7 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 	return ret;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 
 struct locomo_save_data {
 	u16	LCM_GPO;
@@ -272,9 +272,9 @@ struct locomo_save_data {
 	u16	LCM_SPIMD;
 };
 
-static int locomo_suspend(struct platform_device *dev, pm_message_t state)
+static int locomo_suspend(struct device *dev)
 {
-	struct locomo *lchip = platform_get_drvdata(dev);
+	struct locomo *lchip = platform_get_drvdata(to_platform_device(dev));
 	struct locomo_save_data *save;
 	unsigned long flags;
 
@@ -316,9 +316,9 @@ static int locomo_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-static int locomo_resume(struct platform_device *dev)
+static int locomo_resume(struct device *dev)
 {
-	struct locomo *lchip = platform_get_drvdata(dev);
+	struct locomo *lchip = platform_get_drvdata(to_platform_device(dev));
 	struct locomo_save_data *save;
 	unsigned long r;
 	unsigned long flags;
@@ -351,6 +351,8 @@ static int locomo_resume(struct platform_device *dev)
 
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(locomo_dev_pm_ops, locomo_suspend, locomo_resume);
 #endif
 
 
@@ -519,12 +521,11 @@ static int locomo_remove(struct platform_device *dev)
 static struct platform_driver locomo_device_driver = {
 	.probe		= locomo_probe,
 	.remove		= locomo_remove,
-#ifdef CONFIG_PM
-	.suspend	= locomo_suspend,
-	.resume		= locomo_resume,
-#endif
 	.driver		= {
 		.name	= "locomo",
+#ifdef CONFIG_PM_SLEEP
+		.pm	= &locomo_dev_pm_ops,
+#endif
 	},
 };
 
@@ -826,14 +827,15 @@ static int locomo_match(struct device *_dev, struct device_driver *_drv)
 	return dev->devid == drv->devid;
 }
 
-static int locomo_bus_suspend(struct device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int locomo_bus_suspend(struct device *dev)
 {
 	struct locomo_dev *ldev = LOCOMO_DEV(dev);
 	struct locomo_driver *drv = LOCOMO_DRV(dev->driver);
 	int ret = 0;
 
 	if (drv && drv->suspend)
-		ret = drv->suspend(ldev, state);
+		ret = drv->suspend(ldev, PMSG_SUSPEND);
 	return ret;
 }
 
@@ -848,6 +850,10 @@ static int locomo_bus_resume(struct device *dev)
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(locomo_bus_dev_pm_ops, locomo_bus_suspend,
+			 locomo_bus_resume);
+#endif
+
 static int locomo_bus_probe(struct device *dev)
 {
 	struct locomo_dev *ldev = LOCOMO_DEV(dev);
@@ -875,8 +881,9 @@ struct bus_type locomo_bus_type = {
 	.match		= locomo_match,
 	.probe		= locomo_bus_probe,
 	.remove		= locomo_bus_remove,
-	.suspend	= locomo_bus_suspend,
-	.resume		= locomo_bus_resume,
+#ifdef CONFIG_PM_SLEEP
+	.pm		= &locomo_bus_dev_pm_ops,
+#endif
 };
 
 int locomo_driver_register(struct locomo_driver *driver)
-- 
1.7.10.4
