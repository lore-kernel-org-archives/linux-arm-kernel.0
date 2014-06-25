From: dianders@chromium.org (Doug Anderson)
Date: Wed, 25 Jun 2014 09:39:20 -0700
Subject: [PATCH v3] i2c: exynos5: Properly use the "noirq" variants of
 suspend/resume
Message-ID: <1403714360-7581-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original code for the exynos i2c controller registered for the
"noirq" variants.  However during review feedback it was moved to
SIMPLE_DEV_PM_OPS without anyone noticing that it meant we were no
longer actually "noirq" (despite functions named
exynos5_i2c_suspend_noirq and exynos5_i2c_resume_noirq).

i2c controllers that might have wakeup sources on them seem to need to
resume at noirq time so that the individual drivers can actually read
the i2c bus to handle their wakeup.

NOTE: I took the original review feedback from Wolfram and added
poweroff, thaw, freeze, restore.

This patch has only been compile-tested since I don't have all the
patches needed to make my machine using this i2c driver actually
suspend/resume.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes in v3:
- Made the structure static.

Changes in v2:
- Added missing CONFIG_PM_SLEEP

 drivers/i2c/busses/i2c-exynos5.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 63d2292..f9447a4 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -789,8 +789,16 @@ static int exynos5_i2c_resume_noirq(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(exynos5_i2c_dev_pm_ops, exynos5_i2c_suspend_noirq,
-			 exynos5_i2c_resume_noirq);
+static const struct dev_pm_ops exynos5_i2c_dev_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend_noirq = exynos5_i2c_suspend_noirq,
+	.resume_noirq = exynos5_i2c_resume_noirq,
+	.freeze_noirq = exynos5_i2c_suspend_noirq,
+	.thaw_noirq = exynos5_i2c_resume_noirq,
+	.poweroff_noirq = exynos5_i2c_suspend_noirq,
+	.restore_noirq = exynos5_i2c_resume_noirq,
+#endif
+};
 
 static struct platform_driver exynos5_i2c_driver = {
 	.probe		= exynos5_i2c_probe,
-- 
2.0.0.526.g5318336
