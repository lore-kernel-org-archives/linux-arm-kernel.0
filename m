From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 20 Feb 2014 16:31:20 +0100
Subject: [PATCH 8/8] mmc: mmci: Put the device into low power state at system
 suspend
In-Reply-To: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1392910280-12891-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For CONFIG_PM_SLEEP, the device were always left in full power state
after system suspend.

We solely relied on a power domain to put it into low power state,
which is an unreasonable requirement to put on SOCs to implement.
Especially for those SOCs not supporting power domains at all.

Use pm_runtime_force_suspend|resume() as the system suspend callbacks,
to resolve the issue.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c88da1c..1432ae2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1723,36 +1723,6 @@ static int mmci_remove(struct amba_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
-static int mmci_suspend(struct device *dev)
-{
-	struct amba_device *adev = to_amba_device(dev);
-	struct mmc_host *mmc = amba_get_drvdata(adev);
-
-	if (mmc) {
-		struct mmci_host *host = mmc_priv(mmc);
-		pm_runtime_get_sync(dev);
-		writel(0, host->base + MMCIMASK0);
-	}
-
-	return 0;
-}
-
-static int mmci_resume(struct device *dev)
-{
-	struct amba_device *adev = to_amba_device(dev);
-	struct mmc_host *mmc = amba_get_drvdata(adev);
-
-	if (mmc) {
-		struct mmci_host *host = mmc_priv(mmc);
-		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
-		pm_runtime_put(dev);
-	}
-
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_PM
 static void mmci_save(struct mmci_host *host)
 {
@@ -1820,7 +1790,8 @@ static int mmci_runtime_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops mmci_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_PM_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
-- 
1.7.9.5
