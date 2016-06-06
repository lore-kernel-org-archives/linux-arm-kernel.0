From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:05:52 -0500
Subject: [PATCH v1 09/25] PCI: xilinx: Request host bridge window resources
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230552.20936.38959.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request host bridge window resources so they appear in ioport_resource and
iomem_resource and are reflected in /proc/ioports and /proc/iomem.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 5c456db..4703aa3 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -693,6 +693,11 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
 	}
+
+	err = devm_request_pci_bus_resources(dev, &res);
+	if (err)
+		goto error;
+
 	bus = pci_create_root_bus(&pdev->dev, 0,
 				  &xilinx_pcie_ops, port, &res);
 	if (!bus) {
