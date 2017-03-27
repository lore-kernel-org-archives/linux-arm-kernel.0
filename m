From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Mar 2017 10:49:38 +0100
Subject: [PATCH v2 10/22] PCI: xilinx-nwl: update PCI config space remap
 function
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170327094954.7162-11-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_ioremap_nopost* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 4c3e0ab..cc042b1 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -761,7 +761,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	pcie->phys_pcie_reg_base = res->start;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
-	pcie->ecam_base = devm_ioremap_resource(dev, res);
+	pcie->ecam_base = devm_ioremap_nopost_resource(dev, res);
 	if (IS_ERR(pcie->ecam_base))
 		return PTR_ERR(pcie->ecam_base);
 	pcie->phys_ecam_base = res->start;
-- 
2.10.0
