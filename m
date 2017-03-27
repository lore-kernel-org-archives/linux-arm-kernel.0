From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Mar 2017 10:49:46 +0100
Subject: [PATCH v2 18/22] PCI: xgene: update PCI config space remap function
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170327094954.7162-19-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_ioremap_nopost* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 1a61087..df8e13c 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -248,7 +248,7 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
 		dev_err(dev, "can't get CSR resource\n");
 		return ret;
 	}
-	port->csr_base = devm_ioremap_resource(dev, &csr);
+	port->csr_base = devm_ioremap_nopost_resource(dev, &csr);
 	if (IS_ERR(port->csr_base))
 		return PTR_ERR(port->csr_base);
 
@@ -359,7 +359,7 @@ static int xgene_pcie_map_reg(struct xgene_pcie_port *port,
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
-	port->csr_base = devm_ioremap_resource(dev, res);
+	port->csr_base = devm_ioremap_nopost_resource(dev, res);
 	if (IS_ERR(port->csr_base))
 		return PTR_ERR(port->csr_base);
 
-- 
2.10.0
