From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 09:15:37 +0200
Subject: [PATCH 4/7] [media] exynos-gsc: Make runtime PM callbacks available
 for CONFIG_PM
In-Reply-To: <1413270940-4378-1-git-send-email-ulf.hansson@linaro.org>
References: <1413270940-4378-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413270940-4378-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no need to set up the runtime PM callbacks unless they are
being used. Let's make them available for CONFIG_PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/media/platform/exynos-gsc/gsc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index c3a050e..361a807 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1150,6 +1150,7 @@ static int gsc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int gsc_runtime_resume(struct device *dev)
 {
 	struct gsc_dev *gsc = dev_get_drvdata(dev);
@@ -1180,6 +1181,7 @@ static int gsc_runtime_suspend(struct device *dev)
 	pr_debug("gsc%d: state: 0x%lx", gsc->id, gsc->state);
 	return ret;
 }
+#endif
 
 static int gsc_resume(struct device *dev)
 {
@@ -1221,8 +1223,7 @@ static int gsc_suspend(struct device *dev)
 static const struct dev_pm_ops gsc_pm_ops = {
 	.suspend		= gsc_suspend,
 	.resume			= gsc_resume,
-	.runtime_suspend	= gsc_runtime_suspend,
-	.runtime_resume		= gsc_runtime_resume,
+	SET_PM_RUNTIME_PM_OPS(gsc_runtime_suspend, gsc_runtime_resume, NULL)
 };
 
 static struct platform_driver gsc_driver = {
-- 
1.9.1
