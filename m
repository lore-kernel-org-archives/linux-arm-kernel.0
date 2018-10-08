From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Mon, 8 Oct 2018 11:24:44 +0800
Subject: [PATCH v6 5/9] PCI: mediatek: Move the mtk_pcie_startup_port_v2
 function's define after mtk_pcie_setup_irq
In-Reply-To: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1538969088-7136-6-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

This is a prepare patch to fix enable MSI logic, move the function's
define later to avoid forward declaration of mtk_pcie_enable_msi in
the future. No functional changed.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 138 ++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index ead6005..654a63e 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -392,75 +392,6 @@ static struct pci_ops mtk_pcie_ops_v2 = {
 	.write = mtk_pcie_config_write,
 };
 
-static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
-{
-	struct mtk_pcie *pcie = port->pcie;
-	struct resource *mem = &pcie->mem;
-	const struct mtk_pcie_soc *soc = port->pcie->soc;
-	u32 val;
-	size_t size;
-	int err;
-
-	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
-	if (pcie->base) {
-		val = readl(pcie->base + PCIE_SYS_CFG_V2);
-		val |= PCIE_CSR_LTSSM_EN(port->slot) |
-		       PCIE_CSR_ASPM_L1_EN(port->slot);
-		writel(val, pcie->base + PCIE_SYS_CFG_V2);
-	}
-
-	/* Assert all reset signals */
-	writel(0, port->base + PCIE_RST_CTRL);
-
-	/*
-	 * Enable PCIe link down reset, if link status changed from link up to
-	 * link down, this will reset MAC control registers and configuration
-	 * space.
-	 */
-	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
-
-	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
-	val = readl(port->base + PCIE_RST_CTRL);
-	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
-	       PCIE_MAC_SRSTB | PCIE_CRSTB;
-	writel(val, port->base + PCIE_RST_CTRL);
-
-	/* Set up vendor ID and class code */
-	if (soc->need_fix_class_id) {
-		val = PCI_VENDOR_ID_MEDIATEK;
-		writew(val, port->base + PCIE_CONF_VEND_ID);
-
-		val = PCI_CLASS_BRIDGE_PCI;
-		writew(val, port->base + PCIE_CONF_CLASS_ID);
-	}
-
-	/* 100ms timeout value should be enough for Gen1/2 training */
-	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
-				 !!(val & PCIE_PORT_LINKUP_V2), 20,
-				 100 * USEC_PER_MSEC);
-	if (err)
-		return -ETIMEDOUT;
-
-	/* Set INTx mask */
-	val = readl(port->base + PCIE_INT_MASK);
-	val &= ~INTX_MASK;
-	writel(val, port->base + PCIE_INT_MASK);
-
-	/* Set AHB to PCIe translation windows */
-	size = mem->end - mem->start;
-	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
-	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
-
-	val = upper_32_bits(mem->start);
-	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
-
-	/* Set PCIe to AXI translation memory space.*/
-	val = fls(0xffffffff) | WIN_ENABLE;
-	writel(val, port->base + PCIE_AXI_WINDOW0);
-
-	return 0;
-}
-
 static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
@@ -705,6 +636,75 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	return 0;
 }
 
+static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
+{
+	struct mtk_pcie *pcie = port->pcie;
+	struct resource *mem = &pcie->mem;
+	const struct mtk_pcie_soc *soc = port->pcie->soc;
+	u32 val;
+	size_t size;
+	int err;
+
+	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
+	if (pcie->base) {
+		val = readl(pcie->base + PCIE_SYS_CFG_V2);
+		val |= PCIE_CSR_LTSSM_EN(port->slot) |
+		       PCIE_CSR_ASPM_L1_EN(port->slot);
+		writel(val, pcie->base + PCIE_SYS_CFG_V2);
+	}
+
+	/* Assert all reset signals */
+	writel(0, port->base + PCIE_RST_CTRL);
+
+	/*
+	 * Enable PCIe link down reset, if link status changed from link up to
+	 * link down, this will reset MAC control registers and configuration
+	 * space.
+	 */
+	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
+
+	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
+	val = readl(port->base + PCIE_RST_CTRL);
+	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
+	       PCIE_MAC_SRSTB | PCIE_CRSTB;
+	writel(val, port->base + PCIE_RST_CTRL);
+
+	/* Set up vendor ID and class code */
+	if (soc->need_fix_class_id) {
+		val = PCI_VENDOR_ID_MEDIATEK;
+		writew(val, port->base + PCIE_CONF_VEND_ID);
+
+		val = PCI_CLASS_BRIDGE_PCI;
+		writew(val, port->base + PCIE_CONF_CLASS_ID);
+	}
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
+				 !!(val & PCIE_PORT_LINKUP_V2), 20,
+				 100 * USEC_PER_MSEC);
+	if (err)
+		return -ETIMEDOUT;
+
+	/* Set INTx mask */
+	val = readl(port->base + PCIE_INT_MASK);
+	val &= ~INTX_MASK;
+	writel(val, port->base + PCIE_INT_MASK);
+
+	/* Set AHB to PCIe translation windows */
+	size = mem->end - mem->start;
+	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
+
+	val = upper_32_bits(mem->start);
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
+
+	/* Set PCIe to AXI translation memory space.*/
+	val = fls(0xffffffff) | WIN_ENABLE;
+	writel(val, port->base + PCIE_AXI_WINDOW0);
+
+	return 0;
+}
+
 static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus,
 				      unsigned int devfn, int where)
 {
-- 
2.6.4
