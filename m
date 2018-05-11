From: chenyao11@huawei.com (Yao Chen)
Date: Fri, 11 May 2018 17:15:48 +0800
Subject: [PATCH v3 1/2] PCI: kirin: Add MSI support
In-Reply-To: <1526030149-23985-1-git-send-email-chenyao11@huawei.com>
References: <1526030149-23985-1-git-send-email-chenyao11@huawei.com>
Message-ID: <1526030149-23985-2-git-send-email-chenyao11@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for MSI.

Signed-off-by: Yao Chen <chenyao11@huawei.com>
---
 drivers/pci/dwc/pcie-kirin.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index d2970a0..8daab1f 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -426,9 +426,28 @@ static int kirin_pcie_establish_link(struct pcie_port *pp)
 	return 0;
 }
 
+static irqreturn_t kirin_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	return dw_handle_msi_irq(pp);
+}
+
+static void kirin_pcie_msi_init(struct pcie_port *pp)
+{
+	dw_pcie_msi_init(pp);
+}
+
+static void kirin_pcie_enable_interrupts(struct pcie_port *pp)
+{
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		kirin_pcie_msi_init(pp);
+}
+
 static int kirin_pcie_host_init(struct pcie_port *pp)
 {
 	kirin_pcie_establish_link(pp);
+	kirin_pcie_enable_interrupts(pp);
 
 	return 0;
 }
@@ -448,6 +467,26 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 static int __init kirin_add_pcie_port(struct dw_pcie *pci,
 				      struct platform_device *pdev)
 {
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pci->pp.msi_irq = platform_get_irq(pdev, 0);
+		if (pci->pp.msi_irq < 0) {
+			dev_err(&pdev->dev, "failed to get MSI IRQ (%d)\n",
+				pci->pp.msi_irq);
+			return -ENODEV;
+		}
+		ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
+				       kirin_pcie_msi_irq_handler,
+				       IRQF_SHARED | IRQF_NO_THREAD,
+				       "kirin_pcie_msi", &pci->pp);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
+				pci->pp.msi_irq);
+			return ret;
+		}
+	}
+
 	pci->pp.ops = &kirin_pcie_host_ops;
 
 	return dw_pcie_host_init(&pci->pp);
-- 
1.9.1
