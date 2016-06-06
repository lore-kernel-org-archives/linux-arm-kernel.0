From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:05:23 -0500
Subject: [PATCH v1 05/25] PCI: iproc: Request host bridge window resources
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230523.20936.1752.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request host bridge window resources so they appear in ioport_resource and
iomem_resource and are reflected in /proc/ioports and /proc/iomem.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index a576aee..e167b2f 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -462,6 +462,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	if (!pcie || !pcie->dev || !pcie->base)
 		return -EINVAL;
 
+	ret = devm_request_pci_bus_resources(pcie->dev, res);
+	if (ret)
+		return ret;
+
 	ret = phy_init(pcie->phy);
 	if (ret) {
 		dev_err(pcie->dev, "unable to initialize PCIe PHY\n");
