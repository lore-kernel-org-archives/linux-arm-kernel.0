From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 19 Jan 2015 14:22:36 +0100
Subject: [PATCH V2 4/8] [media] exynos-gsc: Make runtime PM callbacks
 available for CONFIG_PM
In-Reply-To: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
References: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1421673760-2600-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no need to set up the runtime PM callbacks unless they are
being used. It also causes compiler warnings about unused functions.

Silence the warnings by making them available for CONFIG_PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/media/platform/exynos-gsc/gsc-core.c | 79 ++++++++++++++--------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
index 532daa8..e84bc35 100644
--- a/drivers/media/platform/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/exynos-gsc/gsc-core.c
@@ -1003,43 +1003,6 @@ static void *gsc_get_drv_data(struct platform_device *pdev)
 	return driver_data;
 }
 
-static int gsc_m2m_suspend(struct gsc_dev *gsc)
-{
-	unsigned long flags;
-	int timeout;
-
-	spin_lock_irqsave(&gsc->slock, flags);
-	if (!gsc_m2m_pending(gsc)) {
-		spin_unlock_irqrestore(&gsc->slock, flags);
-		return 0;
-	}
-	clear_bit(ST_M2M_SUSPENDED, &gsc->state);
-	set_bit(ST_M2M_SUSPENDING, &gsc->state);
-	spin_unlock_irqrestore(&gsc->slock, flags);
-
-	timeout = wait_event_timeout(gsc->irq_queue,
-			     test_bit(ST_M2M_SUSPENDED, &gsc->state),
-			     GSC_SHUTDOWN_TIMEOUT);
-
-	clear_bit(ST_M2M_SUSPENDING, &gsc->state);
-	return timeout == 0 ? -EAGAIN : 0;
-}
-
-static void gsc_m2m_resume(struct gsc_dev *gsc)
-{
-	struct gsc_ctx *ctx;
-	unsigned long flags;
-
-	spin_lock_irqsave(&gsc->slock, flags);
-	/* Clear for full H/W setup in first run after resume */
-	ctx = gsc->m2m.ctx;
-	gsc->m2m.ctx = NULL;
-	spin_unlock_irqrestore(&gsc->slock, flags);
-
-	if (test_and_clear_bit(ST_M2M_SUSPENDED, &gsc->state))
-		gsc_m2m_job_finish(ctx, VB2_BUF_STATE_ERROR);
-}
-
 static int gsc_probe(struct platform_device *pdev)
 {
 	struct gsc_dev *gsc;
@@ -1152,6 +1115,44 @@ static int gsc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int gsc_m2m_suspend(struct gsc_dev *gsc)
+{
+	unsigned long flags;
+	int timeout;
+
+	spin_lock_irqsave(&gsc->slock, flags);
+	if (!gsc_m2m_pending(gsc)) {
+		spin_unlock_irqrestore(&gsc->slock, flags);
+		return 0;
+	}
+	clear_bit(ST_M2M_SUSPENDED, &gsc->state);
+	set_bit(ST_M2M_SUSPENDING, &gsc->state);
+	spin_unlock_irqrestore(&gsc->slock, flags);
+
+	timeout = wait_event_timeout(gsc->irq_queue,
+			     test_bit(ST_M2M_SUSPENDED, &gsc->state),
+			     GSC_SHUTDOWN_TIMEOUT);
+
+	clear_bit(ST_M2M_SUSPENDING, &gsc->state);
+	return timeout == 0 ? -EAGAIN : 0;
+}
+
+static void gsc_m2m_resume(struct gsc_dev *gsc)
+{
+	struct gsc_ctx *ctx;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gsc->slock, flags);
+	/* Clear for full H/W setup in first run after resume */
+	ctx = gsc->m2m.ctx;
+	gsc->m2m.ctx = NULL;
+	spin_unlock_irqrestore(&gsc->slock, flags);
+
+	if (test_and_clear_bit(ST_M2M_SUSPENDED, &gsc->state))
+		gsc_m2m_job_finish(ctx, VB2_BUF_STATE_ERROR);
+}
+
 static int gsc_runtime_resume(struct device *dev)
 {
 	struct gsc_dev *gsc = dev_get_drvdata(dev);
@@ -1182,6 +1183,7 @@ static int gsc_runtime_suspend(struct device *dev)
 	pr_debug("gsc%d: state: 0x%lx", gsc->id, gsc->state);
 	return ret;
 }
+#endif
 
 static int gsc_resume(struct device *dev)
 {
@@ -1223,8 +1225,7 @@ static int gsc_suspend(struct device *dev)
 static const struct dev_pm_ops gsc_pm_ops = {
 	.suspend		= gsc_suspend,
 	.resume			= gsc_resume,
-	.runtime_suspend	= gsc_runtime_suspend,
-	.runtime_resume		= gsc_runtime_resume,
+	SET_RUNTIME_PM_OPS(gsc_runtime_suspend, gsc_runtime_resume, NULL)
 };
 
 static struct platform_driver gsc_driver = {
-- 
1.9.1
