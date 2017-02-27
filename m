From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Feb 2017 15:14:19 +0000
Subject: [PATCH 08/20] PCI: xilinx: update PCI config space remap function
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170227151436.18698-9-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 7f030f5..2fe2df5 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -606,7 +606,7 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 		return err;
 	}
 
-	port->reg_base = devm_ioremap_resource(dev, &regs);
+	port->reg_base = devm_pci_remap_cfg_resource(dev, &regs);
 	if (IS_ERR(port->reg_base))
 		return PTR_ERR(port->reg_base);
 
-- 
2.10.0
