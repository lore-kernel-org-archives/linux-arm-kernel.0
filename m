From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 19 Jan 2015 14:22:39 +0100
Subject: [PATCH V2 7/8] [media] exynos-gsc: Make system PM callbacks available
 for CONFIG_PM_SLEEP
In-Reply-To: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
References: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1421673760-2600-8-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no need to set up the system PM callbacks unless they are
being used. It also causes compiler warnings about unused functions.

Silence the warnings by making them available for CONFIG_PM_SLEEP.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/media/platform/exynos-gsc/gsc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index 0b126eb..194f9fc 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1188,6 +1188,7 @@ static int gsc_runtime_suspend(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
 static int gsc_resume(struct device *dev)
 {
 	struct gsc_dev *gsc = dev_get_drvdata(dev);
@@ -1224,10 +1225,10 @@ static int gsc_suspend(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops gsc_pm_ops = {
-	.suspend		= gsc_suspend,
-	.resume			= gsc_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(gsc_suspend, gsc_resume)
 	SET_RUNTIME_PM_OPS(gsc_runtime_suspend, gsc_runtime_resume, NULL)
 };
 
-- 
1.9.1
