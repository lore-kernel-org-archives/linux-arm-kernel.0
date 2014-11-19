From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Nov 2014 13:48:59 +0000
Subject: [PATCH] thermal: sti: Ignore suspend/resume functions when !PM
Message-ID: <1416404939-365-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevents build warning:

st_thermal.c:278:12:
    warning: ?st_thermal_suspend? defined but not used [-Wunused-function]
st_thermal.c:286:12:
    warning: ?st_thermal_resume? defined but not used [-Wunused-function]

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thermal/st/st_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 90163b3..9841488 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -275,6 +275,7 @@ int st_thermal_unregister(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(st_thermal_unregister);
 
+#ifdef CONFIG_PM
 static int st_thermal_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -305,6 +306,8 @@ static int st_thermal_resume(struct device *dev)
 
 	return 0;
 }
+#endif
+
 SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal_resume);
 EXPORT_SYMBOL_GPL(st_thermal_pm_ops);
 
-- 
1.9.1
