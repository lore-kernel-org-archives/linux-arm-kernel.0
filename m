From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:18:07 +0100
Subject: [RFC/RFT PATCH 16/18] PCI: Add a call to pci_assign_irq() in
 pci_device_probe()
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-17-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Minter <matt@masarand.com>

The pci_assign_irq() function allows assignment of an irq to devices
during device enable time rather than only at boot. Therefore call it
in the pci_device_probe() function during the enable device code path
so this assignment can be performed.

This patch will do nothing on arches which do not set the irq mapping
function pointers and is therefore currently a nop, however as support
for these function pointers is added to arch specific code this will
cause irq assignment to migrate to device enable time allowing the new
code paths to be used.

Signed-off-by: Matthew Minter <matt@masarand.com>
[lorenzo.pieralisi at arm.com: moved pci_assign_irq() call site]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/pci-driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index afa7271..4632fa4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -400,6 +400,8 @@ static int pci_device_probe(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = to_pci_driver(dev->driver);
 
+	pci_assign_irq(pci_dev);
+
 	error = pcibios_alloc_irq(pci_dev);
 	if (error < 0)
 		return error;
-- 
2.10.0
