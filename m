From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 17 Jan 2017 21:30:00 -0300
Subject: [PATCH 1/2] [media] exynos-gsc: Fix unbalanced pm_runtime_enable()
 error
Message-ID: <1484699402-28738-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a006c04e6218 ("[media] exynos-gsc: Fixup clock management at
->remove()") changed the driver's .remove function logic to fist do
a pm_runtime_get_sync() to make sure the device is powered before
attempting to gate the gsc clock.

But the commit also removed a pm_runtime_disable() call that leads
to an unbalanced pm_runtime_enable() error if the driver is removed
and re-probed:

exynos-gsc 13e00000.video-scaler: Unbalanced pm_runtime_enable!
exynos-gsc 13e10000.video-scaler: Unbalanced pm_runtime_enable!

Fixes: a006c04e6218 ("[media] exynos-gsc: Fixup clock management at ->remove()")
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/media/platform/exynos-gsc/gsc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index cbf75b6194b4..83272f10722d 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1118,6 +1118,7 @@ static int gsc_remove(struct platform_device *pdev)
 		clk_disable_unprepare(gsc->clock[i]);
 
 	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	dev_dbg(&pdev->dev, "%s driver unloaded\n", pdev->name);
 	return 0;
-- 
2.7.4
