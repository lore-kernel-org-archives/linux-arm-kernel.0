From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 17 Oct 2016 14:59:04 +0000
Subject: [PATCH -next] PCI: xilinx: Add missing of_node_put() in
 xilinx_pcie_init_irq_domain()
Message-ID: <1476716344-1050-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

This node pointer is returned by of_get_next_child() with refcount
incremented in this function. of_node_put() on it before exitting
this function on error.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pcie-xilinx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index c8616fa..7100ee5 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -529,6 +529,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 						 port);
 	if (!port->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		of_node_put(pcie_intc_node);
 		return -ENODEV;
 	}
 
@@ -540,6 +541,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 							 &xilinx_pcie_msi_chip);
 		if (!port->msi_domain) {
 			dev_err(dev, "Failed to get a MSI IRQ domain\n");
+			of_node_put(pcie_intc_node);
 			return -ENODEV;
 		}
