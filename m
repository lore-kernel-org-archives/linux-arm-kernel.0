From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 23 Apr 2014 21:52:04 +0200
Subject: [PATCH 4/4] dma: ste_dma40: Fixup system suspend/resume
In-Reply-To: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
References: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1398282724-2607-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to handle register context save/restore when needed from
system PM callbacks.

Previously we solely trusted the device to reside in in-active state
while the system suspend callback were invoked, which is just too
optimistic.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/dma/ste_dma40.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 0b29af3..b539fc9 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2945,7 +2945,11 @@ static int dma40_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct d40_base *base = platform_get_drvdata(pdev);
-	int ret = 0;
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
 
 	if (base->lcpa_regulator)
 		ret = regulator_disable(base->lcpa_regulator);
@@ -2958,10 +2962,13 @@ static int dma40_resume(struct device *dev)
 	struct d40_base *base = platform_get_drvdata(pdev);
 	int ret = 0;
 
-	if (base->lcpa_regulator)
+	if (base->lcpa_regulator) {
 		ret = regulator_enable(base->lcpa_regulator);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return pm_runtime_force_resume(dev);
 }
 #endif
 
-- 
1.7.9.5
