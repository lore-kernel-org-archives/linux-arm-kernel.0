From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jan 2017 10:26:47 +0000
Subject: [PATCH] PCI/MSI: pci-xgene-msi: Fix CPU hotplug registration handling
Message-ID: <1484130407-24707-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The conversion to the new hotplug state machine introduced a regression
where a successful hotplug registration would be treated as an error,
effectively disabling the MSI driver forever.

Fix it by doing the proper check on the return value.

Fixes: 9c248f8896e6 ("PCI/xgene-msi: Convert to hotplug state machine")
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Duc Dang <dhdang@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable at vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/host/pci-xgene-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index 1f38d08..f1b633b 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -517,7 +517,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 
 	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "pci/xgene:online",
 			       xgene_msi_hwirq_alloc, NULL);
-	if (rc)
+	if (rc < 0)
 		goto err_cpuhp;
 	pci_xgene_online = rc;
 	rc = cpuhp_setup_state(CPUHP_PCI_XGENE_DEAD, "pci/xgene:dead", NULL,
-- 
2.1.4
