From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 15:01:31 +0200
Subject: [PATCH 2/3] mmc: mmci: Let runtime PM callbacks be available for
 CONFIG_PM
In-Reply-To: <1397134892-20840-1-git-send-email-ulf.hansson@linaro.org>
References: <1397134892-20840-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1397134892-20840-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
callbacks. This means the callbacks becomes available for both
CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed to handle the
combinations of these scenarios.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0f10e3c..eb23c89 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1789,7 +1789,7 @@ static int mmci_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static void mmci_save(struct mmci_host *host)
 {
 	unsigned long flags;
@@ -1857,7 +1857,7 @@ static int mmci_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops mmci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
-	SET_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
+	SET_PM_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
 static struct amba_id mmci_ids[] = {
-- 
1.7.9.5
