From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:06:07 -0500
Subject: [PATCH v1 11/25] PCI: xilinx-nwl: Request host bridge window resources
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230606.20936.88648.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request host bridge window resources so they appear in ioport_resource and
iomem_resource and are reflected in /proc/ioports and /proc/iomem.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 506da7b..3c16bbf 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -829,6 +829,10 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = devm_request_pci_bus_resources(pcie->dev, &res);
+	if (err)
+		goto error;
+
 	err = nwl_pcie_init_irq_domain(pcie);
 	if (err) {
 		dev_err(pcie->dev, "Failed creating IRQ Domain\n");
