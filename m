From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 17 Oct 2016 14:58:17 +0000
Subject: [PATCH -next] PCI: xilinx-nwl: Add missing of_node_put() in
 nwl_pcie_init_irq_domain()
Message-ID: <1476716297-31808-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

This node pointer is returned by of_get_next_child() with refcount
incremented in this function. of_node_put() on it before exitting
this function on error.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 43eaa4a..c16b26c 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -535,6 +535,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 
 	if (!pcie->legacy_irq_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
+		of_node_put(legacy_intc_node);
 		return -ENOMEM;
 	}
