From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 04 Aug 2015 16:54:35 -0500
Subject: [PATCH v5 6/9] PCI: Drop references acquired by of_parse_phandle()
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20150804215435.9189.94410.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_parse_phandle() returns a device_node pointer with the refcount
incremented.  We should dispose of this reference when we're finished.

Drop the reference acquired by of_parse_phandle().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-mvebu.c |    1 +
 drivers/pci/host/pci-xgene.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 70aa095..67ec5e1 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -879,6 +879,7 @@ static void mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
 		return;
 
 	pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
+	of_node_put(msi_node);
 
 	if (pcie->msi)
 		pcie->msi->dev = &pcie->pdev->dev;
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index a9dfb70..4c2fb1f 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -514,6 +514,7 @@ static int xgene_pcie_msi_enable(struct pci_bus *bus)
 	if (!bus->msi)
 		return -ENODEV;
 
+	of_node_put(msi_node);
 	bus->msi->dev = &bus->dev;
 	return 0;
 }
