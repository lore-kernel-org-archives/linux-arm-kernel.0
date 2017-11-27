From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 27 Nov 2017 11:57:57 -0500
Subject: [PATCH V3 20/29] xen: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511801886-6753-21-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/xen-pcifront.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 8fc2e95..94b25b5 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -595,6 +595,7 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 	struct pci_driver *pdrv;
 	int bus = pdev->sh_info->aer_op.bus;
 	int devfn = pdev->sh_info->aer_op.devfn;
+	int domain = pdev->sh_info->aer_op.domain;
 	struct pci_dev *pcidev;
 	int flag = 0;
 
@@ -603,7 +604,7 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 		cmd, bus, devfn);
 	result = PCI_ERS_RESULT_NONE;
 
-	pcidev = pci_get_bus_and_slot(bus, devfn);
+	pcidev = pci_get_domain_bus_and_slot(domain, bus, devfn);
 	if (!pcidev || !pcidev->driver) {
 		dev_err(&pdev->xdev->dev, "device or AER driver is NULL\n");
 		pci_dev_put(pcidev);
-- 
1.9.1
