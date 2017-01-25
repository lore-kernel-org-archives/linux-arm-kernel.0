From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 25 Jan 2017 12:50:31 +0100
Subject: [PATCH 7/7] mfd: exynos-lpass: Add runtime PM support
In-Reply-To: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
References: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115105eucas1p1e7191cf0be871c254dd09477ca7f9e1a@eucas1p1.samsung.com>
Message-ID: <1485345031-2948-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert exisitng lpass-suspend/resume callbacks into runtime PM callbacks.
This way Exynos LPASS driver will be ready for use with power domains
enabled. LPASS will be runtime resumed/suspended as a result of its child
devices runtime PM transitions.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/exynos-lpass.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 44d8ea1a978b..d383b2f6f207 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
@@ -132,6 +133,8 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, lpass);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 	exynos_lpass_enable(lpass);
 
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
@@ -155,8 +158,11 @@ static int __maybe_unused exynos_lpass_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(lpass_pm_ops, exynos_lpass_suspend,
-					exynos_lpass_resume);
+static const struct dev_pm_ops lpass_pm_ops = {
+	SET_RUNTIME_PM_OPS(exynos_lpass_suspend, exynos_lpass_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
+};
 
 static const struct of_device_id exynos_lpass_of_match[] = {
 	{ .compatible = "samsung,exynos5433-lpass" },
-- 
1.9.1
