From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:05:01 -0500
Subject: [PATCH v1 02/25] PCI: designware: Free bridge resource list on failure
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230501.20936.71818.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_pci_get_host_bridge_resources() allocates a list of resources for host
bridge windows.  If we fail after allocating that list, free it before we
return error.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index aafd766..9ade767 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -493,7 +493,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					resource_size(pp->cfg));
 		if (!pp->dbi_base) {
 			dev_err(pp->dev, "error with ioremap\n");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto error;
 		}
 	}
 
@@ -504,7 +505,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
 			dev_err(pp->dev, "error with ioremap in function\n");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto error;
 		}
 	}
 
@@ -513,7 +515,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
 			dev_err(pp->dev, "error with ioremap\n");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto error;
 		}
 	}
 
@@ -528,7 +531,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						&dw_pcie_msi_chip);
 			if (!pp->irq_domain) {
 				dev_err(pp->dev, "irq domain init failed\n");
-				return -ENXIO;
+				ret = -ENXIO;
+				goto error;
 			}
 
 			for (i = 0; i < MAX_MSI_IRQS; i++)
@@ -536,7 +540,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		} else {
 			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
 			if (ret < 0)
-				return ret;
+				goto error;
 		}
 	}
 
@@ -552,8 +556,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	} else
 		bus = pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
 					pp, &res);
-	if (!bus)
-		return -ENOMEM;
+	if (!bus) {
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
@@ -571,6 +577,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	pci_bus_add_devices(bus);
 	return 0;
+
+error:
+	pci_free_resource_list(&res);
+	return ret;
 }
 
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
