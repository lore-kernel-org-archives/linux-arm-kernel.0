From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 25 Oct 2017 15:01:02 -0400
Subject: [PATCH] PCI: turn off PCIe services during shutdown
Message-ID: <1508958063-6947-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the PCIe services such as AER are being left enabled during
shutdown. This might cause spurious AER errors while SOC is being
powered down.

Let's clean up the PCIe services gracefully during shutdown to clear
these false positives.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/portdrv_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 083276e..b350d12 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -246,6 +246,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_remove,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
-- 
1.9.1
