From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri,  3 Aug 2018 16:38:45 +0200
Subject: [PATCH v2 3/6] PCI: mvebu: only remap I/O space if configured
In-Reply-To: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
References: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180803143848.21551-4-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there is no PCI I/O aperture configured in the Device Tree, it does
not make sense to create the virtual mapping for the PCI I/O space,
since we will anyway not create the MBus window that will allow to
access it. Therefore, do the pci_ioremap_io() only if necessary.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a195592723c2..9aa224f2f009 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1220,6 +1220,9 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		pcie->realio.end = min_t(resource_size_t,
 					 IO_SPACE_LIMIT,
 					 resource_size(&pcie->io) - 1);
+
+		for (i = 0; i < (IO_SPACE_LIMIT - SZ_64K); i += SZ_64K)
+			pci_ioremap_io(i, pcie->io.start + i);
 	} else
 		pcie->realio = pcie->io;
 
@@ -1278,9 +1281,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	pcie->nports = i;
 
-	for (i = 0; i < (IO_SPACE_LIMIT - SZ_64K); i += SZ_64K)
-		pci_ioremap_io(i, pcie->io.start + i);
-
 	mvebu_pcie_enable(pcie);
 
 	return 0;
-- 
2.14.4
