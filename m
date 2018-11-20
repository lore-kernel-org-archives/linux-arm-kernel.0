From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 20 Nov 2018 09:27:21 +0000
Subject: [PATCHv2 17/25] PCI: mobiveil: fix the checking of valid device
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181120092615.11680-18-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Avoid to issue CFG transactions to link partner when the PCIe
link is not up. And allow CFG transactions to all functions of
Endpoint implemented multiple functions.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - New patch

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index dc5324d94466..1ae82e790562 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct mobiveil_pcie *pcie = bus->sysdata;
 
+	/* If there is no link, then there is no device */
+	if (bus->number > pcie->rp.root_bus_nr && !mobiveil_pcie_link_up(pcie))
+		return false;
+
 	/* Only one device down on each root port */
 	if ((bus->number == pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
@@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary == pcie->rp.root_bus_nr) && (devfn > 0))
+	if ((bus->primary == pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))
 		return false;
 
 	return true;
-- 
2.17.1
