From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Mon, 14 Aug 2017 21:04:26 +0800
Subject: [PATCH v2 1/3] PCI: mediatek: Fix return value in case of error
In-Reply-To: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
References: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1502715868-17651-2-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

In commit ae02a6dda285 ("PCI: mediatek: Add controller support for MT2712
and MT7622"), the function 'mtk_pcie_init_irq_domain', the pattern used to
check and return error is:

  if (!var) {
    dev_err(...);
    return PTR_ERR(var);
  }

The return value in such case is always 0, change it to return -ENODEV
instead. And if error was returned from this function, the error should
be returned to upper layer instead of -ENODEV.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 44e7885..946c056 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -450,14 +450,14 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 	pcie_intc_node = of_get_next_child(node, NULL);
 	if (!pcie_intc_node) {
 		dev_err(dev, "no PCIe Intc node found\n");
-		return PTR_ERR(pcie_intc_node);
+		return -ENODEV;
 	}
 
 	port->irq_domain = irq_domain_add_linear(pcie_intc_node, INTX_NUM,
 						 &intx_domain_ops, port);
 	if (!port->irq_domain) {
 		dev_err(dev, "failed to get INTx IRQ domain\n");
-		return PTR_ERR(port->irq_domain);
+		return -ENODEV;
 	}
 
 	return 0;
@@ -502,7 +502,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	err = mtk_pcie_init_irq_domain(port, node);
 	if (err) {
 		dev_err(dev, "failed to init PCIe legacy IRQ domain\n");
-		return -ENODEV;
+		return err;
 	}
 
 	return 0;
-- 
2.6.4
