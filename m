From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Jun 2011 18:54:19 +0200
Subject: [PATCH 1/2] MMC: PM: add suspend/resume in atmel-mci
Message-ID: <1ef60c032bc39531302c1603bfcb841d2d437ccc.1309366360.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take care of slots while going to suspend state.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/atmel-mci.c |   51 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index aa8039f..c414ebe 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1878,8 +1878,59 @@ static int __exit atmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int atmci_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	struct atmel_mci *host = platform_get_drvdata(pdev);
+	struct atmel_mci_slot *slot;
+	int i, ret;
+
+	 for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+		slot = host->slot[i];
+		if (!slot)
+			continue;
+		ret = mmc_suspend_host(slot->mmc);
+		if (ret < 0) {
+			while (--i >= 0) {
+				slot = host->slot[i];
+				if (slot)
+					mmc_resume_host(host->slot[i]->mmc);
+			}
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int atmci_resume(struct platform_device *pdev)
+{
+	struct atmel_mci *host = platform_get_drvdata(pdev);
+	struct atmel_mci_slot *slot;
+	int i, ret;
+
+	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+		slot = host->slot[i];
+		if (!slot)
+			continue;
+		ret = mmc_resume_host(slot->mmc);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+#else
+#define atmci_suspend	NULL
+#define atmci_resume	NULL
+#endif
+
+
+
 static struct platform_driver atmci_driver = {
 	.remove		= __exit_p(atmci_remove),
+	.suspend	= atmci_suspend,
+	.resume		= atmci_resume,
 	.driver		= {
 		.name		= "atmel_mci",
 	},
-- 
1.7.3
