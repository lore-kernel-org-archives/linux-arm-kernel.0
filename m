From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  5 Mar 2014 20:17:49 +0100
Subject: [PATCH] ahci_imx: Put #ifdef CONFIG_PM_SLEEP around suspend / resume
 functions
Message-ID: <1394047069-29902-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following warnings when CONFIG_PM_SLEEP is not set:

drivers/ata/ahci_imx.c:284:12: warning: ?imx_ahci_suspend? defined but not used [-Wunused-function]
drivers/ata/ahci_imx.c:299:12: warning: ?imx_ahci_resume? defined but not used [-Wunused-function]

Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci_imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 3cb5d69..497c7ab 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -281,6 +281,7 @@ static void ahci_imx_host_stop(struct ata_host *host)
 	imx_sata_disable(hpriv);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int imx_ahci_suspend(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
@@ -308,6 +309,7 @@ static int imx_ahci_resume(struct device *dev)
 
 	return ahci_platform_resume_host(dev);
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(ahci_imx_pm_ops, imx_ahci_suspend, imx_ahci_resume);
 
-- 
1.9.0
