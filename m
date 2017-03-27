From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Mar 2017 10:49:39 +0100
Subject: [PATCH v2 11/22] PCI: spear13xx: update PCI config space remap
 function
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170327094954.7162-12-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI configuration space should be mapped with a memory region type that
generate on the CPU host bus non-posted write transations. Update the
driver to use the devm_ioremap_nopost* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index eaa4ea8..0fe2b2b 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -273,7 +273,7 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	}
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	pci->dbi_base = devm_ioremap_nopost_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base)) {
 		dev_err(dev, "couldn't remap dbi base %p\n", dbi_base);
 		ret = PTR_ERR(pci->dbi_base);
-- 
2.10.0
