From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Sun, 27 Sep 2015 17:11:46 +0100
Subject: [PATCH] drm/exynos: Avoid NULL pointer dereference in resume if bind
 failed
Message-ID: <1443370306-15429-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If binding failed calling exynos_dp_enable in exynos_dp_resume will
result in several NULL pointer dereferences. It is much better to
simply skip suspend/resume handling if bind has failed, do so by
checking if a drm_dev exists.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/gpu/drm/exynos/exynos_dp_core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
index d66ade0..48baf07 100644
--- a/drivers/gpu/drm/exynos/exynos_dp_core.c
+++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
@@ -1388,6 +1388,9 @@ static int exynos_dp_suspend(struct device *dev)
 {
 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
 
+	if (!dp->drm_dev)
+		return 0;
+
 	exynos_dp_disable(&dp->encoder);
 	return 0;
 }
@@ -1396,6 +1399,9 @@ static int exynos_dp_resume(struct device *dev)
 {
 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
 
+	if (!dp->drm_dev)
+		return 0;
+
 	exynos_dp_enable(&dp->encoder);
 	return 0;
 }
-- 
1.7.2.5
