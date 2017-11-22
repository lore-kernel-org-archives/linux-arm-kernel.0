From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 00:31:03 -0500
Subject: [PATCH 18/30] PCI: ibmphp: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511328675-21981-19-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/ibmphp_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 73cf846..92dd882 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -707,7 +707,8 @@ static void ibm_unconfigure_device(struct pci_func *func)
 	pci_lock_rescan_remove();
 
 	for (j = 0; j < 0x08; j++) {
-		temp = pci_get_bus_and_slot(func->busno, (func->device << 3) | j);
+		temp = pci_get_domain_bus_and_slot(0, func->busno,
+						   (func->device << 3) | j);
 		if (temp) {
 			pci_stop_and_remove_bus_device(temp);
 			pci_dev_put(temp);
@@ -780,7 +781,7 @@ static int ibm_configure_device(struct pci_func *func)
 	if (!(bus_structure_fixup(func->busno)))
 		flag = 1;
 	if (func->dev == NULL)
-		func->dev = pci_get_bus_and_slot(func->busno,
+		func->dev = pci_get_domain_bus_and_slot(0, func->busno,
 				PCI_DEVFN(func->device, func->function));
 
 	if (func->dev == NULL) {
@@ -793,7 +794,7 @@ static int ibm_configure_device(struct pci_func *func)
 		if (num)
 			pci_bus_add_devices(bus);
 
-		func->dev = pci_get_bus_and_slot(func->busno,
+		func->dev = pci_get_domain_bus_and_slot(0, func->busno,
 				PCI_DEVFN(func->device, func->function));
 		if (func->dev == NULL) {
 			err("ERROR... : pci_dev still NULL\n");
-- 
1.9.1
