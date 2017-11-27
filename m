From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 27 Nov 2017 01:20:25 -0500
Subject: [PATCH V2 4/7] PCI: wait device ready after pci_pm_reset()
In-Reply-To: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511763628-11856-5-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rev 3.1 Sec 2.3.1 Request Handling Rules says a device can issue CRS
following a D3hot->D0 transition. Add pci_dev_wait() call to see if
device is available before returning.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ed3c3bc..87e4688 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3990,7 +3990,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return 0;
+	return pci_dev_wait(dev, "PM D3->D0", PCIE_RESET_READY_POLL_MS);
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
-- 
1.9.1
