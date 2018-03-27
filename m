From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Tue, 27 Mar 2018 16:08:14 +0200
Subject: [PATCH v3 1/6] PCI: aardvark: introduce an advk_pcie_valid_device()
 helper
In-Reply-To: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
References: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180327140819.23501-9-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

In other to mimic other PCIe host controller drivers, introduce an
advk_pcie_valid_device() helper, used in the configuration read/write
functions.

This patch by itself is not a fix, but it is required for a follow-up
patch that is a fix, hence the Fixes tag and the Cc to stable.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v2:
 - New patch
---
 drivers/pci/host/pci-aardvark.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index b04d37b3c5de..ccd0304a0c21 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -430,6 +430,15 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static int advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
+				  int devfn)
+{
+	if (PCI_SLOT(devfn) != 0)
+		return false;
+
+	return true;
+}
+
 static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			     int where, int size, u32 *val)
 {
@@ -437,7 +446,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	u32 reg;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0) {
+	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -491,7 +500,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	int offset;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0)
+	if (!advk_pcie_valid_device(pcie, bus, devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (where % size)
-- 
2.14.3
