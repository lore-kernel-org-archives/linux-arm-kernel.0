From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:05:45 -0500
Subject: [PATCH v1 08/25] PCI: xilinx: Free bridge resource list on failure
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230545.20936.65430.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_pci_get_host_bridge_resources() allocates a list of resources for host
bridge windows.  If we fail after allocating that list, free it before we
return error.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 65f0fe0..5c456db 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -660,7 +660,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	struct xilinx_pcie_port *port;
 	struct device *dev = &pdev->dev;
 	struct pci_bus *bus;
-
 	int err;
 	resource_size_t iobase = 0;
 	LIST_HEAD(res);
@@ -696,8 +695,10 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	}
 	bus = pci_create_root_bus(&pdev->dev, 0,
 				  &xilinx_pcie_ops, port, &res);
-	if (!bus)
-		return -ENOMEM;
+	if (!bus) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 #ifdef CONFIG_PCI_MSI
 	xilinx_pcie_msi_chip.dev = port->dev;
@@ -712,6 +713,10 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, port);
 
 	return 0;
+
+error:
+	pci_free_resource_list(&res);
+	return err;
 }
 
 /**
