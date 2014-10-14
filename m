From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 09:15:35 +0200
Subject: [PATCH 2/7] [media] exynos-gsc: Convert gsc_m2m_resume() from int to
 void
In-Reply-To: <1413270940-4378-1-git-send-email-ulf.hansson@linaro.org>
References: <1413270940-4378-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413270940-4378-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gsc_m2m_resume() always returns 0, convert it into void instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/media/platform/exynos-gsc/gsc-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index 3fca4fd..13d0226 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1022,7 +1022,7 @@ static int gsc_m2m_suspend(struct gsc_dev *gsc)
 	return timeout == 0 ? -EAGAIN : 0;
 }
 
-static int gsc_m2m_resume(struct gsc_dev *gsc)
+static void gsc_m2m_resume(struct gsc_dev *gsc)
 {
 	struct gsc_ctx *ctx;
 	unsigned long flags;
@@ -1035,8 +1035,6 @@ static int gsc_m2m_resume(struct gsc_dev *gsc)
 
 	if (test_and_clear_bit(ST_M2M_SUSPENDED, &gsc->state))
 		gsc_m2m_job_finish(ctx, VB2_BUF_STATE_ERROR);
-
-	return 0;
 }
 
 static int gsc_probe(struct platform_device *pdev)
@@ -1165,8 +1163,9 @@ static int gsc_runtime_resume(struct device *dev)
 
 	gsc_hw_set_sw_reset(gsc);
 	gsc_wait_reset(gsc);
+	gsc_m2m_resume(gsc);
 
-	return gsc_m2m_resume(gsc);
+	return 0;
 }
 
 static int gsc_runtime_suspend(struct device *dev)
-- 
1.9.1
