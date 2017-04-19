From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 19 Apr 2017 17:48:59 +0100
Subject: [PATCH v4 10/21] PCI: spear13xx: update PCI config space remap
 function
In-Reply-To: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170419164913.19674-11-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI configuration space should be mapped with a memory region type that
generate on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index eaa4ea8..3ae59de 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -273,7 +273,7 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	}
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base)) {
 		dev_err(dev, "couldn't remap dbi base %p\n", dbi_base);
 		ret = PTR_ERR(pci->dbi_base);
-- 
2.10.0
