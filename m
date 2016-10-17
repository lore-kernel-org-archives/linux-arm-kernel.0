From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 17 Oct 2016 14:57:22 +0000
Subject: [PATCH -next] PCI: rockchip: Add missing of_node_put() in
 rockchip_pcie_init_irq_domain()
Message-ID: <1476716242-31684-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

This node pointer is returned by of_get_next_child() with refcount
incremented in this function. of_node_put() on it before exitting
this function on error.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pcie-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index e0b22da..ab88859 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -949,6 +949,7 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 						    &intx_domain_ops, rockchip);
 	if (!rockchip->irq_domain) {
 		dev_err(dev, "failed to get a INTx IRQ domain\n");
+		of_node_put(intc);
 		return -EINVAL;
 	}
