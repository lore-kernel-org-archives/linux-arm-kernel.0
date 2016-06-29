From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Wed, 29 Jun 2016 20:48:20 +0530
Subject: [PATCH] PCI: xilinx: Modify error handling
Message-ID: <20160629151820.GA14282@amitoj-Inspiron-3542>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Failure of of_get_next_child returns NULL, not an ERR_PTR. Use
appropriate error code -ENODEV to be returned on failure instead.

The Coccinelle semantic patch used to find this issue is as follows:
@@
expression E,E1;
@@

if (
*   E == NULL
   ) { <+... when != E = E1
        PTR_ERR(E)
       ...+> }

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/pci/host/pcie-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 65f0fe0..d76ea8d 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -550,7 +550,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 	pcie_intc_node = of_get_next_child(node, NULL);
 	if (!pcie_intc_node) {
 		dev_err(dev, "No PCIe Intc node found\n");
-		return PTR_ERR(pcie_intc_node);
+		return -ENODEV;
 	}
 
 	port->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
-- 
1.9.1
