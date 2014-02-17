From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 17 Feb 2014 16:20:53 +0100
Subject: [PATCH V3 15/17] i2c: nomadik: Convert to late and early system PM
 callbacks
Message-ID: <1392650453-14925-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At system suspend_late, runtime PM has been disabled by the PM core
which means we can safely operate on these resources. Consequentially
we no longer have to wait until the noirq phase of the system suspend.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 3e08ba1..0a6d438 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -882,9 +882,8 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-
-#ifdef CONFIG_PM
-static int nmk_i2c_suspend(struct device *dev)
+#ifdef CONFIG_PM_SLEEP
+static int nmk_i2c_suspend_late(struct device *dev)
 {
 	struct amba_device *adev = to_amba_device(dev);
 	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
@@ -897,7 +896,7 @@ static int nmk_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int nmk_i2c_resume(struct device *dev)
+static int nmk_i2c_resume_early(struct device *dev)
 {
 	/* First go to the default state */
 	pinctrl_pm_select_default_state(dev);
@@ -906,9 +905,6 @@ static int nmk_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#else
-#define nmk_i2c_suspend	NULL
-#define nmk_i2c_resume	NULL
 #endif
 
 #if CONFIG_PM
@@ -946,14 +942,8 @@ static int nmk_i2c_runtime_resume(struct device *dev)
 }
 #endif
 
-/*
- * We use noirq so that we suspend late and resume before the wakeup interrupt
- * to ensure that we do the !pm_runtime_suspended() check in resume before
- * there has been a regular pm runtime resume (via pm_runtime_get_sync()).
- */
 static const struct dev_pm_ops nmk_i2c_pm = {
-	.suspend_noirq	= nmk_i2c_suspend,
-	.resume_noirq	= nmk_i2c_resume,
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(nmk_i2c_suspend_late, nmk_i2c_resume_early)
 	SET_PM_RUNTIME_PM_OPS(nmk_i2c_runtime_suspend,
 			nmk_i2c_runtime_resume,
 			NULL)
-- 
1.7.9.5
