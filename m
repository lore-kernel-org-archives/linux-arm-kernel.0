From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Feb 2014 18:30:33 +0100
Subject: [PATCH 3/3] PCI: imx6: add support for MSI
In-Reply-To: <1393608633-18321-1-git-send-email-l.stach@pengutronix.de>
References: <1393608633-18321-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1393608633-18321-4-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Message Signaled Interrupts in the
imx6-pcie driver.

Signed-off-by: Harro Haan <hrhaan@gmail.com>
Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index e8663a8c3406..e038d47f1b01 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -25,6 +25,7 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
+#include <linux/interrupt.h>
 
 #include "pcie-designware.h"
 
@@ -329,6 +330,13 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 	return 0;
 }
 
+static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	return dw_handle_msi_irq(pp);
+}
+
 static int imx6_pcie_start_link(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
@@ -403,6 +411,9 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 
 	imx6_pcie_start_link(pp);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI) && (pp->msi_irq > 0))
+		dw_pcie_msi_init(pp);
 }
 
 static void imx6_pcie_reset_phy(struct pcie_port *pp)
@@ -477,6 +488,21 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
 		return -ENODEV;
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
+		if (pp->msi_irq < 0) {
+			dev_info(&pdev->dev, "failed to get MSI irq, host will not support MSI\n");
+		} else {
+			ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+			                       imx6_pcie_msi_handler,
+			                       IRQF_SHARED, "mx6-pcie-msi", pp);
+			if (ret) {
+				dev_err(&pdev->dev, "failed to request MSI irq\n");
+				return -ENODEV;
+			}
+		}
+	}
+
 	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
-- 
1.8.5.3
