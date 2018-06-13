From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Wed, 13 Jun 2018 19:20:44 +0200
Subject: [PATCH] PCI: xilinx: add missing of_node_put()
Message-ID: <1528910444-25593-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 The call to of_get_next_child() returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")
---

Problem found by an experimental cocinelle script

Patch was compile tested with: multi_v7_defconfig + ARCH_ZYNQ=y,
COMPILE_TEST=y, PCIE_XILINX=y
(with one sparse warning though not related to the change proposed)

Patch is against 4.17.0 (localversion-next is next-20180613)

 drivers/pci/controller/pcie-xilinx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index b110a3a..7b1389d 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -509,6 +509,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 						 &intx_domain_ops,
 						 port);
+	of_node_put(pcie_intc_node);
 	if (!port->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENODEV;
-- 
2.1.4
