From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Thu, 8 Nov 2018 10:56:55 +0800
Subject: [PATCH v2] PCI: mediatek: Use devm_of_pci_get_host_bridge_resources()
 to parse DT
Message-ID: <1541645815-30340-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Use the devm_of_pci_get_host_bridge_resources() API in place of the PCI OF
DT parser.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 98 +++++++++-------------------------
 1 file changed, 24 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 2a1f97c..0590a93 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -197,11 +197,7 @@ struct mtk_pcie_port {
  * @dev: pointer to PCIe device
  * @base: IO mapped register base
  * @free_ck: free-run reference clock
- * @io: IO resource
- * @pio: PIO resource
  * @mem: non-prefetchable memory resource
- * @busn: bus range
- * @offset: IO / Memory offset
  * @ports: pointer to PCIe port information
  * @soc: pointer to SoC-dependent operations
  */
@@ -210,14 +206,7 @@ struct mtk_pcie {
 	void __iomem *base;
 	struct clk *free_ck;
 
-	struct resource io;
-	struct resource pio;
 	struct resource mem;
-	struct resource busn;
-	struct {
-		resource_size_t mem;
-		resource_size_t io;
-	} offset;
 	struct list_head ports;
 	const struct mtk_pcie_soc *soc;
 };
@@ -1045,55 +1034,43 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node, *child;
-	struct of_pci_range_parser parser;
-	struct of_pci_range range;
-	struct resource res;
 	struct mtk_pcie_port *port, *tmp;
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct list_head *windows = &host->windows;
+	struct resource_entry *win, *tmp_win;
+	resource_size_t io_base;
 	int err;
 
-	if (of_pci_range_parser_init(&parser, node)) {
-		dev_err(dev, "missing \"ranges\" property\n");
-		return -EINVAL;
-	}
+	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
+						    windows, &io_base);
+	if (err)
+		return err;
 
-	for_each_of_pci_range(&parser, &range) {
-		err = of_pci_range_to_resource(&range, node, &res);
-		if (err < 0)
-			return err;
+	err = devm_request_pci_bus_resources(dev, windows);
+	if (err < 0)
+		return err;
 
-		switch (res.flags & IORESOURCE_TYPE_BITS) {
+	/* Get the I/O and memory ranges from DT */
+	resource_list_for_each_entry_safe(win, tmp_win, windows) {
+		switch (resource_type(win->res)) {
 		case IORESOURCE_IO:
-			pcie->offset.io = res.start - range.pci_addr;
-
-			memcpy(&pcie->pio, &res, sizeof(res));
-			pcie->pio.name = node->full_name;
-
-			pcie->io.start = range.cpu_addr;
-			pcie->io.end = range.cpu_addr + range.size - 1;
-			pcie->io.flags = IORESOURCE_MEM;
-			pcie->io.name = "I/O";
-
-			memcpy(&res, &pcie->io, sizeof(res));
+			err = devm_pci_remap_iospace(dev, win->res, io_base);
+			if (err) {
+				dev_warn(dev, "error %d: failed to map resource %pR\n",
+					 err, win->res);
+				resource_list_destroy_entry(win);
+			}
 			break;
-
 		case IORESOURCE_MEM:
-			pcie->offset.mem = res.start - range.pci_addr;
-
-			memcpy(&pcie->mem, &res, sizeof(res));
+			memcpy(&pcie->mem, win->res, sizeof(*win->res));
 			pcie->mem.name = "non-prefetchable";
 			break;
+		case IORESOURCE_BUS:
+			host->busnr = win->res->start;
+			break;
 		}
 	}
 
-	err = of_pci_parse_bus_range(node, &pcie->busn);
-	if (err < 0) {
-		dev_err(dev, "failed to parse bus ranges property: %d\n", err);
-		pcie->busn.name = node->name;
-		pcie->busn.start = 0;
-		pcie->busn.end = 0xff;
-		pcie->busn.flags = IORESOURCE_BUS;
-	}
-
 	for_each_available_child_of_node(node, child) {
 		int slot;
 
@@ -1125,28 +1102,6 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 	return 0;
 }
 
-static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
-{
-	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
-	struct list_head *windows = &host->windows;
-	struct device *dev = pcie->dev;
-	int err;
-
-	pci_add_resource_offset(windows, &pcie->pio, pcie->offset.io);
-	pci_add_resource_offset(windows, &pcie->mem, pcie->offset.mem);
-	pci_add_resource(windows, &pcie->busn);
-
-	err = devm_request_pci_bus_resources(dev, windows);
-	if (err < 0)
-		return err;
-
-	err = devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
 static int mtk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1169,11 +1124,6 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = mtk_pcie_request_resources(pcie);
-	if (err)
-		goto put_resources;
-
-	host->busnr = pcie->busn.start;
 	host->dev.parent = pcie->dev;
 	host->ops = pcie->soc->ops;
 	host->map_irq = of_irq_parse_and_map_pci;
-- 
2.6.4
