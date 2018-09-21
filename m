From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:21 +0530
Subject: [RFC PATCH 06/40] PCI: keystone: Add start_link/stop_link dw_pcie_ops
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-7-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add start_link/stop_link dw_pcie_ops and invoke ks_pcie_start_link
directly from host_init. This will also be required for adding EP
support.

While at that also use BIT() for LTSSM_EN_VAL.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone-dw.c |  9 +++-
 drivers/pci/controller/dwc/pci-keystone.c    | 51 +++++++++++---------
 drivers/pci/controller/dwc/pci-keystone.h    |  3 +-
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone-dw.c b/drivers/pci/controller/dwc/pci-keystone-dw.c
index 4bd6c6e2b177..ce399232cd99 100644
--- a/drivers/pci/controller/dwc/pci-keystone-dw.c
+++ b/drivers/pci/controller/dwc/pci-keystone-dw.c
@@ -21,7 +21,7 @@
 #include "pci-keystone.h"
 
 /* Application register defines */
-#define LTSSM_EN_VAL		        1
+#define LTSSM_EN_VAL		        BIT(0)
 #define LTSSM_STATE_MASK		0x1f
 #define LTSSM_STATE_L0			0x11
 #define DBI_CS2_EN_VAL			0x20
@@ -418,7 +418,7 @@ int ks_dw_pcie_link_up(struct dw_pcie *pci)
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
 
-void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
+void ks_dw_pcie_stop_link(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 
@@ -426,6 +426,11 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
 	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
 	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+}
+
+void ks_dw_pcie_start_link(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
 
 	/* Initiate Link Training */
 	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index f87ade2de711..24afc691443b 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -40,6 +40,9 @@
 
 #define to_keystone_pcie(x)	dev_get_drvdata((x)->dev)
 
+static int ks_pcie_start_link(struct dw_pcie *pci);
+static void ks_pcie_stop_link(struct dw_pcie *pci);
+
 static void quirk_limit_mrrs(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
@@ -83,26 +86,6 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
 
-static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-
-	if (dw_pcie_link_up(pci)) {
-		dev_info(dev, "Link already up\n");
-		return 0;
-	}
-
-	ks_dw_pcie_initiate_link_train(ks_pcie);
-
-	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_err(dev, "phy link never came up\n");
-	return -ETIMEDOUT;
-}
-
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
@@ -263,7 +246,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	ks_pcie_establish_link(ks_pcie);
 	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
 	ks_pcie_setup_interrupts(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
@@ -279,7 +261,8 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
 
-	return 0;
+	ks_pcie_start_link(pci);
+	return dw_pcie_wait_for_link(pci);
 }
 
 static const struct dw_pcie_host_ops keystone_pcie_host_ops = {
@@ -358,7 +341,31 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
+static int ks_pcie_start_link(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	if (dw_pcie_link_up(pci)) {
+		dev_WARN(dev, "Link already up\n");
+		return 0;
+	}
+
+	ks_dw_pcie_start_link(ks_pcie);
+
+	return 0;
+}
+
+static void ks_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	ks_dw_pcie_stop_link(ks_pcie);
+}
+
 static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = ks_pcie_start_link,
+	.stop_link = ks_pcie_stop_link,
 	.link_up = ks_dw_pcie_link_up,
 };
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.h b/drivers/pci/controller/dwc/pci-keystone.h
index 4eacc263f157..a66deab626aa 100644
--- a/drivers/pci/controller/dwc/pci-keystone.h
+++ b/drivers/pci/controller/dwc/pci-keystone.h
@@ -47,7 +47,8 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		unsigned int devfn, int where, int size, u32 *val);
 void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie);
-void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie);
+void ks_dw_pcie_start_link(struct keystone_pcie *ks_pcie);
+void ks_dw_pcie_stop_link(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_msi_irq_ack(int i, struct pcie_port *pp);
 void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq);
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq);
-- 
2.17.1
