From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 12 Aug 2014 17:14:29 +0100
Subject: [PATCH 5/5] mmc: sdhci-acpi.c: Use SET_RUNTIME_PM_OPS macro to set
 runtime pm callbacks
In-Reply-To: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1407860069-12706-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to get rid of the #else condition, as the macro compiles
away to nothing if not enabled.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/mmc/host/sdhci-acpi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 8ce3c28..3a42540 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -383,20 +383,13 @@ static int sdhci_acpi_runtime_idle(struct device *dev)
 	return 0;
 }
 
-#else
-
-#define sdhci_acpi_runtime_suspend	NULL
-#define sdhci_acpi_runtime_resume	NULL
-#define sdhci_acpi_runtime_idle		NULL
-
 #endif
 
 static const struct dev_pm_ops sdhci_acpi_pm_ops = {
 	.suspend		= sdhci_acpi_suspend,
 	.resume			= sdhci_acpi_resume,
-	.runtime_suspend	= sdhci_acpi_runtime_suspend,
-	.runtime_resume		= sdhci_acpi_runtime_resume,
-	.runtime_idle		= sdhci_acpi_runtime_idle,
+	SET_RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend,
+			sdhci_acpi_runtime_resume, sdhci_acpi_runtime_idle)
 };
 
 static struct platform_driver sdhci_acpi_driver = {
-- 
1.9.1
