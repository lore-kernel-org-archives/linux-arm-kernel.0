From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 19 Jan 2015 14:22:34 +0100
Subject: [PATCH V2 2/8] [media] exynos-gsc: Convert gsc_m2m_resume() from int
 to void
In-Reply-To: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
References: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1421673760-2600-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gsc_m2m_resume() always returns 0, convert it to a void instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/media/platform/exynos-gsc/gsc-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index bd769d4..1865738 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1025,7 +1025,7 @@ static int gsc_m2m_suspend(struct gsc_dev *gsc)
 	return timeout == 0 ? -EAGAIN : 0;
 }
 
-static int gsc_m2m_resume(struct gsc_dev *gsc)
+static void gsc_m2m_resume(struct gsc_dev *gsc)
 {
 	struct gsc_ctx *ctx;
 	unsigned long flags;
@@ -1038,8 +1038,6 @@ static int gsc_m2m_resume(struct gsc_dev *gsc)
 
 	if (test_and_clear_bit(ST_M2M_SUSPENDED, &gsc->state))
 		gsc_m2m_job_finish(ctx, VB2_BUF_STATE_ERROR);
-
-	return 0;
 }
 
 static int gsc_probe(struct platform_device *pdev)
@@ -1168,8 +1166,9 @@ static int gsc_runtime_resume(struct device *dev)
 
 	gsc_hw_set_sw_reset(gsc);
 	gsc_wait_reset(gsc);
+	gsc_m2m_resume(gsc);
 
-	return gsc_m2m_resume(gsc);
+	return 0;
 }
 
 static int gsc_runtime_suspend(struct device *dev)
-- 
1.9.1
