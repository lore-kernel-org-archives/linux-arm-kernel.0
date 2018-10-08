From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Mon, 8 Oct 2018 11:24:48 +0800
Subject: [PATCH v6 9/9] PCI: mediatek: Add loadable kernel module support
In-Reply-To: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1538969088-7136-10-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Implement remove callback function for Mediatek PCIe driver to add
loadable kernel module support.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/Kconfig         |  2 +-
 drivers/pci/controller/pcie-mediatek.c | 52 +++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 028b287..465790f 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -231,7 +231,7 @@ config PCIE_ROCKCHIP_EP
 	  available to support GEN2 with 4 slots.
 
 config PCIE_MEDIATEK
-	bool "MediaTek PCIe controller"
+	tristate "MediaTek PCIe controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index daba78f..3327c75 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
@@ -532,6 +533,27 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
+static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+{
+	struct mtk_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+
+		if (port->irq_domain)
+			irq_domain_remove(port->irq_domain);
+
+		if (IS_ENABLED(CONFIG_PCI_MSI)) {
+			if (port->msi_domain)
+				irq_domain_remove(port->msi_domain);
+			if (port->inner_domain)
+				irq_domain_remove(port->inner_domain);
+		}
+
+		irq_dispose_mapping(port->irq);
+	}
+}
+
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
@@ -1171,6 +1193,32 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+
+static void mtk_pcie_free_resources(struct mtk_pcie *pcie)
+{
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct list_head *windows = &host->windows;
+
+	pci_unmap_iospace(&pcie->pio);
+	pci_free_resource_list(windows);
+}
+
+static int mtk_pcie_remove(struct platform_device *pdev)
+{
+	struct mtk_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+
+	pci_stop_root_bus(host->bus);
+	pci_remove_root_bus(host->bus);
+	mtk_pcie_free_resources(pcie);
+
+	mtk_pcie_irq_teardown(pcie);
+
+	mtk_pcie_put_resources(pcie);
+
+	return 0;
+}
+
 static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
@@ -1248,6 +1296,7 @@ static const struct of_device_id mtk_pcie_ids[] = {
 
 static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
+	.remove = mtk_pcie_remove,
 	.driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_ids,
@@ -1255,4 +1304,5 @@ static struct platform_driver mtk_pcie_driver = {
 		.pm = &mtk_pcie_pm_ops,
 	},
 };
-builtin_platform_driver(mtk_pcie_driver);
+module_platform_driver(mtk_pcie_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.6.4
