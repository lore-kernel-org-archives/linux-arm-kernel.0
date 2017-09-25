From: jglauber@cavium.com (Jan Glauber)
Date: Mon, 25 Sep 2017 14:34:56 +0200
Subject: [PATCH v10 1/7] edac: thunderx: Remove suspend/resume support
In-Reply-To: <20170925123502.17289-1-jglauber@cavium.com>
References: <20170925123502.17289-1-jglauber@cavium.com>
Message-ID: <20170925123502.17289-2-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory controller on ThunderX/OcteonTX systems does not
support power management. Therefore remove the suspend/resume
callbacks.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/edac/thunderx_edac.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index f35d87519a3e..4803c6468bab 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -639,27 +639,6 @@ static irqreturn_t thunderx_lmc_threaded_isr(int irq, void *dev_id)
 	return ret;
 }
 
-#ifdef CONFIG_PM
-static int thunderx_lmc_suspend(struct pci_dev *pdev, pm_message_t state)
-{
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int thunderx_lmc_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_enable_wake(pdev, PCI_D0, 0);
-	pci_restore_state(pdev);
-
-	return 0;
-}
-#endif
-
 static const struct pci_device_id thunderx_lmc_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_THUNDER_LMC) },
 	{ 0, },
@@ -834,10 +813,6 @@ static struct pci_driver thunderx_lmc_driver = {
 	.name     = "thunderx_lmc_edac",
 	.probe    = thunderx_lmc_probe,
 	.remove   = thunderx_lmc_remove,
-#ifdef CONFIG_PM
-	.suspend  = thunderx_lmc_suspend,
-	.resume   = thunderx_lmc_resume,
-#endif
 	.id_table = thunderx_lmc_pci_tbl,
 };
 
-- 
2.9.0.rc0.21.g7777322
