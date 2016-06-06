From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:05:59 -0500
Subject: [PATCH v1 10/25] PCI: xilinx-nwl: Free bridge resource list on failure
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230559.20936.29055.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_pci_get_host_bridge_resources() allocates a list of resources for host
bridge windows.  If we fail after allocating that list, free it before we
return error.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 3479d30..506da7b 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -832,20 +832,22 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	err = nwl_pcie_init_irq_domain(pcie);
 	if (err) {
 		dev_err(pcie->dev, "Failed creating IRQ Domain\n");
-		return err;
+		goto error;
 	}
 
 	bus = pci_create_root_bus(&pdev->dev, pcie->root_busno,
 				  &nwl_pcie_ops, pcie, &res);
-	if (!bus)
-		return -ENOMEM;
+	if (!bus) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie, bus);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"failed to enable MSI support: %d\n", err);
-			return err;
+			goto error;
 		}
 	}
 	pci_scan_child_bus(bus);
@@ -855,6 +857,10 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	pci_bus_add_devices(bus);
 	platform_set_drvdata(pdev, pcie);
 	return 0;
+
+error:
+	pci_free_resource_list(&res);
+	return err;
 }
 
 static int nwl_pcie_remove(struct platform_device *pdev)
