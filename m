From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Mar 2017 10:49:45 +0100
Subject: [PATCH v2 17/22] PCI: armada8k: update PCI config space remap function
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170327094954.7162-18-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_ioremap_nopost* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/dwc/pcie-armada8k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index f110e3b..6bc7c7f 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -230,7 +230,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
-	pci->dbi_base = devm_ioremap_resource(dev, base);
+	pci->dbi_base = devm_ioremap_nopost_resource(dev, base);
 	if (IS_ERR(pci->dbi_base)) {
 		dev_err(dev, "couldn't remap regs base %p\n", base);
 		ret = PTR_ERR(pci->dbi_base);
-- 
2.10.0
