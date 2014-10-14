From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 09:15:40 +0200
Subject: [PATCH 7/7] [media] exynos-gsc: Do full clock gating at runtime PM
 suspend
In-Reply-To: <1413270940-4378-1-git-send-email-ulf.hansson@linaro.org>
References: <1413270940-4378-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413270940-4378-8-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To potentially save more power in runtime PM suspend state, let's also
prepare/unprepare the clock from the runtime PM callbacks.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/media/platform/exynos-gsc/gsc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index e48aefa..e90ba09 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1161,7 +1161,7 @@ static int gsc_runtime_resume(struct device *dev)
 
 	pr_debug("gsc%d: state: 0x%lx", gsc->id, gsc->state);
 
-	ret = clk_enable(gsc->clock);
+	ret = clk_prepare_enable(gsc->clock);
 	if (ret)
 		return ret;
 
@@ -1179,7 +1179,7 @@ static int gsc_runtime_suspend(struct device *dev)
 
 	ret = gsc_m2m_suspend(gsc);
 	if (!ret)
-		clk_disable(gsc->clock);
+		clk_disable_unprepare(gsc->clock);
 
 	pr_debug("gsc%d: state: 0x%lx", gsc->id, gsc->state);
 	return ret;
-- 
1.9.1
